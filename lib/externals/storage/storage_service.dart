import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  Future<void> init();

  Future<Object?> get({required String key});

  Future<bool> set({required String key, required Object data});

  Future<bool> has({required String key});

  Future<bool> remove({required String key});

  Future<void> clear();

  Future<Set<String>> getKeys();
}

final storageProvider = Provider<StorageService>((ref) {
  final StorageServiceImpl storageService = StorageServiceImpl();
  storageService.init();
  return storageService;
});

class StorageServiceImpl implements StorageService {
  late SharedPreferences sharedPreferences;
  // SharedPreferences? sharedPreferences;
  final Completer<SharedPreferences> initCompleter = Completer();

  @override
  Future<void> init() async {
    initCompleter.complete(SharedPreferences.getInstance());
  }

  @override
  Future<dynamic> get({required String key}) async {
    sharedPreferences = await initCompleter.future;
    log("[Get $key]", name: "get $key");
    return sharedPreferences.get(key);
  }

  @override
  Future<bool> set({required String key, required Object data}) async {
    sharedPreferences = await initCompleter.future;
    log("[Set $key]", name: "set $key");
    return await sharedPreferences.setString(key, data.toString());
  }

  @override
  Future<bool> has({required String key}) async {
    sharedPreferences = await initCompleter.future;
    log("[Has $key]", name: "has $key");
    return sharedPreferences.containsKey(key);
  }

  @override
  Future<bool> remove({required String key}) async {
    sharedPreferences = await initCompleter.future;
    log("[remove $key]", name: "remove $key");
    return await sharedPreferences.remove(key);
  }

  @override
  Future<void> clear() async {
    sharedPreferences = await initCompleter.future;
    log("[Clear]", name: "clear");
    await sharedPreferences.clear();
  }

  @override
  Future<Set<String>> getKeys() async {
    sharedPreferences = await initCompleter.future;
    log("[Get Keys]", name: "getKeys");
    return sharedPreferences.getKeys();
  }
}
