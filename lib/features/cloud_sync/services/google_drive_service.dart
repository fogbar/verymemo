import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:verymemo/features/memo/domain/models/model.dart';
import 'package:verymemo/features/memo/data/repositories/memo_repository_impl.dart';

class GoogleAuthClient extends http.BaseClient {
  final http.Client _client;
  final Map<String, String> _headers;

  GoogleAuthClient(this._client, this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}

class GoogleDriveService {
  final Ref ref;
  static const _scopes = [
    drive.DriveApi.driveFileScope,
    drive.DriveApi.driveAppdataScope,
  ];

  final GoogleSignIn _googleSignIn;
  drive.DriveApi? _driveApi;
  String? _appDataFolderId;
  final MemoRepositoryImpl memoRepository;
  static const String _syncFileName = 'verymemo_sync.json';

  GoogleDriveService({
    required this.ref,
    GoogleSignIn? googleSignIn,
    required this.memoRepository,
  }) : _googleSignIn = googleSignIn ?? GoogleSignIn(scopes: _scopes);

  Future<void> initialize() async {
    try {
      log("Google 로그인 시도 중...");

      // 기존 로그인 세션 확인
      final isSignedIn = await _googleSignIn.isSignedIn();
      log("이미 로그인 되어 있나요? $isSignedIn");

      if (isSignedIn) {
        log("기존 로그인 세션 사용");
      }

      final account = await _googleSignIn.signIn();
      if (account == null) {
        log("Google 로그인 취소됨");
        throw Exception('Google 로그인이 필요합니다.');
      }

      log("Google 로그인 성공: ${account.email}");

      final auth = await account.authentication;
      log("인증 토큰 획득: ${auth.accessToken != null ? '성공' : '실패'}");

      final headers = await account.authHeaders;
      log("인증 헤더 획득: ${headers.isNotEmpty ? '성공' : '실패'}");

      // 인증 정보를 포함한 HTTP 클라이언트 생성
      final client = GoogleAuthClient(http.Client(), headers);

      // DriveApi 초기화
      _driveApi = drive.DriveApi(client);
      log("DriveApi 초기화 완료");

      // AppData 폴더 확인 및 생성
      await _ensureAppDataFolder();
      log("AppData 폴더 초기화 완료");
    } catch (e, stackTrace) {
      log("Google Drive 초기화 실패: $e");
      log("스택 트레이스: $stackTrace");

      if (e.toString().contains('ApiException: 10')) {
        throw Exception(
            'Google 로그인 설정 오류: Google Cloud Console에서 OAuth 클라이언트 ID를 확인하세요.');
      } else if (e.toString().contains('sign_in_failed')) {
        throw Exception(
            'Google 로그인 실패: 앱의 패키지 이름과 SHA-1 인증서 지문이 Google Cloud Console에 등록되어 있는지 확인하세요.');
      } else {
        throw Exception('Google Drive 초기화 실패: $e');
      }
    }
  }

  Future<void> _ensureAppDataFolder() async {
    if (_appDataFolderId != null) return;

    try {
      log("AppData 폴더 검색 중...");

      // 먼저 appdata 폴더 ID를 가져옵니다
      final appDataResponse = await _driveApi!.files.list(
        q: "name='appdata' and mimeType='application/vnd.google-apps.folder' and 'root' in parents",
        spaces: 'drive',
        $fields: 'files(id, name)',
      );

      String? appDataFolderId;
      if (appDataResponse.files?.isEmpty == true) {
        log("appdata 폴더가 없습니다. 생성 중...");
        // appdata 폴더 생성
        final appDataFolder = drive.File()
          ..name = 'appdata'
          ..mimeType = 'application/vnd.google-apps.folder'
          ..parents = ['root'];

        final createdAppDataFolder = await _driveApi!.files.create(
          appDataFolder,
          $fields: 'id',
        );
        appDataFolderId = createdAppDataFolder.id;
        log("appdata 폴더 생성 완료: $appDataFolderId");
      } else {
        appDataFolderId = appDataResponse.files!.first.id;
        log("기존 appdata 폴더 찾음: $appDataFolderId");
      }

      // VeryMemo 폴더 검색
      final response = await _driveApi!.files.list(
        q: "name='VeryMemo' and mimeType='application/vnd.google-apps.folder' and '$appDataFolderId' in parents",
        spaces: 'drive',
        $fields: 'files(id, name)',
      );

      if (response.files?.isNotEmpty == true) {
        _appDataFolderId = response.files!.first.id;
        log("기존 VeryMemo 폴더 찾음: $_appDataFolderId");
        return;
      }

      log("VeryMemo 폴더 생성 중...");
      // VeryMemo 폴더 생성
      final folder = drive.File()
        ..name = 'VeryMemo'
        ..mimeType = 'application/vnd.google-apps.folder'
        ..parents = [appDataFolderId!];

      final createdFolder = await _driveApi!.files.create(
        folder,
        $fields: 'id',
      );
      _appDataFolderId = createdFolder.id;
      log("새 VeryMemo 폴더 생성 완료: $_appDataFolderId");
    } catch (e, stackTrace) {
      log("AppData 폴더 생성 실패: $e");
      log("스택 트레이스: $stackTrace");
      throw Exception('AppData 폴더 생성 실패: $e');
    }
  }

  Future<void> sync() async {
    if (_appDataFolderId == null) {
      throw Exception('AppData 폴더가 초기화되지 않았습니다.');
    }

    try {
      // 1. 로컬 메모 데이터 가져오기
      final localMemos = await memoRepository.getAllMemos();
      if (localMemos == null) return;

      // 2. 동기화 파일 검색
      final syncFile = await _findSyncFile();
      if (syncFile != null) {
        // 3. 클라우드 데이터 다운로드
        final cloudData = await _downloadSyncFile(syncFile.id!);
        if (cloudData != null) {
          // 4. 충돌 해결 및 병합
          await _resolveConflicts(localMemos, cloudData);
        }
      }

      // 5. 최종 데이터 업로드
      await _uploadSyncFile(localMemos);
      log("---> 동기화 완료! $_appDataFolderId");
    } catch (e) {
      throw Exception('동기화 실패: $e');
    }
  }

  Future<drive.File?> _findSyncFile() async {
    final response = await _driveApi!.files.list(
      q: "'$_appDataFolderId' in parents and name='$_syncFileName'",
      spaces: 'drive',
    );

    return response.files?.isNotEmpty == true ? response.files!.first : null;
  }

  Future<List<MemoModel>?> _downloadSyncFile(String fileId) async {
    try {
      final response = await _driveApi!.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as drive.Media;

      final completer = Completer<List<int>>();
      final chunks = <int>[];

      response.stream.listen(
        (chunk) => chunks.addAll(chunk),
        onDone: () => completer.complete(chunks),
        onError: (error) => completer.completeError(error),
      );

      final bytes = await completer.future;
      final jsonString = utf8.decode(bytes);
      final jsonData = json.decode(jsonString) as List<dynamic>;

      return jsonData.map((json) => MemoModel.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  Future<void> _uploadSyncFile(List<MemoModel> memos) async {
    try {
      final jsonData = memos.map((memo) => memo.toJson()).toList();
      final jsonString = json.encode(jsonData);
      final bytes = utf8.encode(jsonString);

      final file = drive.File()
        ..name = _syncFileName
        ..parents = [_appDataFolderId!];

      await _driveApi!.files.create(
        file,
        uploadMedia: drive.Media(Stream.value(bytes), bytes.length),
      );
    } catch (e) {
      throw Exception('동기화 파일 업로드 실패: $e');
    }
  }

  Future<void> _resolveConflicts(
    List<MemoModel> localMemos,
    List<MemoModel> cloudMemos,
  ) async {
    final localMap = {for (var memo in localMemos) memo.memoId: memo};
    final cloudMap = {for (var memo in cloudMemos) memo.memoId: memo};

    // 1. 로컬에만 있는 메모는 그대로 유지
    // 2. 클라우드에만 있는 메모는 로컬에 추가
    for (var cloudMemo in cloudMemos) {
      if (!localMap.containsKey(cloudMemo.memoId)) {
        await memoRepository.addMemo(cloudMemo);
      }
    }

    // 3. 양쪽에 모두 있는 메모는 최신 버전으로 업데이트
    for (var localMemo in localMemos) {
      final cloudMemo = cloudMap[localMemo.memoId];
      if (cloudMemo != null) {
        final localDate = localMemo.updatedAt ?? localMemo.createdAt;
        final cloudDate = cloudMemo.updatedAt ?? cloudMemo.createdAt;

        if (cloudDate.isAfter(localDate)) {
          await memoRepository.updateMemo(cloudMemo);
        }
      }
    }
  }

  Future<void> uploadFile(String localPath, String fileName) async {
    if (_appDataFolderId == null) {
      throw Exception('AppData 폴더가 초기화되지 않았습니다.');
    }

    try {
      final file = File(localPath);
      final content = await file.readAsBytes();

      final driveFile = drive.File()
        ..name = fileName
        ..parents = [_appDataFolderId!];

      await _driveApi!.files.create(
        driveFile,
        uploadMedia: drive.Media(file.openRead(), content.length),
      );
    } catch (e) {
      throw Exception('파일 업로드 실패: $e');
    }
  }

  Future<void> downloadFile(String fileId, String localPath) async {
    try {
      final response = await _driveApi!.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as drive.Media;

      final file = File(localPath);
      final completer = Completer<List<int>>();
      final chunks = <int>[];

      response.stream.listen(
        (chunk) => chunks.addAll(chunk),
        onDone: () => completer.complete(chunks),
        onError: (error) => completer.completeError(error),
      );

      final bytes = await completer.future;
      await file.writeAsBytes(bytes);
    } catch (e) {
      throw Exception('파일 다운로드 실패: $e');
    }
  }

  Future<List<drive.File>> listFiles() async {
    if (_appDataFolderId == null) {
      throw Exception('AppData 폴더가 초기화되지 않았습니다.');
    }

    try {
      final response = await _driveApi!.files.list(
        q: "'$_appDataFolderId' in parents",
        spaces: 'drive',
      );

      return response.files ?? [];
    } catch (e) {
      throw Exception('파일 목록 조회 실패: $e');
    }
  }

  Future<void> deleteFile(String fileId) async {
    try {
      await _driveApi!.files.delete(fileId);
    } catch (e) {
      throw Exception('파일 삭제 실패: $e');
    }
  }
}
