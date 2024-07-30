class OrderRequest {
  OrderRequest({
    this.paymentMethodId,
    this.partnerShipperId,
    this.shipperType,
    this.totalShippingFee,
    this.customerAddressId,
    this.customerNote,
    this.collaboratorId,
    this.codeVoucher,
    this.agencyByCustomerId,
    this.isUsedPiont,
    this.isUseBalanceCollaborator,
    this.name,
    this.phone,
    this.addressDetail,
    this.province,
    this.district,
    this.wards,
    this.fromPos = true,
  });

  int? paymentMethodId;
  int? partnerShipperId;
  int? shipperType;
  int? totalShippingFee;
  int? customerAddressId;
  String? name;
  String? phone;
  String? customerNote;
  int? collaboratorId;
  int? agencyByCustomerId;
  String? codeVoucher;
  bool? isUsedPiont;
  bool? isUseBalanceCollaborator;
  String? addressDetail;
  int? province;
  int? district;
  int? wards;
  bool fromPos = true;

  Map<String, dynamic> toJson() => {
        "payment_method_id": paymentMethodId,
        "partner_shipper_id": partnerShipperId,
        "shipper_type": shipperType,
        "total_shipping_fee": totalShippingFee,
        "customer_address_id": customerAddressId,
        "customer_note": customerNote,
        "collaborator_by_customer_id": collaboratorId,
        "agency_by_customer_id": agencyByCustomerId,
        "code_voucher": codeVoucher,
        "is_use_points": isUsedPiont,
        "is_use_balance_collaborator": isUseBalanceCollaborator,
        "phone": phone,
        "name": name,
        "address_detail": addressDetail,
        "province": province,
        "district": district,
        "wards": wards,
        "from_pos": fromPos,
      };
}
