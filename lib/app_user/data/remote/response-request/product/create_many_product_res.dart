
class CreateManyProductsRes {
  CreateManyProductsRes({
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
  ResManyProduct? data;

  factory CreateManyProductsRes.fromJson(Map<String, dynamic> json) =>
      CreateManyProductsRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : ResManyProduct.fromJson(json["data"]),
      );
}

class ResManyProduct {
  ResManyProduct({
    this.allowSkipSameName,
    this.totalProductsRequest,
    this.totalSkipSameName,
    this.totalChangedSameName,
    this.totalFailed,
    this.totalNewAdd,
  });

  bool? allowSkipSameName;
  int? totalProductsRequest;
  int? totalSkipSameName;
  int? totalChangedSameName;
  int? totalFailed;
  int? totalNewAdd;

  factory ResManyProduct.fromJson(Map<String, dynamic> json) => ResManyProduct(
        allowSkipSameName: json["allow_skip_same_name"] == null
            ? null
            : json["allow_skip_same_name"],
        totalProductsRequest: json["total_products_request"] == null
            ? null
            : json["total_products_request"],
        totalSkipSameName: json["total_skip_same_name"] == null
            ? null
            : json["total_skip_same_name"],
        totalChangedSameName: json["total_changed_same_name"] == null
            ? null
            : json["total_changed_same_name"],
        totalFailed: json["total_failed"] == null ? null : json["total_failed"],
        totalNewAdd:
            json["total_new_add"] == null ? null : json["total_new_add"],
      );
}
