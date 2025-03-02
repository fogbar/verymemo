import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class PlatformUtil {
  static Future<String?> getPlatformInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceId;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id; // 안드로이드 ID
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId =
          iosInfo.identifierForVendor ?? 'unknown_device_id'; // iOS의 Vendor ID
    } else if (Platform.isMacOS) {
      final macOsInfo = await deviceInfo.macOsInfo;
      deviceId = macOsInfo.computerName;
    } else if (Platform.isWindows) {
      final windowsInfo = await deviceInfo.windowsInfo;
      deviceId = windowsInfo.computerName;
    } else {
      deviceId = 'unknown_device_id';
    }
    return deviceId;
  }
}
