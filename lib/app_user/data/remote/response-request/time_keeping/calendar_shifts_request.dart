// To parse this JSON data, do
//
//     final calendarShiftsRequest = calendarShiftsRequestFromJson(jsonString);

import 'dart:convert';

CalendarShiftsRequest calendarShiftsRequestFromJson(String str) =>
    CalendarShiftsRequest.fromJson(json.decode(str));

String calendarShiftsRequestToJson(CalendarShiftsRequest data) =>
    json.encode(data.toJson());

class CalendarShiftsRequest {
  CalendarShiftsRequest({
    this.startTime,
    this.endTime,
    this.listStaffId,
    this.listShiftId,
  });

  DateTime? startTime;
  DateTime? endTime;
  List<int>? listStaffId;
  List<int>? listShiftId;

  factory CalendarShiftsRequest.fromJson(Map<String, dynamic> json) =>
      CalendarShiftsRequest(
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        listStaffId: json["list_staff_id"] == null
            ? null
            : List<int>.from(json["list_staff_id"].map((x) => x)),
        listShiftId: json["list_shift_id"] == null
            ? null
            : List<int>.from(json["list_shift_id"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "start_time": startTime == null ? null : startTime!.toIso8601String(),
        "end_time": endTime == null ? null : endTime!.toIso8601String(),
        "list_staff_id": listStaffId == null
            ? null
            : List<dynamic>.from(listStaffId!.map((x) => x)),
        "list_shift_id": listShiftId == null
            ? null
            : List<dynamic>.from(listShiftId!.map((x) => x)),
      };
}
