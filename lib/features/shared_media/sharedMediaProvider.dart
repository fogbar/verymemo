import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

// 외부 앱에서 공유하기로 받아온 미디어 들을 관리하는 프로바이더
// 앱 라이프사이클 프로바이더에서 관리
final sharedMediaProvider = StateNotifierProvider.autoDispose<
    SharedMediaNotifier, List<SharedMediaFile>>((ref) {
  // final navigationService = ref.watch(navigationServiceProvider);
  // final storageService = ref.watch(storageProvider);
  // return SharedMediaNotifier(navigationService, storageService);
  return SharedMediaNotifier();
});

class SharedMediaNotifier extends StateNotifier<List<SharedMediaFile>> {
  StreamSubscription? _intentSub;

  SharedMediaNotifier() : super([]) {
    _initStream();
    _handleInitialMedia();
  }

  void _initStream() {
    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen((value) {
      state = value;
      print(value.map((f) => f.toMap()));
    }, onError: (err) {
      print("Stream error: $err");
    });
  }

  Future<void> _handleInitialMedia() async {
    final initialMedia = await ReceiveSharingIntent.instance.getInitialMedia();
    state = initialMedia;
    ReceiveSharingIntent.instance.reset();
  }

  @override
  void dispose() {
    _intentSub?.cancel();
    super.dispose();
  }
}
