


import '../../../../model/history_check_in.dart';

class AllHistoryCheckInRes {
    int? code;
    bool? success;
    Data? data;
    String? msgCode;
    String? msg;

    AllHistoryCheckInRes({
        this.code,
        this.success,
        this.data,
        this.msgCode,
        this.msg,
    });

    factory AllHistoryCheckInRes.fromJson(Map<String, dynamic> json) => AllHistoryCheckInRes(
        code: json["code"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        msgCode: json["msg_code"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": data?.toJson(),
        "msg_code": msgCode,
        "msg": msg,
    };
}

class Data {
    int? currentPage;
    List<HistoryCheckIn>? data;
   
    String? nextPageUrl;
  

    Data({
        this.currentPage,
        this.data,
        
        this.nextPageUrl,
     
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<HistoryCheckIn>.from(json["data"]!.map((x) => HistoryCheckIn.fromJson(x))),
       
        nextPageUrl: json["next_page_url"],
     
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
       
        "next_page_url": nextPageUrl,
     
    };
}









