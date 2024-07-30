import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/checkin_location.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class AddCheckInLocationController extends GetxController {
  TextEditingController nameEditingController = TextEditingController();
  var checkInLocation = CheckInLocation().obs;
  final _networkInfo = NetworkInfo();
  CheckInLocation? checkInLocationInput;

  AddCheckInLocationController({this.checkInLocationInput}) {
    if (checkInLocationInput != null) {
      checkInLocation.value = checkInLocationInput!;
      nameEditingController.text = checkInLocationInput!.name ?? "";
    }
    _initNetworkInfo();
  }

  Future<void> deleteCheckInLocation() async {
    try {
      var data = await RepositoryManager.timeKeepingRepository
          .deleteCheckInLocation(checkInLocationId: checkInLocation.value.id!);
      Get.back(result: "reload");
      SahaAlert.showSuccess(message: "Xoá thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateCheckInLocation() async {
    try {
      var data = await RepositoryManager.timeKeepingRepository
          .updateCheckInLocation(
              checkInLocation: checkInLocation.value,
              checkInLocationId: checkInLocation.value.id!);
      Get.back(result: "reload");
      SahaAlert.showSuccess(message: "Thêm thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addCheckInLocation() async {
    try {
      var data = await RepositoryManager.timeKeepingRepository
          .addCheckInLocation(checkInLocation: checkInLocation.value);
      Get.back(result: "reload");
      SahaAlert.showSuccess(message: "Thêm thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> _initNetworkInfo() async {
    String? wifiName, wifiBSSID;
    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiName = await _networkInfo.getWifiName();
        } else {
          wifiName = await _networkInfo.getWifiName();
        }
      } else {
        if (Platform.isAndroid) {
          print('Checking Android permissions');
          var status = await Permission.location.status;
          // Blocked?
          if (status.isLimited || status.isDenied || status.isRestricted) {
            // Ask the user to unblock
            if (await Permission.location.request().isGranted) {
              wifiName = await _networkInfo.getWifiName();
              print('Location permission granted');
            } else {
              print('Location permission not granted');
            }
          } else {
            wifiName = await _networkInfo.getWifiName();
            print('Permission already granted (previous execution?)');
          }
        }

      }
    } on PlatformException catch (e) {
      log('Failed to get Wifi Name', error: e);
      wifiName = 'Failed to get Wifi Name';
    }

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        } else {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        }
      } else {
        wifiBSSID = await _networkInfo.getWifiBSSID();
      }
    } on PlatformException catch (e) {
      log('Failed to get Wifi BSSID', error: e);
      wifiBSSID = 'Failed to get Wifi BSSID';
    }

    checkInLocation.value.wifiName = wifiName;
    checkInLocation.value.wifiMac = wifiBSSID;
    checkInLocation.refresh();
  }
}
