import 'package:com.ikitech.store/app_user/model/location_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/screen2/report/choose_time/choose_time_screen.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import '../../../../components/saha_user/popup/popup_keyboard.dart';
import '../../../../model/filter_top_sale.dart';
import '../../../../model/staff.dart';
import 'filter_top_sale_controller.dart';

class filterTopSaleScreen extends StatelessWidget {
  FilterTopSale? filterOrderInput;
  late FilterTopSaleController filterOrderController;
  Function? onFilter;
  SahaDataController sahaDataController = Get.find();
  bool? isEdit;
  int? indexFilter;

  filterTopSaleScreen(
      {this.filterOrderInput, this.isEdit, this.indexFilter, this.onFilter}) {
    filterOrderController = FilterTopSaleController(
        filterOrderInput: filterOrderInput, indexFilter: indexFilter);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Bộ lọc"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            head(),
            SizedBox(
              height: 10,
            ),
            boxExpended(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SahaButtonFullParent(
                    text: "Đặt lại",
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      filterOrderController.filterOrder.value = FilterTopSale(
                        staffs: [],
                      );
                    },
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: SahaButtonFullParent(
                    text: "Lọc",
                    onPressed: () {
                      var filterCast = filterOrderController.filterOrder.value;
                      onFilter!(FilterTopSale(
                        dateTo: filterCast.dateTo,
                        dateFrom: filterCast.dateFrom,
                        staffs: filterCast.staffs,
                        type: filterCast.type,
                        provinceIds: filterCast.provinceIds,
                      ));
                    },
                    color:
                        SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget head() {
    return InkWell(
      onTap: () {
        Get.to(() => ChooseTimeScreen(
                  isCompare: false,
                  hideCompare: true,
                  initTab: filterOrderController.indexTabTime,
                  fromDayInput:
                      filterOrderController.filterOrder.value.dateFrom,
                  toDayInput: filterOrderController.filterOrder.value.dateTo,
                  initChoose: filterOrderController.indexChooseTime,
                  callback: (DateTime fromDate,
                      DateTime toDay,
                      DateTime fromDateCP,
                      DateTime toDayCP,
                      bool isCompare,
                      int? indexTab,
                      int? indexChoose) {
                    filterOrderController.filterOrder.value.dateFrom = fromDate;
                    filterOrderController.filterOrder.value.dateTo = toDay;
                    filterOrderController.indexTabTime = indexTab ?? 0;
                    filterOrderController.indexChooseTime = indexChoose ?? 0;
                    filterOrderController.filterOrder.refresh();
                  },
                ))!
            .then((value) => {
                  // saleReportController.getReports(),
                });
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Obx(
          () => Row(
            children: [
              filterOrderController.filterOrder.value.dateFrom != null
                  ? Expanded(
                      child: SahaDateUtils()
                              .getDate(filterOrderController
                                      .filterOrder.value.dateFrom ??
                                  DateTime.now())
                              .isAtSameMomentAs(SahaDateUtils().getDate(
                                  filterOrderController
                                          .filterOrder.value.dateTo ??
                                      DateTime.now()))
                          ? Row(
                              children: [
                                Text(
                                  "Ngày: ",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Spacer(),
                                Text(
                                    "${SahaDateUtils().getDDMMYY(filterOrderController.filterOrder.value.dateFrom ?? DateTime.now())}"),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Từ ngày: ",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    Text(
                                        "${SahaDateUtils().getDDMMYY(filterOrderController.filterOrder.value.dateFrom ?? DateTime.now())}"),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Đến ngày: ",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    Text(
                                        "${SahaDateUtils().getDDMMYY(filterOrderController.filterOrder.value.dateTo ?? DateTime.now())}"),
                                  ],
                                ),
                              ],
                            ),
                    )
                  : Expanded(
                      child: Container(
                      child: Text(
                        "Chọn ngày",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )),
              !(filterOrderController.filterOrder.value.dateTo != null &&
                      filterOrderController.filterOrder.value.dateFrom != null)
                  ? SizedBox(
                      width: 20,
                    )
                  : SizedBox(
                      width: 10,
                    ),
              if (!(filterOrderController.filterOrder.value.dateTo != null &&
                  filterOrderController.filterOrder.value.dateFrom != null))
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 21,
                  color: Theme.of(Get.context!).primaryColor,
                ),
              if (filterOrderController.filterOrder.value.dateTo != null &&
                  filterOrderController.filterOrder.value.dateFrom != null)
                Container(
                  height: 30,
                  width: 2,
                  color: Colors.grey,
                ),
              if (filterOrderController.filterOrder.value.dateTo != null &&
                  filterOrderController.filterOrder.value.dateFrom != null)
                TextButton(
                    onPressed: () {
                      filterOrderController.filterOrder.value.dateTo = null;
                      filterOrderController.filterOrder.value.dateFrom = null;
                      filterOrderController.filterOrder.refresh();
                    },
                    child: Text("Bỏ chọn"))
            ],
          ),
        ),
      ),
    );
  }

  Widget boxExpended() {
    return Container(
      color: Colors.white,
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Column(
                children: [
                  InkWell(
                    onTap: () {
                      filterOrderController.expPayment.value =
                          !filterOrderController.expPayment.value;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 10, left: 10, right: 10),
                      child: Row(
                        children: [
                          Text(
                            "Nhóm khách hàng",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_down_rounded)
                        ],
                      ),
                    ),
                  ),
                  if (filterOrderController.expPayment.value)
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        itemCustomerType(
                            onTap: () {
                              if (filterOrderController.filterOrder.value.type != 1) {
                                filterOrderController.filterOrder.value.type = 1;
                                filterOrderController.filterOrder.refresh();
                              } else {
                                filterOrderController.filterOrder.value.type = null;
                                filterOrderController.filterOrder.refresh();
                              }

                            },
                            type: 1,
                            icon: Icons.group,
                            title: "Cộng tác viên"),
                        itemCustomerType(
                            onTap: () {
                              if (filterOrderController.filterOrder.value.type != 2) {
                                filterOrderController.filterOrder.value.type = 2;
                                filterOrderController.filterOrder.refresh();
                              } else {
                                filterOrderController.filterOrder.value.type = null;
                                filterOrderController.filterOrder.refresh();
                              }
                            },
                            type: 2,
                            icon: Icons.store,
                            title: "Đại lý"),
                        itemCustomerType(
                            onTap: () {
                              if (filterOrderController.filterOrder.value.type != 0) {
                                filterOrderController.filterOrder.value.type = 0;
                                filterOrderController.filterOrder.refresh();
                              } else {
                                filterOrderController.filterOrder.value.type = null;
                                filterOrderController.filterOrder.refresh();
                              }
                            },
                            type: 0,
                            icon: Icons.person,
                            title: "Khách lẻ"),
                      ],
                    ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )),
          Divider(),
          Obx(
            () => (Get.find<SahaDataController>()
                            .badgeUser
                            .value
                            .decentralization
                            ?.orderList ??
                        false) ==
                    true
                ? Column(
                    children: [
                      InkWell(
                        onTap: () {
                          filterOrderController.expStaff.value =
                              !filterOrderController.expStaff.value;
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10, left: 10, right: 10),
                          child: Row(
                            children: [
                              Text(
                                "Nhân viên sale",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Spacer(),
                              Icon(Icons.keyboard_arrow_down_rounded)
                            ],
                          ),
                        ),
                      ),
                      if (filterOrderController.expStaff.value)
                        Container(
                          width: Get.width,
                          padding: EdgeInsets.all(10),
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: filterOrderController.listStaff
                                .map((e) => itemSale(staff: e))
                                .toList(),
                          ),
                        ),
                    ],
                  )
                : Container(),
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  PopupKeyboard().showDialogAddressSelected(
                    callback: (List<LocationAddress> v) {
                      filterOrderController.filterOrder.value.provinceIds = v;
                      filterOrderController.filterOrder.refresh();
                      Get.back();
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10, left: 10, right: 10),
                  child: Row(
                    children: [
                      Text(
                        "Chọn tỉnh thành",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Icon(Icons.keyboard_arrow_down_rounded)
                    ],
                  ),
                ),
              ),
              Obx(
                () => Container(
                  width: Get.width,
                  padding: EdgeInsets.all(10),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children:
                        (filterOrderController.filterOrder.value.provinceIds ??
                                [])
                            .map((e) => itemLocation(locationAddress: e))
                            .toList(),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget item({required Staff staff}) {
    return InkWell(
      onTap: () {
        print(staff.id);
        if ((filterOrderController.filterOrder.value.staffs ?? [])
            .map((e) => e.id)
            .contains(staff.id)) {
          print(staff.id);
          (filterOrderController.filterOrder.value.staffs ?? [])
              .removeWhere((s) => s.id == staff.id);
        } else {
          (filterOrderController.filterOrder.value.staffs ?? []).add(staff);
          print(
              "${filterOrderController.filterOrder.value.staffs!.map((e) => e.id)}");
        }
        filterOrderController.filterOrder.refresh();
      },
      child: Obx(
        () => Stack(
          children: [
            Container(
              width: (Get.width - 40) / 2,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color:
                          (filterOrderController.filterOrder.value.staffs ?? [])
                                  .map((e) => e.id)
                                  .contains(staff.id)
                              ? Theme.of(Get.context!).primaryColor
                              : Colors.grey[200]!)),
              child: Center(
                child: Text(
                  staff.name ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color:
                        (filterOrderController.filterOrder.value.staffs ?? [])
                                .map((e) => e.id)
                                .contains(staff.id)
                            ? Theme.of(Get.context!).primaryColor
                            : null,
                  ),
                ),
              ),
            ),
            if ((filterOrderController.filterOrder.value.staffs ?? [])
                .map((e) => e.id)
                .contains(staff.id))
              Positioned(
                left: -25,
                top: -20,
                child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(Get.context!).primaryColor,
                    ),
                    transform: Matrix4.rotationZ(-0.5),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        Positioned(
                            bottom: -0,
                            right: 20,
                            child: new RotationTransition(
                              turns: new AlwaysStoppedAnimation(20 / 360),
                              child: new Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 13,
                              ),
                            ))
                      ],
                    )),
              )
          ],
        ),
      ),
    );
  }

  Widget itemLocation({required LocationAddress locationAddress}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: (Get.width - 40) / 2,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.05),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              locationAddress.name ?? '',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Positioned(
          right: -5,
          top: -5,
          child: InkWell(
            onTap: () {
              (filterOrderController.filterOrder.value.provinceIds ?? [])
                  .removeWhere((e) => e.id == locationAddress.id);
              filterOrderController.filterOrder.refresh();
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red)),
              child: Icon(
                Icons.clear,
                color: Colors.red,
                size: 15,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget itemSale({required Staff staff}) {
    return InkWell(
      onTap: () {
        print(staff.id);
        if ((filterOrderController.filterOrder.value.staffs ?? [])
            .map((e) => e.id)
            .contains(staff.id)) {
          print(staff.id);
          (filterOrderController.filterOrder.value.staffs ?? [])
              .removeWhere((s) => s.id == staff.id);
        } else {
          (filterOrderController.filterOrder.value.staffs ?? []).add(staff);
          print(
              "${filterOrderController.filterOrder.value.staffs!.map((e) => e.id)}");
        }
        filterOrderController.filterOrder.refresh();
      },
      child: Obx(
        () => Stack(
          children: [
            Container(
              width: (Get.width - 40) / 2,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color:
                          (filterOrderController.filterOrder.value.staffs ?? [])
                                  .map((e) => e.id)
                                  .contains(staff.id)
                              ? Theme.of(Get.context!).primaryColor
                              : Colors.grey[200]!)),
              child: Center(
                child: Text(
                  staff.name ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color:
                        (filterOrderController.filterOrder.value.staffs ?? [])
                                .map((e) => e.id)
                                .contains(staff.id)
                            ? Theme.of(Get.context!).primaryColor
                            : null,
                  ),
                ),
              ),
            ),
            if ((filterOrderController.filterOrder.value.staffs ?? [])
                .map((e) => e.id)
                .contains(staff.id))
              Positioned(
                left: -25,
                top: -20,
                child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(Get.context!).primaryColor,
                    ),
                    transform: Matrix4.rotationZ(-0.5),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        Positioned(
                            bottom: -0,
                            right: 20,
                            child: new RotationTransition(
                              turns: new AlwaysStoppedAnimation(20 / 360),
                              child: new Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 13,
                              ),
                            ))
                      ],
                    )),
              )
          ],
        ),
      ),
    );
  }

  Widget type() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 0),
            child: Text(
              "Nhóm khách hàng",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              itemCustomerType(
                  onTap: () {
                    filterOrderController.filterOrder.value.type = 1;
                    filterOrderController.filterOrder.refresh();
                  },
                  type: 1,
                  icon: Icons.group,
                  title: "Cộng tác viên"),
              itemCustomerType(
                  onTap: () {
                    filterOrderController.filterOrder.value.type = 2;
                    filterOrderController.filterOrder.refresh();
                  },
                  type: 2,
                  icon: Icons.store,
                  title: "Đại lý"),
              itemCustomerType(
                  onTap: () {
                    filterOrderController.filterOrder.value.type = 0;
                    filterOrderController.filterOrder.refresh();
                  },
                  type: 0,
                  icon: Icons.person,
                  title: "Khách lẻ"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget itemCustomerType(
      {required IconData icon,
      required String title,
      required int type,
      required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Obx(
        () => Stack(
          children: [
            Container(
              width: (Get.width - 40) / 2,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color:
                          filterOrderController.filterOrder.value.type == type
                              ? Theme.of(Get.context!).primaryColor
                              : Colors.grey[200]!)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: filterOrderController.filterOrder.value.type == type
                        ? Theme.of(Get.context!).primaryColor
                        : Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color:
                            filterOrderController.filterOrder.value.type == type
                                ? Theme.of(Get.context!).primaryColor
                                : null),
                  ),
                ],
              ),
            ),
            if (filterOrderController.filterOrder.value.type == type)
              Positioned(
                left: -25,
                top: -20,
                child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(Get.context!).primaryColor,
                    ),
                    transform: Matrix4.rotationZ(-0.5),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        Positioned(
                            bottom: -0,
                            right: 20,
                            child: new RotationTransition(
                              turns: new AlwaysStoppedAnimation(20 / 360),
                              child: new Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 13,
                              ),
                            ))
                      ],
                    )),
              )
          ],
        ),
      ),
    );
  }
}
