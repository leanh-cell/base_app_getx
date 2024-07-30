class HomeHomeDataUserUserResponse {
  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  HomeDataUser? data;

  HomeHomeDataUserUserResponse(
      {this.code, this.success, this.msgCode, this.msg, this.data});

  HomeHomeDataUserUserResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    msg = json['msg'];
    data =
        json['data'] != null ? new HomeDataUser.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg_code'] = this.msgCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HomeDataUser {
  List<BannerUser>? banner;

  HomeDataUser({this.banner});

  HomeDataUser.fromJson(Map<String, dynamic> json) {
    if (json['banner'] != null) {
      banner = [];
      json['banner'].forEach((v) {
        banner!.add(new BannerUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banner != null) {
      data['banner'] = this.banner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerUser {
  int? id;
  String? imageUrl;
  String? title;
  String? actionLink;

  BannerUser({this.id, this.imageUrl, this.title});

  BannerUser.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? null : json['id'];
    imageUrl = json['image_url'] == null ? null : json['image_url'];
    title = json['title'] == null ? null : json['title'];
    actionLink = json['action_link'] == null ? null : json['action_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['title'] = this.title;
    data['action_link'] = this.actionLink;
    return data;
  }
}
