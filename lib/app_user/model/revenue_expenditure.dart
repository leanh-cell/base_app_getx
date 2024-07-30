import 'package:com.ikitech.store/app_user/model/profile_user.dart';
import 'package:com.ikitech.store/app_user/model/supplier.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';

import 'staff.dart';

class RevenueExpenditure {
  RevenueExpenditure({
    this.id,
    this.storeId,
    this.branchId,
    this.code,
    this.recipientGroup,
    this.recipientReferencesId,
    this.referencesId,
    this.referencesValue,
    this.referenceName,
    this.currentMoney,
    this.changeMoney,
    this.allowAccounting = true,
    this.isRevenue,
    this.description,
    this.actionCreate,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
    this.typeActionName,
    this.staff,
    this.supplier,
    this.customer,
    this.user,
    this.type,
    this.historyPayOrders,
    this.historyImportStocks,
  });

  int? id;
  int? storeId;
  int? branchId;
  String? code;
  int? recipientGroup;
  int? recipientReferencesId;
  int? referencesId;
  int? type;
  String? referencesValue;
  String? referenceName;
  double? currentMoney;
  double? changeMoney;
  bool? allowAccounting = true;
  bool? isRevenue;
  String? description;
  int? actionCreate;
  int? paymentMethod;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? typeActionName;
  Staff? staff;
  Supplier? supplier;
  ProfileUser? user;
  InfoCustomer? customer;
  List<HistoryPayOrder>? historyPayOrders;
  List<HistoryImportStock>? historyImportStocks;
  factory RevenueExpenditure.fromJson(Map<String, dynamic> json) =>
      RevenueExpenditure(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        code: json["code"] == null ? null : json["code"],
        recipientGroup:
            json["recipient_group"] == null ? null : json["recipient_group"],
        recipientReferencesId: json["recipient_references_id"] == null
            ? null
            : json["recipient_references_id"],
        referencesId:
            json["references_id"] == null ? null : json["references_id"],
        type: json["type"] == null ? null : json["type"],
        referencesValue:
            json["references_value"] == null ? null : json["references_value"],
        referenceName:
            json["reference_name"] == null ? null : json["reference_name"],
        staff: json["staff"] == null ? null : Staff.fromJson(json["staff"]),
        supplier: json["supplier"] == null
            ? null
            : Supplier.fromJson(json["supplier"]),
        customer: json["customer"] == null
            ? null
            : InfoCustomer.fromJson(json["customer"]),
        user: json["user"] == null ? null : ProfileUser.fromJson(json["user"]),
        currentMoney: json["current_money"] == null
            ? null
            : json["current_money"].toDouble(),
        changeMoney: json["change_money"] == null
            ? null
            : json["change_money"].toDouble(),
        allowAccounting:
            json["allow_accounting"] == null ? null : json["allow_accounting"],
        isRevenue: json["is_revenue"] == null ? null : json["is_revenue"],
        description: json["description"] == null ? null : json["description"],
        actionCreate:
            json["action_create"] == null ? null : json["action_create"],
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        typeActionName:
            json["type_action_name"] == null ? null : json["type_action_name"],
        historyPayOrders: json["history_pay_orders"] == null
            ? null
            : List<HistoryPayOrder>.from(json["history_pay_orders"]
                .map((x) => HistoryPayOrder.fromJson(x))),
        historyImportStocks: json["history_import_stocks"] == null
            ? null
            : List<HistoryImportStock>.from(json["history_import_stocks"]
                .map((x) => HistoryImportStock.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "branch_id": branchId == null ? null : branchId,
        "code": code == null ? null : code,
        "recipient_group": recipientGroup == null ? null : recipientGroup,
        "recipient_references_id":
            recipientReferencesId == null ? null : recipientReferencesId,
        "references_id": referencesId,
        "references_value": referencesValue == null ? null : referencesValue,
        "reference_name": referenceName == null ? null : referenceName,
        "current_money": currentMoney == null ? null : currentMoney,
        "change_money": changeMoney == null ? null : changeMoney,
        "allow_accounting": allowAccounting == null ? null : allowAccounting,
        "is_revenue": isRevenue == null ? null : isRevenue,
        "description": description == null ? null : description,
        "action_create": actionCreate == null ? null : actionCreate,
        "type": type == null ? null : type,
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "type_action_name": typeActionName == null ? null : typeActionName,
      };
}

class HistoryPayOrder {
  HistoryPayOrder({
    this.money,
    this.paymentMethod,
    this.remainingAmount,
    this.revenueExpenditureId,
    this.createdAt,
    this.updatedAt,
    this.orderIdRef,
    this.orderCode,
  });

  int? money;
  int? paymentMethod;
  int? remainingAmount;
  int? revenueExpenditureId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? orderIdRef;
  String? orderCode;

  factory HistoryPayOrder.fromJson(Map<String, dynamic> json) =>
      HistoryPayOrder(
        money: json["money"] == null ? null : json["money"],
        paymentMethod: json["payment_method"],
        remainingAmount:
            json["remaining_amount"] == null ? null : json["remaining_amount"],
        revenueExpenditureId: json["revenue_expenditure_id"] == null
            ? null
            : json["revenue_expenditure_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        orderIdRef: json["order_id_ref"] == null ? null : json["order_id_ref"],
        orderCode: json["order_code"] == null ? null : json["order_code"],
      );

  Map<String, dynamic> toJson() => {
        "money": money == null ? null : money,
        "payment_method": paymentMethod,
        "remaining_amount": remainingAmount == null ? null : remainingAmount,
        "revenue_expenditure_id":
            revenueExpenditureId == null ? null : revenueExpenditureId,
        "order_id_ref": orderIdRef == null ? null : orderIdRef,
        "order_code": orderCode == null ? null : orderCode,
      };
}

class HistoryImportStock {
  HistoryImportStock({
    this.money,
    this.paymentMethod,
    this.revenueExpenditureId,
    this.remainingAmount,
    this.createdAt,
    this.updatedAt,
    this.importStockIdRef,
    this.code,
  });

  double? money;
  int? paymentMethod;
  int? revenueExpenditureId;
  double? remainingAmount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? importStockIdRef;
  String? code;

  factory HistoryImportStock.fromJson(Map<String, dynamic> json) =>
      HistoryImportStock(
        money: json["money"] == null ? null : json["money"].toDouble(),
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        revenueExpenditureId: json["revenue_expenditure_id"] == null
            ? null
            : json["revenue_expenditure_id"],
        remainingAmount: json["remaining_amount"] == null
            ? null
            : json["remaining_amount"].toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        importStockIdRef: json["import_stock_id_ref"] == null
            ? null
            : json["import_stock_id_ref"],
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "money": money,
        "payment_method": paymentMethod,
        "revenue_expenditure_id":
            revenueExpenditureId == null ? null : revenueExpenditureId,
        "remaining_amount": remainingAmount == null ? null : remainingAmount,
        "import_stock_id_ref":
            importStockIdRef == null ? null : importStockIdRef,
        "code": code == null ? null : code,
      };
}
