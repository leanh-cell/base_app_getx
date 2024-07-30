import 'ctv.dart';

class RequestPayment {
  RequestPayment({
    this.id,
    this.storeId,
    this.collaboratorId,
    this.money,
    this.status,
    this.from,
    this.createdAt,
    this.updatedAt,
    this.ctv,
    this.checkChoose = false,
  });

  int? id;
  int? storeId;
  int? collaboratorId;
  double? money;
  int? status;
  int? from;
  DateTime? createdAt;
  DateTime? updatedAt;
  Ctv? ctv;

  bool checkChoose;

  factory RequestPayment.fromJson(Map<String, dynamic> json) => RequestPayment(
    id: json["id"] == null ? null : json["id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    collaboratorId: json["collaborator_id"] == null ? null : json["collaborator_id"],
    money: json["money"] == null ? null : json["money"].toDouble(),
    status: json["status"] == null ? null : json["status"],
    from: json["from"] == null ? null : json["from"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    ctv: json["collaborator"] == null ? null : Ctv.fromJson(json["collaborator"]),
  );

}
