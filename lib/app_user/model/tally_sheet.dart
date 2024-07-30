import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/tally_sheet_request.dart';
import 'package:com.ikitech.store/app_user/model/branch.dart';
import 'package:com.ikitech.store/app_user/model/profile_user.dart';

import 'staff.dart';

class TallySheet {
  TallySheet({
    this.id,
    this.storeId,
    this.branchId,
    this.branch,
    this.code,
    this.existingBranch,
    this.realityExist,
    this.deviant,
    this.status,
    this.note,
    this.balanceTime,
    this.profileUser,
    this.staff,
    this.createdAt,
    this.updatedAt,
    this.listTallySheetItem,
  });

  int? id;
  int? storeId;
  int? branchId;
  Branch? branch;
  String? code;
  int? existingBranch;
  int? realityExist;
  int? deviant;
  int? status;
  String? note;
  DateTime? balanceTime;
  ProfileUser? profileUser;
  Staff? staff;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<TallySheetItem>? listTallySheetItem;

  factory TallySheet.fromJson(Map<String, dynamic> json) => TallySheet(
      id: json["id"] == null ? null : json["id"],
      storeId: json["store_id"] == null ? null : json["store_id"],
      branchId: json["branch_id"] == null ? null : json["branch_id"],
      branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
      staff: json["staff"] == null ? null : Staff.fromJson(json["staff"]),
      code: json["code"] == null ? null : json["code"],
      existingBranch:
          json["existing_branch"] == null ? null : json["existing_branch"],
      realityExist:
          json["reality_exist"] == null ? null : json["reality_exist"],
      deviant: json["deviant"] == null ? null : json["deviant"],
      status: json["status"] == null ? null : json["status"],
      note: json["note"] == null ? null : json["note"],
      balanceTime: json["balance_time"] == null
          ? null
          : DateTime.parse(json["balance_time"]),
      profileUser:
          json["user"] == null ? null : ProfileUser.fromJson(json["user"]),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      listTallySheetItem: json["tally_sheet_items"] == null
          ? null
          : List<TallySheetItem>.from(json["tally_sheet_items"]
              .map((x) => TallySheetItem.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "branch_id": branchId == null ? null : branchId,
        "code": code == null ? null : code,
        "existing_branch": existingBranch == null ? null : existingBranch,
        "reality_exist": realityExist == null ? null : realityExist,
        "deviant": deviant == null ? null : deviant,
        "status": status == null ? null : status,
        "note": note == null ? null : note,
        "balance_time": balanceTime,
      };
}
