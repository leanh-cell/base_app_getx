import 'package:com.ikitech.store/app_user/data/remote/response-request/payment_method/all_payment_method_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/saha_user/button/saha_button.dart';
import '../config_payment_controller.dart';
import 'widget/config_payment_guide_for_bank.dart';

class ConfigDetailPaymentScreen extends StatelessWidget {
  
  final PaymentMethod paymentMethod;
  ConfigDetailPaymentScreen({
    required this.paymentMethod,
  }) {
    configPaymentController = Get.find();
  }

  late ConfigPaymentController configPaymentController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Thiết lập tài khoản"),
      ),
      body: paymentMethod.id == 1
          ? ConfigPaymentGuideBank(
              listPaymentMethod: configPaymentController
                  .listPaymentMethod[1].config?.paymentGuide,
              onSave: (List<BankModel> list) {
                configPaymentController.upDatePaymentMethod(
                    paymentMethod.id,
                    {"payment_guide": list.map((e) => e.toJson()).toList()},
                    true,
                    back: false);
                // configPaymentController.listConfig[1][0] =
                //     list.map((e) => e.toJson()).toList();
              },
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if(paymentMethod.id == 2)
                  vnPay(),
                  if(paymentMethod.id == 3)
                  onePay()
                ],
              ),
            ),
      bottomNavigationBar: paymentMethod.id != 1
          ? Container(
              height: 65,
              color: Colors.white,
              child: Column(
                children: [
                  SahaButtonFullParent(
                    color: Theme.of(context).primaryColor,
                    text: "Lưu",
                    onPressed: () {
                        if (paymentMethod.id == 0) {
                      configPaymentController.upDatePaymentMethod(
                        paymentMethod.id,
                        {
                          "description": "Thanh toán khi nhận hàng",
                        },
                        true,
                      );
                    }
                
                    if (paymentMethod.id == 2) {
                      configPaymentController.upDatePaymentMethod(
                        paymentMethod.id,
                        {
                          "description": "Thanh toán qua VNPAY",
                          "vnp_TmnCode": paymentMethod.config?.vnpTmnCode,
                          "vnp_HashSecret":
                              paymentMethod.config?.vnpHashSecret,
                        },
                        true,
                      );
                    }
                    if (paymentMethod.id == 3) {
                      configPaymentController.upDatePaymentMethod(
                        paymentMethod.id,
                        {
                          "merchant": paymentMethod.config?.merchant,
                          "hascode": paymentMethod.config?.hascode,
                          "access_code": paymentMethod.config?.accessCode,
                        },
                        true,
                      );
                    }
                      // configPaymentController.upDatePaymentMethod(
                      //     2,
                      //     {
                      //       "payment_key":
                      //           "${configPaymentController.listTextEditingController[2][2].text}",
                      //       "security_code":
                      //           "${configPaymentController.listTextEditingController[2][1].text}",
                      //       "token_key":
                      //           "${configPaymentController.listTextEditingController[2][0].text}",
                      //     },
                      //     true);
                      Get.back();
                    },
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget vnPay() {
    var vnpTmnCode = TextEditingController(text: paymentMethod.config?.vnpTmnCode);
    var vnpHashSecret = TextEditingController(text: paymentMethod.config?.vnpHashSecret);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: 50,
          child: Row(
            children: [
              Icon(
                Icons.keyboard_hide_outlined,
                size: 18,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: vnpTmnCode,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "Nhập ${paymentMethod.defineField?[0] ?? ''}",
                  ),
                  style: TextStyle(fontSize: 15),
                  minLines: 1,
                  maxLines: 1,
                  onChanged: (v) {
                    paymentMethod.config?.vnpTmnCode = v; 
                  },
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
          Container(
          padding: EdgeInsets.all(10),
          height: 50,
          child: Row(
            children: [
              Icon(
                Icons.keyboard_hide_outlined,
                size: 18,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: vnpHashSecret,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "Nhập ${paymentMethod.defineField?[1] ?? ''}",
                  ),
                  style: TextStyle(fontSize: 15),
                  minLines: 1,
                  maxLines: 1,
                  onChanged: (v) {
                    paymentMethod.config?.vnpHashSecret = v; 
                  
                   
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

   Widget onePay() {
    var merchant = TextEditingController(text: paymentMethod.config?.merchant);
    var hascode = TextEditingController(text: paymentMethod.config?.hascode);
    var accessCode = TextEditingController(text: paymentMethod.config?.accessCode);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: 50,
          child: Row(
            children: [
              Icon(
                Icons.keyboard_hide_outlined,
                size: 18,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: merchant,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "Nhập ${paymentMethod.defineField?[0] ?? ''}",
                  ),
                  style: TextStyle(fontSize: 15),
                  minLines: 1,
                  maxLines: 1,
                  onChanged: (v) {
                    paymentMethod.config?.merchant = v; 
                  },
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
          Container(
          padding: EdgeInsets.all(10),
          height: 50,
          child: Row(
            children: [
              Icon(
                Icons.keyboard_hide_outlined,
                size: 18,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: hascode,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "Nhập ${paymentMethod.defineField?[1] ?? ''}",
                  ),
                  style: TextStyle(fontSize: 15),
                  minLines: 1,
                  maxLines: 1,
                  onChanged: (v) {
                    paymentMethod.config?.hascode = v; 
                  
                   
                  },
                ),
              ),
            ],
          ),
        ),
         Divider(
          height: 1,
        ),
          Container(
          padding: EdgeInsets.all(10),
          height: 50,
          child: Row(
            children: [
              Icon(
                Icons.keyboard_hide_outlined,
                size: 18,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: accessCode,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "Nhập ${paymentMethod.defineField?[2] ?? ''}",
                  ),
                  style: TextStyle(fontSize: 15),
                  minLines: 1,
                  maxLines: 1,
                  onChanged: (v) {
                    paymentMethod.config?.accessCode = v; 
                  
                   
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
