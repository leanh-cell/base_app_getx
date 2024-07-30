class Shifts {
  Shifts({
    this.id,
    this.storeId,
    this.branchId,
    this.name,
    this.code,
    this.startWorkHour,
    this.startWorkMinute,
    this.endWorkHour,
    this.endWorkMinute,
    this.startBreakHour,
    this.startBreakMinute,
    this.endBreakHour,
    this.endBreakMinute,
    this.minutesLateAllow,
    this.minutesEarlyLeaveAllow,
    this.daysOfWeek,
    this.createdAt,
    this.updatedAt,
    this.daysOfWeekList,
  });

  int? id;
  int? storeId;
  int? branchId;
  String? name;
  String? code;
  int? startWorkHour;
  int? startWorkMinute;
  int? endWorkHour;
  int? endWorkMinute;
  int? startBreakHour;
  int? startBreakMinute;
  int? endBreakHour;
  int? endBreakMinute;
  int? minutesLateAllow;
  int? minutesEarlyLeaveAllow;
  List<int>? daysOfWeek;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<int>? daysOfWeekList;

  factory Shifts.fromJson(Map<String, dynamic> json) {
    List<int> listSort = json["days_of_week_list"] == null
        ? []
        : List<int>.from(json["days_of_week_list"].map((x) => x));

    listSort.sort();

    return Shifts(
      id: json["id"] == null ? null : json["id"],
      storeId: json["store_id"] == null ? null : json["store_id"],
      branchId: json["branch_id"] == null ? null : json["branch_id"],
      name: json["name"] == null ? null : json["name"],
      code: json["code"] == null ? null : json["code"],
      startWorkHour:
          json["start_work_hour"] == null ? null : json["start_work_hour"],
      startWorkMinute:
          json["start_work_minute"] == null ? null : json["start_work_minute"],
      endWorkHour: json["end_work_hour"] == null ? null : json["end_work_hour"],
      endWorkMinute:
          json["end_work_minute"] == null ? null : json["end_work_minute"],
      startBreakHour: json["start_break_hour"],
      startBreakMinute: json["start_break_minute"],
      endBreakHour: json["end_break_hour"],
      endBreakMinute: json["end_break_minute"],
      minutesLateAllow: json["minutes_late_allow"] == null
          ? null
          : json["minutes_late_allow"],
      minutesEarlyLeaveAllow: json["minutes_early_leave_allow"] == null
          ? null
          : json["minutes_early_leave_allow"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      daysOfWeekList: listSort,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "branch_id": branchId == null ? null : branchId,
        "name": name == null ? null : name,
        "code": code == null ? null : code,
        "start_work_hour": startWorkHour == null ? null : startWorkHour,
        "start_work_minute": startWorkMinute == null ? null : startWorkMinute,
        "end_work_hour": endWorkHour == null ? null : endWorkHour,
        "end_work_minute": endWorkMinute == null ? null : endWorkMinute,
        "start_break_hour": startBreakHour,
        "start_break_minute": startBreakMinute,
        "end_break_hour": endBreakHour,
        "end_break_minute": endBreakMinute,
        "minutes_late_allow":
            minutesLateAllow == null ? null : minutesLateAllow,
        "minutes_early_leave_allow":
            minutesEarlyLeaveAllow == null ? null : minutesEarlyLeaveAllow,
        "days_of_week": daysOfWeek == null
            ? null
            : List<dynamic>.from(daysOfWeek!.map((x) => x)),
        // "days_of_week_list": daysOfWeekList == null
        //     ? null
        //     : List<dynamic>.from(daysOfWeekList!.map((x) => x)),
      };
}
