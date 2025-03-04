import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:verymemo/common/types/typedef.dart';
import 'package:verymemo/features/memo/data/data-sources/memo_local_data_source.dart';
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
  Future<MAP?> getMemo(int memoId) async {
    return await localDataSource.getMemo(memoId);
  }

  @override
  Future<List<MAP?>> getAllMemos() async {
    return await localDataSource.getAllMemos();
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
