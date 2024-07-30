class ShipmentCalculateReq {
  ShipmentCalculateReq({
    this.moneyCollection,
    this.senderProvinceId,
    this.senderDistrictId,
    this.senderWardsId,
    this.senderAddress,
    this.receiverProvinceId,
    this.receiverDistrictId,
    this.receiverWardsId,
    this.receiverAddress,
    this.weight = 0,
    this.length = 0,
    this.width = 0,
    this.height = 0,
  });

  double? moneyCollection;
  int? senderProvinceId;
  int? senderDistrictId;
  int? senderWardsId;
  String? senderAddress;
  int? receiverProvinceId;
  int? receiverDistrictId;
  int? receiverWardsId;
  String? receiverAddress;
  double? weight = 0;
  int? length = 0;
  int? width = 0;
  int? height = 0;

  Map<String, dynamic> toJson() => {
        "money_collection": moneyCollection == null ? null : moneyCollection,
        "sender_province_id":
            senderProvinceId == null ? null : senderProvinceId,
        "sender_district_id":
            senderDistrictId == null ? null : senderDistrictId,
        "sender_wards_id": senderWardsId == null ? null : senderWardsId,
        "sender_address": senderAddress == null ? null : senderAddress,
        "receiver_province_id":
            receiverProvinceId == null ? null : receiverProvinceId,
        "receiver_district_id":
            receiverDistrictId == null ? null : receiverDistrictId,
        "receiver_wards_id": receiverWardsId == null ? null : receiverWardsId,
        "receiver_address": receiverAddress == null ? null : receiverAddress,
        "weight": weight == null ? null : weight,
        "length": length == null ? null : length,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
      };
}
