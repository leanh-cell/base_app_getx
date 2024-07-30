class ScheduleNoti {
  ScheduleNoti({
    this.id,
    this.storeId,
    this.title,
    this.description,
    this.groupCustomer,
    this.timeOfDay,
    this.typeSchedule,
    this.timeRun,
    this.dayOfWeek,
    this.dayOfMonth,
    this.status,
    this.typeAction,
    this.valueAction,
    this.reminiscentName,
    this.createdAt,
    this.updatedAt,
    this.agencyTypeId,
    this.agencyTypeName,
  });

  int? id;
  int? storeId;
  String? title;
  String? description;
  int? groupCustomer;
  String? timeOfDay;
  int? typeSchedule;
  DateTime? timeRun;
  int? dayOfWeek;
  int? dayOfMonth;
  int? status;
  String? typeAction;
  String? valueAction;
  String? reminiscentName;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? agencyTypeId;
  String? agencyTypeName;

  factory ScheduleNoti.fromJson(Map<String, dynamic> json) => ScheduleNoti(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        groupCustomer:
            json["group_customer"] == null ? null : json["group_customer"],
        timeOfDay:
            json["time_of_day"] == null ? null : json["time_of_day"].toString(),
        typeSchedule:
            json["type_schedule"] == null ? null : json["type_schedule"],
        timeRun:
            json["time_run"] == null ? null : DateTime.parse(json["time_run"]),
        dayOfWeek: json["day_of_week"] == null ? null : json["day_of_week"],
        dayOfMonth: json["day_of_month"] == null ? null : json["day_of_month"],
        status: json["status"] == null ? null : json["status"],
        typeAction: json["type_action"] == null ? null : json["type_action"],
        valueAction: json["value_action"] == null ? null : json["value_action"],
        reminiscentName:
            json["reminiscent_name"] == null ? null : json["reminiscent_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        agencyTypeId: json["agency_type_id"],
        agencyTypeName: json["agency_type_name"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "group_customer": groupCustomer == null ? null : groupCustomer,
        "time_of_day": (timeOfDay == null ? "00:00:00" : timeOfDay)!
            .replaceAll(" AM", ":00")
            .replaceAll(" PM", ":00"),
        "type_schedule": typeSchedule == null ? null : typeSchedule,
        "time_run": timeRun == null ? null : timeRun!.toIso8601String(),
        "day_of_week": dayOfWeek == null ? null : dayOfWeek,
        "day_of_month": dayOfMonth == null ? null : dayOfMonth,
        "status": status == null ? null : status,
        "type_action": typeAction == null ? null : typeAction,
        "value_action": valueAction == null ? null : valueAction,
        "reminiscent_name": reminiscentName == null ? null : reminiscentName,
        "agency_type_id": agencyTypeId,
        "agency_type_name": agencyTypeName,
      };
}
