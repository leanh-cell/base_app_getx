


import 'package:sahashop_customer/app_customer/model/product.dart';

class AllProductVoucherRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    ProductVoucher? data;

    AllProductVoucherRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory AllProductVoucherRes.fromJson(Map<String, dynamic> json) => AllProductVoucherRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : ProductVoucher.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class ProductVoucher {
    int? currentPage;
    List<Product>? data;
   
    String? nextPageUrl;
 

    ProductVoucher({
        this.currentPage,
        this.data,
      
        this.nextPageUrl,
     
    });

    factory ProductVoucher.fromJson(Map<String, dynamic> json) => ProductVoucher(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
       
        nextPageUrl: json["next_page_url"],
    
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
       
        "next_page_url": nextPageUrl,
       
    };
}

