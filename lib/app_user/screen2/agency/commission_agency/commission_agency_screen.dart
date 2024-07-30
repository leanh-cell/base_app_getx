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
import 'commission_agency_controller.dart';

class CommissionAgencyScreen extends StatelessWidget {
  CommissionAgencyController commissionAgencyController =
      Get.put(CommissionAgencyController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cấu hình đại lý"),
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

                Obx(() => itemConfig(
                    title: "Cho phép Gửi yêu cầu thanh toán:",
                    config: commissionAgencyController.isAllowPaymentRequest.value,
                    onChange: () {
                      commissionAgencyController.isAllowPaymentRequest.value =
                          !commissionAgencyController.isAllowPaymentRequest.value;
                    })),
                SizedBox(
                  height: 10,
                ),
                Obx(() => itemConfig(
                    title: "Cho phép Quyết toán ngày 1 hàng tháng:",
                    config: commissionAgencyController.paymentOneOfMonth.value,
                    onChange: () {
                      commissionAgencyController.paymentOneOfMonth.value =
                          !commissionAgencyController.paymentOneOfMonth.value;
                    })),
                SizedBox(
                  height: 10,
                ),
                Obx(() => itemConfig(
                    title: "Cho phép Quyết toán ngày 16 hàng tháng:",
                    config: commissionAgencyController.payment16OfMonth.value,
                    onChange: () {
                      commissionAgencyController.payment16OfMonth.value =
                          !commissionAgencyController.payment16OfMonth.value;
                    })),
                SizedBox(
                  height: 10,
                ),
                Obx(() => itemConfig(
                    title: "Cho phép hưởng hoa hồng từ khách hàng giới thiệu:",
                    config:
                    commissionAgencyController.allowRoseReferralCustomer.value,
                    onChange: () {
                      commissionAgencyController.allowRoseReferralCustomer.value =
                      !commissionAgencyController
                          .allowRoseReferralCustomer.value;
                    })),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Số dư ví tối thiểu đủ để quyết toán:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: SahaPrimaryColor)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: TextField(
                      controller: commissionAgencyController
                          .limitMoneyEditingController.value,
                      inputFormatters: [ThousandsFormatter()],
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      onChanged: (va) {},
                      textInputAction: TextInputAction.search,
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Phần trăm hoa hồng giới thiệu CTV:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Obx(
                          () => Checkbox(
                          value: commissionAgencyController
                              .bonusTypeForCtvT2.value ==
                              0,
                          onChanged: (v) {
                            commissionAgencyController.bonusTypeForCtvT2.value =
                            0;
                          }),
                    ),
                    Expanded(child: Text('Từ tổng đơn hàng')),
                    InkWell(
                      onTap: () {
                        SahaDialogApp.showDialogSuggestion(
                            title: 'Chú giải thông số',
                            contentWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Divider(),
                                Text(
                                  "Người giới thiệu sẽ được nhận hoa hồng như sau:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Nhận phần trăm từ tổng đơn hàng, ví dụ đơn hàng CTV mua tổng 100.000đ bạn nhập 10% thì Đại lý giới thiệu nhận được 10.000đ'),
                              ],
                            ));
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.blue,
                            size: 20,
                          ),
                          Text(
                            'i',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Obx(
                          () => Checkbox(
                          value: commissionAgencyController
                              .bonusTypeForCtvT2.value ==
                              1,
                          onChanged: (v) {
                            commissionAgencyController.bonusTypeForCtvT2.value =
                            1;
                          }),
                    ),
                    Expanded(
                        child: Text('Từ hoa hồng cộng tác viên mua hàng')),
                    InkWell(
                      onTap: () {
                        SahaDialogApp.showDialogSuggestion(
                            title: 'Chú giải thông số',
                            contentWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Divider(),
                                Text(
                                  "Người giới thiệu sẽ được nhận hoa hồng như sau:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Nhận phần trăm hoa hồng từ CTV được hưởng, ví dụ hóa đơn CTV nhận được 100.000đ hoa hồng,bạn nhập ô này 10% thì đại lý giới thiệu nhận được 10.000đ'),
                              ],
                            ));
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.blue,
                            size: 20,
                          ),
                          Text(
                            'i',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: SahaPrimaryColor)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: TextField(
                      controller: commissionAgencyController
                          .percentRoseRankMoneyEditingController.value,
                      inputFormatters: [ThousandsFormatter()],
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      onChanged: (va) {},
                      textInputAction: TextInputAction.search,
                      maxLength: 2,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        counterText: "",
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: 'Nhập...',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                  commissionAgencyController.configsCollabBonus();
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
          color: Colors.white,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title)),
              CupertinoSwitch(
                value: config,
                onChanged: (bool value) {
                  onChange();
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
          await commissionAgencyController.addLevelBonusAgency(
              int.parse(SahaStringUtils()
                  .convertFormatText(levelEditingController.text)),
              int.parse(SahaStringUtils()
                  .convertFormatText(percentEditingController.text)));

          await commissionAgencyController.getAllLevelBonusAgency(isRefresh: true);

          commissionAgencyController.listLevelBonus
              .add(BonusLevel(limit: 0, bonus: 0));
          commissionAgencyController.checkInput.add(false);
        } else {
          commissionAgencyController.listLevelBonus
              .add(BonusLevel(limit: 0, bonus: 0));
          commissionAgencyController.checkInput.add(false);
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
                          commissionAgencyController.checkInput[index!] = true;
                        } else {
                          commissionAgencyController.checkInput[index!] = false;
                        }
                        print(commissionAgencyController.checkInput[index]);
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
                          commissionAgencyController.checkInput[index!] = true;
                        } else {
                          commissionAgencyController.checkInput[index!] = false;
                        }
                        print(commissionAgencyController.checkInput[index]);
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
                      commissionAgencyController.checkInput[index!] == false) {
                    SahaDialogApp.showDialogYesNo(
                        mess: "Bạn có chắc chắn muốn xoá mức thưởng này chứ",
                        onOK: () async {
                          commissionAgencyController
                              .deleteLevelBonus(bonusLevel.id!);
                          commissionAgencyController.listLevelBonus
                              .removeAt(index);
                        });
                  } else if (commissionAgencyController.checkInput[index!] ==
                          true &&
                      bonusLevel.limit.toString() != "" &&
                      bonusLevel.bonus.toString() != "") {
                    await commissionAgencyController.updateLevelBonusAgency(
                        int.parse(SahaStringUtils().convertFormatText(
                            levelEditingController.text == ""
                                ? "0"
                                : levelEditingController.text)),
                        int.parse(SahaStringUtils().convertFormatText(
                            percentEditingController.text == ""
                                ? "0"
                                : percentEditingController.text)),
                        bonusLevel.id!);
                    commissionAgencyController.getAllLevelBonusAgency(isRefresh: true);
                  } else {
                    commissionAgencyController.listLevelBonus.removeAt(index);
                  }
                },
                child: Container(
                  height: 35,
                  width: 35,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: commissionAgencyController.checkInput[index!] == false
                          ? Colors.red
                          : commissionAgencyController.checkInput[index] == true &&
                                  bonusLevel.limit.toString() != "0" &&
                                  bonusLevel.bonus.toString() != "0"
                              ? Colors.blue
                              : Colors.red,
                      shape: BoxShape.circle),
                  child: Center(
                      child: Text(
                    commissionAgencyController.checkInput[index] == false
                        ? "Xoá"
                        : commissionAgencyController.checkInput[index] == true &&
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
