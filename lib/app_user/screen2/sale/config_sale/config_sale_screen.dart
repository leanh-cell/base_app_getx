import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../components/saha_user/button/saha_button.dart';
import '../../../const/constant.dart';
import '../../../model/bonus_level.dart';
import '../../../utils/string_utils.dart';
import 'config_sale_controller.dart';

class ConfigSaleScreen extends StatelessWidget {
  ConfigSaleController controller = ConfigSaleController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Cấu hình sale"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Column(
            //   children: [
            //     Container(
            //       color: Colors.white,
            //       height: 50,
            //       padding: const EdgeInsets.all(10.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Expanded(child: Text("Cho phép sale")),
            //           Obx(
            //             () => CupertinoSwitch(
            //               value: controller.configSale.value.allowSale ?? false,
            //               onChanged: (bool value) {
            //                 controller.configSale.value.allowSale =
            //                     !(controller.configSale.value.allowSale ??
            //                         false);
            //                 controller.configSale.refresh();
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Divider(
            //       height: 1,
            //     )
            //   ],
            // ),
            InkWell(
              onTap: () {
                showDialogType(
                    type: controller.configSale.value.typeBonusPeriod,
                    onChoose: (v) {
                      controller.configSale.value.typeBonusPeriod = v;
                      controller.configSale.refresh();
                    });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    Text('Kỳ thưởng: '),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Obx(
                        () => Text(
                          getText(controller.configSale.value.typeBonusPeriod),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Cách tính thưởng Sale theo doanh số:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "(Là phần thưởng dành cho Sale khi chinh phục được các mức doanh số)",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Thông tin cấu hình: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                        () => controller.isLoading.value == true
                        ? Container()
                        : Column(
                      children: [
                        if (controller
                            .listLevelBonus.isNotEmpty)
                          ...List.generate(
                            controller.listLevelBonus.length,
                                (index) => itemLevel(
                                bonusLevel: controller
                                    .listLevelBonus[index],
                                index: index,
                                indexLast: controller
                                    .listLevelBonus.length -
                                    1),
                          ),
                        controller.listLevelBonus.isEmpty
                            ? itemLevel(
                            bonusLevel: BonusLevel(limit: 0, bonus: 0),
                            index: 0,
                            indexLast: 0)
                            : Container(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Lưu",
              onPressed: () {
                controller.setConfigSale();
              },
            )
          ],
        ),
      ),
    );
  }

  String getText(int? type) {
    if (type == 0) return "Theo tháng";
    if (type == 1) return "Theo tuần";
    if (type == 2) return "Theo quý";
    if (type == 3) return "Theo năm";
    return "Chọn kỳ";
  }

  void showDialogType({int? type, required Function onChoose}) {
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
                    "Chọn kỳ",
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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      "Theo tháng",
                    ),
                    onTap: () async {
                      onChoose(0);
                      Get.back();
                    },
                    trailing: type == 0
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Theo tuần",
                    ),
                    onTap: () async {
                      onChoose(1);
                      Get.back();
                    },
                    trailing: type == 1
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Theo quý",
                    ),
                    onTap: () async {
                      onChoose(2);
                      Get.back();
                    },
                    trailing: type == 2
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Theo năm",
                    ),
                    onTap: () async {
                      onChoose(3);
                      Get.back();
                    },
                    trailing: type == 3
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  Widget itemLevel(
      {required BonusLevel bonusLevel, int? index, int? indexLast}) {
    TextEditingController levelEditingController = TextEditingController(
        text:
        SahaStringUtils().convertFormatText(bonusLevel.limit.toString()) ==
            "0"
            ? ""
            : SahaStringUtils().convertToUnit(bonusLevel.limit.toString()));
    TextEditingController percentEditingController = TextEditingController(
        text:
        SahaStringUtils().convertFormatText(bonusLevel.bonus.toString()) ==
            "0"
            ? ""
            : SahaStringUtils().convertToUnit(bonusLevel.bonus.toString()));

    void addLevelBonus() async {
      if (levelEditingController.text != "" &&
          percentEditingController.text != "") {
        if (bonusLevel.limit.toString() !=
            SahaStringUtils()
                .convertFormatText(levelEditingController.text) &&
            bonusLevel.bonus.toString() !=
                SahaStringUtils()
                    .convertFormatText(percentEditingController.text)) {
          await controller.addLevelBonus(
              int.parse(SahaStringUtils()
                  .convertFormatText(levelEditingController.text)),
              int.parse(SahaStringUtils()
                  .convertFormatText(percentEditingController.text)));

          await controller.getBonusStepSale(isRefresh: true);

          controller.listLevelBonus
              .add(BonusLevel(limit: 0, bonus: 0));
          controller.checkInput.add(false);
        } else {
          controller.listLevelBonus
              .add(BonusLevel(limit: 0, bonus: 0));
          controller.checkInput.add(false);
        }
      } else {
        SahaAlert.showError(message: "Chưa nhập Mức hoặc Tỉ lệ");
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Mức:"),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                width: 100,
                decoration:
                BoxDecoration(border: Border.all(color: SahaPrimaryColor)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Focus(
                    onFocusChange: (hasFocus) async {
                      if (hasFocus) {
                      } else {
                        if (SahaStringUtils().convertFormatText(
                            levelEditingController.text) !=
                            bonusLevel.limit.toString() &&
                            SahaStringUtils().convertFormatText(
                                percentEditingController.text) !=
                                bonusLevel.bonus.toString() &&
                            SahaStringUtils().convertFormatText(
                                levelEditingController.text) !=
                                "" &&
                            SahaStringUtils().convertFormatText(
                                percentEditingController.text) !=
                                "") {
                          //  addLevelBonus();
                        }
                      }
                    },
                    child: TextField(
                      controller: levelEditingController,
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [ThousandsFormatter()],
                      onChanged: (va) {
                        if (SahaStringUtils().convertFormatText(
                            levelEditingController.text) !=
                            bonusLevel.limit.toString() ||
                            SahaStringUtils().convertFormatText(
                                percentEditingController.text) !=
                                bonusLevel.bonus.toString()) {
                          controller.checkInput[index!] = true;
                        } else {
                          controller.checkInput[index!] = false;
                        }
                        print(controller.checkInput[index]);
                      },
                      textInputAction: TextInputAction.done,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: 'Nhập...',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Thưởng: "),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                width: 100,
                decoration:
                BoxDecoration(border: Border.all(color: SahaPrimaryColor)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Focus(
                    onFocusChange: (hasFocus) async {
                      if (hasFocus) {
                      } else {
                        if (SahaStringUtils().convertFormatText(
                            levelEditingController.text) !=
                            bonusLevel.limit.toString() &&
                            SahaStringUtils().convertFormatText(
                                percentEditingController.text) !=
                                bonusLevel.bonus.toString() &&
                            SahaStringUtils().convertFormatText(
                                levelEditingController.text) !=
                                "" &&
                            SahaStringUtils().convertFormatText(
                                percentEditingController.text) !=
                                "") {
                          //addLevelBonus();
                        }
                      }
                    },
                    child: TextField(
                      controller: percentEditingController,
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [ThousandsFormatter()],
                      onChanged: (va) {
                        if (SahaStringUtils().convertFormatText(
                            levelEditingController.text) !=
                            bonusLevel.limit.toString() ||
                            SahaStringUtils().convertFormatText(
                                percentEditingController.text) !=
                                bonusLevel.bonus.toString()) {
                          controller.checkInput[index!] = true;
                        } else {
                          controller.checkInput[index!] = false;
                        }
                        print(controller.checkInput[index]);
                      },
                      textInputAction: TextInputAction.done,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: 'Nhập...',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Obx(() => InkWell(
            onTap: () async {
              if (bonusLevel.id != null &&
                  controller.checkInput[index!] == false) {
                SahaDialogApp.showDialogYesNo(
                    mess: "Bạn có chắc chắn muốn xoá mức thưởng này chứ",
                    onOK: () async {
                      controller
                          .deleteLevelBonus(bonusLevel.id!);
                      controller.listLevelBonus
                          .removeAt(index);
                    });
              } else if (controller.checkInput[index!] ==
                  true &&
                  bonusLevel.limit.toString() != "" &&
                  bonusLevel.bonus.toString() != "") {
                await controller.updateLevelBonus(
                    int.parse(SahaStringUtils().convertFormatText(
                        levelEditingController.text == ""
                            ? "0"
                            : levelEditingController.text)),
                    int.parse(SahaStringUtils().convertFormatText(
                        percentEditingController.text == ""
                            ? "0"
                            : percentEditingController.text)),
                    bonusLevel.id!);
                controller.getBonusStepSale(isRefresh: true);
              } else {
                controller.listLevelBonus.removeAt(index);
              }
            },
            child: Container(
              height: 35,
              width: 35,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color:
                  controller.checkInput[index!] == false
                      ? Colors.red
                      : controller.checkInput[index] ==
                      true &&
                      bonusLevel.limit.toString() != "0" &&
                      bonusLevel.bonus.toString() != "0"
                      ? Colors.blue
                      : Colors.red,
                  shape: BoxShape.circle),
              child: Center(
                  child: Text(
                    controller.checkInput[index] == false
                        ? "Xoá"
                        : controller.checkInput[index] == true &&
                        bonusLevel.limit.toString() != "0" &&
                        bonusLevel.bonus.toString() != "0"
                        ? "Lưu"
                        : "Xoá",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          )),
          SizedBox(
            width: 5,
          ),
          index == indexLast
              ? InkWell(
            onTap: () async {
              addLevelBonus();
            },
            child: Container(
              height: 35,
              width: 35,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.green, shape: BoxShape.circle),
              child: Center(
                  child: Icon(
                    Icons.add,
                    size: 19,
                    color: Colors.white,
                  )),
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}
