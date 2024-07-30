class UpdateDeviceTokenResponse {
  int? code;
  bool? success;
  String? msgCode;
  DeviceTokenUser? data;

  UpdateDeviceTokenResponse({this.code, this.success, this.msgCode, this.data});

  UpdateDeviceTokenResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    data = json['data'] != null ? new DeviceTokenUser.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg_code'] = this.msgCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DeviceTokenUser {
  int? id;
  int? userId;
  int? storeId;
  String? deviceToken;
  String? deviceId;
  int? deviceType;
  bool? active;
  String? createdAt;
  String? updatedAt;

  DeviceTokenUser(
      {this.id,
        this.userId,
        this.storeId,
        this.deviceToken,
        this.deviceId,
        this.deviceType,
        this.active,
        this.createdAt,
        this.updatedAt});

  DeviceTokenUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    deviceToken = json['device_token'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['device_token'] = this.deviceToken;
    data['device_id'] = this.deviceId;
    data['device_type'] = this.deviceType;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}