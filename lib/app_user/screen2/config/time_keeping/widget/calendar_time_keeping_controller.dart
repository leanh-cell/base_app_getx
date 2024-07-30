import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';

class CalendarTimeKeepingController extends GetxController {
  var textType = "Tuần".obs;
  List<String> listType = ["Ngày", "Tuần", "Tháng", "Tuỳ chọn"];
  var dateFrom = DateTime.now().obs;
  var dateTo = DateTime.now().obs;
  bool? isCreate;

  CalendarTimeKeepingController({this.isCreate}) {
    dateFrom.value = SahaDateUtils().getFirstDayOfWeekDATETIME();
    dateTo.value = SahaDateUtils().getEndDayOfWeekDATETIME();
    if (isCreate == true) {
      if (checkPast(dateFrom.value) == true) {
        dateFrom.value = DateTime.now();
      }
    }
  }

  bool checkPast(DateTime date) {
    if (date.isBefore(DateTime.now()) ||
        date.isAtSameMomentAs(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }

  void changeType() {
    if (textType.value == "Ngày") {
      dateFrom.value = SahaDateUtils().getDate(DateTime.now());
      dateTo.value = SahaDateUtils().getDate(DateTime.now());
    }

    if (textType.value == "Tuần") {
      dateFrom.value = SahaDateUtils().getFirstDayOfWeekDATETIME();
      dateTo.value = SahaDateUtils().getEndDayOfWeekDATETIME();
    }

    if (textType.value == "Tháng") {
      dateTo.value = SahaDateUtils().getEndDayOfMonthDateTime();
      dateFrom.value = DateTime(dateTo.value.year, dateTo.value.month, 1);
      // dateTo.value = SahaDateUtils().getEndDayOfMonthDateTime();
    }

    if (textType.value == "Tuỳ chọn") {}

    if (isCreate == true) {
      if (checkPast(dateFrom.value) == true) {
        dateFrom.value = DateTime.now();
      }
    }
  }

  DateTime castDate(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0, 0, 0);
  }

  void controllerDate({required isNext}) {
    if (textType.value == "Tuần") {
      print(dateFrom.value);
      print(SahaDateUtils().getFirstDayOfWeekDATETIME());
      if (castDate(dateFrom.value)
              .isAfter(castDate(SahaDateUtils().getFirstDayOfWeekDATETIME())) &&
          castDate(dateTo.value).isAtSameMomentAs(
              castDate(SahaDateUtils().getEndDayOfWeekDATETIME()))) {
        print("========");
        dateFrom.value = SahaDateUtils().getFirstDayOfWeekDATETIME();
      }
      if (isNext == true) {
        dateFrom.value = dateFrom.value.add(Duration(days: 7));
        dateTo.value = dateTo.value.add(Duration(days: 7));
      } else {
        dateFrom.value = dateFrom.value.subtract(Duration(days: 7));
        dateTo.value = dateTo.value.subtract(Duration(days: 7));
      }
    }

    if (textType.value == "Ngày") {
      if (isNext == true) {
        dateFrom.value = dateFrom.value.add(Duration(days: 1));
        dateTo.value = dateTo.value.add(Duration(days: 1));
      } else {
        dateFrom.value = dateFrom.value.subtract(Duration(days: 1));
        dateTo.value = dateTo.value.subtract(Duration(days: 1));
      }
    }

    if (textType.value == "Tháng") {
      if (castDate(dateFrom.value).isAfter(castDate(
              DateTime(dateFrom.value.year, dateFrom.value.month, 1))) &&
          castDate(dateTo.value).isAtSameMomentAs(
              castDate(SahaDateUtils().getEndDayOfMonthDateTime()))) {
        dateFrom.value = DateTime(dateFrom.value.year, dateFrom.value.month, 1);
      }
      if (isNext == true) {
        dateFrom.value =
            DateTime(dateFrom.value.year, dateFrom.value.month + 1, 1);
        int lastDateOfMonth =
            DateTime(dateFrom.value.year, dateFrom.value.month + 1, 0).day;
        dateTo.value = DateTime(
            dateTo.value.year, dateTo.value.month + 1, lastDateOfMonth);
      } else {
        int lastDateOfMonth =
            DateTime(dateFrom.value.year, dateFrom.value.month, 0).day;
        dateFrom.value =
            DateTime(dateFrom.value.year, dateFrom.value.month - 1, 1);
        dateTo.value = DateTime(
            dateTo.value.year, dateTo.value.month - 1, lastDateOfMonth);
      }
    }

    if (isCreate == true) {
      if (checkPast(dateFrom.value) == true) {
        dateFrom.value = DateTime.now();
      }
    }
  }
}
