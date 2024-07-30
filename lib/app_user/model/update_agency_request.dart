class UpdatePriceAgencyRequest {
  UpdatePriceAgencyRequest({
    this.agencyTypeId,
    this.mainPrice,
    this.elementDistributesPrice,
    this.subElementDistributesPrice,
  });

  int? agencyTypeId;
  double? mainPrice;
  List<ElementDistributesPrice>? elementDistributesPrice;
  List<ElementDistributesPrice>? subElementDistributesPrice;

  Map<String, dynamic> toJson() => {
    "agency_type_id": agencyTypeId == null ? null : agencyTypeId,
    "main_price": mainPrice == null ? null : mainPrice,
    "element_distributes_price": elementDistributesPrice == null ? null : List<dynamic>.from(elementDistributesPrice!.map((x) => x.toJson())),
    "sub_element_distributes_price": subElementDistributesPrice == null ? null : List<dynamic>.from(subElementDistributesPrice!.map((x) => x.toJson())),
  };
}

class ElementDistributesPrice {
  ElementDistributesPrice({
    this.distributeName,
    this.elementDistribute,
    this.price,
    this.subElementDistribute,
  });

  String? distributeName;
  String? elementDistribute;
  double? price;
  String? subElementDistribute;

  Map<String, dynamic> toJson() => {
    "distribute_name": distributeName == null ? null : distributeName,
    "element_distribute": elementDistribute == null ? null : elementDistribute,
    "price": price == null ? null : price,
    "sub_element_distribute": subElementDistribute == null ? null : subElementDistribute,
  };
}
