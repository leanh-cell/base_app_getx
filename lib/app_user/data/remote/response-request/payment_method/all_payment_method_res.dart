

class AllPaymentMethodRes {
    int? code;
    bool? success;
    List<PaymentMethod>? data;
    String? msgCode;
    String? msg;

    AllPaymentMethodRes({
        this.code,
        this.success,
        this.data,
        this.msgCode,
        this.msg,
    });

    factory AllPaymentMethodRes.fromJson(Map<String, dynamic> json) => AllPaymentMethodRes(
        code: json["code"],
        success: json["success"],
        data: json["data"] == null ? [] : List<PaymentMethod>.from(json["data"]!.map((x) => PaymentMethod.fromJson(x))),
        msgCode: json["msg_code"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg_code": msgCode,
        "msg": msg,
    };
}

class PaymentMethod {
    int? id;
    String? name;
    List<String>? field;
    List<String>? defineField;
    bool? isAuto;
    String? description;
    bool? use;
    Config? config;

    PaymentMethod({
        this.id,
        this.name,
        this.field,
        this.defineField,
        this.isAuto,
        this.description,
        this.use,
        this.config,
    });

    factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: json["name"],
        field: json["field"] == null ? [] : List<String>.from(json["field"]!.map((x) => x)),
        defineField: json["define_field"] == null ? [] : List<String>.from(json["define_field"]!.map((x) => x)),
        isAuto: json["is_auto"],
        description: json["description"],
        use: json["use"],
        config: json["config"] == null ? null : Config.fromJson(json["config"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "field": field == null ? [] : List<dynamic>.from(field!.map((x) => x)),
        "define_field": defineField == null ? [] : List<dynamic>.from(defineField!.map((x) => x)),
        "is_auto": isAuto,
        "description": description,
        "use": use,
        "config": config?.toJson(),
    };
}

class Config {
    String? description;
    List<PaymentGuide>? paymentGuide;
    String? vnpTmnCode;
    String? vnpHashSecret;
    String? merchant;
    String? hascode;
    String? accessCode;

    Config({
        this.description,
        this.paymentGuide,
        this.vnpTmnCode,
        this.vnpHashSecret,
        this.merchant,
        this.hascode,
        this.accessCode,
    });

    factory Config.fromJson(Map<String, dynamic> json) => Config(
        description: json["description"],
        paymentGuide: json["payment_guide"] == null ? [] : List<PaymentGuide>.from(json["payment_guide"]!.map((x) => PaymentGuide.fromJson(x))),
        vnpTmnCode: json["vnp_TmnCode"],
        vnpHashSecret: json["vnp_HashSecret"],
        merchant: json["merchant"],
        hascode: json["hascode"],
        accessCode: json["access_code"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "payment_guide": paymentGuide == null ? [] : List<dynamic>.from(paymentGuide!.map((x) => x.toJson())),
        "vnp_TmnCode": vnpTmnCode,
        "vnp_HashSecret": vnpHashSecret,
        "merchant": merchant,
        "hascode": hascode,
        "access_code": accessCode,
    };
}

class PaymentGuide {
    String? accountName;
    String? accountNumber;
    String? bank;
    String? branch;
    String? qrCodeImageUrl;

    PaymentGuide({
        this.accountName,
        this.accountNumber,
        this.bank,
        this.branch,
        this.qrCodeImageUrl,
    });

    factory PaymentGuide.fromJson(Map<String, dynamic> json) => PaymentGuide(
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        bank: json["bank"],
        branch: json["branch"],
        qrCodeImageUrl: json["qr_code_image_url"],
    );

    Map<String, dynamic> toJson() => {
        "account_name": accountName,
        "account_number": accountNumber,
        "bank": bank,
        "branch": branch,
        "qr_code_image_url": qrCodeImageUrl,
    };
}
