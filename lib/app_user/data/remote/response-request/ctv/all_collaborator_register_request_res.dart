

import 'package:com.ikitech.store/app_user/model/ctv.dart';

class AllCollaboratorRegisterRequestRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    Data? data;

    AllCollaboratorRegisterRequestRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory AllCollaboratorRegisterRequestRes.fromJson(Map<String, dynamic> json) => AllCollaboratorRegisterRequestRes(
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
    List<CollaboratorRegisterRequest>? data;
   
    String? nextPageUrl;


    Data({
        this.currentPage,
        this.data,
       
        this.nextPageUrl,
     
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<CollaboratorRegisterRequest>.from(json["data"]!.map((x) => CollaboratorRegisterRequest.fromJson(x))),
       
        nextPageUrl: json["next_page_url"],
 
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
       
        "next_page_url": nextPageUrl,
     
    };
}

class CollaboratorRegisterRequest {
    int? id;
    int? storeId;
    int? customerId;
    int? collaboratorId;
    int? status;
    String? note;
    DateTime? createdAt;
    DateTime? updatedAt;
    Ctv? collaborator;

    CollaboratorRegisterRequest({
        this.id,
        this.storeId,
        this.customerId,
        this.collaboratorId,
        this.status,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.collaborator,
    });

    factory CollaboratorRegisterRequest.fromJson(Map<String, dynamic> json) => CollaboratorRegisterRequest(
        id: json["id"],
        storeId: json["store_id"],
        customerId: json["customer_id"],
        collaboratorId: json["collaborator_id"],
        status: json["status"],
        note: json["note"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        collaborator: json["collaborator"] == null ? null : Ctv.fromJson(json["collaborator"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "customer_id": customerId,
        "collaborator_id": collaboratorId,
        "status": status,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        // "collaborator": collaborator?.toJson(),
    };
}

