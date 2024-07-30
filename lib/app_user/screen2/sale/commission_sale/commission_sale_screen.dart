import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import 'package:com.ikitech.store/app_user/model/bonus_level.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'commission_sale_controller.dart';

class CommissionSaleScreen extends StatelessWidget {
  CommissionSaleController commissionSaleController =
      Get.put(CommissionSaleController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cấu hình Sale"),
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                      () => commissionSaleController.isLoading.value == true
                      ? Container()
                      : Column(
                    children: [
                      if (commissionSaleController
                          .listLevelBonus.isNotEmpty)
                        ...List.generate(
                          commissionSaleController.listLevelBonus.length,
                              (index) => itemLevel(
                              bonusLevel: commissionSaleController
                                  .listLevelBonus[index],
                              index: index,
                              indexLast: commissionSaleController
                                  .listLevelBonus.length -
                                  1),
                        ),
                      commissionSaleController.listLevelBonus.isEmpty
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
        ),
      ),
    );
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
          await commissionSaleController.addLevelBonus(
              int.parse(SahaStringUtils()
                  .convertFormatText(levelEditingController.text)),
              int.parse(SahaStringUtils()
                  .convertFormatText(percentEditingController.text)));

          await commissionSaleController.getBonusStepSale(isRefresh: true);

          commissionSaleController.listLevelBonus
              .add(BonusLevel(limit: 0, bonus: 0));
          commissionSaleController.checkInput.add(false);
        } else {
          commissionSaleController.listLevelBonus
              .add(BonusLevel(limit: 0, bonus: 0));
          commissionSaleController.checkInput.add(false);
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
                          commissionSaleController.checkInput[index!] = true;
                        } else {
                          commissionSaleController.checkInput[index!] = false;
                        }
                        print(commissionSaleController.checkInput[index]);
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
                          commissionSaleController.checkInput[index!] = true;
                        } else {
                          commissionSaleController.checkInput[index!] = false;
                        }
                        print(commissionSaleController.checkInput[index]);
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
                      commissionSaleController.checkInput[index!] == false) {
                    SahaDialogApp.showDialogYesNo(
                        mess: "Bạn có chắc chắn muốn xoá mức thưởng này chứ",
                        onOK: () async {
                          commissionSaleController
                              .deleteLevelBonus(bonusLevel.id!);
                          commissionSaleController.listLevelBonus
                              .removeAt(index);
                        });
                  } else if (commissionSaleController.checkInput[index!] ==
                          true &&
                      bonusLevel.limit.toString() != "" &&
                      bonusLevel.bonus.toString() != "") {
                    await commissionSaleController.updateLevelBonus(
                        int.parse(SahaStringUtils().convertFormatText(
                            levelEditingController.text == ""
                                ? "0"
                                : levelEditingController.text)),
                        int.parse(SahaStringUtils().convertFormatText(
                            percentEditingController.text == ""
                                ? "0"
                                : percentEditingController.text)),
                        bonusLevel.id!);
                    commissionSaleController.getBonusStepSale(isRefresh: true);
                  } else {
                    commissionSaleController.listLevelBonus.removeAt(index);
                  }
                },
                child: Container(
                  height: 35,
                  width: 35,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color:
                          commissionSaleController.checkInput[index!] == false
                              ? Colors.red
                              : commissionSaleController.checkInput[index] ==
                                          true &&
                                      bonusLevel.limit.toString() != "0" &&
                                      bonusLevel.bonus.toString() != "0"
                                  ? Colors.blue
                                  : Colors.red,
                      shape: BoxShape.circle),
                  child: Center(
                      child: Text(
                    commissionSaleController.checkInput[index] == false
                        ? "Xoá"
                        : commissionSaleController.checkInput[index] == true &&
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
