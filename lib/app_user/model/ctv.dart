
import 'package:sahashop_customer/app_customer/model/info_customer.dart';

class Ctv {
  Ctv({
    this.id,
    this.storeId,
    this.customerId,
    this.status,
    this.paymentAuto,
    this.balance,
    this.firstAndLastName,
    this.cmnd,
    this.dateRange,
    this.issuedBy,
    this.frontCard,
    this.backCard,
    this.bank,
    this.ordersCount,
    this.sumTotalFinal,
    this.sumShareCollaborator,
    this.accountNumber,
    this.accountName,
    this.branch,
    this.createdAt,
    this.updatedAt,
    this.customer,
  });

  int? id;
  int? storeId;
  int? customerId;
  int? status;
  int? ordersCount;
  double? sumTotalFinal;
  double? sumShareCollaborator;
  bool? paymentAuto;
  double? balance;
  String? firstAndLastName;
  String? cmnd;
  DateTime? dateRange;
  String? issuedBy;
  String? frontCard;
  String? backCard;
  String? bank;
  String? accountNumber;
  String? accountName;
  String? branch;
  DateTime? createdAt;
  DateTime? updatedAt;
  InfoCustomer? customer;

  factory Ctv.fromJson(Map<String, dynamic> json) => Ctv(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        status: json["status"] == null ? null : json["status"],
        paymentAuto: json["payment_auto"] == null ? null : json["payment_auto"],
        balance: json["balance"] == null ? null : json["balance"].toDouble(),
        firstAndLastName: json["first_and_last_name"] == null
            ? null
            : json["first_and_last_name"],
        cmnd: json["cmnd"] == null ? null : json["cmnd"],
        ordersCount: json["orders_count"] == null ? null : json["orders_count"],
        sumTotalFinal:
            json["sum_total_final"] == null ? null : json["sum_total_final"].toDouble(),
        sumShareCollaborator: json["sum_share_collaborator"] == null
            ? null
            : json["sum_share_collaborator"].toDouble(),
        dateRange: json["date_range"] == null
            ? null
            : DateTime.parse(json["date_range"]),
        issuedBy: json["issued_by"] == null ? null : json["issued_by"],
        frontCard: json["front_card"] == null ? null : json["front_card"],
        backCard: json["back_card"] == null ? null : json["back_card"],
        bank: json["bank"] == null ? null : json["bank"],
        accountNumber:
            json["account_number"] == null ? null : json["account_number"],
        accountName: json["account_name"] == null ? null : json["account_name"],
        branch: json["branch"] == null ? null : json["branch"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        customer: json["customer"] == null
            ? null
            : InfoCustomer.fromJson(json["customer"]),
      );
}
