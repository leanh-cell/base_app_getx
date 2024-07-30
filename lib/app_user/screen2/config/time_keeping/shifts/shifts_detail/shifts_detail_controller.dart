import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/shifts.dart';

class ShiftDetailController extends GetxController {
  Shifts? shiftsInput;
  TextEditingController nameShiftsEditingController = TextEditingController();
  TextEditingController codeShiftsEditingController = TextEditingController();
  TextEditingController lateShiftsEditingController = TextEditingController();
  TextEditingController earlyShiftsEditingController = TextEditingController();
  List<int> listDate = [2, 3, 4, 5, 6, 7, 8];
  var listDateChoose = RxList<int>();
  var configHigh = false.obs;
  var shifts = Shifts().obs;

  ShiftDetailController({this.shiftsInput}) {
    if (shiftsInput != null) {
      shifts.value = shiftsInput!;
      listDateChoose(shifts.value.daysOfWeekList);
      nameShiftsEditingController.text = shifts.value.name ?? "";
      codeShiftsEditingController.text = shifts.value.code ?? "";
      lateShiftsEditingController.text =
          (shifts.value.minutesLateAllow ?? 0).toString();
      earlyShiftsEditingController.text =
          (shifts.value.minutesEarlyLeaveAllow ?? 0).toString();
      if ((shifts.value.minutesLateAllow ?? 0) != 0 ||
          (shifts.value.minutesEarlyLeaveAllow ?? 0) != 0) {
        configHigh.value = true;
      }
    }
  }

  bool checkChoose(int date) {
    if (listDateChoose.contains(date)) return true;
    return false;
  }

  bool checkTimeEnd(
      int startHour, int startMinute, int endHour, int endMinute) {
    if (startHour == 0 && startMinute == 0 && endHour == 0 && endMinute == 0)
      return true;
    if (startHour < endHour) {
      return true;
    } else if (startHour > endHour) {
      return false;
    } else if (startHour == endHour) {
      if (startMinute < endMinute) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<void> addShift() async {
    try {
      if (listDateChoose.isEmpty) {
        SahaAlert.showError(message: "Chưa chọn ngày trong tuần");
        return;
      }
      shifts.value.daysOfWeek = listDateChoose;
      var data = await RepositoryManager.timeKeepingRepository
          .addShift(shifts: shifts.value);
      Get.back(result: "reload");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateShifts() async {
    try {
      if (listDateChoose.isEmpty) {
        SahaAlert.showError(message: "Chưa chọn ngày trong tuần");
        return;
      }
      shifts.value.daysOfWeek = listDateChoose;
      var data = await RepositoryManager.timeKeepingRepository
          .updateShifts(shifts: shifts.value, shiftsId: shiftsInput!.id!);
      Get.back(result: "reload");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteShifts() async {
    try {
      if (listDateChoose.isEmpty) {
        SahaAlert.showError(message: "Chưa chọn ngày trong tuần");
        return;
      }
      shifts.value.daysOfWeek = listDateChoose;
      var data = await RepositoryManager.timeKeepingRepository
          .deleteShifts(shiftsId: shiftsInput!.id!);
      Get.back(result: "reload");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
