import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/voucher.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';

class ChooseController extends GetxController {
  var listVoucher = RxList<Voucher>();
  var listChooseVoucher = RxList<bool>();
  var voucherCodeChoose = "".obs;
  var codeVoucherEditingController = TextEditingController().obs;
  String? voucherCodeChooseInput;

  HomeController cartController = Get.find();

  ChooseController({this.voucherCodeChooseInput}) {
    if (voucherCodeChooseInput != null) {
      voucherCodeChoose.value = voucherCodeChooseInput!;
    }
    getVoucherCustomer();
  }

  Future<void> getVoucherCustomer() async {
    try {
      var res = await RepositoryManager.marketingChanel.getAllVoucher();
      listVoucher(res!.data!);
      listVoucher.forEach((element) {
        listChooseVoucher.add(false);
      });
      var index = listVoucher
          .indexWhere((element) => element.code == voucherCodeChoose.value);
      if (index != -1) {
        listChooseVoucher[index] = true;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void enterCodeVoucher(BuildContext context) async {
    cartController.cartCurrent.value.codeVoucher =
        codeVoucherEditingController.value.text;
    await cartController.useVoucher((err) {
      if (err != 'success') {
        listChooseVoucher([]);
        listVoucher.forEach((element) {
          listChooseVoucher.add(false);
        });
        voucherCodeChoose.value = "";
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(
                    "Bạn chưa đủ điều kiện sử dụng Voucher này !",
                    style: TextStyle(fontSize: 17),
                  ),
                  content: Text(
                    "Vui lòng xem điều kiện sử dụng Voucher, hoặc sử dụng Voucher khác !",
                    style: TextStyle(fontSize: 15),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Thoát",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ));
        cartController.cartCurrent.value.codeVoucher = "";
      } else {
        cartController.cartCurrent.value.codeVoucher =
            codeVoucherEditingController.value.text.toUpperCase();
        Get.back();
      }
    });
  }

  void checkConditionVoucher(BuildContext context) async {
    if (voucherCodeChoose.value.isEmpty) {
      cartController.cartCurrent.value.codeVoucher = "";
      await cartController.useVoucher((err) {});
      cartController.refresh();
      Get.back();
    } else {
      cartController.cartCurrent.value.codeVoucher = voucherCodeChoose.value;
      await cartController.useVoucher((err) {
        if (err != 'success') {
          listChooseVoucher([]);
          listVoucher.forEach((element) {
            listChooseVoucher.add(false);
          });
          voucherCodeChoose.value = "";
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text(
                      "Bạn chưa đủ điều kiện sử dụng Voucher này !",
                      style: TextStyle(fontSize: 17),
                    ),
                    content: Text(
                      "Vui lòng xem điều kiện sử dụng Voucher, hoặc sử dụng Voucher khác !",
                      style: TextStyle(fontSize: 15),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Thoát",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ));
          cartController.cartCurrent.value.codeVoucher = "";
        } else {
          cartController.cartCurrent.value.codeVoucher =
              voucherCodeChoose.value;
          Get.back();
        }
      });
    }
  }

  void checkChooseVoucher(bool value, int index) {
    listChooseVoucher([]);
    listVoucher.forEach((element) {
      listChooseVoucher.add(false);
    });
    voucherCodeChoose.value = "";
    if (value == false) {
      listChooseVoucher[index] = true;
      voucherCodeChoose.value = listVoucher[index].code!;
    }
  }
}
