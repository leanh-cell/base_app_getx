
import 'package:sahashop_customer/app_customer/model/product.dart';

class ProductLastInventoryRes {
  ProductLastInventoryRes({
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

  factory ProductLastInventoryRes.fromJson(Map<String, dynamic> json) =>
      ProductLastInventoryRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.totalValueStock,
    this.totalStock,
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  double? totalValueStock;
  int? totalStock;
  int? currentPage;
  List<ProductLastInventory>? data;
  String? nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalValueStock: json["total_value_stock"] == null
            ? null
            : json["total_value_stock"].toDouble(),
        totalStock: json["total_stock"] == null ? null : json["total_stock"],
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<ProductLastInventory>.from(
                json["data"].map((x) => ProductLastInventory.fromJson(x))),
        nextPageUrl:
            json["next_page_url"] == null ? null : json["next_page_url"],
      );
}

class ProductLastInventory {
  ProductLastInventory({
    this.id,
    this.name,
    this.distributeStock,
    this.importExport,
    this.mainStock,
    this.images,
    this.mainImportCountStock,
    this.mainImportTotalAmount,
    this.mainExportCountStock,
    this.mainExportTotalAmount,
  });

  int? id;
  String? name;
  List<Distributes>? distributeStock;
  List<Distributes>? importExport;
  List<ImageProduct>? images;
  MainStock? mainStock;
  int? mainImportCountStock;
  double? mainImportTotalAmount;
  int? mainExportCountStock;
  double? mainExportTotalAmount;

  factory ProductLastInventory.fromJson(Map<String, dynamic> json) =>
      ProductLastInventory(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        distributeStock: json["distribute_stock"] == null
            ? null
            : List<Distributes>.from(
                json["distribute_stock"].map((x) => Distributes.fromJson(x))),
        importExport: json["distribute_import_export"] == null
            ? null
            : List<Distributes>.from(
                json["distribute_import_export"].map((x) => Distributes.fromJson(x))),
        mainStock: json["main_stock"] == null
            ? null
            : MainStock.fromJson(json["main_stock"]),
        images: json["images"] == null
            ? null
            : List<ImageProduct>.from(
                json["images"].map((x) => ImageProduct.fromJson(x))),
        mainImportCountStock: json["main_import_count_stock"] == null
            ? null
            : json["main_import_count_stock"],
        mainImportTotalAmount: json["main_import_total_amount"] == null
            ? null
            : json["main_import_total_amount"].toDouble(),
        mainExportCountStock: json["main_export_count_stock"] == null
            ? null
            : json["main_export_count_stock"],
        mainExportTotalAmount: json["main_export_total_amount"] == null
            ? null
            : json["main_export_total_amount"].toDouble(),
      );
}

class MainStock {
  MainStock({
    this.stock,
    this.costOfCapital,
    this.importPrice,
  });

  int? stock;
  double? costOfCapital;
  double? importPrice;

  factory MainStock.fromJson(Map<String, dynamic> json) => MainStock(
        stock: json["stock"] == null ? null : json["stock"],
        costOfCapital: json["cost_of_capital"] == null
            ? null
            : json["cost_of_capital"].toDouble(),
        importPrice: json["import_price"] == null
            ? null
            : json["import_price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "stock": stock == null ? null : stock,
        "cost_of_capital": costOfCapital == null ? null : costOfCapital,
        "import_price": importPrice == null ? null : importPrice,
      };
}
