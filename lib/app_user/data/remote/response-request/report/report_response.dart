import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/chart.dart';

ReportResponse reportResponseFromJson(String str) =>
    ReportResponse.fromJson(json.decode(str));

String reportResponseToJson(ReportResponse data) => json.encode(data.toJson());

class ReportResponse {
  ReportResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  Data? data;

  factory ReportResponse.fromJson(Map<String, dynamic> json) => ReportResponse(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.dataPrimeTime,
    this.dataCompareTime,
  });

  DataPrimeTime? dataPrimeTime;
  DataCompareTime? dataCompareTime;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dataPrimeTime: json["data_prime_time"] == null
        ? null
        : DataPrimeTime.fromJson(json["data_prime_time"]),
    dataCompareTime: json["data_compare_time"] == null
        ? null
        : DataCompareTime.fromJson(json["data_compare_time"]),
  );

  Map<String, dynamic> toJson() => {
    "data_prime_time": dataPrimeTime!.toJson(),
    "data_compare_time": dataCompareTime!.toJson(),
  };
}

class DataCompareTime {
  DataCompareTime({
    this.totalOrderCount,
    this.totalShippingFee,
    this.totalBeforeDiscount,
    this.comboDiscountAmount,
    this.productDiscountAmount,
    this.voucherDiscountAmount,
    this.totalAfterDiscount,
    this.totalFinal,
    this.detailsByOrderStatus,
    this.detailsByPaymentStatus,
    this.typeChart,
    this.totalCollaboratorRegCount,
    this.totalReferralOfCustomerCount,
    this.charts,
  });

  double? totalOrderCount;
  double? totalShippingFee;
  double? totalBeforeDiscount;
  double? comboDiscountAmount;
  double? productDiscountAmount;
  double? voucherDiscountAmount;
  double? totalAfterDiscount;
  double? totalFinal;
  DetailsByOrderStatus? detailsByOrderStatus;
  DetailsByPaymentStatus? detailsByPaymentStatus;
  String? typeChart;
  int? totalCollaboratorRegCount;
  int? totalReferralOfCustomerCount;
  List<Chart?>? charts;

  factory DataCompareTime.fromJson(Map<String, dynamic> json) =>
      DataCompareTime(
        totalOrderCount: json["total_order_count"].toDouble(),
        totalShippingFee: json["total_shipping_fee"].toDouble(),
        totalBeforeDiscount: json["total_before_discount"].toDouble(),
        comboDiscountAmount: json["combo_discount_amount"].toDouble(),
        productDiscountAmount: json["product_discount_amount"].toDouble(),
        voucherDiscountAmount: json["voucher_discount_amount"].toDouble(),
        totalAfterDiscount: json["total_after_discount"].toDouble(),
        totalFinal: json["total_final"].toDouble(),
        detailsByOrderStatus: json["details_by_order_status"] == null
            ? null
            : DetailsByOrderStatus.fromJson(json["details_by_order_status"]),
        detailsByPaymentStatus: json["details_by_payment_status"] == null
            ? null
            : DetailsByPaymentStatus.fromJson(
            json["details_by_payment_status"]),
        typeChart: json["type_chart"],
        charts: List<Chart>.from(json["charts"].map((x) => Chart.fromJson(x))),
        totalCollaboratorRegCount: json["total_collaborator_reg_count"] == null
            ? 0
            : json["total_collaborator_reg_count"],
        totalReferralOfCustomerCount: json["total_referral_of_customer_count"] == null
            ? 0
            : json["total_referral_of_customer_count"],
      );

  Map<String, dynamic> toJson() => {
    "total_order_count": totalOrderCount,
    "total_shipping_fee": totalShippingFee,
    "total_before_discount": totalBeforeDiscount,
    "combo_discount_amount": comboDiscountAmount,
    "product_discount_amount": productDiscountAmount,
    "voucher_discount_amount": voucherDiscountAmount,
    "total_after_discount": totalAfterDiscount,
    "total_final": totalFinal,
    "details_by_order_status": detailsByOrderStatus!.toJson(),
    "details_by_payment_status": detailsByPaymentStatus!.toJson(),
    "type_chart": typeChart,
    "charts": List<dynamic>.from(charts!.map((x) => x!.toJson())),
  };
}

class DetailsByOrderStatus {
  DetailsByOrderStatus({
    this.waitingForProgressing,
    this.packing,
    this.outOfStock,
    this.userCancelled,
    this.customerCancelled,
    this.shipping,
    this.deliveryError,
    this.customerReturning,
    this.customerHasReturns,
    this.completed,
  });

  Chart? waitingForProgressing;
  Chart? packing;
  Chart? outOfStock;
  Chart? userCancelled;
  Chart? customerCancelled;
  Chart? shipping;
  Chart? deliveryError;
  Chart? customerReturning;
  Chart? customerHasReturns;
  Chart? completed;

  factory DetailsByOrderStatus.fromJson(Map<String, dynamic> json) =>
      DetailsByOrderStatus(
        waitingForProgressing: Chart.fromJson(json["WAITING_FOR_PROGRESSING"]),
        packing: Chart.fromJson(json["PACKING"]),
        outOfStock: Chart.fromJson(json["OUT_OF_STOCK"]),
        userCancelled: Chart.fromJson(json["USER_CANCELLED"]),
        customerCancelled: Chart.fromJson(json["CUSTOMER_CANCELLED"]),
        shipping: Chart.fromJson(json["SHIPPING"]),
        deliveryError: Chart.fromJson(json["DELIVERY_ERROR"]),
        customerReturning: Chart.fromJson(json["CUSTOMER_RETURNING"]),
        customerHasReturns: Chart.fromJson(json["CUSTOMER_HAS_RETURNS"]),
        completed: Chart.fromJson(json["COMPLETED"]),
      );

  Map<String, dynamic> toJson() => {
    "WAITING_FOR_PROGRESSING": waitingForProgressing!.toJson(),
    "PACKING": packing!.toJson(),
    "OUT_OF_STOCK": outOfStock!.toJson(),
    "USER_CANCELLED": userCancelled!.toJson(),
    "CUSTOMER_CANCELLED": customerCancelled!.toJson(),
    "SHIPPING": shipping!.toJson(),
    "DELIVERY_ERROR": deliveryError!.toJson(),
    "CUSTOMER_RETURNING": customerReturning!.toJson(),
    "CUSTOMER_HAS_RETURNS": customerHasReturns!.toJson(),
    "COMPLETED": completed!.toJson(),
  };
}

class DetailsByPaymentStatus {
  DetailsByPaymentStatus({
    this.waitingForProgressing,
    this.paid,
    this.partiallyPaid,
    this.customerCancelled,
    this.refunds,
  });

  Chart? waitingForProgressing;
  Chart? paid;
  Chart? partiallyPaid;
  Chart? customerCancelled;
  Chart? refunds;

  factory DetailsByPaymentStatus.fromJson(Map<String, dynamic> json) =>
      DetailsByPaymentStatus(

        waitingForProgressing: Chart.fromJson(json["WAITING_FOR_PROGRESSING"]),
        paid: Chart.fromJson(json["PAID"]),
        partiallyPaid: Chart.fromJson(json["PARTIALLY_PAID"]),
        customerCancelled: Chart.fromJson(json["CUSTOMER_CANCELLED"]),
        refunds: Chart.fromJson(json["REFUNDS"]),
      );

  Map<String, dynamic> toJson() => {
    "WAITING_FOR_PROGRESSING": waitingForProgressing!.toJson(),
    "PAID": paid!.toJson(),
    "PARTIALLY_PAID": partiallyPaid!.toJson(),
    "CUSTOMER_CANCELLED": customerCancelled!.toJson(),
    "REFUNDS": refunds!.toJson(),
  };
}

class DataPrimeTime {
  DataPrimeTime({
    this.totalOrderCount,
    this.totalShippingFee,
    this.totalBeforeDiscount,
    this.comboDiscountAmount,
    this.productDiscountAmount,
    this.voucherDiscountAmount,
    this.totalAfterDiscount,
    this.totalFinal,
    this.detailsByOrderStatus,
    this.totalCollaboratorRegCount,
    this.totalReferralOfCustomerCount,
    this.detailsByPaymentStatus,
    this.typeChart,
    this.charts,
  });

  double? totalOrderCount;
  double? totalShippingFee;
  double? totalBeforeDiscount;
  double? comboDiscountAmount;
  double? productDiscountAmount;
  double? voucherDiscountAmount;
  double? totalAfterDiscount;
  double? totalFinal;
  DetailsByOrderStatus? detailsByOrderStatus;
  DetailsByPaymentStatus? detailsByPaymentStatus;
  int? totalCollaboratorRegCount;
  int? totalReferralOfCustomerCount;
  String? typeChart;
  List<Chart?>? charts;

  factory DataPrimeTime.fromJson(Map<String, dynamic> json) => DataPrimeTime(
    totalOrderCount: json["total_order_count"].toDouble(),
    totalShippingFee: json["total_shipping_fee"].toDouble(),
    totalBeforeDiscount: json["total_before_discount"].toDouble(),
    comboDiscountAmount: json["combo_discount_amount"].toDouble(),
    productDiscountAmount: json["product_discount_amount"].toDouble(),
    voucherDiscountAmount: json["voucher_discount_amount"].toDouble(),
    totalAfterDiscount: json["total_after_discount"].toDouble(),
    totalFinal: json["total_final"].toDouble(),
    detailsByOrderStatus: json["details_by_order_status"] == null
        ? null
        : DetailsByOrderStatus.fromJson(json["details_by_order_status"]),
    detailsByPaymentStatus: json["details_by_payment_status"] == null
        ? null
        : DetailsByPaymentStatus.fromJson(
        json["details_by_payment_status"]),
    typeChart: json["type_chart"],
    totalCollaboratorRegCount: json["total_collaborator_reg_count"] == null
        ? 0
        : json["total_collaborator_reg_count"],
    totalReferralOfCustomerCount:
    json["total_referral_of_customer_count"] == null
        ? 0
        : json["total_referral_of_customer_count"],
    charts: List<Chart>.from(json["charts"].map((x) => Chart.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_order_count": totalOrderCount,
    "total_shipping_fee": totalShippingFee,
    "total_before_discount": totalBeforeDiscount,
    "combo_discount_amount": comboDiscountAmount,
    "product_discount_amount": productDiscountAmount,
    "voucher_discount_amount": voucherDiscountAmount,
    "total_after_discount": totalAfterDiscount,
    "total_final": totalFinal,
    "details_by_order_status": detailsByOrderStatus,
    "details_by_payment_status": detailsByPaymentStatus,
    "type_chart": typeChart,
    "charts": List<dynamic>.from(charts!.map((x) => x!.toJson())),
  };
}
