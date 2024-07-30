import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/const/order_constant.dart';
import 'package:com.ikitech.store/app_user/model/branch.dart' as user;
import 'package:com.ikitech.store/app_user/model/filter_order.dart';
import 'package:com.ikitech.store/app_user/screen2/report/choose_time/choose_time_screen.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

import '../../../model/staff.dart';
import 'filter_order_controller.dart';

class filterOrderScreen extends StatelessWidget {
  FilterOrder? filterOrderInput;
  late FilterOrderController filterOrderController;
  Function? onFilter;
  SahaDataController sahaDataController = Get.find();
  bool? isEdit;
  int? indexFilter;

  filterOrderScreen(
      {this.filterOrderInput, this.isEdit, this.indexFilter, this.onFilter}) {
    filterOrderController = FilterOrderController(
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
            source(),
            boxExpended(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      bottomNavigationBar: isEdit == true
          ? Container(
              height: 65,
              color: Colors.white,
              child: Column(
                children: [
                  SahaButtonFullParent(
                    text: "LƯU",
                    onPressed: () {
                      if (filterOrderInput != null) {
                        filterOrderController.addFilter();
                      } else {
                        PopupInput().showDialogInputNote(
                            height: 100,
                            confirm: (v) {
                              filterOrderController.filterOrder.value.name = v;
                              filterOrderController.addFilter();
                            },
                            title: "Tên bộ lọc",
                            textInput:
                                "${filterOrderController.filterOrder.value.name ?? ""}");
                      }
                    },
                    color:
                        SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
                  ),
                ],
              ),
            )
          : Container(
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
                            filterOrderController.filterOrder.value =
                                FilterOrder(
                                    listBranch: [],
                                    listOrderStt: [],
                                    listPaymentStt: [],
                                    listSource: [],
                                    name: "filter_order");
                          },
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: SahaButtonFullParent(
                          text: "Lọc",
                          onPressed: () {
                            var filterCast =
                                filterOrderController.filterOrder.value;
                            onFilter!(FilterOrder(
                              name: "filter_order",
                              dateTo: filterCast.dateTo,
                              dateFrom: filterCast.dateFrom,
                              listSource: filterCast.listSource,
                              listPaymentStt: filterCast.listPaymentStt,
                              listOrderStt: filterCast.listOrderStt,
                              listBranch: filterCast.listBranch,
                              staff: filterCast.staff,
                            ));
                          },
                          color: SahaColorUtils()
                              .colorPrimaryTextWithWhiteBackground(),
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

  Widget source() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 0),
            child: Text(
              "Nguồn",
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
              itemSource(
                  onTap: () {
                    if ((filterOrderController.filterOrder.value.listSource ??
                            [])
                        .contains(ORDER_FROM_POS_IN_STORE)) {
                      filterOrderController.filterOrder.value.listSource!
                          .remove(ORDER_FROM_POS_IN_STORE);
                      filterOrderController.filterOrder.refresh();
                    } else {
                      filterOrderController.filterOrder.value.listSource!
                          .add(ORDER_FROM_POS_IN_STORE);
                      filterOrderController.filterOrder.refresh();
                    }
                  },
                  type: ORDER_FROM_POS_IN_STORE,
                  icon: Icons.point_of_sale_outlined,
                  title: "Pos tại quầy"),
              itemSource(
                  onTap: () {
                    if ((filterOrderController.filterOrder.value.listSource ??
                            [])
                        .contains(ORDER_FROM_POS_DELIVERY)) {
                      filterOrderController.filterOrder.value.listSource!
                          .remove(ORDER_FROM_POS_DELIVERY);
                      filterOrderController.filterOrder.refresh();
                    } else {
                      filterOrderController.filterOrder.value.listSource!
                          .add(ORDER_FROM_POS_DELIVERY);
                      filterOrderController.filterOrder.refresh();
                    }
                  },
                  type: ORDER_FROM_POS_DELIVERY,
                  icon: Icons.point_of_sale_outlined,
                  title: "Pos giao vận"),
              itemSource(
                  onTap: () {
                    if ((filterOrderController.filterOrder.value.listSource ??
                            [])
                        .contains(ORDER_FROM_WEB)) {
                      filterOrderController.filterOrder.value.listSource!
                          .remove(ORDER_FROM_WEB);
                      filterOrderController.filterOrder.refresh();
                    } else {
                      filterOrderController.filterOrder.value.listSource!
                          .add(ORDER_FROM_WEB);
                      filterOrderController.filterOrder.refresh();
                    }
                  },
                  type: ORDER_FROM_WEB,
                  icon: Icons.web,
                  title: "Web"),
              itemSource(
                  onTap: () {
                    if ((filterOrderController.filterOrder.value.listSource ??
                            [])
                        .contains(ORDER_FROM_APP)) {
                      filterOrderController.filterOrder.value.listSource!
                          .remove(ORDER_FROM_APP);
                      filterOrderController.filterOrder.refresh();
                    } else {
                      filterOrderController.filterOrder.value.listSource!
                          .add(ORDER_FROM_APP);
                      filterOrderController.filterOrder.refresh();
                    }
                  },
                  type: ORDER_FROM_APP,
                  icon: Icons.mobile_screen_share_rounded,
                  title: "App"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget itemSource(
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
                          (filterOrderController.filterOrder.value.listSource ??
                                      [])
                                  .contains(type)
                              ? Theme.of(Get.context!).primaryColor
                              : Colors.grey[200]!)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color:
                        (filterOrderController.filterOrder.value.listSource ??
                                    [])
                                .contains(type)
                            ? Theme.of(Get.context!).primaryColor
                            : Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: (filterOrderController
                                        .filterOrder.value.listSource ??
                                    [])
                                .contains(type)
                            ? Theme.of(Get.context!).primaryColor
                            : null),
                  ),
                ],
              ),
            ),
            if ((filterOrderController.filterOrder.value.listSource ?? [])
                .contains(type))
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

  Widget boxExpended() {
    return Container(
      color: Colors.white,
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sahaDataController.badgeUser.value.isStaff != true) Divider(),
          Obx(
            () => Column(
              children: [
                if (sahaDataController.badgeUser.value.isStaff != true)
                  InkWell(
                    onTap: () {
                      filterOrderController.expBranch.value =
                          !filterOrderController.expBranch.value;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 10, left: 10),
                      child: Row(
                        children: [
                          Text(
                            "Chi nhánh",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_down_rounded)
                        ],
                      ),
                    ),
                  ),
                if (sahaDataController.badgeUser.value.isStaff != true)
                  if (filterOrderController.expBranch.value)
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.all(10),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: sahaDataController.listBranch
                            .map((e) => itemBranch(branch: e))
                            .toList(),
                      ),
                    ),
              ],
            ),
          ),
          Divider(),
          Obx(
            () => Column(
              children: [
                InkWell(
                  onTap: () {
                    filterOrderController.expStatus.value =
                        !filterOrderController.expStatus.value;
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, bottom: 10, left: 10),
                    child: Row(
                      children: [
                        Text(
                          "Trạng thái đơn hàng",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_down_rounded)
                      ],
                    ),
                  ),
                ),
                if (filterOrderController.expStatus.value)
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.all(10),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        itemStatus(status: WAITING_FOR_PROGRESSING),
                        itemStatus(status: PACKING),
                        itemStatus(status: SHIPPING),
                        itemStatus(status: COMPLETED),
                        itemStatus(status: OUT_OF_STOCK),
                        itemStatus(status: USER_CANCELLED),
                        itemStatus(status: CUSTOMER_CANCELLED),
                        itemStatus(status: DELIVERY_ERROR),
                        itemStatus(status: CUSTOMER_RETURNING),
                        itemStatus(status: CUSTOMER_HAS_RETURNS),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Divider(),
          Obx(
            () => Column(
              children: [
                InkWell(
                  onTap: () {
                    filterOrderController.expPayment.value =
                        !filterOrderController.expPayment.value;
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, bottom: 10, left: 10),
                    child: Row(
                      children: [
                        Text(
                          "Trạng thái thanh toán",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_down_rounded)
                      ],
                    ),
                  ),
                ),
                if (filterOrderController.expPayment.value)
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.all(10),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        itemPayment(status: UNPAID),
                        itemPayment(status: PAID),
                        itemPayment(status: PARTIALLY_PAID),
                        itemPayment(status: CUSTOMER_CANCELLED),
                        itemPayment(status: REFUNDS),
                      ],
                    ),
                  ),
              ],
            ),
          ),
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
                              top: 10.0, bottom: 10, left: 10),
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

                            // [
                            //
                            //   itemPayment(status: UNPAID),
                            //   itemPayment(status: PAID),
                            //   itemPayment(status: PARTIALLY_PAID),
                            //   itemPayment(status: CUSTOMER_CANCELLED),
                            //   itemPayment(status: REFUNDS),
                            // ],
                          ),
                        ),
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget itemBranch({required user.Branch branch}) {
    return InkWell(
      onTap: () {
        if (filterOrderController.checkBranch(branch)) {
          filterOrderController.filterOrder.value.listBranch!
              .removeWhere((e) => e.id == branch.id);
          filterOrderController.filterOrder.refresh();
        } else {
          filterOrderController.filterOrder.value.listBranch!.add(branch);
          filterOrderController.filterOrder.refresh();
        }
      },
      child: Stack(
        children: [
          Container(
            width: (Get.width - 40) / 2,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color:
                        (filterOrderController.filterOrder.value.listBranch ??
                                    [])
                                .map((e) => e.id)
                                .contains(branch.id)
                            ? Theme.of(Get.context!).primaryColor
                            : Colors.grey[200]!)),
            child: Center(
              child: Text(
                "${branch.name ?? ""}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color:
                      (filterOrderController.filterOrder.value.listBranch ?? [])
                              .map((e) => e.id)
                              .contains(branch.id)
                          ? Theme.of(Get.context!).primaryColor
                          : null,
                ),
              ),
            ),
          ),
          if ((filterOrderController.checkBranch(branch)))
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
    );
  }

  Widget itemStatus({required String status}) {
    return InkWell(
      onTap: () {
        if (filterOrderController.checkOrderStt(status)) {
          filterOrderController.filterOrder.value.listOrderStt!
              .removeWhere((e) => e == status);
          filterOrderController.filterOrder.refresh();
        } else {
          filterOrderController.filterOrder.value.listOrderStt!.add(status);
          filterOrderController.filterOrder.refresh();
        }
      },
      child: Stack(
        children: [
          Container(
            width: (Get.width - 40) / 2,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: filterOrderController.checkOrderStt(status)
                        ? Theme.of(Get.context!).primaryColor
                        : Colors.grey[200]!)),
            child: Center(
              child: Text(
                "${ORDER_STATUS_DEFINE[status]}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: filterOrderController.checkOrderStt(status)
                        ? Theme.of(Get.context!).primaryColor
                        : null),
              ),
            ),
          ),
          if ((filterOrderController.checkOrderStt(status)))
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
    );
  }

  Widget itemPayment({required String status}) {
    return InkWell(
      onTap: () {
        if (filterOrderController.checkPaymentStt(status)) {
          filterOrderController.filterOrder.value.listPaymentStt!
              .removeWhere((e) => e == status);
          filterOrderController.filterOrder.refresh();
        } else {
          filterOrderController.filterOrder.value.listPaymentStt!.add(status);
          filterOrderController.filterOrder.refresh();
        }
      },
      child: Stack(
        children: [
          Container(
            width: (Get.width - 40) / 2,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: filterOrderController.checkPaymentStt(status)
                        ? Theme.of(Get.context!).primaryColor
                        : Colors.grey[200]!)),
            child: Center(
              child: Text(
                "${ORDER_PAYMENT_DEFINE[status]}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: filterOrderController.checkPaymentStt(status)
                      ? Theme.of(Get.context!).primaryColor
                      : null,
                ),
              ),
            ),
          ),
          if ((filterOrderController.checkPaymentStt(status)))
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
    );
  }

  Widget itemSale({required Staff staff}) {
    return InkWell(
      onTap: () {
        if (filterOrderController.filterOrder.value.staff?.id == staff.id) {
          filterOrderController.filterOrder.value.staff = null;
        } else {
          filterOrderController.filterOrder.value.staff = staff;
        }
        print(filterOrderController.filterOrder.value.staff?.name);
        filterOrderController.filterOrder.refresh();
      },
      child: Stack(
        children: [
          Container(
            width: (Get.width - 40) / 2,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: filterOrderController.filterOrder.value.staff?.id ==
                            staff.id
                        ? Theme.of(Get.context!).primaryColor
                        : Colors.grey[200]!)),
            child: Center(
              child: Text(
                staff.name ?? '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: filterOrderController.filterOrder.value.staff?.id ==
                          staff.id
                      ? Theme.of(Get.context!).primaryColor
                      : null,
                ),
              ),
            ),
          ),
          if (filterOrderController.filterOrder.value.staff?.id == staff.id)
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
    );
  }
}
