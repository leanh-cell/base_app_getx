import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/device.dart';

class DeviceController extends GetxController {
  var listDevice = RxList<Device>();
  var deviceCurrent = Device().obs;

  DeviceController() {
    getId();
    getAllDevice();
  }

  Future<void> getAllDevice() async {
    try {
      var data = await RepositoryManager.timeKeepingRepository.getAllDevice();
      listDevice(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addDevice() async {
    try {
      var data = await RepositoryManager.timeKeepingRepository
          .addDevice(device: deviceCurrent.value);
      getAllDevice();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceCurrent.value = Device(
        name: iosDeviceInfo.name,
        deviceId: iosDeviceInfo.identifierForVendor,
      );
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceCurrent.value = Device(
        name: androidDeviceInfo.device,
        deviceId: androidDeviceInfo.androidId,
      );
    }
  }
}
