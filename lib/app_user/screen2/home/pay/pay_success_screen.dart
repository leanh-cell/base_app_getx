import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/const/const_revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

class PaySuccessScreen extends StatefulWidget {
  double moneyMustPay;

  PaySuccessScreen({
    required this.moneyMustPay,
  });

  @override
  State<PaySuccessScreen> createState() => _PaySuccessScreenState();
}

class _PaySuccessScreenState extends State<PaySuccessScreen> {
  HomeController homeController = Get.find();

  TextEditingController emailEditingController = TextEditingController();
  late TextEditingController textEditingController;
  late TextEditingController noteEditingController;
  final _formKey = GlobalKey<FormState>();
  int paymentMethod = 0;
  List<int> listMoneySuggestions = [];
  bool checkTapEmail = false;

  @override
  void initState() {
    noteEditingController = TextEditingController(
      text: homeController.cartCurrent.value.customerNote ?? "",
    );

    emailEditingController.text = homeController.cartCurrent.value.infoCustomer?.email ?? "";

    textEditingController = TextEditingController(
        text:
            "${SahaStringUtils().convertToUnit(homeController.cartCurrent.value.cartData?.totalFinal ?? 0)}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Thanh toán'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: Get.width,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                            color: Colors.grey[200]),
                        child: Column(
                          children: [
                            Text(
                              "Khách hàng cần thanh toán",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${SahaStringUtils().convertToMoney(widget.moneyMustPay)}₫",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Khách hàng đưa",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            InkWell(
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
                                              setState(() {
                                                paymentMethod = 3;
                                                textEditingController.text =
                                                    "${SahaStringUtils().convertToUnit(homeController.cartCurrent.value.cartData?.totalFinal ?? 0)}";
                                              });
                                            },
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
                                              setState(() {
                                                paymentMethod = 0;
                                              });
                                            },
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
                                              setState(() {
                                                paymentMethod = 1;
                                                textEditingController.text =
                                                    "${SahaStringUtils().convertToUnit(homeController.cartCurrent.value.cartData?.totalFinal ?? 0)}";
                                              });
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
                                              "COD",
                                            ),
                                            onTap: () {
                                              Get.back();
                                              setState(() {
                                                paymentMethod = 2;
                                                textEditingController.text =
                                                    "${SahaStringUtils().convertToUnit(homeController.cartCurrent.value.cartData?.totalFinal ?? 0)}";
                                              });
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
                                height: 50,
                                width: Get.width / 2,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      namePayment(paymentMethod),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Icon(Icons.keyboard_arrow_down_rounded)
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: textEditingController,
                                autofocus: false,
                                onTap: () {
                                  checkTapEmail = false;
                                  textEditingController.text = "";
                                },
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                inputFormatters: [ThousandsFormatter()],
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 15, top: 0, right: 15, bottom: 0),
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Tiền khách trả",
                                ),
                                keyboardType: TextInputType.number,
                                maxLines: null,
                                onChanged: (v) async {
                                  setState(() {
                                    suggestionMoney();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: Get.width / 2,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: double.parse(SahaStringUtils()
                                                .convertFormatText(
                                                    textEditingController
                                                                .text ==
                                                            ""
                                                        ? "0"
                                                        : textEditingController
                                                            .text)) -
                                            (homeController.cartCurrent.value
                                                    .cartData?.totalFinal ??
                                                0) <
                                        0
                                    ? Colors.red
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${double.parse(SahaStringUtils().convertFormatText(textEditingController.text == "" ? "0" : textEditingController.text)) - (homeController.cartCurrent.value.cartData?.totalFinal ?? 0) < 0 ? "KHÁCH HÀNG NỢ" : "TIỀN THỪA"}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  "${SahaStringUtils().convertToMoney(double.parse(SahaStringUtils().convertFormatText(textEditingController.text == "" ? "0" : textEditingController.text)) - (homeController.cartCurrent.value.cartData?.totalFinal ?? 0))}₫",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          maxLines: null,
                          decoration: InputDecoration(labelText: "Ghi chú"),
                          controller: noteEditingController,
                          keyboardType: TextInputType.multiline,
                          onTap: () {
                            PopupInput().showDialogInputNote(
                                confirm: (v) {
                                  homeController
                                      .cartCurrent.value.customerNote = v;
                                  noteEditingController.text = v;
                                  homeController.updateInfoCart();
                                },
                                title: "Ghi chú",
                                textInput:
                                    "${homeController.cartCurrent.value.customerNote ?? ""}");
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          onChanged: (v) {},
                        ),
                      ),
                      if (homeController.infoCustomer.value.email == null ||
                          homeController.infoCustomer.value.email == "")
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            decoration:
                                InputDecoration( labelText: 'Gửi đơn qua email'),
                            controller: emailEditingController,
                            onTap: () {
                              checkTapEmail = true;
                            },
                            validator: (value) {
                              if (value!.length == 0) return null;
                              if (value.length < 1) {
                                return 'Bạn chưa nhập Email';
                              } else {
                                if (GetUtils.isEmail(value)) {
                                  return null;
                                } else {
                                  return 'Email không hợp lệ';
                                }
                              }
                            },
                            onChanged: (v) {},
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (_keyboardIsVisible() && checkTapEmail == false)
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Wrap(
                    spacing: 5,
                    children:
                        listMoneySuggestions.map((e) => itemMoney(e)).toList(),
                  ),
                ),
              SizedBox(
                height: 15,
              )
            ],
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("In hoá đơn:"),
                      CupertinoSwitch(
                        value: UserInfo().getIsPrint() ?? false,
                        onChanged: (bool value) async {
                          setState(() {
                            UserInfo()
                                .setPrint(!(UserInfo().getIsPrint() ?? false));
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SahaButtonFullParent(
                  text: "THANH TOÁN",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (homeController.cartCurrent.value.infoCustomer ==
                              null &&
                          double.parse(SahaStringUtils().convertFormatText(
                                      textEditingController.text == ""
                                          ? "0"
                                          : textEditingController.text)) -
                                  (homeController.cartCurrent.value.cartData
                                          ?.totalFinal ??
                                      0) <
                              0) {
                        SahaAlert.showToastMiddle(
                            message: "Không có khách hàng để cho nợ");
                        Get.back();
                      } else {
                        Get.until(
                          (route) => route.settings.name == "home_screen",
                        );
                        if (homeController.listOrder.isNotEmpty) {
                          homeController.isShowBill.value = false;
                          await homeController.orderCart(
                              paymentMethod: paymentMethod,
                              amountMoney: double.parse(SahaStringUtils()
                                  .convertFormatText(
                                      textEditingController.text == ""
                                          ? "0"
                                          : textEditingController.text)));
                          homeController.isShowBill.value = false;
                          if (emailEditingController.text != "") {
                            homeController
                                .sendOrderEmail(emailEditingController.text);
                          }
                          homeController.cartCurrent.value.id = 0;
                          homeController.getCart();
                          homeController.searchProduct();
                        }
                      }
                    }
                  },
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void suggestionMoney() {
    if (textEditingController.text.length == 0) {
      listMoneySuggestions = [
        100000,
        200000,
        500000,
      ];
    } else if (textEditingController.text.length <= 5) {
      listMoneySuggestions = [
        int.parse(SahaStringUtils()
                .convertFormatText(textEditingController.text)) *
            10,
        int.parse(SahaStringUtils()
                .convertFormatText(textEditingController.text)) *
            100,
        int.parse(SahaStringUtils()
                .convertFormatText(textEditingController.text)) *
            1000
      ];
    } else if (textEditingController.text.length == 6) {
      listMoneySuggestions = [
        int.parse(SahaStringUtils()
                .convertFormatText(textEditingController.text)) *
            10,
        int.parse(SahaStringUtils()
                .convertFormatText(textEditingController.text)) *
            100,
      ];
    } else {
      listMoneySuggestions = [
        int.parse(SahaStringUtils()
                .convertFormatText(textEditingController.text)) *
            10,
      ];
    }
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  Widget itemProduct(
    LineItem order,
  ) {
    String? textMoney() {
      if (order.product?.minPrice == 0) {
        if (order.product?.productDiscount == null) {
          return "${order.product!.price == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(order.product?.price)}₫"}";
        } else {
          return "${order.product!.productDiscount!.discountPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(order.product!.productDiscount!.discountPrice)}₫"}";
        }
      } else {
        if (order.product!.productDiscount == null) {
          return "${order.product!.minPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(order.product!.minPrice)}₫"}";
        } else {
          return "${order.product!.minPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(order.product!.minPrice! - ((order.product!.minPrice! * order.product!.productDiscount!.value!) / 100))}₫"}";
        }
      }
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    imageUrl: order.product?.images != null &&
                            order.product!.images!.isNotEmpty
                        ? (order.product!.images![0].imageUrl ?? "")
                        : "",
                    placeholder: (context, url) => new SahaLoadingWidget(
                      size: 20,
                    ),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${order.product?.name ?? ""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "SL: ${order.quantity ?? "0"}",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  order.product?.productDiscount == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Text(
                            order.product?.minPrice == 0
                                ? "${order.product?.price == 0 ? "Giảm" : "${SahaStringUtils().convertToMoney(order.product?.price ?? 0)}₫"}"
                                : "${SahaStringUtils().convertToMoney(order.product?.minPrice ?? 0)}₫",
                            style: TextStyle(
                                decoration: order.product?.price == 0
                                    ? null
                                    : TextDecoration.lineThrough,
                                color: order.product?.productDiscount == null
                                    ? Theme.of(Get.context!).primaryColor
                                    : Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: order.product?.productDiscount == null
                                    ? 14
                                    : 10),
                          ),
                        ),
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      textMoney()!,
                      style: TextStyle(
                          color: SahaColorUtils()
                              .colorPrimaryTextWithWhiteBackground(),
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }

  Widget itemMoney(int money) {
    return InkWell(
      onTap: () {
        textEditingController.text =
            "${SahaStringUtils().convertToUnit(money)}";
        textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: textEditingController.text.length));
        setState(() {});
      },
      child: Container(
        width: (Get.width - 30) / 3,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
        child: Center(child: Text("${SahaStringUtils().convertToUnit(money)}")),
      ),
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
      return "COD";
    }
    if (PAYMENT_TYPE_TRANSFER == paymentMethod) {
      return "CHUYỂN KHOẢN";
    }
    return "";
  }
}
