import 'dart:convert';

StateOrder stateOrderFromJson(String str) =>
    StateOrder.fromJson(json.decode(str));

String stateOrderToJson(StateOrder data) => json.encode(data.toJson());

class StateOrder {
  StateOrder({
    this.id,
    this.orderId,
    this.author,
    this.note,
    this.customerCantSee,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? orderId;
  int? author;
  String? note;
  bool? customerCantSee;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory StateOrder.fromJson(Map<String, dynamic> json) => StateOrder(
        id: json["id"],
        orderId: json["order_id"],
        author: json["author"],
        note: json["note"],
        customerCantSee: json["customer_cant_see"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "author": author,
        "note": note,
        "customer_cant_see": customerCantSee,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
