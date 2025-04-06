import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verymemo/features/cloud_sync/cloud_provider.dart';
import 'package:verymemo/features/cloud_sync/providers/google_drive_provider.dart';

class CloudSyncState {
  final bool isInitialized;
  final bool isSyncing;
  final String? error;

  CloudSyncState({
    this.isInitialized = false,
    this.isSyncing = false,
    this.error,
  });

  CloudSyncState copyWith({
    bool? isInitialized,
    bool? isSyncing,
    String? error,
  }) {
    return CloudSyncState(
      isInitialized: isInitialized ?? this.isInitialized,
      isSyncing: isSyncing ?? this.isSyncing,
      error: error ?? this.error,
    );
  }
}

class CloudSyncNotifier extends StateNotifier<CloudSyncState> {
  final Ref ref;

  CloudSyncNotifier(this.ref) : super(CloudSyncState());

  Future<void> initialize(CloudProvider provider) async {
    try {
      state = state.copyWith(isSyncing: true);
      switch (provider) {
        case CloudProvider.googleDrive:
          final googleDriveNotifier =
              ref.read(googleDriveSyncProvider(provider).notifier);
          await googleDriveNotifier.initialize();
          break;
        case CloudProvider.iCloud:
          // iCloud 초기화 로직 구현
          break;
      }
      state = state.copyWith(isInitialized: true, isSyncing: false);
    } catch (e) {
      print('클라우드 초기화 실패: $e');
      state = state.copyWith(
        isSyncing: false,
        error: e.toString(),
      );
    }
  }

  Future<void> sync(CloudProvider provider) async {
    try {
      state = state.copyWith(isSyncing: true);
      switch (provider) {
        case CloudProvider.googleDrive:
          final googleDriveNotifier =
              ref.read(googleDriveSyncProvider(provider).notifier);
          await googleDriveNotifier.sync();
          break;
        case CloudProvider.iCloud:
          // iCloud 동기화 로직 구현
          break;
      }
      state = state.copyWith(isSyncing: false);
    } catch (e) {
      print('클라우드 동기화 실패: $e');
      state = state.copyWith(
        isSyncing: false,
        error: e.toString(),
      );
    }
  }
}

final cloudSyncProvider =
    StateNotifierProvider<CloudSyncNotifier, CloudSyncState>((ref) {
  return CloudSyncNotifier(ref);
});

// 사용 예시:
// final googleDriveSync = ref.watch(cloudSyncProvider(CloudProvider.googleDrive));
// final iCloudSync = ref.watch(cloudSyncProvider(CloudProvider.iCloud));
