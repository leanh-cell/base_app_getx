import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';

import 'general_setting_controller.dart';

class GeneralSettingScreen extends StatelessWidget {
  GeneralSettingController generalSettingController =
      GeneralSettingController();

  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cài đặt chung"),
        ),
        body: Obx(
          ()=>generalSettingController.loadInit.value ? SahaLoadingFullScreen(): SingleChildScrollView(
            child: Column(
              children: [
                 Obx(
                  () => itemConfig(
                      title: "Bật phí VAT",
                      config: generalSettingController
                              .generalSetting.value.enableVat ??
                          false,
                      onChange: () {
                        generalSettingController.generalSetting.value
                            .enableVat = !(generalSettingController
                                .generalSetting.value.enableVat ??
                            false);
                        generalSettingController.percentVat.text = '';
                        generalSettingController.generalSetting.value.percentVat = null;
                        generalSettingController.generalSetting.refresh();
                      }),
                ),
                Obx(
                  ()=>generalSettingController.generalSetting.value
                            .enableVat == true ? itemInput(
                      padHead: false,
                      title: "Phí VAT",
                      subTitle: "Phần trăm:",
                      subText: "Nhập phần trăm",
                      typeUnit: "%",
                      controller: generalSettingController.percentVat,
                      validator: (value) {},
                      onChanged: (v) {
                        generalSettingController.generalSetting.value.percentVat =
                            double.parse(v);
                      }) : const SizedBox()
                ),
                Obx(
                  () => itemConfig(
                      title: "Thông báo sắp hết hàng",
                      config: generalSettingController
                              .generalSetting.value.notiNearOutStock ??
                          false,
                      onChange: () {
                        generalSettingController.generalSetting.value
                            .notiNearOutStock = !(generalSettingController
                                .generalSetting.value.notiNearOutStock ??
                            false);
                        generalSettingController.generalSetting.refresh();
                      }),
                ),
                itemInput(
                    padHead: false,
                    title: "Số lượng sản phẩm thông báo gần hết hàng",
                    subTitle: "Số lượng:",
                    subText: "Nhập số lượng",
                    typeUnit: "",
                    controller:
                    generalSettingController.notiStockCountNearEdit,
                    validator: (value) {},
                    onChanged: (v) {
                      generalSettingController.generalSetting.value
                          .notiStockCountNear = int.parse(v);
                    }),
                Obx(
                      () => itemConfig(
                      title: "Cho phép bán âm sản phẩm",
                      config: generalSettingController
                          .generalSetting.value.allowSemiNegative ??
                          false,
                      onChange: () {
                        generalSettingController.generalSetting.value
                            .allowSemiNegative = !(generalSettingController
                            .generalSetting.value.allowSemiNegative ??
                            false);
                        generalSettingController.generalSetting.refresh();
                      }),
                ),
                 Obx(
                      () => itemConfig(
                      title: "Cho phép chọn chi nhánh khi thanh toán đơn hàng",

                      config: generalSettingController
                          .generalSetting.value.allowBranchPaymentOrder ??
                          false,
                      onChange: (v) {
                        generalSettingController.generalSetting.value.allowBranchPaymentOrder = v;
                        generalSettingController.generalSetting.value.autoChooseDefaultBranchPaymentOrder = true;
                        generalSettingController.generalSetting.refresh();
                      }),
                ),
                 Obx(
                      () =>generalSettingController
                          .generalSetting.value.allowBranchPaymentOrder == true ? itemConfig(
                      title: "Tự động chọn chi nhánh mặc định khi thanh toán đơn hàng",
                      config: generalSettingController
                          .generalSetting.value.autoChooseDefaultBranchPaymentOrder ??
                          false,
                      onChange: (v) {
                        generalSettingController.generalSetting.value.autoChooseDefaultBranchPaymentOrder = v;
                        generalSettingController.generalSetting.refresh();
                      }) : const SizedBox()
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Lưu",
                onPressed: () {
                  generalSettingController.editGeneralSettings();
                 
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemConfig(
      {required String title,
      required bool config,
      required Function onChange}) {
    return Column(
      children: [
        Container(
          height: 4,
          color: Colors.grey[200],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              height: 50,
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    title,
                    maxLines: 1,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  )),
                  CupertinoSwitch(
                    value: config,
                    onChanged: (bool value) {
                      onChange(value);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget itemInput({
    required String title,
    required String subTitle,
    required String subText,
    required TextEditingController controller,
    required String typeUnit,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    IconData? icon,
    int? maxLength,
    bool padHead = true,
  }) {
    return Column(
      children: [
        if (padHead == true)
          Container(
            height: 4,
            color: Colors.grey[200],
          ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(icon),
                    ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(subTitle),
                    Expanded(
                      child: TextFormField(
                        maxLength: maxLength,
                        controller: controller,
                        inputFormatters: inputFormatters,
                        keyboardType: TextInputType.number,
                        validator: validator,
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: subText,
                            suffixText: typeUnit,
                            suffixStyle: TextStyle(color: Colors.black)),
                        minLines: 1,
                        maxLines: 1,
                        onChanged: onChanged != null
                            ? (value) {
                                onChanged(value);
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
