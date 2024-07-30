import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../../components/saha_user/button/saha_button.dart';
import '../../../components/saha_user/dialog/dialog.dart';
import '../../../utils/string_utils.dart';
import 'point_manager_controller.dart';

class PointManagerScreen extends StatelessWidget {
  PointManagerController pointManagerController = PointManagerController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Xu thưởng khách hàng"),
          actions: [
            TextButton(
                onPressed: () {
                  SahaDialogApp.showDialogYesNo(
                      mess:
                          "các cài đặt xu thưởng sẽ trở lại mặc định bạn có muốn tiếp tục?",
                      onOK: () {
                        pointManagerController.resetRewardPoint();
                      });
                },
                child: Text(
                  "Đặt lại ",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ))
          ],
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Obx(
                  () => itemConfig(
                      title: "Cho phép sử dụng xu khi mua hàng",
                      config: pointManagerController.permissionUsePoint.value,
                      onChange: () {
                        pointManagerController.permissionUsePoint.value =
                            !pointManagerController.permissionUsePoint.value;
                      }),
                ),
                Obx(
                  () => !pointManagerController.permissionUsePoint.value
                      ? Container()
                      : Column(
                          children: [
                            itemInput(
                                title: "Quy đổi 1 Xu thành VNĐ",
                                subTitle: "1 Xu bằng:",
                                subText: "Nhập số tiền VNĐ",
                                typeUnit: "VNĐ",
                                controller: pointManagerController
                                    .moneyAPointEdit.value,
                                inputFormatters: [ThousandsFormatter()],
                                onChanged: (value) {
                                  pointManagerController.moneyAPointEdit
                                      .refresh();
                                },
                                validator: (value) {
                                  if (value!.length < 1) {
                                    return "Chưa nhập số tiền";
                                  } else {
                                    return null;
                                  }
                                }),
                            itemInput(
                                icon: Ionicons.reader_outline,
                                title: "Phần trăm hoàn xu cho mỗi đơn hàng",
                                subTitle: "Phần trăm:",
                                subText: "Nhập phần trăm",
                                typeUnit: "%",
                                controller: pointManagerController
                                    .percentRefundEdit.value,
                                isShowExam: true,
                                onChanged: (v) {
                                  pointManagerController.percentRefundEdit
                                      .refresh();
                                },
                                validator: (value) {
                                  if (value!.length < 1 ||
                                      double.parse(value) > 100) {
                                    return "Phần trăm không hợp lệ";
                                  } else {
                                    return null;
                                  }
                                }),
                            Obx(
                              () => itemConfig(
                                  title:
                                      "Xét giới hạn Xu nhận ĐƯỢC khi mua hàng",
                                  config:
                                      pointManagerController.limitedPoint.value,
                                  onChange: () {
                                    pointManagerController.limitedPoint.value =
                                        !pointManagerController
                                            .limitedPoint.value;
                                  }),
                            ),
                            Obx(
                              () => pointManagerController.limitedPoint.value ==
                                      true
                                  ? itemInput(
                                      padHead: false,

                                      title:
                                          "Số Xu nhận được tối đa khi mua hàng",
                                      subTitle: "Số Xu:",
                                      subText: "Nhập số Xu",
                                      typeUnit: "Xu",
                                      controller: pointManagerController
                                          .orderMaxPointEdit,
                                      validator: (value) {
                                        if (value!.length < 1 ||
                                            double.parse(value) == 0) {
                                          return "Số Xu không hợp lệ";
                                        } else {
                                          return null;
                                        }
                                      })
                                  : const SizedBox(),
                            ),
                            itemInput(
                              title: "Số Xu nhận được khi Đánh giá sản phẩm",
                              subTitle: "Số Xu:",
                              subText: "Nhập số Xu",
                              typeUnit: "Xu",
                              controller:
                                  pointManagerController.reviewPointEdit,
                            ),
                            itemInput(
                              title:
                                  "Số Xu nhận được khi Giới thiệu 'ĐƯỢC' bạn bè",
                              subTitle: "Số Xu:",
                              subText: "Nhập số Xu",
                              typeUnit: "Xu",
                              controller:
                                  pointManagerController.introducePointEdit,
                            ),
                            Obx(
                              () => itemConfig(
                                  title:
                                      "Xét giới hạn số tiền có thể sử dụng bởi xu trong một đơn hàng",
                                  config:
                                      pointManagerController.isPercentUse.value,
                                  onChange: () {
                                    pointManagerController.isPercentUse.value =
                                        !pointManagerController
                                            .isPercentUse.value;
                                  }),
                            ),
                            Obx(
                              () => pointManagerController.isPercentUse.value ==
                                      true
                                  ? itemInput(
                                      title:
                                          "Phần trăm số tiền tối đa sử dụng bằng xu trên mỗi đơn hàng",
                                      subTitle: "Phần trăm:",
                                      subText: "Nhập phần trăm",
                                      typeUnit: "%",
                                      controller: pointManagerController
                                          .percentMaxPointUseEdit,
                                      validator: (value) {
                                        if (value!.length < 1 ||
                                            double.parse(value) == 0) {
                                          return "Phần trăm không hợp lệ";
                                        } else {
                                          return null;
                                        }
                                      })
                                  : Container(),
                            ),
                          ],
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Xu cho đại lý',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Cho phép đại lý được hưởng xu sản phẩm',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Obx(
                              () => Checkbox(
                                value: pointManagerController
                                    .bonusPointProductToAgency.value,
                                onChanged: (v) {
                                  pointManagerController
                                          .bonusPointProductToAgency.value =
                                      !pointManagerController
                                          .bonusPointProductToAgency.value;
                                }),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Cho phép tặng thêm xu từ sản phẩm thưởng',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Obx(
                              () =>  Checkbox(
                                value: pointManagerController
                                    .bonusPointBonusProductToAgency.value,
                                onChanged: (v) {
                                  pointManagerController
                                          .bonusPointBonusProductToAgency.value =
                                      !pointManagerController
                                          .bonusPointBonusProductToAgency.value;
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
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
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    pointManagerController.configRewardPoint();
                  }
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
                      onChange();
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
    bool? isShowExam,
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
                  Expanded(
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
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
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 10,
                        ),
                        padding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]!),
                            borderRadius: BorderRadius.circular(2)),
                        child: TextFormField(
                          maxLength: maxLength,
                          controller: controller,
                          inputFormatters: inputFormatters,
                          keyboardType: TextInputType.number,
                          validator: validator,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(2),
                              counterText: "",
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
                    ),
                  ],
                ),
              ),
              if (isShowExam == true)
                SizedBox(
                  height: 10,
                ),
              if (isShowExam == true)
                Obx(() {
                  var percent =
                      pointManagerController.percentRefundEdit.value.text == ""
                          ? "0"
                          : pointManagerController.percentRefundEdit.value.text;

                  var moneyAPoint =
                      pointManagerController.moneyAPointEdit.value.text == "" ||
                              pointManagerController
                                      .moneyAPointEdit.value.text ==
                                  "0"
                          ? "0"
                          : pointManagerController.moneyAPointEdit.value.text;
                  return Text(
                    "Ví dụ: 100.000 VNĐ hoàn ${double.parse(SahaStringUtils().convertFormatText(percent))}% = "
                    "${SahaStringUtils().convertToMoney((100000 * double.parse(SahaStringUtils().convertFormatText(percent))) / 100)}"
                    " VNĐ = ${SahaStringUtils().convertToMoney((moneyAPoint == "0" || moneyAPoint == "" ? "0" : ((((100000 * double.parse(SahaStringUtils().convertFormatText(percent))) / 100) * 1) / (double.parse(SahaStringUtils().convertFormatText(moneyAPoint))))))} Xu",
                    style: TextStyle(fontSize: 12),
                  );
                }),
            ],
          ),
        ),
      ],
    );
  }
}
