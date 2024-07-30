class Gift {
  Gift({
    this.id,
    this.storeId,
    this.spinWheelId,
    this.userId,
    this.name,
    this.imageUrl,
    this.typeGift,
    this.amountCoin,
    this.percentReceived,
    this.amountGift,
    this.valueGift,
    this.text,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  int? spinWheelId;
  int? userId;
  String? name;
  String? imageUrl;
  int? typeGift;
  int? amountCoin;
  double? percentReceived;
  int? amountGift;
  String? valueGift;
  dynamic text;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Gift.fromJson(Map<String, dynamic> json) => Gift(
        id: json["id"],
        storeId: json["store_id"],
        spinWheelId: json["spin_wheel_id"],
        userId: json["user_id"],
        name: json["name"],
        imageUrl: json["image_url"],
        typeGift: json["type_gift"],
        amountCoin: json["amount_coin"],
        percentReceived: json["percent_received"].toDouble(),
        amountGift: json["amount_gift"],
        valueGift: json["value_gift"],
        text: json["text"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "spin_wheel_id": spinWheelId,
        "user_id": userId,
        "name": name,
        "image_url": imageUrl,
        "type_gift": typeGift,
        "amount_coin": amountCoin ?? 0,
        "percent_received": percentReceived,
        "amount_gift": amountGift,
        "value_gift": valueGift,
        "text": text,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
