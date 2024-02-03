import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceIdGenerator {
  Future<String?> getDeviceId()async{
    if (Platform.isAndroid) {
      const _androidIdPlugin = AndroidId();
      final String? androidId = await _androidIdPlugin.getId();
      return androidId;
    }
    if(Platform.isIOS){
      var _deviceInfo = DeviceInfoPlugin();
      var _iosDeviceinfo = await _deviceInfo.iosInfo;
      final String? iosId = _iosDeviceinfo.identifierForVendor;
      return iosId;
    }
    return null;
  }
}