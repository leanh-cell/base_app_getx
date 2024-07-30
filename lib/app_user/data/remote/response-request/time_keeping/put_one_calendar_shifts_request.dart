
class PutOneCalendarShiftsRequest {
  PutOneCalendarShiftsRequest({
    this.date,
    this.shiftId,
    this.listStaffId,
  });

  DateTime? date;
  int? shiftId;
  List<int>? listStaffId;


  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date!.toIso8601String(),
    "shift_id": shiftId == null ? null : shiftId,
    "list_staff_ids": listStaffId == null ? null : List<int>.from(listStaffId!.map((x) => x)),
  };
}

