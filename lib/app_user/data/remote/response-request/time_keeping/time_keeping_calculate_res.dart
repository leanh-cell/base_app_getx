import 'package:com.ikitech.store/app_user/model/history_checkin_checkout.dart';
import 'package:com.ikitech.store/app_user/model/shifts.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';

class TimeKeepingCalculateRes {
  TimeKeepingCalculateRes({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  TimeKeepingCalculate? data;

  factory TimeKeepingCalculateRes.fromJson(Map<String, dynamic> json) =>
      TimeKeepingCalculateRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : TimeKeepingCalculate.fromJson(json["data"]),
      );
}

class TimeKeepingCalculate {
  TimeKeepingCalculate({
    this.dateFrom,
    this.dateTo,
    this.listStaffTimekeeping,
  });

  DateTime? dateFrom;
  DateTime? dateTo;
  List<ListStaffTimekeeping>? listStaffTimekeeping;

  factory TimeKeepingCalculate.fromJson(Map<String, dynamic> json) =>
      TimeKeepingCalculate(
        dateFrom: json["date_from"] == null
            ? null
            : DateTime.parse(json["date_from"]),
        dateTo:
            json["date_to"] == null ? null : DateTime.parse(json["date_to"]),
        listStaffTimekeeping: json["list_staff_timekeeping"] == null
            ? null
            : List<ListStaffTimekeeping>.from(json["list_staff_timekeeping"]
                .map((x) => ListStaffTimekeeping.fromJson(x))),
      );
}

class ListStaffTimekeeping {
  ListStaffTimekeeping({
    this.staff,
    this.totalSeconds,
    this.keepingHistories,
    this.totalSalary,
    this.recordingTime,
    this.salaryOneHour,
    this.shiftsWork,
  });

  Staff? staff;
  int? totalSeconds;
  double? totalSalary;
  double? salaryOneHour;
  List<RecordingTime>? recordingTime;
  List<HistoryCheckInCheckout>? keepingHistories;
  List<Shifts>? shiftsWork;

  factory ListStaffTimekeeping.fromJson(Map<String, dynamic> json) =>
      ListStaffTimekeeping(
        staff: json["staff"] == null ? null : Staff.fromJson(json["staff"]),
        totalSeconds:
            json["total_seconds"] == null ? null : json["total_seconds"],
        totalSalary: json["total_salary"] == null
            ? null
            : json["total_salary"].toDouble(),
        recordingTime: json["recording_time"] == null
            ? null
            : List<RecordingTime>.from(
                json["recording_time"].map((x) => RecordingTime.fromJson(x))),
        salaryOneHour: json["salary_one_hour"] == null
            ? null
            : json["salary_one_hour"].toDouble(),
        keepingHistories: json["keeping_histories"] == null
            ? null
            : List<HistoryCheckInCheckout>.from(json["keeping_histories"]
                .map((x) => HistoryCheckInCheckout.fromJson(x))),
        shiftsWork: json["shift_work"] == null
            ? null
            : List<Shifts>.from(
                json["shift_work"].map((x) => Shifts.fromJson(x))),
      );
}

class RecordingTime {
  RecordingTime({
    this.timeCheckIn,
    this.timeCheckOut,
    this.totalInTime,
    this.isBonus,
  });

  DateTime? timeCheckIn;
  DateTime? timeCheckOut;
  int? totalInTime;
  bool? isBonus;

  factory RecordingTime.fromJson(Map<String, dynamic> json) => RecordingTime(
        timeCheckIn: json["time_check_in"] == null
            ? null
            : DateTime.parse(json["time_check_in"]),
        timeCheckOut: json["time_check_out"] == null
            ? null
            : DateTime.parse(json["time_check_out"]),
        totalInTime:
            json["total_in_time"] == null ? null : json["total_in_time"],
    isBonus:
            json["is_bonus"] == null ? null : json["is_bonus"],
      );
}
