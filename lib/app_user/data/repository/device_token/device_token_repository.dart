import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/device_token/device_token_user_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';

import '../handle_error.dart';

class DeviceTokenRepository {
  Future<DeviceTokenUser?> updateDeviceTokenUser(String? deviceToken) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }

    try {
      var res = await SahaServiceManager().service!.updateDeviceTokenUser({
        "device_token": deviceToken,
        "device_id": deviceId,
        "device_type": Platform.isAndroid ? 0 : 1,
      });

      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
