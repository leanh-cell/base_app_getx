import 'package:sahashop_customer/app_customer/model/info_customer.dart';

import 'cart_model.dart';

class CartInfo {
  CartInfo({
    this.id,
    this.storeId,
    this.branchId,
    this.name,
    this.codeVoucher,
    this.isUsePoints,
    this.isUseBalanceCollaborator,
    this.paymentMethodId,
    this.partnerShipperId,
    this.shipperType,
    this.totalShippingFee,
    this.discount,
    this.customerAddressId,
    this.customerNote,
    this.customerPhone,
    this.customerName,
    this.addressDetail,
    this.customerId,
    this.province,
    this.district,
    this.wards,
    this.wardsName,
    this.districtName,
    this.provinceName,
    this.cartData,
    this.infoCustomer,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  int? branchId;
  String? name;
  String? codeVoucher;
  bool? isUsePoints;
  bool? isUseBalanceCollaborator;
  int? paymentMethodId;
  int? partnerShipperId;
  int? shipperType;
  double? totalShippingFee;
  double? discount;
  bool? isDefault;
  int? customerAddressId;
  String? customerNote;
  String? customerPhone;
  String? customerName;
  String? addressDetail;
  int? customerId;
  int? province;
  int? district;
  int? wards;
  String? provinceName;
  String? districtName;
  String? wardsName;
  InfoCustomer? infoCustomer;
  CartModel? cartData;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CartInfo.fromJson(Map<String, dynamic> json) => CartInfo(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        name: json["name"] == null ? null : json["name"],
        codeVoucher: json["code_voucher"] == null ? null : json["code_voucher"],
        isDefault: json["is_default"] == null ? null : json["is_default"],
        isUsePoints:
            json["is_use_points"] == null ? null : json["is_use_points"],
        isUseBalanceCollaborator: json["is_use_balance_collaborator"] == null
            ? null
            : json["is_use_balance_collaborator"],
        paymentMethodId: json["payment_method_id"] == null
            ? null
            : json["payment_method_id"],
        partnerShipperId: json["partner_shipper_id"] == null
            ? null
            : json["partner_shipper_id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        shipperType: json["shipper_type"] == null ? null : json["shipper_type"],
        totalShippingFee: json["total_shipping_fee"] == null
            ? null
            : json["total_shipping_fee"].toDouble(),
        discount: json["discount"] == null ? null : json["discount"].toDouble(),
        customerAddressId: json["customer_address_id"] == null
            ? null
            : json["customer_address_id"],
        customerNote:
            json["customer_note"] == null ? null : json["customer_note"],
        customerPhone:
            json["customer_phone"] == null ? null : json["customer_phone"],
        customerName:
            json["customer_name"] == null ? null : json["customer_name"],
        wardsName: json["wards_name"] == null ? null : json["wards_name"],
        districtName:
            json["district_name"] == null ? null : json["district_name"],
        provinceName:
            json["province_name"] == null ? null : json["province_name"],
        addressDetail:
            json["address_detail"] == null ? null : json["address_detail"],
        province: json["province"] == null ? null : json["province"],
        district: json["district"] == null ? null : json["district"],
        wards: json["wards"] == null ? null : json["wards"],
        infoCustomer: json["customer"] == null
            ? null
            : InfoCustomer.fromJson(json["customer"]),
        cartData: json["info_cart"] == null
            ? null
            : CartModel.fromJson(json["info_cart"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "branch_id": branchId == null ? null : branchId,
        "name": name == null ? null : name,
        "code_voucher": codeVoucher,
        "is_use_points": isUsePoints,
        "is_use_balance_collaborator": isUseBalanceCollaborator,
        "payment_method_id": paymentMethodId,
        "partner_shipper_id": partnerShipperId,
        "customer_id": customerId,
        "shipper_type": shipperType,
        "total_shipping_fee": totalShippingFee,
        "discount": discount == null ? null : discount,
        "is_default": isDefault == null ? null : isDefault,
        "customer_address_id": customerAddressId,
        "customer_note": customerNote,
        "customer_phone": customerPhone,
        "customer_name": customerName,
        "address_detail": addressDetail,
        "province": province,
        "district": district,
        "wards": wards,
      };
}
