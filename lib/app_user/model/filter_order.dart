import 'package:hive/hive.dart';
import 'package:com.ikitech.store/app_user/model/branch.dart';

import 'staff.dart';

part 'filter_order.g.dart';

@HiveType(typeId: 2)
class FilterOrder {
  @HiveField(0)
  DateTime? dateFrom;
  @HiveField(1)
  DateTime? dateTo;
  @HiveField(2)
  List<int>? listSource = [];
  @HiveField(3)
  List<Branch>? listBranch = [];
  @HiveField(4)
  List<String>? listOrderStt = [];
  @HiveField(5)
  List<String>? listPaymentStt = [];
  @HiveField(6)
  String? name;
  @HiveField(7)
  Staff? staff;

  FilterOrder(
      {this.dateFrom,
      this.dateTo,
      this.listSource,
      this.listBranch,
      this.listOrderStt,
      this.listPaymentStt,
      this.name,
      this.staff,
      });

  FilterOrder copyWith(
      {DateTime? dateFrom,
      DateTime? dateTo,
      List<int>? listSource,
      List<Branch>? listBranch,
      List<String>? listOrderStt,
      List<String>? listPaymentStt,
      String? name,
      Staff? staff,
      }) {
    return FilterOrder(
      name: name ?? this.name,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      listSource: listSource ?? this.listSource,
      listBranch: listBranch ?? this.listBranch,
      listOrderStt: listOrderStt ?? this.listOrderStt,
      listPaymentStt: listPaymentStt ?? this.listPaymentStt,
      staff: staff ?? this.staff,
    );
  }
}
