import '../../../../model/agency_type.dart';
import '../customer/all_group_customer_res.dart';

class VoucherRequest {
  VoucherRequest({
    this.voucherType,
    this.name,
    this.code,
    this.description,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.discountType,
    this.discountFor,
    this.valueDiscount,
    this.setLimitValueDiscount,
    this.maxValueDiscount,
    this.setLimitTotal,
    this.isFreeShip,
    this.valueLimitTotal,
    this.shipDiscountValue,
    this.isShowVoucher,
    this.setLimitAmount,
    this.amount,
    this.products,
    this.isEnd,
    this.group,this.agencyTypes,this.groupTypes,this.isUseOnce,this.isUseOnceCodeMultipleTime,this.startingCharacter,this.amountUseOnce,this.voucherLength,this.isPublic
  });

  int? voucherType;
  String? name;
  String? code;
  String? description;
  String? imageUrl;
  String? startTime;
  String? endTime;
  int? discountType;
  int? discountFor;
  double? valueDiscount;
  double? shipDiscountValue;
  bool? setLimitValueDiscount;
  bool? isFreeShip;
  int? maxValueDiscount;
  bool? setLimitTotal;
  int? valueLimitTotal;
  bool? isShowVoucher;
  bool? setLimitAmount;
  int? amount;
  String? products;
  bool? isEnd;
  List<int>? group;
  List<AgencyType>? agencyTypes;
  List<GroupCustomer>? groupTypes;
  bool? isUseOnce;
  bool? isUseOnceCodeMultipleTime;
  String? startingCharacter;
  int? voucherLength;
  int? amountUseOnce;
  bool? isPublic;

  Map<String, dynamic> toJson() => {
        "is_end": isEnd,
        "voucher_type": voucherType,
        "name": name,
        "code": code,
        "description": description,
        "image_url": imageUrl,
        "start_time": startTime,
        "end_time": endTime,
        "discount_for": discountFor,
        "is_free_ship": isFreeShip,
      
        "ship_discount_value":
            shipDiscountValue == null ? null : shipDiscountValue,
        "discount_type": discountType,
        "value_discount": valueDiscount,
        "set_limit_value_discount": setLimitValueDiscount,
        "max_value_discount": maxValueDiscount,
        "set_limit_total": setLimitTotal,
        "value_limit_total": valueLimitTotal,
        "is_show_voucher": isShowVoucher,
        "set_limit_amount": setLimitAmount,
        "amount": amount,
        "product_ids": products,
        "agency_types": agencyTypes == null ? [] : List<dynamic>.from(agencyTypes!.map((x) => x.toJson())),
        "group_types": groupTypes == null ? [] : List<dynamic>.from(groupTypes!.map((x) => x.toJson())),
        "group_customers": group,
        "is_use_once" : isUseOnce,
        "is_use_once_code_multiple_time" :isUseOnceCodeMultipleTime,
        "voucher_length":voucherLength,
        "starting_character": startingCharacter,
        "amount_use_once":amountUseOnce,
        "is_public":isPublic


      };
}
