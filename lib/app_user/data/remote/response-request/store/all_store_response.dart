import 'dart:convert';

AllStoreResponse allStoreResponseFromJson(String str) =>
    AllStoreResponse.fromJson(json.decode(str));

String allStoreResponseToJson(AllStoreResponse data) =>
    json.encode(data.toJson());

class AllStoreResponse {
  AllStoreResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  List<Store>? data;

  factory AllStoreResponse.fromJson(Map<String, dynamic> json) =>
      AllStoreResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: List<Store>.from(json["data"].map((x) => Store.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Store {
  int? id;
  String? name;
  String? storeCode;
  String? nameType;
  String? dateExpried;
  String? address;
  int? userId;
  int? idTypeOfStore;int? career;
  String? createdAt;
  String? updatedAt;
  String? logoUrl;
  bool? hasUploadStore;
  String? linkGooglePlay;
  String? linkAppleStore;
  int? totalProducts;
  int? totalProductCategories;
  int? totalPosts;
  int? totalPostCategories;
  int? totalCustomers;
  int? totalOrders;

  Store(
      {this.id,
        this.name,
        this.storeCode,
        this.dateExpried,
        this.address,
        this.userId,
        this.nameType,
        this.idTypeOfStore,
        this.career,
        this.createdAt,
        this.updatedAt,
        this.logoUrl,
        this.hasUploadStore,
        this.linkGooglePlay,
        this.linkAppleStore,
        this.totalProducts,
        this.totalProductCategories,
        this.totalPosts,
        this.totalPostCategories,
        this.totalCustomers,
        this.totalOrders});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeCode = json['store_code'];
    dateExpried = json['date_expried'];
    address = json['address'];
    userId = json['user_id'];
    nameType = json['name_type'];
    idTypeOfStore = json['id_type_of_store'];
    career = json['career'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    logoUrl = json['logo_url'];
    hasUploadStore = json['has_upload_store'];
    linkGooglePlay = json['link_google_play'];
    linkAppleStore = json['link_apple_store'];
    totalProducts = json['total_products'];
    totalProductCategories = json['total_product_categories'];
    totalPosts = json['total_posts'];
    totalPostCategories = json['total_post_categories'];
    totalCustomers = json['total_customers'];
    totalOrders = json['total_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['store_code'] = this.storeCode;
    data['date_expried'] = this.dateExpried;
    data['address'] = this.address;
    data['user_id'] = this.userId;
    data['name_type'] = this.nameType;
    data['id_type_of_store'] = this.idTypeOfStore;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['logo_url'] = this.logoUrl;
    data['has_upload_store'] = this.hasUploadStore;
    data['link_google_play'] = this.linkGooglePlay;
    data['link_apple_store'] = this.linkAppleStore;
    data['total_products'] = this.totalProducts;
    data['total_product_categories'] = this.totalProductCategories;
    data['total_posts'] = this.totalPosts;
    data['total_post_categories'] = this.totalPostCategories;
    data['total_customers'] = this.totalCustomers;
    data['total_orders'] = this.totalOrders;
    return data;
  }
}