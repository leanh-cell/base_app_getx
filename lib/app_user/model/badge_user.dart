import 'decentralization.dart';
import 'info_address.dart';

class BadgeUser {
  BadgeUser({
    this.isStaff,
    this.totalOrders,
    this.ordersWaitingForProgressing,
    this.ordersRefunds,
    this.ordersPacking,
    this.ordersShipping,
    this.ordersCompleted,
    this.totalStaffOnline,
    this.totalImportNotCompleted,
    this.temporaryOrder,
    this.totalTallySheetChecked,
    this.totalProductOrDiscountNearlyOutStock,
    this.chatsUnread,
    this.voucherTotal,
    this.productsDiscount,
    this.reviewsNoProcess,
    this.totalFinalInDay,
    this.totalOrdersInDay,
    this.notificationUnread,
    this.decentralization,
    this.infoAddress,
    this.staffHasCheckin,
    this.allowSemiNegative,
    this.isSale,
   
  });

  bool? isStaff;
  bool? isSale;
  int? totalOrders;
  int? ordersWaitingForProgressing;
  int? ordersRefunds;
  int? ordersPacking;
  int? ordersShipping;
  int? ordersCompleted;
  int? totalStaffOnline;
  int? totalImportNotCompleted;
  int? totalTallySheetChecked;
  int? temporaryOrder;
  int? totalProductOrDiscountNearlyOutStock;
  int? chatsUnread;
  int? voucherTotal;
  int? totalOrdersInDay;
  int? productsDiscount;
  int? reviewsNoProcess;
  double? totalFinalInDay;
  int? notificationUnread;
  Decentralization? decentralization;
  InfoAddress? infoAddress;
  bool? staffHasCheckin;
  bool? allowSemiNegative;
 

  factory BadgeUser.fromJson(Map<String, dynamic> json) => BadgeUser(
        isStaff: json["is_staff"] == null ? null : json["is_staff"],
        isSale: json["is_sale"] == null ? null : json["is_sale"],
        totalOrders: json["total_orders"] == null ? null : json["total_orders"],
        totalOrdersInDay: json["total_orders_in_day"] == null
            ? null
            : json["total_orders_in_day"],
        temporaryOrder:
            json["temporary_order"] == null ? null : json["temporary_order"],
        ordersWaitingForProgressing:
            json["orders_waitting_for_progressing"] == null
                ? null
                : json["orders_waitting_for_progressing"],
        ordersRefunds:
            json["orders_refunds"] == null ? null : json["orders_refunds"],
        ordersPacking:
            json["orders_packing"] == null ? null : json["orders_packing"],
        ordersShipping:
            json["orders_shipping"] == null ? null : json["orders_shipping"],
        totalStaffOnline: json["total_staff_online"] == null
            ? null
            : json["total_staff_online"],
        totalImportNotCompleted: json["total_import_not_completed"] == null
            ? null
            : json["total_import_not_completed"],
        totalTallySheetChecked: json["total_tally_sheet_checked"] == null
            ? null
            : json["total_tally_sheet_checked"],
        totalProductOrDiscountNearlyOutStock:
            json["total_product_or_discount_nearly_out_stock"] == null
                ? null
                : json["total_product_or_discount_nearly_out_stock"],
        chatsUnread: json["chats_unread"] == null ? null : json["chats_unread"],
        voucherTotal:
            json["voucher_total"] == null ? null : json["voucher_total"],
        productsDiscount: json["products_discount"] == null
            ? null
            : json["products_discount"],
        reviewsNoProcess: json["reviews_no_process"] == null
            ? null
            : json["reviews_no_process"],
        totalFinalInDay: json["total_final_in_day"] == null
            ? null
            : json["total_final_in_day"].toDouble(),
        notificationUnread: json["notification_unread"] == null
            ? null
            : json["notification_unread"],
        ordersCompleted: json["total_orders_completed_in_day"] == null
            ? null
            : json["total_orders_completed_in_day"],
        decentralization: json["decentralization"] == null
            ? null
            : Decentralization.fromJson(json["decentralization"]),
        infoAddress: json["address_pickup"] == null
            ? null
            : InfoAddress.fromJson(json["address_pickup"]),
        staffHasCheckin: json["staff_has_checkin"] == null
            ? null
            : json["staff_has_checkin"],
        allowSemiNegative: json["allow_semi_negative"] == null
            ? null
            : json["allow_semi_negative"],
        
      );
}
