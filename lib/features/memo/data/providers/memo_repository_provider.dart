import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/memo/data/data-sources/memo_local_data_source.dart';
import 'package:verymemo/features/memo/data/data-sources/memo_remote_data_source.dart';
import 'package:verymemo/features/memo/data/repositories/memo_repository_impl.dart';

final memoRepositoryProvider = Provider<MemoRepositoryImpl>((ref) {
  final memoLocalDataSource = ref.watch(memoLocalDataSourceProvider);
  final memoRemoteDataSource = ref.watch(memoRemoteDataSourceProvider);
  return MemoRepositoryImpl(memoLocalDataSource, memoRemoteDataSource);
});
