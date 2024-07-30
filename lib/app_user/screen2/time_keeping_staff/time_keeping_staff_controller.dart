import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:custom_timer/custom_timer.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/checkin_checkout_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/checkin_location.dart';
import 'package:com.ikitech.store/app_user/model/device.dart';
import 'package:com.ikitech.store/app_user/model/history_checkin_checkout.dart';
import 'package:com.ikitech.store/app_user/model/shifts.dart';
import 'package:network_info_plus/network_info_plus.dart';

class TimeKeepingStaffController extends GetxController {
  var listShifts = RxList<Shifts>();
  var listHistory = RxList<HistoryCheckInCheckout>();
  final _networkInfo = NetworkInfo();
  var checkInLocation = CheckInLocation().obs;
  var listCheckInLCT = RxList<CheckInLocation>();
  var checkInCheckOutRequest = CheckInCheckOutRequest().obs;
  var isInShift = false.obs;
  var timeSpacer = Duration();
  var timeWorked = 0;
  var process = 0.0.obs;
  var isLoading = false.obs;
  var deviceCurrent = Device().obs;
  var listDevice = RxList<Device>();
  var initTime = Duration().obs;
  int endWorkHour = 0;
  int endWorkMinute = 0;

  CustomTimerController controllerTimer = CustomTimerController();

  late Timer timer;

  TimeKeepingStaffController() {
    getId();
    getCheckInLocation();
    getTimeKeepingToday();
  }

  void startTimerLoadData() {
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        calculatorProcess();
      },
    );
  }

  void checkLocation() {
    var wifiReal = checkInLocation.value;
    for (var check in listCheckInLCT) {
      if (check.wifiName == wifiReal.wifiName &&
          check.wifiMac == wifiReal.wifiMac) {
        checkInCheckOutRequest.value.wifiMac = wifiReal.wifiMac;
        checkInCheckOutRequest.value.wifiName = wifiReal.wifiName;
        break;
      }
    }
  }

  Future<void> getAllDevice() async {
    try {
      var data = await RepositoryManager.timeKeepingRepository.getAllDevice();
      var list = data!.data!.where((e) => e.status == 1).toList();
      listDevice(list);
      if (listDevice
          .map((e) => e.deviceId)
          .toList()
          .contains(deviceCurrent.value.deviceId)) {
        checkInCheckOutRequest.value.deviceId = deviceCurrent.value.deviceId;
        checkInCheckOutRequest.value.deviceName = deviceCurrent.value.name;
      }
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
      getAllDevice();
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceCurrent.value = Device(
        name: androidDeviceInfo.device,
        deviceId: androidDeviceInfo.androidId,
      );
      getAllDevice();
    }
  }

  void checkShiftCurrent() {
    timeSpacer = Duration();
    var timeNow = DateTime.now();
    var endMax = 0;
    var startMin = 0;
    var timeBreak = Duration();
    var durationStart = Duration();
    var durationEnd = Duration();
    if (listShifts.isNotEmpty) {
      startMin = (listShifts[0].startWorkHour ?? 0) * 10000 +
          ((listShifts[0].startWorkMinute ?? 0) * 100) +
          00;
      durationStart = Duration(
          hours: (listShifts[0].startWorkHour ?? 0),
          minutes: (listShifts[0].startWorkMinute ?? 0),
          seconds: 0);
    }
    for (var i = 0; i < listShifts.length; i++) {
      var check = listShifts[i];
      var start = (check.startWorkHour ?? 0) * 10000 +
          ((check.startWorkMinute ?? 0) * 100) +
          00;
      var end = (check.endWorkHour ?? 0) * 10000 +
          ((check.endWorkMinute ?? 0) * 100) +
          00;

      if (end >= endMax) {
        endMax = end;
        durationEnd = Duration(
            hours: (check.endWorkHour ?? 0),
            minutes: (check.endWorkMinute ?? 0),
            seconds: 0);
        endWorkHour = check.endWorkHour ?? 0;
        endWorkMinute = check.endBreakMinute ?? 0;
      }

      if (start <= startMin) {
        startMin = start;
        durationStart = Duration(
            hours: (check.startWorkHour ?? 0),
            minutes: (check.startWorkMinute ?? 0),
            seconds: 0);
      }

      if (i > 0) {
        var checkBefore = listShifts[i - 1];
        var endBefore = (checkBefore.endWorkHour ?? 0) * 10000 +
            ((checkBefore.endWorkMinute ?? 0) * 100) +
            00;

        if (endBefore > start) {
        } else {
          timeBreak = timeBreak +
              (Duration(
                      hours: (check.startWorkHour ?? 0),
                      minutes: (check.startWorkMinute ?? 0),
                      seconds: 0) -
                  Duration(
                      hours: (checkBefore.endWorkHour ?? 0),
                      minutes: (checkBefore.endWorkMinute ?? 0),
                      seconds: 0));
        }
      }
    }

    var timeCheck = timeNow.hour * 10000 + (timeNow.minute * 100) + 00;

    if (startMin <= timeCheck && timeCheck <= endMax) {
      isInShift.value = true;
    }

    print(timeBreak);

    timeSpacer = durationEnd - durationStart - timeBreak;
    print(timeSpacer);
    controllerTimer.start();
    startTimerLoadData();
  }

  bool checkInShift(Shifts shifts) {
    var timeNow = DateTime.now();

    var start = (shifts.startWorkHour ?? 0) * 10000 +
        ((shifts.startWorkMinute ?? 0) * 100) +
        00;
    var end = (shifts.endWorkHour ?? 0) * 10000 +
        ((shifts.endWorkMinute ?? 0) * 100) +
        00;

    var timeCheck = timeNow.hour * 10000 + (timeNow.minute * 100) + 00;

    if (start <= timeCheck && timeCheck <= end) {
      return true;
    } else {
      return false;
    }
  }

  void calculatorProcess() {
    process.value =
        timeWorked / (timeSpacer.inSeconds == 0 ? 1 : timeSpacer.inSeconds);
  }

  Future<void> getCheckInLocation() async {
    isLoading.value = true;
    try {
      var data =
          await RepositoryManager.timeKeepingRepository.getCheckInLocation();
      listCheckInLCT(data!.data!);
      await _initNetworkInfo();
      checkLocation();
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getTimeKeepingToday() async {
    try {
      var data =
          await RepositoryManager.timeKeepingRepository.getTimeKeepingToday();
      listShifts(data!.data!.shiftWorking);
      listHistory(data.data!.historyCheckinCheckout);
      calculateTimeInit();
      checkShiftCurrent();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void calculateTimeInit() {
    initTime.value = Duration();

    if (listHistory.isEmpty) return;
    if (listHistory.last.isCheckin == true) {
      for (var i = 0; i < listHistory.reversed.length; i++) {
        var his = listHistory.reversed.toList()[i];
        if (his.isCheckin == false) {
          var hisBefore = listHistory.reversed.toList()[i - 1];
          var duration = Duration(
              hours: hisBefore.timeCheck!.hour - his.timeCheck!.hour,
              minutes: hisBefore.timeCheck!.minute - his.timeCheck!.minute,
              seconds: hisBefore.timeCheck!.second - his.timeCheck!.second);
          initTime.value = initTime.value + duration;
        }
      }
    } else {
      var list = listHistory.reversed.toList();
      list.removeAt(0);
      for (var i = 0; i < list.length; i++) {
        var his = list.toList()[i];
        if (his.isCheckin == false) {
          var hisBefore = list.toList()[i - 1];
          var duration = Duration(
              hours: hisBefore.timeCheck!.hour - his.timeCheck!.hour,
              minutes: hisBefore.timeCheck!.minute - his.timeCheck!.minute,
              seconds: hisBefore.timeCheck!.second - his.timeCheck!.second);
          initTime.value = initTime.value + duration;
        }
      }
    }
  }

  Future<void> checkInCheckOut() async {
    try {
      print(checkInCheckOutRequest.value.deviceId);
      var data = await RepositoryManager.timeKeepingRepository.checkInCheckOut(
          checkInCheckOutRequest: checkInCheckOutRequest.value);
       listShifts(data!.data!.shiftWorking);
      listHistory(data.data!.historyCheckinCheckout);
      timer.cancel();
       calculateTimeInit();
       checkShiftCurrent();
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
        wifiName = await _networkInfo.getWifiName();
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
