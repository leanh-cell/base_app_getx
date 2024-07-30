import 'package:com.ikitech.store/app_user/model/staff.dart';

import 'branch.dart';
import 'profile_user.dart';
import 'transfer_stock_item.dart';

class TransferStock {
  TransferStock({
    this.totalTransfered,
    this.totalWait,
    this.totalCancel,
    this.id,
    this.storeId,
    this.fromBranchId,
    this.toBranchId,
    this.status,
    this.note,
    this.code,
    this.userId,
    this.staffId,
    this.handleTime,
    this.createdAt,
    this.updatedAt,
    this.profileUser,
    this.staff,
    this.transferStockItems,
    this.toBranch,
    this.fromBranch,
  });

  int? totalTransfered;
  int? totalWait;
  int? totalCancel;
  int? id;
  int? storeId;
  int? fromBranchId;
  int? toBranchId;
  int? status;
  String? note;
  String? code;
  int? userId;
  int? staffId;
  DateTime? handleTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<TransferStockItem>? transferStockItems;
  ProfileUser? profileUser;
  Staff? staff;
  Branch? toBranch;
  Branch? fromBranch;

  factory TransferStock.fromJson(Map<String, dynamic> json) => TransferStock(
        totalTransfered:
            json["total_transfered"] == null ? null : json["total_transfered"],
        profileUser:
            json["user"] == null ? null : ProfileUser.fromJson(json["user"]),
        staff: json["staff"] == null ? null : Staff.fromJson(json["staff"]),
        totalWait: json["total_wait"] == null ? null : json["total_wait"],
        totalCancel: json["total_cancel"] == null ? null : json["total_cancel"],
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        fromBranchId:
            json["from_branch_id"] == null ? null : json["from_branch_id"],
        toBranchId: json["to_branch_id"] == null ? null : json["to_branch_id"],
        status: json["status"] == null ? null : json["status"],
        note: json["note"] == null ? null : json["note"],
        code: json["code"] == null ? null : json["code"],
        userId: json["user_id"] == null ? null : json["user_id"],
        staffId: json["staff_id"] == null ? null : json["staff_id"],
        handleTime: json["handle_time"] == null
            ? null
            : DateTime.parse(json["handle_time"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        transferStockItems: json["transfer_stock_items"] == null
            ? null
            : List<TransferStockItem>.from(json["transfer_stock_items"]
                .map((x) => TransferStockItem.fromJson(x))),
        toBranch: json["to_branch"] == null
            ? null
            : Branch.fromJson(json["to_branch"]),
        fromBranch: json["from_branch"] == null
            ? null
            : Branch.fromJson(json["from_branch"]),
      );

  Map<String, dynamic> toJson() => {
        "total_transfered": totalTransfered == null ? null : totalTransfered,
        "total_wait": totalWait == null ? null : totalWait,
        "total_cancel": totalCancel == null ? null : totalCancel,
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "from_branch_id": fromBranchId == null ? null : fromBranchId,
        "to_branch_id": toBranchId == null ? null : toBranchId,
        "status": status == null ? null : status,
        "note": note == null ? null : note,
        "code": code == null ? null : code,
        "user_id": userId == null ? null : userId,
        "staff_id": staffId,
        "transfer_stock_items": transferStockItems == null
            ? null
            : List<dynamic>.from(transferStockItems!.map((x) => x.toJson())),
      };
}
