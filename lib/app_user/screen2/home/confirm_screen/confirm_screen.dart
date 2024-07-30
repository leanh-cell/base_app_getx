import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_keyboard.dart';
import 'package:com.ikitech.store/app_user/const/const_revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/const/order_constant.dart';
import 'package:com.ikitech.store/app_user/screen2/choose_voucher/choose_voucher_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/choose_address/new_customer_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/choose_customer/choose_customer_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/info_customer/info_customer_screen.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/screen_default/confirm_screen/widget/widget_animate_check.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../shipment/shipment_choose_screen.dart';
import 'choose_address_receiver/config_address_receiver_sreen.dart';
import 'choose_address_receiver/receiver_address_screen.dart';
import 'confirm_controller.dart';

// ignore: must_be_immutable
class ConfirmUserScreen extends StatelessWidget {
  ConfirmUserController confirmController = Get.put(ConfirmUserController());
  final dataKey = new GlobalKey();
  final dataKeyPayment = new GlobalKey();
  HomeController homeController = Get.find();


  late TextEditingController noteEditingController;

  ConfirmUserScreen() {
    noteEditingController = TextEditingController(
      text: homeController.cartCurrent.value.customerNote ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Xác nhận đơn hàng"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                key: dataKey,
                height: 5,
              ),
              Obx(
                () => Column(
                  children: [
                    homeController.cartCurrent.value.infoCustomer != null
                        ? Card(
                            child: InkWell(
                              onTap: () {
                                Get.to(() => ConfigAddressCustomerScreen(
                                          phoneCustomer: homeController
                                                  .cartCurrent
                                                  .value
                                                  .customerPhone ??
                                              "",
                                        ))!
                                    .then(
                                        (value) => {homeController.getCart()});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            shape: BoxShape.circle,
                                          ),
                                          child: SvgPicture.asset(
                                            "packages/sahashop_customer/assets/icons/location.svg",
                                            color: SahaColorUtils()
                                                .colorPrimaryTextWithWhiteBackground(),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Địa chỉ nhận hàng :"),
                                            Container(
                                              width: Get.width * 0.7,
                                              child: Text(
                                                "${homeController.cartCurrent.value.customerName ?? "Chưa có tên"}  | ${homeController.cartCurrent.value.customerPhone ?? "Chưa có số điện thoại"}",
                                                maxLines: 2,
                                              ),
                                            ),
                                            Container(
                                              width: Get.width * 0.7,
                                              child: Text(
                                                "${homeController.cartCurrent.value.addressDetail ?? "Chưa có địa chỉ chi tiết"}",
                                                maxLines: 2,
                                              ),
                                            ),
                                            Container(
                                              width: Get.width * 0.7,
                                              child: Text(
                                                "${homeController.cartCurrent.value.wardsName ?? "Chưa có Phường/Xã"}, ${homeController.cartCurrent.value.districtName ?? "Chưa có Quận/Huyện"}, ${homeController.cartCurrent.value.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 13),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 14,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Obx(
                            () => AnimateCheck(
                              opacity: confirmController.opacityCurrent.value,
                              color:
                                  confirmController.colorAnimateAddress.value,
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    if (homeController
                                            .cartCurrent.value.infoCustomer !=
                                        null) {
                                      Get.to(() => InfoCustomerScreen(
                                            infoCustomerId: homeController
                                                .cartCurrent.value.customerId!,
                                            isCancel: true,
                                          ));
                                    } else {
                                      Get.to(() => ChooseCustomerScreen());
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(6),
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF5F6F9),
                                                shape: BoxShape.circle,
                                              ),
                                              child: SvgPicture.asset(
                                                  "packages/sahashop_customer/assets/icons/location.svg",
                                                  color: SahaColorUtils()
                                                      .colorPrimaryTextWithWhiteBackground()),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Địa chỉ nhận hàng :"),
                                                Container(
                                                  width: Get.width * 0.7,
                                                  child: Text(
                                                    "Chưa chọn địa chỉ nhận hàng (nhấn để chọn)",
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 14,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "packages/sahashop_customer/assets/icons/cart_icon.svg",
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Các mặt hàng đã đặt :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ...homeController.listOrder.map((e) => itemProduct(e)).toList(),
              Divider(
                height: 1,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng số tiền (${homeController.listOrder.length} sản phẩm) : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Obx(
                      () => Text(
                          "${SahaStringUtils().convertToMoney((homeController.cartCurrent.value.cartData?.totalBeforeDiscount ?? 0))}"),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.description_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Ghi chú',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      child: TextFormField(
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Nhập để ghi chú",
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.black87),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          suffixIcon: Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                          ),
                          suffixIconConstraints: BoxConstraints(
                            minWidth: 10,
                            minHeight: 30,
                          ),
                          border: InputBorder.none,
                        ),
                        controller: noteEditingController,
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.end,
                        onTap: () {
                          PopupInput().showDialogInputNote(
                              confirm: (v) {
                                homeController.cartCurrent.value.customerNote =
                                    v;
                                noteEditingController.text = v;
                                homeController.updateInfoCart();
                              },
                              title: "Ghi chú",
                              textInput:
                                  "${homeController.cartCurrent.value.customerNote ?? ""}");
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ShipmentChooseScreen());
                },
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.local_shipping,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Phí vận chuyển : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacer(),
                      Obx(
                        () =>
                            homeController.cartCurrent.value.totalShippingFee ==
                                        null ||
                                    homeController.cartCurrent.value
                                            .totalShippingFee ==
                                        0
                                ? Text("Chọn hoặc miễn phí")
                                : Text(
                                    "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.totalShippingFee ?? 0)}",
                                    style: TextStyle(fontSize: 13),
                                  ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: SahaColorUtils()
                            .colorPrimaryTextWithWhiteBackground(),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ChooseVoucherScreen(
                            voucherCodeChooseInput:
                                homeController.cartCurrent.value.codeVoucher,
                          ))!
                      .then((value) => {});
                },
                child: Container(
                  key: dataKeyPayment,
                  height: 55,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "packages/sahashop_customer/assets/icons/receipt.svg",
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Shop Voucher : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacer(),
                      Obx(
                        () => homeController.cartCurrent.value.codeVoucher ==
                                    null ||
                                homeController.cartCurrent.value.codeVoucher ==
                                    ""
                            ? Text("Chọn hoặc nhập mã")
                            : Text(
                                "Mã: ${homeController.cartCurrent.value.codeVoucher}",
                                style: TextStyle(fontSize: 13),
                              ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: SahaColorUtils()
                            .colorPrimaryTextWithWhiteBackground(),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              confirmController.paymentMethodName.value != ""
                  ? Container(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          // Get.to(() => PaymentMethodCustomerScreen(
                          //       idPaymentCurrent:
                          //           confirmController.idPaymentCurrent.value,
                          //       callback: (String paymentMethodName,
                          //           int idPaymentCurrent) {
                          //         confirmController.paymentMethodName.value =
                          //             paymentMethodName;
                          //         confirmController.idPaymentCurrent.value =
                          //             idPaymentCurrent;
                          //       },
                          //     ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F6F9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    "packages/sahashop_customer/assets/icons/money.svg",
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Phương thức thanh toán',
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            Spacer(),
                            Obx(
                              () => InkWell(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Chọn hình thức thanh toán",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
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
                                                confirmController
                                                    .paymentMethod.value = 3;
                                                confirmController.cod = 0;
                                              },
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
                                                "Thanh toán khi nhận hàng",
                                              ),
                                              onTap: () {
                                                Get.back();
                                                confirmController
                                                    .paymentMethod.value = 2;
                                              },
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  width: 120,
                                  child: Text(
                                    "${namePayment(confirmController.paymentMethod.value)}",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Obx(
                      () => AnimateCheck(
                        opacity: confirmController.opacityPaymentCurrent.value,
                        color: confirmController.colorAnimatePayment.value,
                        child: InkWell(
                          onTap: () {
                            // Get.to(() => PaymentMethodCustomerScreen(
                            //       idPaymentCurrent:
                            //           confirmController.idPaymentCurrent.value,
                            //       callback: (String paymentMethodName,
                            //           int idPaymentCurrent) {
                            //         confirmController.paymentMethodName.value =
                            //             paymentMethodName;
                            //         confirmController.idPaymentCurrent.value =
                            //             idPaymentCurrent;
                            //       },
                            //     ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5F6F9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      "packages/sahashop_customer/assets/icons/money.svg",
                                      color: SahaColorUtils()
                                          .colorPrimaryTextWithWhiteBackground(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Phương thức thanh toán',
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Obx(
                                () => Container(
                                  width: 120,
                                  child: confirmController
                                              .paymentMethodName.value ==
                                          ""
                                      ? Text(
                                          "Chọn phương thức thanh toán",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: SahaColorUtils()
                                                  .colorPrimaryTextWithWhiteBackground()),
                                        )
                                      : Text(
                                          "${confirmController.paymentMethodName.value}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: SahaColorUtils()
                                                  .colorPrimaryTextWithWhiteBackground()),
                                        ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              Divider(
                height: 1,
              ),
              Obx(
                () => (homeController.cartCurrent.value.cartData
                                ?.balanceCollaboratorCanUse ??
                            0) >
                        0
                    ? Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/fair_trade.svg",
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Dùng số dư cộng tác viên ",
                            style: TextStyle(fontSize: 13),
                          ),
                          Spacer(),
                          Text(
                              "[-${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.balanceCollaboratorCanUse ?? 0)}₫] "),
                          CupertinoSwitch(
                            value: homeController.cartCurrent.value
                                    .isUseBalanceCollaborator ??
                                false,
                            onChanged: (bool value) {
                              homeController.cartCurrent.value
                                  .isUseBalanceCollaborator = !(homeController
                                      .cartCurrent
                                      .value
                                      .isUseBalanceCollaborator ??
                                  false);
                              homeController.cartCurrent.refresh();
                              homeController.updateInfoCart();
                            },
                          ),
                        ],
                      )
                    : Container(),
              ),
              Divider(
                height: 1,
              ),
              Obx(
                () => Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tạm tính :',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700])),
                            Text(
                                "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.totalBeforeDiscount ?? 0)}",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800])),
                          ],
                        ),
                      ),
                      homeController.cartCurrent.value.cartData
                                  ?.productDiscountAmount ==
                              0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Giảm giá sản phẩm :',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                  Text(
                                      "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.productDiscountAmount ?? 0)}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800])),
                                ],
                              ),
                            ),
                      homeController.cartCurrent.value.cartData
                                  ?.voucherDiscountAmount ==
                              0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Giảm giá voucher :',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                  Text(
                                      "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.voucherDiscountAmount ?? 0)}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800])),
                                ],
                              ),
                            ),
                      homeController.cartCurrent.value.cartData
                                  ?.comboDiscountAmount ==
                              0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Giảm giá combo :',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                  Text(
                                      "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.comboDiscountAmount ?? 0)}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800])),
                                ],
                              ),
                            ),
                      homeController.cartCurrent.value.cartData?.discount == 0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Chiết khấu :',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                  Text(
                                      "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.discount ?? 0)}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800])),
                                ],
                              ),
                            ),
                      homeController.cartCurrent.value.cartData?.isUsePoints ==
                              false
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Giảm giá Xu :',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                  Text(
                                      "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.bonusPointsAmountUsed)}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800])),
                                ],
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tổng tiền vận chuyển :',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700])),
                            Text(
                                "+ ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.totalShippingFee ?? 0)}",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800])),
                          ],
                        ),
                      ),
                      if ((homeController.cartCurrent.value.cartData
                                  ?.shipDiscountAmount ??
                              0) >
                          0)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Miễn phí vận chuyển :',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[700])),
                              Text(
                                  "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.shipDiscountAmount ?? 0)}",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[800])),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tổng thanh toán :',
                            ),
                            Text(
                                "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.totalFinal ?? 0)}",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.grey[200],
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F6F9),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            "packages/sahashop_customer/assets/icons/doc.svg",
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                              "Nhấn 'Đặt hàng' đồng nghĩa với việc bạn đồng ý tuân theo Điều khoản ${StoreInfo().name} "),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
            height: 100,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                offset: Offset(0, 0.1), // Shadow position
              ),
            ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    PopupKeyboard().showDialogInputKeyboard(
                      numberInput:
                          "${SahaStringUtils().convertToMoney(confirmController.amountMoney.value)}",
                      title: "Số tiền trả trước",
                      confirm: (number) {
                        confirmController.amountMoney.value = number;
                        if (confirmController.amountMoney.value >
                            (homeController
                                    .cartCurrent.value.cartData?.totalFinal ??
                                0)) {
                          confirmController.amountMoney.value = (homeController
                                  .cartCurrent.value.cartData?.totalFinal ??
                              0);
                        }
                        confirmController.amountMoney.refresh();
                      },
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      if (confirmController.amountMoney.value != 0)
                        Text(
                          "Đã trả trước: ${SahaStringUtils().convertToMoney(confirmController.amountMoney.value)}",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.blue,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Tổng thanh toán",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Text(
                        "${SahaStringUtils().convertToMoney((homeController.cartCurrent.value.cartData?.totalFinal ?? 0) - confirmController.amountMoney.value)}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () async {
                    if (homeController.cartCurrent.value.infoCustomer == null) {
                      Scrollable.ensureVisible(dataKey.currentContext!,
                          duration: Duration(milliseconds: 500));
                      confirmController.colorAnimateAddress.value = Colors.red;
                      confirmController.opacityCurrent.value = 0;
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        confirmController.opacityCurrent.value = 1;
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          confirmController.opacityCurrent.value = 0;
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            confirmController.opacityCurrent.value = 1;
                          });
                        });
                      });
                    } else {
                      if (homeController
                              .cartCurrent.value.infoCustomer?.province ==
                          null) {
                        SahaDialogApp.showDialogYesNo(
                            mess:
                                "Khách hàng chưa có địa chỉ!\nThiết lập địa chỉ ?",
                            onOK: () {
                              Get.to(() => NewCustomerScreen(
                                        infoCustomer: homeController
                                            .cartCurrent.value.infoCustomer,
                                        isShowAll: true,
                                      ))!
                                  .then((value) => {
                                        homeController.getCart(),
                                      });
                            });
                      } else {
                        Get.until(
                          (route) => route.settings.name == "home_screen",
                        );
                        if (homeController.isLoadingOrder.value == false) {
                          if (homeController.listOrder.isNotEmpty) {
                            homeController.isShowBill.value = false;
                            await homeController.orderCart(
                                paymentMethod:
                                    confirmController.paymentMethod.value,
                                amountMoney:
                                    confirmController.amountMoney.value,
                                orderFrom: ORDER_FROM_POS_DELIVERY);
                            confirmController.amountMoney.value = 0;
                            homeController.isShowBill.value = false;
                            homeController.cartCurrent.value.id = 0;
                            homeController.getCart();
                            homeController.searchProduct();
                          }
                        }
                      }
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(color: Colors.grey[200]!)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Lên đơn",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6!
                                  .color,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget itemProduct(LineItem lineItem) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: lineItem.product!.images!.length == 0
                            ? ""
                            : lineItem.product!.images![0].imageUrl!,
                        errorWidget: (context, url, error) => SahaEmptyImage(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lineItem.product!.name ?? "Loi san pham",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        maxLines: 2,
                      ),
                      if (lineItem.distributesSelected != null &&
                          lineItem.distributesSelected!.isNotEmpty)
                        SizedBox(
                          height: 5,
                        ),
                      if (lineItem.distributesSelected != null &&
                          lineItem.distributesSelected!.isNotEmpty)
                        Text(
                          'Phân loại: ${lineItem.distributesSelected![0].value ?? ""}${lineItem.distributesSelected![0].subElement == null ? "" : ","} ${lineItem.distributesSelected![0].subElement ?? ""}',
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${SahaStringUtils().convertToMoney(lineItem.itemPrice ?? 0)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: SahaColorUtils()
                                      .colorPrimaryTextWithWhiteBackground()),
                            ),
                          ),
                          Text(" x${lineItem.quantity}   ",
                              style:
                                  Theme.of(Get.context!).textTheme.bodyText1),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }

  String namePayment(int paymentMethod) {
    if (PAYMENT_TYPE_SWIPE == paymentMethod) {
      return "QUẸT THẺ";
    }
    if (PAYMENT_TYPE_CASH == paymentMethod) {
      return "TIỀN MẶT";
    }
    if (PAYMENT_TYPE_COD == paymentMethod) {
      return "Thanh toán khi nhận hàng";
    }
    if (PAYMENT_TYPE_TRANSFER == paymentMethod) {
      return "Chuyển khoản";
    }
    return "";
  }
}
