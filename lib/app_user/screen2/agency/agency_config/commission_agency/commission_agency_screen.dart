import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import 'package:com.ikitech.store/app_user/model/bonus_level.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'commission_agency_controller.dart';

class CommissionAgencyScreen extends StatefulWidget {
  @override
  _CommissionAgencyScreenState createState() => _CommissionAgencyScreenState();
}

class _CommissionAgencyScreenState extends State<CommissionAgencyScreen> {
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
                Text(
                  "Cách tính thưởng Đại lý theo doanh số:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "(Là phần thưởng dành cho Đại lý khi chinh phục được các mức doanh số)",
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
                  () => commissionAgencyController.isLoading.value == true
                      ? Container()
                      : Column(
                          children: [
                            if (commissionAgencyController
                                .listLevelBonus.isNotEmpty)
                              ...List.generate(
                                commissionAgencyController.listLevelBonus.length,
                                (index) => itemLevel(
                                    bonusLevel: commissionAgencyController
                                        .listLevelBonus[index],
                                    index: index,
                                    indexLast: commissionAgencyController
                                            .listLevelBonus.length -
                                        1),
                              ),
                            commissionAgencyController.listLevelBonus.isEmpty
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
                  height: 20,
                ),
                Text(
                  "Số dư ví tối thiểu đủ để quyết toán:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
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
                      inputFormatters: [
                        ThousandsFormatter()
                      ],
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
              Text(title),
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
        text: SahaStringUtils().convertFormatText(bonusLevel.limit.toString()) == "0"
            ? ""
            : SahaStringUtils().convertToUnit(bonusLevel.limit.toString()));
    TextEditingController percentEditingController = TextEditingController(
        text: SahaStringUtils().convertFormatText(bonusLevel.bonus.toString()) == "0"
            ? ""
            : SahaStringUtils().convertToUnit(bonusLevel.bonus.toString()));

    void addLevelBonus() async {
      if (levelEditingController.text != "" &&
          percentEditingController.text != "") {
        if (bonusLevel.limit.toString() != SahaStringUtils().convertFormatText(levelEditingController.text) &&
            bonusLevel.bonus.toString() != SahaStringUtils().convertFormatText(percentEditingController.text)) {
          await commissionAgencyController.addLevelBonus(
              int.parse(SahaStringUtils().convertFormatText(levelEditingController.text)),
              int.parse(SahaStringUtils().convertFormatText(percentEditingController.text)));

          await commissionAgencyController.getAllLevelBonus(isRefresh: true);

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
                        if (SahaStringUtils().convertFormatText(levelEditingController.text) !=
                            bonusLevel.limit.toString() &&
                            SahaStringUtils().convertFormatText(percentEditingController.text) !=
                                bonusLevel.bonus.toString() &&
                            SahaStringUtils().convertFormatText(levelEditingController.text) != "" &&
                            SahaStringUtils().convertFormatText(percentEditingController.text) != "") {
                        //  addLevelBonus();
                        }
                      }
                    },
                    child: TextField(
                      controller: levelEditingController,
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        ThousandsFormatter()
                      ],
                      onChanged: (va) {
                        if (SahaStringUtils().convertFormatText(levelEditingController.text) !=
                                bonusLevel.limit.toString() ||
                            SahaStringUtils().convertFormatText(percentEditingController.text) !=
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
                        if (SahaStringUtils().convertFormatText(levelEditingController.text) !=
                                bonusLevel.limit.toString() &&
                            SahaStringUtils().convertFormatText(percentEditingController.text) !=
                                bonusLevel.bonus.toString() &&
                            SahaStringUtils().convertFormatText(levelEditingController.text) != "" &&
                            SahaStringUtils().convertFormatText(percentEditingController.text) != "") {
                          //addLevelBonus();
                        }
                      }
                    },
                    child: TextField(
                      controller: percentEditingController,
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        ThousandsFormatter()
                      ],
                      onChanged: (va) {
                        if (SahaStringUtils().convertFormatText(levelEditingController.text) !=
                                bonusLevel.limit.toString() ||
                            SahaStringUtils().convertFormatText(percentEditingController.text) !=
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
                    commissionAgencyController.deleteLevelBonus(bonusLevel.id!);
                    commissionAgencyController.listLevelBonus.removeAt(index);
                  } else if (commissionAgencyController.checkInput[index!] ==
                          true &&
                      bonusLevel.limit.toString() != "" &&
                      bonusLevel.bonus.toString() != "") {
                    await commissionAgencyController.updateLevelBonus(
                        int.parse(SahaStringUtils().convertFormatText(levelEditingController.text)),
                        int.parse(SahaStringUtils().convertFormatText(percentEditingController.text)),
                        bonusLevel.id!);
                   commissionAgencyController.getAllLevelBonus(isRefresh: true);
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
