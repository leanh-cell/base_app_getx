import 'product_last_inventory_res.dart';

class AllProductIEStockRes {
  AllProductIEStockRes({
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
  AllProductIEStock? data;

  factory AllProductIEStockRes.fromJson(Map<String, dynamic> json) =>
      AllProductIEStockRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : AllProductIEStock.fromJson(json["data"]),
      );
}

class AllProductIEStock {
  AllProductIEStock({
    this.importCountStock,
    this.importTotalAmount,
    this.exportCountStock,
    this.exportTotalAmount,
    this.stockCountEnd,
    this.costOfCapitalEnd,
    this.importPriceEnd,
    this.stockCountBegin,
    this.costOfCapitalBegin,
    this.importPriceBegin,
    this.currentPage,
    this.data,
    this.nextPageUrl,
    this.totalAmountBegin,
    this.totalAmountEnd,
  });

  int? importCountStock;
  double? importTotalAmount;
  int? exportCountStock;
  double? totalAmountBegin;
  double? totalAmountEnd;
  double? exportTotalAmount;
  int? stockCountEnd;
  double? costOfCapitalEnd;
  double? importPriceEnd;
  int? stockCountBegin;
  double? costOfCapitalBegin;
  double? importPriceBegin;
  int? currentPage;
  List<ProductLastInventory>? data;
  String? nextPageUrl;

  factory AllProductIEStock.fromJson(Map<String, dynamic> json) => AllProductIEStock(
    importCountStock: json["import_count_stock"] == null ? null : json["import_count_stock"],
    importTotalAmount: json["import_total_amount"] == null ? null : json["import_total_amount"].toDouble(),
    exportCountStock: json["export_count_stock"] == null ? null : json["export_count_stock"],
    exportTotalAmount: json["export_total_amount"] == null ? null : json["export_total_amount"].toDouble(),
    stockCountEnd: json["stock_count_end"] == null ? null : json["stock_count_end"],
    costOfCapitalEnd: json["cost_of_capital_end"] == null ? null : json["cost_of_capital_end"].toDouble(),
    importPriceEnd: json["import_price_end"] == null ? null : json["import_price_end"].toDouble(),
    stockCountBegin: json["stock_count_begin"] == null ? null : json["stock_count_begin"],
    totalAmountBegin: json["total_amount_begin"] == null ? 0 : json["total_amount_begin"].toDouble(),
      totalAmountEnd:  json["total_amount_end"] == null ? 0 : json["total_amount_end"].toDouble(),
    costOfCapitalBegin: json["cost_of_capital_begin"] == null ? null : json["cost_of_capital_begin"].toDouble(),
    importPriceBegin: json["import_price_begin"] == null ? null : json["import_price_begin"].toDouble(),
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<ProductLastInventory>.from(json["data"].map((x) => ProductLastInventory.fromJson(x))),
        nextPageUrl:
            json["next_page_url"] == null ? null : json["next_page_url"],
      );
}
