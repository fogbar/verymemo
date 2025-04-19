import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:verymemo/features/cloud_sync/cloud_provider.dart';
import 'package:verymemo/features/cloud_sync/services/google_drive_service.dart';
import 'package:verymemo/features/memo/data/providers/memo_repository_provider.dart';

part 'google_drive_provider.g.dart';

@riverpod
GoogleDriveService googleDriveService(Ref ref) {
  final memoRepository = ref.watch(memoRepositoryProvider);
  return GoogleDriveService(ref: ref, memoRepository: memoRepository);
}

class GoogleDriveState {
  final bool isInitialized;
  final bool isSyncing;
  final String? error;

  GoogleDriveState({
    this.isInitialized = false,
    this.isSyncing = false,
    this.error,
  });

  GoogleDriveState copyWith({
    bool? isInitialized,
    bool? isSyncing,
    String? error,
  }) {
    return GoogleDriveState(
      isInitialized: isInitialized ?? this.isInitialized,
      isSyncing: isSyncing ?? this.isSyncing,
      error: error ?? this.error,
    );
  }
}

class GoogleDriveNotifier extends StateNotifier<GoogleDriveState> {
  final Ref ref;
  final GoogleDriveService _service;

  GoogleDriveNotifier(this.ref, CloudProvider provider)
      : _service = ref.read(googleDriveServiceProvider),
        super(GoogleDriveState());

  Future<void> initialize() async {
    try {
      state = state.copyWith(isSyncing: true);
      await _service.initialize();
      state = state.copyWith(isInitialized: true, isSyncing: false);
    } catch (e) {
      print('Google Drive 초기화 실패: $e');
      state = state.copyWith(
        isSyncing: false,
        error: e.toString(),
      );
    }
  }

  Future<void> sync() async {
    try {
      state = state.copyWith(isSyncing: true);
      await _service.sync();
      state = state.copyWith(isSyncing: false);
    } catch (e) {
      print('Google Drive 동기화 실패: $e');
      state = state.copyWith(
        isSyncing: false,
        error: e.toString(),
      );
    }
  }
}

final googleDriveSyncProvider = StateNotifierProvider.family<
    GoogleDriveNotifier, GoogleDriveState, CloudProvider>((ref, provider) {
  return GoogleDriveNotifier(ref, provider);
});
