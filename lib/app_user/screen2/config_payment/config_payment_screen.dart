import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/payment_method/all_payment_method_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/switch_button/switch_button.dart';
import '../../../saha_data_controller.dart';
import 'config_detail_payment/config_detail_payment_screen.dart';
import 'config_payment_controller.dart';

class ConfigPayment extends StatelessWidget {
  late ConfigPaymentController configPaymentController;
  SahaDataController sahaDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    configPaymentController = Get.put(ConfigPaymentController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Cài đặt thanh toán"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: Get.width,
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      height: 13,
                      width: 13,
                      child: SvgPicture.asset(
                        "assets/icons/bell.svg",
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                          "Vui lòng lựa chọn phương thức thanh toán mà bạn muốn kích hoạt cho Shop."),
                    )
                  ],
                ),
              ),
            ),
            Obx(
              () =>configPaymentController.loadInit.value ? SahaLoadingFullScreen(): Column(
                children: [
                  ...configPaymentController.listPaymentMethod
                      .map((e) => itemPayment(e)).toList()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemPayment(PaymentMethod paymentMethod) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("${paymentMethod.name ?? ''}")),
              SizedBox(
                width: 10,
              ),
              if (paymentMethod.id != 0)
                InkWell(
                  onTap: () {
                    Get.to(() => ConfigDetailPaymentScreen(
                        paymentMethod: paymentMethod,
                        // listDefineField:
                        //     paymentMethod.defineField,
                        // listTextEditingController: configPaymentController
                        //     .listTextEditingController[index],
                        // listFieldRequest:
                        //     configPaymentController.listFieldRequest[index],
                        // listConfig: configPaymentController.listConfig[index],
                        ));
                  },
                  child: Text(
                    "Cài đặt",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              SizedBox(
                width: 10,
              ),
             
                CustomSwitch(
                  value: paymentMethod.use ?? false,
                  onChanged: (bool val) {
                    if (paymentMethod.id == 0) {
                      configPaymentController.upDatePaymentMethod(
                        paymentMethod.id,
                        {
                          "description": "Thanh toán khi nhận hàng",
                        },
                        val,
                      );
                    }
                    if (paymentMethod.id == 1) {
                      configPaymentController.upDatePaymentMethod(
                        paymentMethod.id,
                        {
                          "description" : "Thanh toán qua ngân hàng",
                          "payment_guide": paymentMethod.config!.paymentGuide!
                              .map((e) => e.toJson())
                              .toList(),
                        },
                        val,
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
                        val,
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
                        val,
                      );
                    }
                    // if (configPaymentController.listUsePaymentMethod[index]!) {
                    //   configPaymentController.upDatePaymentMethod(
                    //       configPaymentController.listIdPaymentMethod[index],
                    //       index == 1
                    //           ? {
                    //               "payment_guide":
                    //                   configPaymentController.listConfig[1][0]
                    //             }
                    //           : {
                    //               "payment_key":
                    //                   "${configPaymentController.listTextEditingController[2][2].text}",
                    //               "security_code":
                    //                   "${configPaymentController.listTextEditingController[2][1].text}",
                    //               "token_key":
                    //                   "${configPaymentController.listTextEditingController[2][0].text}",
                    //             },
                    //       false,);
                    // } else {
                    //   configPaymentController.upDatePaymentMethod(
                    //       configPaymentController.listIdPaymentMethod[index],
                    //       index == 1
                    //           ? {
                    //               "payment_guide":
                    //                   configPaymentController.listConfig[1][0]
                    //             }
                    //           : {
                    //               "payment_key":
                    //                   "${configPaymentController.listTextEditingController[2][2].text}",
                    //               "security_code":
                    //                   "${configPaymentController.listTextEditingController[2][1].text}",
                    //               "token_key":
                    //                   "${configPaymentController.listTextEditingController[2][0].text}",
                    //             },
                    //       true);
                    // }
                  },
                ),
              
            ],
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }
}
