import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:verymemo/common/types/typedef.dart';
import 'package:verymemo/features/memo/data/data-sources/memo_local_data_source.dart';
import 'package:verymemo/features/memo/domain/models/memo_model.dart';
import 'package:verymemo/features/memo/domain/repositories/memo_repository.dart';

final memoRepositoryProvider = Provider<MemoRepository>((ref) {
  final memoLocalDataSource = ref.watch(memoLocalDataSourceProvider);
  return MemoRepositoryImpl(memoLocalDataSource);
});

class MemoRepositoryImpl implements MemoRepository {
  final MemoLocalDataSource localDataSource;

  MemoRepositoryImpl(this.localDataSource);

  @override
  Future<int> addMemo(MAP memo) async {
    return await localDataSource.addMemo(memo);
  }

  @override
  Future<MemoModel?> getMemo(int memoId) async {
    final map = await localDataSource.getMemo(memoId);
    if (map != null) {
      // 🔄 `MemoModel.fromJson`으로 변환해 반환
      return MemoModel.fromJson(map);
    }
    return null;
  }

  @override
  Future<List<MemoModel?>> getAllMemos() async {
    final maps = await localDataSource.getAllMemos();
    return maps.map((map) => MemoModel.fromJson(map)).toList(); // 🔄 리스트 변환
  }

  @override
  Future<int> updateMemo(int memoId, MAP memo) async {
    return await localDataSource.updateMemo(memoId, memo);
  }

  @override
  Future<int> deleteMemo(int memoId) async {
    return await localDataSource.deleteMemo(memoId);
  }
}
