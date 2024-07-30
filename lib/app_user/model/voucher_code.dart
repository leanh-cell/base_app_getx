import 'package:com.ikitech.store/app_user/model/info_customer.dart';

class VoucherCode {
  int? id;
  String? code;
  int? status;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? useTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  InfoCustomer? customer;

  VoucherCode({
    this.id,
    this.code,
    this.status,
    this.startTime,
    this.endTime,
    this.useTime,
    this.createdAt,
    this.updatedAt,
    this.customer,
  });

  factory VoucherCode.fromJson(Map<String, dynamic> json) => VoucherCode(
        id: json["id"],
        code: json["code"],
        status: json["status"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        useTime:
            json["use_time"] == null ? null : DateTime.parse(json["use_time"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        customer: json["customer"] == null
            ? null
            : InfoCustomer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "status": status,
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "use_time": useTime,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "customer": customer,
      };
}
