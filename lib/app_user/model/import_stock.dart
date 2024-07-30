import 'package:com.ikitech.store/app_user/model/branch.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:com.ikitech.store/app_user/model/supplier.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

class ImportStock {
  ImportStock({
    this.id,
    this.storeId,
    this.branchId,
    this.supplierId,
    this.code,
    this.remainingAmount,
    this.existingBranch,
    this.status,
    this.paymentStatus,
    this.paymentMethod,
    this.note,
    this.totalNumber,
    this.totalAmount,
    this.totalFinal,
    this.discount,
    this.tax,
    this.cost,
    this.userId,
    this.staffId,
    this.createdAt,
    this.updatedAt,
    this.importStockItems,
    this.importStockCodeRefund,
    this.importStockIdRefund,
    this.supplier,
    this.hasRefunded,
    this.changeStatusHistory,
    this.historyPayImportStock,
    this.branch,
    this.staff,this.vat,this.totalPayment
  });

  int? id;
  int? storeId;
  int? branchId;
  int? supplierId;
  String? code;
  double? remainingAmount;
  int? existingBranch;
  int? status;
  int? paymentStatus;
  int? paymentMethod;
  String? note;
  int? totalNumber;
  double? totalAmount;
  double? totalFinal;
  double? discount;
  dynamic tax;
  double? cost;
  bool? hasRefunded;
  int? userId;
  int? staffId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? importStockCodeRefund;
  int? importStockIdRefund;
  List<ImportStockItem>? importStockItems;
  List<ChangeStatusHistory>? changeStatusHistory;
  List<HistoryPayImportStock>? historyPayImportStock;
  Supplier? supplier;
  Branch? branch;
  Staff? staff;
  double? vat;
  double? totalPayment;

  factory ImportStock.fromJson(Map<String, dynamic> json) => ImportStock(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        importStockCodeRefund: json["import_stock_code_refund"] == null
            ? null
            : json["import_stock_code_refund"],
        importStockIdRefund: json["import_stock_id_refund"] == null
            ? null
            : json["import_stock_id_refund"],
        supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
        code: json["code"] == null ? null : json["code"],
        hasRefunded: json["has_refunded"] == null ? null : json["has_refunded"],
        remainingAmount: json["remaining_amount"] == null
            ? null
            : json["remaining_amount"].toDouble(),
        existingBranch:
            json["existing_branch"] == null ? null : json["existing_branch"],
        status: json["status"] == null ? null : json["status"],
        paymentStatus:
            json["payment_status"] == null ? null : json["payment_status"],
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        note: json["note"] == null ? null : json["note"],
        totalNumber: json["total_number"] == null ? null : json["total_number"],
        totalAmount: json["total_amount"] == null
            ? null
            : json["total_amount"].toDouble(),
        totalFinal:
            json["total_final"] == null ? null : json["total_final"].toDouble(),
        discount: json["discount"] == null ? null : json["discount"].toDouble(),
        tax: json["tax"],
        cost: json["cost"] == null ? null : json["cost"].toDouble(),
        userId: json["user_id"],
        staffId: json["staff_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        importStockItems: json["import_stock_items"] == null
            ? null
            : List<ImportStockItem>.from(json["import_stock_items"]
                .map((x) => ImportStockItem.fromJson(x))),
        supplier: json["supplier"] == null
            ? null
            : Supplier.fromJson(json["supplier"]),
        changeStatusHistory: json["change_status_history"] == null
            ? null
            : List<ChangeStatusHistory>.from(json["change_status_history"]
                .map((x) => ChangeStatusHistory.fromJson(x))),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        staff: json["user"] == null
            ? json["staff"] == null
                ? null
                : Staff.fromJson(json["staff"])
            : Staff.fromJson(json["user"]),
        historyPayImportStock: json["history_pay_import_stock"] == null
            ? null
            : List<HistoryPayImportStock>.from(json["history_pay_import_stock"]
                .map((x) => HistoryPayImportStock.fromJson(x))),
        vat: json["vat"]== null ? null :  json["vat"].toDouble(),
        totalPayment: json["total_payment"] == null ? null : json["total_payment"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        //"branch_id": branchId == null ? null : branchId,
        "supplier_id": supplierId == null ? null : supplierId,
        "code": code == null ? null : code,
        "existing_branch": existingBranch == null ? null : existingBranch,
        "status": status == null ? null : status,
        "payment_status": paymentStatus == null ? null : paymentStatus,
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "note": note == null ? null : note,
        "total_number": totalNumber == null ? null : totalNumber,
        "total_amount": totalAmount == null ? null : totalAmount,
        "discount": discount,
        "tax": tax,
        "cost": cost,
        "user_id": userId,
        "staff_id": staffId,
        "vat":vat,
        "import_stock_items": importStockItems == null
            ? null
            : List<dynamic>.from(importStockItems!.map((x) => x.toJson())),
        "total_payment" : totalPayment
      };
}

class ChangeStatusHistory {
  ChangeStatusHistory({
    this.status,
    this.timeHandle,
  });

  int? status;
  DateTime? timeHandle;

  factory ChangeStatusHistory.fromJson(Map<String, dynamic> json) =>
      ChangeStatusHistory(
        status: json["status"],
        timeHandle: json["time_handle"] == null
            ? null
            : DateTime.parse(json["time_handle"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "time_handle":
            timeHandle == null ? null : timeHandle!.toIso8601String(),
      };
}

class ImportStockItem {
  ImportStockItem({
    this.id,
    this.storeId,
    this.branchId,
    this.importStockId,
    this.productId,
    this.elementDistributeId,
    this.subElementDistributeId,
    this.existingBranch,
    this.importPrice,
    this.discount,
    this.taxPercent,
    this.quantity,
    this.quantityInit,
    this.totalRefund,
    this.quantityReturnMax,
    this.distributeName,
    this.elementDistributeName,
    this.subElementDistributeName,
    this.product,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  int? branchId;
  int? importStockId;
  int? productId;
  int? elementDistributeId;
  int? subElementDistributeId;
  int? existingBranch;
  double? importPrice;
  int? discount;
  int? taxPercent;
  int? quantity;
  int? quantityInit;
  int? totalRefund;
  int? quantityReturnMax;
  String? distributeName;
  String? elementDistributeName;
  String? subElementDistributeName;
  Product? product;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ImportStockItem.fromJson(Map<String, dynamic> json) =>
      ImportStockItem(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        importStockId:
            json["import_stock_id"] == null ? null : json["import_stock_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        elementDistributeId: json["element_distribute_id"],
        subElementDistributeId: json["sub_element_distribute_id"],
        existingBranch:
            json["existing_branch"] == null ? null : json["existing_branch"],
        importPrice: json["import_price"] == null
            ? null
            : json["import_price"].toDouble(),
        discount: json["discount"] == null ? null : json["discount"],
        taxPercent: json["tax_percent"] == null ? null : json["tax_percent"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        totalRefund: json["total_refund"] == null ? null : json["total_refund"],
        distributeName: json["distribute_name"],
        elementDistributeName: json["element_distribute_name"],
        subElementDistributeName: json["sub_element_distribute_name"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
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
        "import_stock_id": importStockId == null ? null : importStockId,
        "product_id": productId == null ? null : productId,
        "element_distribute_id": elementDistributeId,
        "sub_element_distribute_id": subElementDistributeId,
        "existing_branch": existingBranch == null ? null : existingBranch,
        "import_price": importPrice == null ? null : importPrice,
        "discount": discount == null ? null : discount,
        "tax_percent": taxPercent == null ? null : taxPercent,
        "quantity": quantity == null ? null : quantity,
        "distribute_name": distributeName,
        "element_distribute_name": elementDistributeName,
        "sub_element_distribute_name": subElementDistributeName,
      };
}

class HistoryPayImportStock {
  HistoryPayImportStock({
    this.money,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
  });

  double? money;
  int? paymentMethod;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory HistoryPayImportStock.fromJson(Map<String, dynamic> json) =>
      HistoryPayImportStock(
        money: json["money"] == null ? null : json["money"].toDouble(),
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "money": money == null ? null : money,
        "payment_method": paymentMethod == null ? null : paymentMethod,
      };
}
