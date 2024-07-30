


import 'package:com.ikitech.store/app_user/model/info_customer.dart';

class AllGroupCustomerRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    Data? data;

    AllGroupCustomerRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory AllGroupCustomerRes.fromJson(Map<String, dynamic> json) => AllGroupCustomerRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class Data {
    int? currentPage;
    List<GroupCustomer>? data;
   
    String? nextPageUrl;
   

    Data({
        this.currentPage,
        this.data,
       
        this.nextPageUrl,
      
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<GroupCustomer>.from(json["data"]!.map((x) => GroupCustomer.fromJson(x))),
       
        nextPageUrl: json["next_page_url"],
      
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        
        "next_page_url": nextPageUrl,
     
    };
}

















class GroupCustomer {
  GroupCustomer({
    this.id,
    this.storeId,
    this.name,
    this.note,
    this.groupType,
    this.typeCompare,
    this.comparisonExpression,
    this.valueCompare,
    this.createdAt,
    this.updatedAt,
    this.conditionItems,this.customerIds,this.customers,this.count
  });

  int? id;
  int? storeId;
  String? name;
  String? note;
  int? groupType;
  int? typeCompare;
  String? comparisonExpression;
  int? valueCompare;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ConditionItem>? conditionItems;
  List<int>? customerIds;
  List<InfoCustomer>? customers;
  int? count;

  factory GroupCustomer.fromJson(Map<String, dynamic> json) => GroupCustomer(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        name: json["name"] == null ? null : json["name"],
        note: json["note"] == null ? null : json["note"],
        groupType: json["group_type"],
        typeCompare: json["type_compare"] == null ? null : json["type_compare"],
        comparisonExpression: json["comparison_expression"] == null
            ? null
            : json["comparison_expression"],
        valueCompare:
            json["value_compare"] == null ? null : json["value_compare"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        conditionItems: json["condition_items"] == null
            ? null
            : List<ConditionItem>.from(
                json["condition_items"].map((x) => ConditionItem.fromJson(x))),

        customerIds : json["customer_ids"] == null
            ? null
            : List<int>.from(
                json["customer_ids"].map((x) => x)),
        customers: json["customers"] == null
            ? null
            : List<InfoCustomer>.from(
                json["customers"].map((x) => InfoCustomer.fromJson(x))),
        count: json["count_customers"]
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "name": name == null ? null : name,
        "note": note == null ? null : note,
        "group_type": groupType,
        "type_compare": typeCompare == null ? null : typeCompare,
        "comparison_expression":
            comparisonExpression == null ? null : comparisonExpression,
        "value_compare": valueCompare == null ? null : valueCompare,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "condition_items": conditionItems == null
            ? null
            : List<dynamic>.from(conditionItems!.map((x) => x.toJson())),
        "customer_ids": customerIds == null
            ? null
            : List<dynamic>.from(customerIds!.map((x) => x)),
        "count_customers" : count
      };
}

class ConditionItem {
  ConditionItem({
    this.typeCompare,
    this.comparisonExpression,
    this.valueCompare,
    this.sub,
  });

  int? typeCompare;
  String? comparisonExpression;
  String? valueCompare;
  String? sub;

  factory ConditionItem.fromJson(Map<String, dynamic> json) => ConditionItem(
        typeCompare: json["type_compare"] == null ? null : json["type_compare"],
        comparisonExpression: json["comparison_expression"] == null
            ? null
            : json["comparison_expression"],
        valueCompare:
            json["value_compare"] == null ? null : json["value_compare"],
      );

  Map<String, dynamic> toJson() => {
        "type_compare": typeCompare == null ? null : typeCompare,
        "comparison_expression":
            comparisonExpression == null ? null : comparisonExpression,
        "value_compare": valueCompare == null ? null : valueCompare,
      };
}
