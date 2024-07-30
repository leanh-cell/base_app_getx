import 'package:com.ikitech.store/app_user/model/location_address.dart';

import 'staff.dart';

class FilterTopSale {
  DateTime? dateFrom;
  DateTime? dateTo;

  List<Staff>? staffs;
  int? type;
  List<LocationAddress>? provinceIds;

  FilterTopSale({
    this.dateFrom,
    this.dateTo,
    this.type,
    this.staffs,
    this.provinceIds,
  });

  FilterTopSale copyWith({
    DateTime? dateFrom,
    DateTime? dateTo,
    List<Staff>? staffs,
    int? type,
    List<LocationAddress>? provinceIds,
  }) {
    return FilterTopSale(
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      staffs: staffs ?? this.staffs,
      type: type ?? this.type,
      provinceIds: provinceIds ?? this.provinceIds,
    );
  }
}
