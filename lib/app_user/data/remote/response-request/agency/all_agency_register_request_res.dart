

import '../../../../model/agency.dart';

class AllAgencyRegisterRequestsRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    Data? data;

    AllAgencyRegisterRequestsRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory AllAgencyRegisterRequestsRes.fromJson(Map<String, dynamic> json) => AllAgencyRegisterRequestsRes(
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
    List<AgencyRegisterRequest>? data;
   
    String? nextPageUrl;
 

    Data({
        this.currentPage,
        this.data,
      
        this.nextPageUrl,
    
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<AgencyRegisterRequest>.from(json["data"]!.map((x) => AgencyRegisterRequest.fromJson(x))),
       
        nextPageUrl: json["next_page_url"],
     
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
       
       
        "next_page_url": nextPageUrl,
      
    };
}

class AgencyRegisterRequest {
    int? id;
    int? storeId;
    int? customerId;
    int? agencyId;
    int? status;
    dynamic note;
    DateTime? createdAt;
    DateTime? updatedAt;
    Agency? agency;

    AgencyRegisterRequest({
        this.id,
        this.storeId,
        this.customerId,
        this.agencyId,
        this.status,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.agency,
    });

    factory AgencyRegisterRequest.fromJson(Map<String, dynamic> json) => AgencyRegisterRequest(
        id: json["id"],
        storeId: json["store_id"],
        customerId: json["customer_id"],
        agencyId: json["agency_id"],
        status: json["status"],
        note: json["note"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        agency: json["agency"] == null ? null : Agency.fromJson(json["agency"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "customer_id": customerId,
        "agency_id": agencyId,
        "status": status,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "agency": agency?.toJson(),
    };
}

