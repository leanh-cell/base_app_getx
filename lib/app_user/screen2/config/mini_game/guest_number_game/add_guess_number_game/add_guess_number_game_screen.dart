import 'package:com.ikitech.store/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/screen2/config/mini_game/guest_number_game/add_guess_number_game/add_guess_number_game_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../../components/saha_user/button/saha_button.dart';
import '../../../../../components/saha_user/dialog/dialog.dart';
import '../../../../../components/saha_user/loading/loading_full_screen.dart';
import '../../../../../components/saha_user/text_field/text_field_no_border.dart';
import '../../../../../components/widget/select_image/select_images.dart';
import '../../../../../model/image_assset.dart';
import '../../../../../utils/date_utils.dart';
import 'add_result/add_result_screen.dart';
import 'award_anounce/award_anounce_screen.dart';

enum ResultType { typeListResult, typeNumber }

class AddGuessNumberGameScreen extends StatefulWidget {
  AddGuessNumberGameScreen({Key? key, this.guessGameId}) : super(key: key);
  int? guessGameId;

  @override
  State<AddGuessNumberGameScreen> createState() =>
      _AddGuessNumberGameScreenState();
}

class _AddGuessNumberGameScreenState extends State<AddGuessNumberGameScreen> {
  final _formKey = GlobalKey<FormState>();

  AddGuessNumberGameController addGuessNumberGameController =
      Get.put(AddGuessNumberGameController());

  @override
  void initState() {
    super.initState();
    if (widget.guessGameId != null) {
      addGuessNumberGameController.getGuessNumberGame(id: widget.guessGameId!);
    } else {
      addGuessNumberGameController.guessGameReq.value.isGuessNumber = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.guessGameId == null
              ? 'Thêm game đoán số'
              : "Sửa game đoán số"),
          actions: [
            widget.guessGameId != null
                ? GestureDetector(
                    onTap: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: "Bạn có chắc muốn xoá game này",
                          onClose: () {},
                          onOK: () {
                            addGuessNumberGameController.deleteGuessNumberGame(
                                id: widget.guessGameId!);
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        FontAwesomeIcons.trashCan,
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        body: Obx(
          () => addGuessNumberGameController.loadInit.value
              ? SahaLoadingFullScreen()
              : SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            SahaDialogApp.showDialogGroupMarketingType(
                                onChoose: (v) {
                                  addGuessNumberGameController.group.value = v;
                                  addGuessNumberGameController
                                      .guessGameReq.value.applyFor = v;
                                },
                                groupType:
                                    addGuessNumberGameController.group.value);
                          },
                          child: Container(
                            width: Get.width,
                            height: 50,
                            padding: EdgeInsets.only(left: 10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.group,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Obx(
                                    () => Row(
                                      children: [
                                        Expanded(child: Text('Nhóm áp dụng: ')),
                                        Text(
                                            '${addGuessNumberGameController.group.value == 0 ? "Tất cả" : addGuessNumberGameController.group.value == 1 ? "Cộng tác viên" : addGuessNumberGameController.group.value == 2 ? "Đại lý" : 'Nhóm khách hàng'} '),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down_rounded),
                              ],
                            ),
                          ),
                        ),
                        Obx(() => addGuessNumberGameController.group.value == 2
                            ? InkWell(
                                onTap: () {
                                  SahaDialogApp.showDialogAgencyType(
                                      onChoose: (v) {
                                        addGuessNumberGameController
                                            .agencyType.value = v;
                                        addGuessNumberGameController
                                                .guessGameReq.value.agencyId =
                                            addGuessNumberGameController
                                                .agencyType.value.id!;
                                      },
                                      type: addGuessNumberGameController
                                          .agencyType.value.id,
                                      listAgencyType:
                                          addGuessNumberGameController
                                              .listAgencyType
                                              .toList());
                                },
                                child: Container(
                                  width: Get.width,
                                  height: 50,
                                  padding: EdgeInsets.only(left: 10),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.leaderboard,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Obx(
                                          () => Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      'Chọn cấp đại lý: ')),
                                              Text(
                                                  '${addGuessNumberGameController.agencyType.value.name ?? ""} '),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Icon(Icons.keyboard_arrow_down_rounded),
                                    ],
                                  ),
                                ),
                              )
                            : Container()),
                        Obx(() => addGuessNumberGameController.group.value == 4
                            ? InkWell(
                                onTap: () {
                                  SahaDialogApp.showDialogCustomerGroupType(
                                      onChoose: (v) {
                                        addGuessNumberGameController
                                            .groupCustomer.value = v;
                                        addGuessNumberGameController
                                                .guessGameReq
                                                .value
                                                .groupCustomerId =
                                            addGuessNumberGameController
                                                .groupCustomer.value.id!;
                                      },
                                      type: addGuessNumberGameController
                                          .groupCustomer.value.id,
                                      listGroupCustomer:
                                          addGuessNumberGameController
                                              .listGroupCus
                                              .toList());
                                },
                                child: Container(
                                  width: Get.width,
                                  height: 50,
                                  padding: EdgeInsets.only(left: 10),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.leaderboard,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Obx(
                                          () => Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      'Chọn nhóm khách hàng: ')),
                                              Text(
                                                  '${addGuessNumberGameController.groupCustomer.value.name ?? ""} '),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Icon(Icons.keyboard_arrow_down_rounded),
                                    ],
                                  ),
                                ),
                              )
                            : Container()),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Trạng thái hoạt động'),
                              CupertinoSwitch(
                                  value: addGuessNumberGameController
                                          .guessGameReq.value.isShowGame ??
                                      false,
                                  onChanged: (v) {
                                    addGuessNumberGameController
                                        .guessGameReq.value.isShowGame = v;
                                    addGuessNumberGameController.guessGameReq
                                        .refresh();
                                  })
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text('Tên trò chơi'),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller:
                                      addGuessNumberGameController.nameMiniGame,
                                  onChanged: (v) {
                                    addGuessNumberGameController
                                        .guessGameReq.value.name = v;
                                  },
                                  validator: (value) {
                                    if (value!.length < 1) {
                                      return 'Chưa nhập tên trò chơi';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "Nhập tên trò chơi tại đây",
                                  ),
                                  style: TextStyle(fontSize: 14),
                                  minLines: 1,
                                  maxLines: 1,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Loại kết quả:'),
                              // Row(
                              //   children: [
                              //     Obx(
                              //       () => Checkbox(
                              //           value: addGuessNumberGameController
                              //                   .guessGameReq
                              //                   .value
                              //                   .isGuessNumber ==
                              //               false,
                              //           onChanged: (v) {
                              //             if (v == true) {
                              //               addGuessNumberGameController
                              //                   .guessGameReq
                              //                   .value
                              //                   .isGuessNumber = false;
                              //             } else {
                              //               addGuessNumberGameController
                              //                   .guessGameReq
                              //                   .value
                              //                   .isGuessNumber = null;
                              //             }

                              //             addGuessNumberGameController
                              //                 .guessGameReq
                              //                 .refresh();
                              //           }),
                              //     ),
                              //     Text('Nhập danh sách đáp án')
                              //   ],
                              // ),
                              // Row(
                              //   children: [
                              //     Checkbox(
                              //         value: addGuessNumberGameController
                              //                 .guessGameReq.value.isGuessNumber ==
                              //             true,
                              //         onChanged: (v) {
                              //           if (v == true) {
                              //             addGuessNumberGameController
                              //                 .guessGameReq
                              //                 .value
                              //                 .isGuessNumber = true;
                              //           } else {
                              //             addGuessNumberGameController
                              //                 .guessGameReq
                              //                 .value
                              //                 .isGuessNumber = null;
                              //           }
                              //           addGuessNumberGameController.guessGameReq
                              //               .refresh();
                              //         }),
                              //     Text('Theo dãy số')
                              //   ],
                              // )
                              Obx(
                                () => ListTile(
                                  title: const Text('Theo dãy số'),
                                  leading: Radio<ResultType>(
                                    value: ResultType.typeNumber,
                                    groupValue: addGuessNumberGameController
                                        .character.value,
                                    onChanged: (ResultType? value) {
                                      addGuessNumberGameController.guessGameReq
                                          .value.isGuessNumber = true;
                                      setState(() {
                                        addGuessNumberGameController
                                            .character.value = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Obx(
                                () => ListTile(
                                  title: const Text('Nhập danh sách đáp án'),
                                  leading: Radio<ResultType>(
                                    value: ResultType.typeListResult,
                                    groupValue: addGuessNumberGameController
                                        .character.value,
                                    onChanged: (ResultType? value) {
                                      setState(() {
                                        addGuessNumberGameController
                                            .character.value = value!;
                                        addGuessNumberGameController
                                            .guessGameReq
                                            .value
                                            .isGuessNumber = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Obx(
                          () => addGuessNumberGameController
                                      .guessGameReq.value.isGuessNumber ==
                                  true
                              ? SizedBox()
                              : Card(
                                  child: ListTile(
                                    onTap: () {
                                      if (addGuessNumberGameController
                                              .guessGameReq
                                              .value
                                              .isGuessNumber ==
                                          null) {
                                        SahaAlert.showError(
                                            message:
                                                'Bạn chưa chọn loại trò chơi\nVui lòng hãy chọn loại trò chơi');
                                        return;
                                      }
                                      Get.to(() => AddResultScreen(
                                            listGuessNumberResult:
                                                addGuessNumberGameController
                                                    .guessGameReq
                                                    .value
                                                    .listGuessNumberResult!,
                                            onSubmit: (v) {
                                              addGuessNumberGameController
                                                  .guessGameReq
                                                  .value
                                                  .listGuessNumberResult = v;
                                              addGuessNumberGameController
                                                  .guessGameReq
                                                  .refresh();
                                            },
                                          ));
                                    },
                                    title: Text('Danh sách đáp án'),
                                    subtitle: (addGuessNumberGameController
                                                    .guessGameReq
                                                    .value
                                                    .listGuessNumberResult ??
                                                [])
                                            .isEmpty
                                        ? Text(
                                            'Chưa có danh sách đáp án,mời bạn vào đây để tạo danh sách đáp án',
                                            style: TextStyle(color: Colors.red),
                                          )
                                        : null,
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                  ),
                                ),
                        ),
                        Obx(
                          () => addGuessNumberGameController
                                      .guessGameReq.value.isGuessNumber ==
                                  false
                              ? SizedBox()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Số lượng chữ số: '),
                                          Expanded(
                                            child: TextFormField(
                                              controller:
                                                  addGuessNumberGameController
                                                      .rangeNumber,
                                              onChanged: (v) {
                                                addGuessNumberGameController
                                                        .guessGameReq
                                                        .value
                                                        .rangeNumber =
                                                    int.tryParse(v);
                                                addGuessNumberGameController
                                                    .guessGameReq
                                                    .refresh();
                                              },
                                              validator: (value) {
                                                if (value!.length < 1) {
                                                  return 'Chưa nhập số lượng chữ số đáp án';
                                                }
                                                return null;
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: InputDecoration(
                                                isDense: true,
                                                border: InputBorder.none,
                                                hintText:
                                                    "Nhập số lượng chữ số của đáp án",
                                              ),
                                              style: TextStyle(fontSize: 14),
                                              minLines: 1,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Text('Phần thưởng: '),
                                          Expanded(
                                            child: TextFormField(
                                              controller:
                                                  addGuessNumberGameController
                                                      .valueGift,
                                              onChanged: (v) {
                                                addGuessNumberGameController
                                                    .guessGameReq
                                                    .value
                                                    .valueGift = v;

                                                addGuessNumberGameController
                                                    .guessGameReq
                                                    .refresh();
                                              },
                                              validator: (value) {
                                                if (value!.length < 1) {
                                                  return 'Chưa nhập phần thưởng';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                isDense: true,
                                                border: InputBorder.none,
                                                hintText: "Nhập phần thưởng",
                                              ),
                                              style: TextStyle(fontSize: 14),
                                              minLines: 1,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (addGuessNumberGameController
                                              .guessGameReq.value.rangeNumber !=
                                          null)
                                        Column(
                                          children: [
                                            Divider(),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                    'Khách hàng cần nhập số từ '),
                                                for (int i = 0;
                                                    i <
                                                        addGuessNumberGameController
                                                            .guessGameReq
                                                            .value
                                                            .rangeNumber!;
                                                    i++)
                                                  Text('0'),
                                                Text(' đến '),
                                                for (int i = 0;
                                                    i <
                                                        addGuessNumberGameController
                                                            .guessGameReq
                                                            .value
                                                            .rangeNumber!;
                                                    i++)
                                                  Text('9'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Đáp án: '),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        addGuessNumberGameController
                                                            .textResult,
                                                    onChanged: (v) {
                                                      addGuessNumberGameController
                                                          .guessGameReq
                                                          .value
                                                          .textResult = v;
                                                      addGuessNumberGameController
                                                          .guessGameReq
                                                          .refresh();
                                                    },
                                                    validator: (value) {
                                                      if (value!.length < 1) {
                                                        return 'Chưa nhập đáp án';
                                                      }

                                                      return null;
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      border: InputBorder.none,
                                                      hintText:
                                                          "Nhập đáp án có ${addGuessNumberGameController.guessGameReq.value.rangeNumber} chữ số",
                                                    ),
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                    minLines: 1,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                        ),
                        Divider(),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Thời gian bắt đầu'),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      dp.DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(1999, 1, 1),
                                          maxTime: DateTime(2050, 1, 1),
                                          theme: dp.DatePickerTheme(
                                              headerColor: Colors.white,
                                              backgroundColor: Colors.white,
                                              itemStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                              doneStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16)),
                                          onChanged: (date) {},
                                          onConfirm: (date) {
                                        if (date.isBefore(
                                                addGuessNumberGameController
                                                    .dateStart) ==
                                            true) {
                                          setState(() {
                                            addGuessNumberGameController
                                                .checkDayStart = true;
                                            addGuessNumberGameController
                                                .dateStart = date;
                                          });
                                        } else {
                                          setState(() {
                                            addGuessNumberGameController
                                                .checkDayStart = false;
                                            addGuessNumberGameController
                                                .dateStart = date;
                                            addGuessNumberGameController
                                                .guessGameReq
                                                .value
                                                .timeStart = date;
                                          });
                                        }
                                      },
                                          currentTime: DateTime.now(),
                                          locale: dp.LocaleType.vi);
                                    },
                                    child: Text(
                                      '${SahaDateUtils().getDDMMYY(addGuessNumberGameController.dateStart)}',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        dp.DatePicker.showTime12hPicker(
                                          context,
                                          showTitleActions: true,
                                          onChanged: (date) {
                                            print('change $date in time zone ' +
                                                date.timeZoneOffset.inHours
                                                    .toString());
                                          },
                                          onConfirm: (date) {
                                            var timeCheck = DateTime(
                                                addGuessNumberGameController
                                                    .dateStart.year,
                                                addGuessNumberGameController
                                                    .dateStart.month,
                                                addGuessNumberGameController
                                                    .dateStart.day,
                                                date.hour,
                                                date.minute,
                                                date.second);
                                            if (DateTime.now()
                                                    .isAfter(timeCheck) ==
                                                true) {
                                              setState(() {
                                                addGuessNumberGameController
                                                    .checkDayStart = true;
                                                addGuessNumberGameController
                                                    .timeStart = date;
                                              });
                                            } else {
                                              setState(() {
                                                addGuessNumberGameController
                                                    .checkDayStart = false;
                                                addGuessNumberGameController
                                                    .timeStart = date;
                                                addGuessNumberGameController
                                                    .guessGameReq
                                                    .value
                                                    .timeStart = timeCheck;
                                              });
                                            }
                                          },
                                          currentTime: DateTime.now(),
                                          locale: dp.LocaleType.vi,
                                        );
                                      },
                                      child: Text(
                                        '  ${SahaDateUtils().getHHMM(addGuessNumberGameController.timeStart)}',
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        addGuessNumberGameController.checkDayStart
                            ? Container(
                                padding: EdgeInsets.all(8.0),
                                color: Colors.red[50],
                                width: Get.width,
                                child: Text(
                                  "Vui lòng nhập thời gian bắt đầu trò chơi sau thời gian hiện tại",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.red),
                                ),
                              )
                            : Divider(
                                height: 1,
                              ),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Thời gian kết thúc'),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      dp.DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(1999, 1, 1),
                                          maxTime: DateTime(2050, 1, 1),
                                          theme: dp.DatePickerTheme(
                                              headerColor: Colors.white,
                                              backgroundColor: Colors.white,
                                              itemStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                              doneStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16)),
                                          onChanged: (date) {},
                                          onConfirm: (date) {
                                        if (date.isBefore(
                                                addGuessNumberGameController
                                                    .dateStart) ==
                                            true) {
                                          setState(() {
                                            addGuessNumberGameController
                                                .checkDayEnd = true;
                                            addGuessNumberGameController
                                                .dateEnd = date;
                                          });
                                        } else {
                                          setState(() {
                                            addGuessNumberGameController
                                                .checkDayEnd = false;
                                            addGuessNumberGameController
                                                .dateEnd = date;

                                            addGuessNumberGameController
                                                .guessGameReq
                                                .value
                                                .timeEnd = date;
                                          });
                                        }
                                      },
                                          currentTime: DateTime.now(),
                                          locale: dp.LocaleType.vi);
                                    },
                                    child: Text(
                                      '${SahaDateUtils().getDDMMYY(addGuessNumberGameController.dateEnd)}',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        dp.DatePicker.showTime12hPicker(
                                          context,
                                          showTitleActions: true,
                                          onChanged: (date) {
                                            print('change $date in time zone ' +
                                                date.timeZoneOffset.inHours
                                                    .toString());
                                          },
                                          onConfirm: (date) {
                                            var time = DateTime(
                                                addGuessNumberGameController
                                                    .dateEnd.year,
                                                addGuessNumberGameController
                                                    .dateEnd.month,
                                                addGuessNumberGameController
                                                    .dateEnd.day,
                                                date.hour,
                                                date.minute,
                                                date.second);
                                            if (date.isBefore(
                                                    addGuessNumberGameController
                                                        .timeStart) ==
                                                true) {
                                              setState(() {
                                                addGuessNumberGameController
                                                    .checkDayEnd = true;
                                                addGuessNumberGameController
                                                    .timeEnd = date;
                                              });
                                            } else {
                                              setState(() {
                                                addGuessNumberGameController
                                                    .checkDayEnd = false;
                                                addGuessNumberGameController
                                                    .timeEnd = date;
                                                addGuessNumberGameController
                                                    .guessGameReq
                                                    .value
                                                    .timeEnd = time;
                                              });
                                            }
                                          },
                                          currentTime: DateTime.now(),
                                          locale: dp.LocaleType.vi,
                                        );
                                      },
                                      child: Text(
                                        '  ${SahaDateUtils().getHHMM(addGuessNumberGameController.timeEnd)}',
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        addGuessNumberGameController.checkDayEnd
                            ? Container(
                                padding: EdgeInsets.all(8.0),
                                color: Colors.red[50],
                                width: Get.width,
                                child: Text(
                                  "Thời gian kết thúc phải sau thời gian bắt đầu",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.red),
                                ),
                              )
                            : Divider(
                                height: 1,
                              ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Số lần chơi trong ngày"),
                              Container(
                                width: Get.width * 0.5,
                                child: TextFormField(
                                  onChanged: (v) {
                                    addGuessNumberGameController.guessGameReq
                                        .value.turnInDay = int.tryParse(v);
                                  },
                                  controller:
                                      addGuessNumberGameController.turnInOneDay,
                                  keyboardType: TextInputType.number,
                                  maxLength: 2,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp("[,.]")),
                                  ],
                                  // validator: (value) {
                                  //   if (value!.length < 1) {
                                  //     return 'Chưa nhập số lần chơi';
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText: "Số lần chơi"),
                                  minLines: 1,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Hiển thị danh sách người đoán đúng"),
                              Checkbox(
                                  value: addGuessNumberGameController
                                          .guessGameReq.value.isShowAllPrizer ??
                                      false,
                                  onChanged: (v) {
                                    if (v == true) {
                                      addGuessNumberGameController.guessGameReq
                                          .value.isShowAllPrizer = true;
                                      addGuessNumberGameController.guessGameReq
                                          .refresh();
                                    } else {
                                      addGuessNumberGameController.guessGameReq
                                          .value.isShowAllPrizer = false;
                                      addGuessNumberGameController.guessGameReq
                                          .refresh();
                                    }
                                  })
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Obx(
                            () => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Ảnh mô tả game'),
                                  SelectImages(
                                    type: '',
                                    title: 'Ảnh mô tả',
                                    subTitle: 'Tối đa 10 hình',
                                    onUpload: () {
                                      addGuessNumberGameController
                                          .setUploadingImages(true);
                                    },
                                    images: addGuessNumberGameController
                                        .listImages
                                        .toList(),
                                    doneUpload: (List<ImageData> listImages) {
                                      print(
                                          "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                                      addGuessNumberGameController
                                          .setUploadingImages(false);
                                      addGuessNumberGameController
                                          .listImages(listImages);
                                      addGuessNumberGameController.guessGameReq
                                          .value.images = (listImages
                                              .map((e) => e.linkImage ?? "x"))
                                          .toList();
                                    },
                                    maxImage: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: SahaTextFieldNoBorder(
                            withAsterisk: false,
                            controller:
                                addGuessNumberGameController.description,
                            onChanged: (v) {
                              addGuessNumberGameController
                                  .guessGameReq.value.description = v;
                            },
                            textInputType: TextInputType.multiline,
                            labelText: "Mô tả",
                            hintText: "Nhập mô tả trò chơi",
                            //maxLine: 2,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        if ((addGuessNumberGameController
                                        .guessGameReq.value.timeEnd ??
                                    DateTime.now())
                                .isBefore(DateTime.now()) &&
                            addGuessNumberGameController
                                    .guessGameReq.value.finalResultAnnounced !=
                                null)
                          Card(
                            child: ListTile(
                              onTap: () {
                                Get.to(() => AwardAnounceScreen(
                                      guessNumberGame:
                                          addGuessNumberGameController
                                              .guessGameReq.value,
                                    ));
                              },
                              title: Text('Thông tin người trúng thưởng'),
                              subtitle: null,
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: widget.guessGameId == null
                    ? "Thêm trò chơi"
                    : 'Sửa trò chơi',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.guessGameId == null) {
                      addGuessNumberGameController.addGuessNumberGame();
                    } else {
                      addGuessNumberGameController.updateGuessNumberGame(
                          id: widget.guessGameId!);
                    }
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
}
