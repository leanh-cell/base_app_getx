
import 'package:com.ikitech.store/app_user/model/shifts.dart';

class CalendarShiftsRes {
  CalendarShiftsRes({
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
  List<CalendarShifts>? data;

  factory CalendarShiftsRes.fromJson(Map<String, dynamic> json) =>
      CalendarShiftsRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : List<CalendarShifts>.from(
                json["data"].map((x) => CalendarShifts.fromJson(x))),
      );
}

class CalendarShifts {
  CalendarShifts({
    this.shifts,
    this.hasStaff,
    this.staffInTime,
  });

  Shifts? shifts;
  bool? hasStaff;
  List<StaffInTime>? staffInTime;

  factory CalendarShifts.fromJson(Map<String, dynamic> json) => CalendarShifts(
        shifts: json["shift"] == null ? null : Shifts.fromJson(json["shift"]),
        hasStaff: json["has_staff"] == null ? null : json["has_staff"],
        staffInTime: json["staff_in_time"] == null
            ? null
            : List<StaffInTime>.from(
                json["staff_in_time"].map((x) => StaffInTime.fromJson(x))),
      );
}

class StaffInTime {
  StaffInTime({
    this.date,
    this.staffWork,
  });

  DateTime? date;
  List<StaffWork>? staffWork;

  factory StaffInTime.fromJson(Map<String, dynamic> json) => StaffInTime(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        staffWork: json["staff_work"] == null
            ? null
            : List<StaffWork>.from(
                json["staff_work"].map((x) => StaffWork.fromJson(x))),
      );
}

class StaffWork {
  StaffWork({
    this.name,
    this.id,
    this.avatarImage,
  });

  String? name;
  int? id;
  String? avatarImage;

  factory StaffWork.fromJson(Map<String, dynamic> json) => StaffWork(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
        avatarImage: json["avatar_image"] == null ? null : json["avatar_image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "id": id == null ? null : id,
        "avatar_image": avatarImage,
      };
}
