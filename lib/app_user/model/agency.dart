import 'agency_type.dart';
import 'info_customer.dart';

class Agency {
  Agency({
    this.id,
    this.storeId,
    this.customerId,
    this.agencyTypeId,
    this.paymentAuto,
    this.balance,
    this.firstAndLastName,
    this.cmnd,
    this.dateRange,
    this.issuedBy,
    this.frontCard,
    this.backCard,
    this.status,
    this.bank,
    this.accountNumber,
    this.accountName,
    this.ordersCount,
    this.sumTotalFinal,
    this.branch,
    this.sumPoint,
    this.createdAt,
    this.updatedAt,
    this.agencyType,
    this.customer,
    this.pointsCount,
    this.sumShareAgency,this.latitude,this.longitude,this.staffSaleVisitAgency
  });

  int? id;
  int? storeId;
  int? customerId;
  int? agencyTypeId;
  bool? paymentAuto;
  double? balance;
  int? pointsCount;
  String? sumPoint;
  String? firstAndLastName;
  String? cmnd;
  DateTime? dateRange;
  String? issuedBy;
  String? frontCard;
  String? backCard;
  int? status;
  int? ordersCount;
  int? sumTotalFinal;
  double? sumShareAgency;
  String? bank;
  String? accountNumber;
  String? accountName;
  String? branch;
  DateTime? createdAt;
  DateTime? updatedAt;
  AgencyType? agencyType;
  InfoCustomer? customer;
  double? latitude;
  double? longitude;
  StaffSaleVisitAgency? staffSaleVisitAgency;

  factory Agency.fromJson(Map<String, dynamic> json) => Agency(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        agencyTypeId: json["agency_type_id"],
        paymentAuto: json["payment_auto"] == null ? null : json["payment_auto"],
        balance: json["balance"] == null ? null : json["balance"].toDouble(),
        firstAndLastName: json["first_and_last_name"],
        sumShareAgency: json["sum_share_agency"] == null
            ? null
            : json["sum_share_agency"].toDouble(),
        cmnd: json["cmnd"],
        sumPoint: json["sum_point"],
        dateRange: json["date_range"] == null
            ? null
            : DateTime.parse(json["date_range"]),
        issuedBy: json["issued_by"],
        frontCard: json["front_card"],
        pointsCount: json["points_count"],
        backCard: json["back_card"],
        status: json["status"],
        bank: json["bank"],
        ordersCount: json["orders_count"],
        sumTotalFinal: json["sum_total_final"],
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        branch: json["branch"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        agencyType: json["agency_type"] == null
            ? null
            : AgencyType.fromJson(json["agency_type"]),
        customer: json["customer"] == null
            ? null
            : InfoCustomer.fromJson(json["customer"]),
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        staffSaleVisitAgency : json["staff_sale_visit_agency"] == null ? null : StaffSaleVisitAgency.fromJson(json["staff_sale_visit_agency"])
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "customer_id": customerId == null ? null : customerId,
        "agency_type_id": agencyTypeId,
        "payment_auto": paymentAuto == null ? null : paymentAuto,
        "balance": balance == null ? null : balance,
        "first_and_last_name": firstAndLastName,
        "sum_point": sumPoint,
        "cmnd": cmnd,
        "date_range": dateRange,
        "issued_by": issuedBy,
        "front_card": frontCard,
        "back_card": backCard,
        "status": status,
        "bank": bank,
        "account_number": accountNumber,
        "account_name": accountName,
        "branch": branch,
        "customer": customer == null ? null : customer!.toJson(),
        "longitude":longitude,
        "latitude" : latitude
      };
}

class StaffSaleVisitAgency {
    int? id;
    int? storeId;
    int? staffId;
    bool? isAgencyOpen;
    int? agencyId;
    DateTime? timeCheckin;
    DateTime? timeCheckout;
    int? timeVisit;
    double? latitude;
    double? longitude;
    String? note;
    int? percentPin;
    List<String>? images;
    DateTime? createdAt;
    DateTime? updatedAt;

    StaffSaleVisitAgency({
        this.id,
        this.storeId,
        this.staffId,
        this.isAgencyOpen,
        this.agencyId,
        this.timeCheckin,
        this.timeCheckout,
        this.timeVisit,
        this.latitude,
        this.longitude,
        this.note,
        this.percentPin,
        this.createdAt,
        this.updatedAt,this.images
    });

    factory StaffSaleVisitAgency.fromJson(Map<String, dynamic> json) => StaffSaleVisitAgency(
        id: json["id"],
        storeId: json["store_id"],
        staffId: json["staff_id"],
        isAgencyOpen: json["is_agency_open"],
        agencyId: json["agency_id"],
        timeCheckin: json["time_checkin"] == null ? null : DateTime.parse(json["time_checkin"]),
        timeCheckout: json["time_checkout"]== null ? null : DateTime.parse(json["time_checkout"]),
        timeVisit: json["time_visit"],
        latitude: json["latitude"] == null ? null :  json["latitude"].toDouble(),
        longitude: json["longitude"]== null ? null :  json["longitude"].toDouble(),
        percentPin: json["percent_pin"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        note: json["note"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "staff_id": staffId,
        "is_agency_open": isAgencyOpen,
        "agency_id": agencyId,
        "time_checkin": timeCheckin?.toIso8601String(),
        "time_checkout": timeCheckout,
        "time_visit": timeVisit,
        "latitude": latitude,
        "longitude": longitude,
        "note": note,
        "percent_pin": percentPin,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
         "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
       
    };
}