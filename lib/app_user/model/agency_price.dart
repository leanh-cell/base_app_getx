
import 'package:sahashop_customer/app_customer/model/product.dart';

class AgencyPrice {
  AgencyPrice({
    this.mainPrice,
    this.distributes,
  });

  int? mainPrice;
  List<Distributes>? distributes;

  factory AgencyPrice.fromJson(Map<String, dynamic> json) => AgencyPrice(
    mainPrice: json["main_price"] == null ? null : json["main_price"],
    distributes: json["distributes"] == null ? null : List<Distributes>.from(json["distributes"].map((x) => Distributes.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "main_price": mainPrice == null ? null : mainPrice,
    "distributes": distributes == null ? null : List<dynamic>.from(distributes!.map((x) => x.toJson())),
  };
}