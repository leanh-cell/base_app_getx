import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_keyboard.dart';
import 'package:com.ikitech.store/app_user/const/const_revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/model/revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:com.ikitech.store/app_user/model/supplier.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/import_stock/import_stock/import_stock_detail_screen.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../const/order_constant.dart';
import '../../../data/repository/repository_manager.dart';
import '../../bill/bill_detail/bill_detail_screen.dart';
import '../../info_customer/history_order/order_detail_manage/order_detail_manage_screen.dart';
import 'choose_customer/choose_customer_re_screen.dart';
import 'choose_suppliers/choose_suppliers_screen.dart';
import 'revenue_expenditure_controller.dart';
import 'staff/choose_staff_screen.dart';

class RevenueExpenditureScreen extends StatelessWidget {
  bool isRevenue;
  double? changeMoney;
  int? recipientGroup;
  int? recipientReferencesId;
  String? nameRecipientReferencesIdInput;
  RevenueExpenditure? revenueExpenditure;

  RevenueExpenditureScreen(
      {required this.isRevenue,
      this.changeMoney,
      this.recipientGroup,
      this.nameRecipientReferencesIdInput,
      this.recipientReferencesId,
      this.revenueExpenditure}) {
    revenueExpenditureController = RevenueExpenditureController(
        recipientGroup: recipientGroup,
        recipientReferencesId: recipientReferencesId,
        nameRecipientReferencesIdInput: nameRecipientReferencesIdInput,
        changeMoney: changeMoney,
        isRevenue: isRevenue,
        revenueExpenditureInput: revenueExpenditure);
  }

  late RevenueExpenditureController revenueExpenditureController;

  var orderShow = Order().obs;
  var isLoading = false.obs;
  Future<void> getOneOrder(String orderCode) async {
    EasyLoading.show();
    isLoading.value = true;
    try {
      var res = await RepositoryManager.orderRepository.getOneOrder(orderCode);
      orderShow.value = res!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    EasyLoading.dismiss();
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back(result: revenueExpenditureController.isSuccess);
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Row(
            children: [
              Obx(
                () => Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "${revenueExpenditureController.revenueExpenditure.value.code ?? (revenueExpenditureController.revenueExpenditure.value.isRevenue == true ? "Tạo phiếu thu" : "Tạo phiếu chi")}"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              IgnorePointer(
                ignoring: revenueExpenditure == null ? false : true,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          typePayment(revenueExpenditureController
                                  .revenueExpenditure.value.paymentMethod ??
                              0),
                          SizedBox(
                            width: 40,
                          ),
                          InkWell(
                            onTap: () {
                              PopupKeyboard().showDialogInputKeyboard(
                                numberInput:
                                    "${SahaStringUtils().convertToMoney(revenueExpenditureController.revenueExpenditure.value.changeMoney ?? 0)}",
                                title: "Giá trị thu",
                                confirm: (number) {
                                  revenueExpenditureController
                                      .revenueExpenditure
                                      .value
                                      .changeMoney = number;
                                  revenueExpenditureController
                                      .revenueExpenditure
                                      .refresh();
                                },
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Giá trị ${revenueExpenditureController.revenueExpenditure.value.isRevenue == true ? "thu" : "chi"}"),
                                Obx(
                                  () => Text(
                                    "${SahaStringUtils().convertToMoney(revenueExpenditureController.revenueExpenditure.value.changeMoney ?? 0)}",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (isRevenue == true) {
                                showTypeRevenue();
                              } else {
                                showType();
                              }
                            },
                            child: Obx(
                              () => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    revenueExpenditureController
                                                .revenueExpenditure
                                                .value
                                                .type !=
                                            null
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${revenueExpenditureController.revenueExpenditure.value.isRevenue == true ? "Loại phiếu thu" : "Loại phiếu chi"}",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                "${getType(revenueExpenditureController.revenueExpenditure.value.type)}",
                                              ),
                                            ],
                                          )
                                        : Text(
                                            "${isRevenue == true ? "Loại phiếu thu" : "Loại phiếu chi"}",
                                          ),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios_rounded,
                                        size: 18)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                          InkWell(
                            onTap: () {
                              showGroup(
                                  isRevenue: revenueExpenditureController
                                      .revenueExpenditure.value.isRevenue);
                            },
                            child: Obx(
                              () => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${revenueExpenditureController.revenueExpenditure.value.isRevenue == true ? "Nhóm người nộp" : "Nhóm người nhận"}",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        Text(
                                          "${getRecipientGroup(revenueExpenditureController.revenueExpenditure.value.recipientGroup)}",
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios_rounded,
                                        size: 18)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                          if (revenueExpenditureController
                                  .revenueExpenditure.value.recipientGroup !=
                              3)
                            Obx(
                              () => InkWell(
                                onTap: () {
                                  if (revenueExpenditureController
                                          .revenueExpenditure
                                          .value
                                          .recipientGroup ==
                                      0) {
                                    Get.to(() => ChooseCustomerReScreen())!
                                        .then((info) {
                                      InfoCustomer infoCustomer =
                                          info as InfoCustomer;
                                      revenueExpenditureController
                                          .nameRecipientReferencesId
                                          .value = infoCustomer.name ?? "";
                                      revenueExpenditureController
                                              .revenueExpenditure
                                              .value
                                              .recipientReferencesId =
                                          infoCustomer.id;
                                    });
                                  }

                                  if (revenueExpenditureController
                                          .revenueExpenditure
                                          .value
                                          .recipientGroup ==
                                      1) {
                                    Get.to(() => ChooseSuppliersScreen())!
                                        .then((info) {
                                      Supplier supplier = info as Supplier;
                                      revenueExpenditureController
                                          .nameRecipientReferencesId
                                          .value = supplier.name ?? "";
                                      revenueExpenditureController
                                          .revenueExpenditure
                                          .value
                                          .recipientReferencesId = supplier.id;
                                    });
                                  }

                                  if (revenueExpenditureController
                                          .revenueExpenditure
                                          .value
                                          .recipientGroup ==
                                      2) {
                                    Get.to(() => ChooseStaffScreen())!
                                        .then((info) {
                                      Staff staff = info as Staff;
                                      revenueExpenditureController
                                          .nameRecipientReferencesId
                                          .value = staff.name ?? "";
                                      revenueExpenditureController
                                          .revenueExpenditure
                                          .value
                                          .recipientReferencesId = staff.id;
                                    });
                                  }

                                  if (revenueExpenditureController
                                          .revenueExpenditure
                                          .value
                                          .recipientGroup ==
                                      3) {
                                    PopupInput().showDialogInputNote(
                                        confirm: (v) {
                                          revenueExpenditureController
                                              .nameRecipientReferencesId
                                              .value = v;
                                        },
                                        title:
                                            "${revenueExpenditureController.revenueExpenditure.value.isRevenue == true ? "Người nộp" : "Người nhận"}",
                                        textInput:
                                            "${revenueExpenditureController.nameRecipientReferencesId.value}");
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${revenueExpenditureController.revenueExpenditure.value.isRevenue == true ? "Người nộp" : "Người nhận"}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "${revenueExpenditureController.nameRecipientReferencesId.value == "" ? revenueExpenditure != null ? "Không tồn tại" : "${revenueExpenditureController.revenueExpenditure.value.isRevenue == true ? "Chọn người nộp" : "Chọn người nhận"}" : revenueExpenditureController.nameRecipientReferencesId.value}",
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Icon(Icons.arrow_forward_ios_rounded,
                                          size: 18)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          Divider(
                            height: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hạch toán kết quả kinh doanh",
                                    ),
                                    Text(
                                      "Tính phiếu thu này vào báo cáo tài chính lỗ lãi",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Obx(
                                  () => CupertinoSwitch(
                                    value: revenueExpenditureController
                                            .revenueExpenditure
                                            .value
                                            .allowAccounting ??
                                        false,
                                    onChanged: (bool value) {
                                      revenueExpenditureController
                                              .revenueExpenditure
                                              .value
                                              .allowAccounting =
                                          !(revenueExpenditureController
                                                  .revenueExpenditure
                                                  .value
                                                  .allowAccounting ??
                                              true);
                                      revenueExpenditureController
                                          .revenueExpenditure
                                          .refresh();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() => revenueExpenditureController
                                .revenueExpenditure.value.createdAt !=
                            null
                        ? Column(
                            children: [
                              Divider(
                                height: 1,
                              ),
                              Container(
                                width: Get.width,
                                color: Colors.white,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ngày ghi nhận",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    Text(
                                        "${SahaDateUtils().getDDMMYY(revenueExpenditureController.revenueExpenditure.value.createdAt!)}, ${SahaDateUtils().getHHMM(revenueExpenditureController.revenueExpenditure.value.createdAt!)}")
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container()),
                    Divider(
                      height: 1,
                    ),

                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: revenueExpenditureController
                                .desEditingController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Mô tả"),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onChanged: (v) async {
                              revenueExpenditureController
                                  .revenueExpenditure.value.description = v;
                            },
                          ),
                          Divider(
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Obx(
                    () => revenueExpenditureController.loading.value
                    ? Container()
                    : Container(
                  width: Get.width,
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          await getOneOrder(
                              revenueExpenditureController
                                  .revenueExpenditure
                                  .value
                                  .referencesValue ??
                                  "");

                          if (orderShow.value.orderFrom == ORDER_FROM_APP ||
                              orderShow.value.orderFrom ==
                                  ORDER_FROM_WEB ||
                              orderShow.value.orderFrom ==
                                  ORDER_FROM_POS_DELIVERY) {
                            Get.to(() => OrderDetailScreen(
                              order: orderShow.value,
                            ));
                          } else {
                            Get.to(() => BillDetailScreen(
                              orderCode:
                              revenueExpenditureController
                                  .revenueExpenditure
                                  .value
                                  .referencesValue ??
                                  "",
                            ));
                          }
                        },
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              revenueExpenditureController
                                  .revenueExpenditure
                                  .value
                                  .referencesValue ??
                                  "",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryColor,
                                  fontSize: 14),
                            ),
                            Text(
                              "${SahaDateUtils().getDDMMYY(revenueExpenditureController.revenueExpenditure.value.createdAt ?? DateTime.now())}, ${SahaDateUtils().getHHMM(revenueExpenditureController.revenueExpenditure.value.createdAt ?? DateTime.now())}",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
              ),
              Obx(() => revenueExpenditureController
                              .revenueExpenditure.value.historyPayOrders !=
                          null &&
                      revenueExpenditureController
                          .revenueExpenditure.value.historyPayOrders!.isNotEmpty
                  ? Column(
                      children: [
                        Container(
                          width: Get.width,
                          color: Colors.white,
                          height: 45,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "   Đơn hàng được thanh toán",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Column(
                          children: revenueExpenditureController
                              .revenueExpenditure.value.historyPayOrders!
                              .map(
                                (history) => Container(
                                  width: Get.width,
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () async {
                                      await getOneOrder(
                                          history.orderCode ?? "");

                                      if (orderShow.value.orderFrom == ORDER_FROM_APP ||
                                          orderShow.value.orderFrom ==
                                              ORDER_FROM_WEB ||
                                          orderShow.value.orderFrom ==
                                              ORDER_FROM_POS_DELIVERY) {
                                        Get.to(() => OrderDetailScreen(
                                              order: orderShow.value,
                                            ));
                                      } else {
                                        Get.to(() => BillDetailScreen(
                                              orderCode:
                                                  history.orderCode ?? "",
                                            ));
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              history.orderCode!,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              "${SahaDateUtils().getDDMMYY(history.createdAt!)}, ${SahaDateUtils().getHHMM(history.createdAt!)}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        Text(
                                          "${SahaStringUtils().convertToMoney(history.money ?? 0)}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      ],
                    )
                  : Container()),
              SizedBox(
                height: 10,
              ),
              Obx(() => revenueExpenditureController
                              .revenueExpenditure.value.historyImportStocks !=
                          null &&
                      revenueExpenditureController.revenueExpenditure.value
                          .historyImportStocks!.isNotEmpty
                  ? Column(
                      children: [
                        Container(
                          width: Get.width,
                          color: Colors.white,
                          height: 45,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "   Đơn hàng được thanh toán",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Column(
                          children: revenueExpenditureController
                              .revenueExpenditure.value.historyImportStocks!
                              .map(
                                (history) => Container(
                                  width: Get.width,
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => ImportStockDetailScreen(
                                                importStockInputId:
                                                    history.importStockIdRef ??
                                                        0,
                                              ));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              history.code ?? "",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              "${SahaDateUtils().getDDMMYY(history.createdAt!)}, ${SahaDateUtils().getHHMM(history.createdAt!)}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${SahaStringUtils().convertToMoney(history.money ?? 0)}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      ],
                    )
                  : Container()),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => revenueExpenditureController
                      .revenueExpenditure.value.createdAt ==
                  null
              ? Container(
                  height: 65,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SahaButtonFullParent(
                        text: "Tạo phiếu ${isRevenue == true ? "thu" : "chi"}",
                        onPressed: () {
                          revenueExpenditureController
                              .createRevenueExpenditure();
                        },
                        color: SahaColorUtils()
                            .colorPrimaryTextWithWhiteBackground(),
                      ),
                    ],
                  ),
                )
              : Container(
                  height: 1,
                  width: 1,
                ),
        ),
      ),
    );
  }

  Widget typePayment(int paymentMethod) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: Get.context!,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
            ),
            builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Chọn hình thức thanh toán",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/credit_card.svg",
                      height: 40,
                      width: 40,
                    ),
                    title: Text(
                      'Chuyển khoản',
                    ),
                    onTap: () {
                      Get.back();
                      revenueExpenditureController
                          .revenueExpenditure.value.paymentMethod = 3;
                      revenueExpenditureController.revenueExpenditure.refresh();
                    },
                    trailing: revenueExpenditureController
                                .revenueExpenditure.value.paymentMethod ==
                            3
                        ? Icon(
                            Icons.check,
                            color: Colors.blue,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/transfer_money.svg",
                      height: 40,
                      width: 40,
                    ),
                    title: Text(
                      "Tiền mặt",
                    ),
                    onTap: () {
                      Get.back();
                      revenueExpenditureController
                          .revenueExpenditure.value.paymentMethod = 0;
                      revenueExpenditureController.revenueExpenditure.refresh();
                    },
                    trailing: revenueExpenditureController
                                .revenueExpenditure.value.paymentMethod ==
                            0
                        ? Icon(
                            Icons.check,
                            color: Colors.blue,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/atm.svg",
                      height: 40,
                      width: 40,
                    ),
                    title: Text(
                      "Quẹt thẻ",
                    ),
                    onTap: () {
                      Get.back();
                      revenueExpenditureController
                          .revenueExpenditure.value.paymentMethod = 1;
                      revenueExpenditureController.revenueExpenditure.refresh();
                    },
                    trailing: revenueExpenditureController
                                .revenueExpenditure.value.paymentMethod ==
                            1
                        ? Icon(
                            Icons.check,
                            color: Colors.blue,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/cod.svg",
                      height: 40,
                      width: 40,
                    ),
                    title: Text(
                      "COD",
                    ),
                    onTap: () {
                      Get.back();
                      revenueExpenditureController
                          .revenueExpenditure.value.paymentMethod = 2;
                      revenueExpenditureController.revenueExpenditure.refresh();
                    },
                    trailing: revenueExpenditureController
                                .revenueExpenditure.value.paymentMethod ==
                            2
                        ? Icon(
                            Icons.check,
                            color: Colors.blue,
                          )
                        : null,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            });
      },
      child: Container(
        child: Column(
          children: [
            if (PAYMENT_TYPE_TRANSFER == paymentMethod)
              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/credit_card.svg",
                        height: 40,
                        width: 40,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Chuyển khoản",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            if (PAYMENT_TYPE_CASH == paymentMethod)
              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/transfer_money.svg",
                        height: 40,
                        width: 40,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Tiền mặt",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            if (PAYMENT_TYPE_SWIPE == paymentMethod)
              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/atm.svg",
                        height: 40,
                        width: 40,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Quẹt thẻ",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            if (PAYMENT_TYPE_COD == paymentMethod)
              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/cod.svg",
                        height: 40,
                        width: 40,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "COD",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  String? getType(int? type) {
    if (type == 0) {
      return "Thanh toán cho đơn hàng";
    }

    if (type == 1) {
      return "Thu nhập khác";
    }

    if (type == 2) {
      return "Tiền thưởng";
    }

    if (type == 3) {
      return "Khởi tạo kho";
    }
    if (type == 4) {
      return "Cho thuê tài sản";
    }
    if (type == 5) {
      return "Nhượng bán thanh lý tài sản";
    }
    if (type == 6) {
      return "Thu nợ khách hàng";
    }
    if (type == 10) {
      return "Chi phí khác";
    }
    if (type == 11) {
      return "Chi phí sản phẩm";
    }
    if (type == 12) {
      return "chi phí nguyên vật liệu";
    }
    if (type == 13) {
      return "Chi phí sinh hoạt";
    }
    if (type == 14) {
      return "Chi phí nhân công";
    }
    if (type == 15) {
      return "Chi phí bán hàng";
    }
    if (type == 16) {
      return "Chi phí quản lý cửa hàng";
    }
    if (type == 17) {
      return "Thanh toán cho đơn nhập hàng";
    }
    return null;
  }

  String? getRecipientGroup(int? type) {
    if (type == 0) {
      return "Nhóm khách hàng";
    }

    if (type == 1) {
      return "Nhóm nhà cung cấp";
    }

    if (type == 2) {
      return "Nhóm nhân viên";
    }

    if (type == 3) {
      return "Đối tượng khác";
    }
    return "${isRevenue == true ? "Chọn nhóm người nộp" : "Chọn nhóm người nhận"}";
  }

  void showType() {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Loại phiếu chi",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Chi phí khác',
                        ),
                        onTap: () {
                          Get.back();
                          revenueExpenditureController
                              .revenueExpenditure.value.type = 10;
                          revenueExpenditureController.revenueExpenditure
                              .refresh();
                        },
                      ),
                    ),
                    if (revenueExpenditureController
                            .revenueExpenditure.value.type ==
                        10)
                      Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Thanh toán cho đơn nhập hàng',
                        ),
                        onTap: () {
                          Get.back();
                          revenueExpenditureController
                              .revenueExpenditure.value.type = 17;
                          revenueExpenditureController.revenueExpenditure
                              .refresh();
                        },
                      ),
                    ),
                    if (revenueExpenditureController
                            .revenueExpenditure.value.type ==
                        17)
                      Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Chi phí sản phẩm',
                        ),
                        onTap: () {
                          Get.back();
                          revenueExpenditureController
                              .revenueExpenditure.value.type = 11;
                          revenueExpenditureController.revenueExpenditure
                              .refresh();
                        },
                      ),
                    ),
                    if (revenueExpenditureController
                            .revenueExpenditure.value.type ==
                        11)
                      Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Chi phí nguyên vật liệu',
                        ),
                        onTap: () {
                          Get.back();
                          revenueExpenditureController
                              .revenueExpenditure.value.type = 12;
                          revenueExpenditureController.revenueExpenditure
                              .refresh();
                        },
                      ),
                    ),
                    if (revenueExpenditureController
                            .revenueExpenditure.value.type ==
                        12)
                      Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Chi phí sinh hoạt',
                        ),
                        onTap: () {
                          Get.back();
                          revenueExpenditureController
                              .revenueExpenditure.value.type = 13;
                          revenueExpenditureController.revenueExpenditure
                              .refresh();
                        },
                      ),
                    ),
                    if (revenueExpenditureController
                            .revenueExpenditure.value.type ==
                        13)
                      Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Chi phí nhân công',
                        ),
                        onTap: () {
                          Get.back();
                          revenueExpenditureController
                              .revenueExpenditure.value.type = 14;
                          revenueExpenditureController.revenueExpenditure
                              .refresh();
                        },
                      ),
                    ),
                    if (revenueExpenditureController
                            .revenueExpenditure.value.type ==
                        14)
                      Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Chi phí bán hàng',
                        ),
                        onTap: () {
                          Get.back();
                          revenueExpenditureController
                              .revenueExpenditure.value.type = 15;
                          revenueExpenditureController.revenueExpenditure
                              .refresh();
                        },
                      ),
                    ),
                    if (revenueExpenditureController
                            .revenueExpenditure.value.type ==
                        15)
                      Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Chi phí quản lý cửa hàng',
                        ),
                        onTap: () {
                          Get.back();
                          revenueExpenditureController
                              .revenueExpenditure.value.type = 16;
                          revenueExpenditureController.revenueExpenditure
                              .refresh();
                        },
                      ),
                    ),
                    if (revenueExpenditureController
                            .revenueExpenditure.value.type ==
                        16)
                      Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  void showTypeRevenue() {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Loại phiếu thu",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  'Thanh toán cho đơn hàng',
                                ),
                                onTap: () {
                                  Get.back();
                                  revenueExpenditureController
                                      .revenueExpenditure.value.type = 0;
                                  revenueExpenditureController
                                      .revenueExpenditure
                                      .refresh();
                                },
                              ),
                            ),
                            if (revenueExpenditureController
                                    .revenueExpenditure.value.type ==
                                0)
                              Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        Divider(
                          height: 1,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "Thu nhập khác",
                                ),
                                onTap: () {
                                  Get.back();
                                  revenueExpenditureController
                                      .revenueExpenditure.value.type = 1;
                                  revenueExpenditureController
                                      .revenueExpenditure
                                      .refresh();
                                },
                              ),
                            ),
                            if (revenueExpenditureController
                                    .revenueExpenditure.value.type ==
                                1)
                              Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        Divider(
                          height: 1,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "Tiền thưởng",
                                ),
                                onTap: () {
                                  Get.back();
                                  revenueExpenditureController
                                      .revenueExpenditure.value.type = 2;
                                  revenueExpenditureController
                                      .revenueExpenditure
                                      .refresh();
                                },
                              ),
                            ),
                            if (revenueExpenditureController
                                    .revenueExpenditure.value.type ==
                                2)
                              Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        Divider(
                          height: 1,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "Khởi tạo kho",
                                ),
                                onTap: () {
                                  Get.back();
                                  revenueExpenditureController
                                      .revenueExpenditure.value.type = 3;
                                  revenueExpenditureController
                                      .revenueExpenditure
                                      .refresh();
                                },
                              ),
                            ),
                            if (revenueExpenditureController
                                    .revenueExpenditure.value.type ==
                                3)
                              Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        Divider(
                          height: 1,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "Cho thuê tài sản",
                                ),
                                onTap: () {
                                  Get.back();
                                  revenueExpenditureController
                                      .revenueExpenditure.value.type = 4;
                                  revenueExpenditureController
                                      .revenueExpenditure
                                      .refresh();
                                },
                              ),
                            ),
                            if (revenueExpenditureController
                                    .revenueExpenditure.value.type ==
                                4)
                              Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        Divider(
                          height: 1,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "Nhượng bán thanh lý tài sản",
                                ),
                                onTap: () {
                                  Get.back();
                                  revenueExpenditureController
                                      .revenueExpenditure.value.type = 5;
                                  revenueExpenditureController
                                      .revenueExpenditure
                                      .refresh();
                                },
                              ),
                            ),
                            if (revenueExpenditureController
                                    .revenueExpenditure.value.type ==
                                5)
                              Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        Divider(
                          height: 1,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "Thu nợ khách hàng",
                                ),
                                onTap: () {
                                  Get.back();
                                  revenueExpenditureController
                                      .revenueExpenditure.value.type = 6;
                                  revenueExpenditureController
                                      .revenueExpenditure
                                      .refresh();
                                },
                              ),
                            ),
                            if (revenueExpenditureController
                                    .revenueExpenditure.value.type ==
                                6)
                              Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void showGroup({bool? isRevenue}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Nhóm người ${isRevenue == true ? 'nộp' : 'nhận'}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Nhóm khách hàng',
                      ),
                      onTap: () {
                        Get.back();
                        if (revenueExpenditureController
                                .revenueExpenditure.value.recipientGroup !=
                            0) {
                          revenueExpenditureController
                              .nameRecipientReferencesId.value = "";
                          revenueExpenditureController.revenueExpenditure.value
                              .recipientReferencesId = null;
                        }
                        revenueExpenditureController
                            .revenueExpenditure.value.recipientGroup = 0;
                        revenueExpenditureController.revenueExpenditure
                            .refresh();
                      },
                    ),
                  ),
                  if (revenueExpenditureController
                          .revenueExpenditure.value.recipientGroup ==
                      0)
                    Icon(
                      Icons.check,
                      color: Colors.blue,
                    ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              Divider(
                height: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Nhóm nhà cung cấp',
                      ),
                      onTap: () {
                        Get.back();
                        if (revenueExpenditureController
                                .revenueExpenditure.value.recipientGroup !=
                            1) {
                          revenueExpenditureController
                              .nameRecipientReferencesId.value = "";
                          revenueExpenditureController.revenueExpenditure.value
                              .recipientReferencesId = null;
                        }
                        revenueExpenditureController
                            .revenueExpenditure.value.recipientGroup = 1;
                        revenueExpenditureController.revenueExpenditure
                            .refresh();
                      },
                    ),
                  ),
                  if (revenueExpenditureController
                          .revenueExpenditure.value.recipientGroup ==
                      1)
                    Icon(
                      Icons.check,
                      color: Colors.blue,
                    ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              Divider(
                height: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        "Nhóm nhân viên",
                      ),
                      onTap: () {
                        Get.back();
                        if (revenueExpenditureController
                                .revenueExpenditure.value.recipientGroup !=
                            2) {
                          revenueExpenditureController
                              .nameRecipientReferencesId.value = "";
                          revenueExpenditureController.revenueExpenditure.value
                              .recipientReferencesId = null;
                        }
                        revenueExpenditureController
                            .revenueExpenditure.value.recipientGroup = 2;
                        revenueExpenditureController.revenueExpenditure
                            .refresh();
                      },
                    ),
                  ),
                  if (revenueExpenditureController
                          .revenueExpenditure.value.recipientGroup ==
                      2)
                    Icon(
                      Icons.check,
                      color: Colors.blue,
                    ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              Divider(
                height: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        "Đối tượng khác",
                      ),
                      onTap: () {
                        Get.back();
                        if (revenueExpenditureController
                                .revenueExpenditure.value.recipientGroup !=
                            3) {
                          revenueExpenditureController
                              .nameRecipientReferencesId.value = "";
                          revenueExpenditureController.revenueExpenditure.value
                              .recipientReferencesId = null;
                        }
                        revenueExpenditureController
                            .revenueExpenditure.value.recipientGroup = 3;
                        revenueExpenditureController.revenueExpenditure
                            .refresh();
                      },
                    ),
                  ),
                  if (revenueExpenditureController
                          .revenueExpenditure.value.recipientGroup ==
                      3)
                    Icon(
                      Icons.check,
                      color: Colors.blue,
                    ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              Divider(
                height: 1,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }
}
