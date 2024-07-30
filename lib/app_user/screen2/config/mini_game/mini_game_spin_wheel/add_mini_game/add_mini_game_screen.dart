import 'dart:developer';

import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/widget/select_image/select_images.dart';
import 'package:com.ikitech.store/app_user/screen2/config/mini_game/mini_game_spin_wheel/add_mini_game/add_mini_game_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/config/mini_game/mini_game_spin_wheel/add_mini_game/default_image.dart';
import 'package:com.ikitech.store/components/app_customer/components/image_default/list_image_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../../components/saha_user/button/saha_button.dart';
import '../../../../../components/saha_user/dialog/dialog.dart';

import '../../../../../components/saha_user/text_field/text_field_no_border.dart';
import '../../../../../components/widget/image_picker_single/image_picker_single.dart';
import '../../../../../model/image_assset.dart';
import '../../../../../utils/date_utils.dart';
import '../gift/gift_screen.dart';

class AddMiniGameScreen extends StatefulWidget {
  AddMiniGameScreen({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  State<AddMiniGameScreen> createState() => _AddMiniGameScreenState();
}

class _AddMiniGameScreenState extends State<AddMiniGameScreen> {
  final _formKey = GlobalKey<FormState>();

  final AddMiniGameController addMiniGameController =
      Get.put(AddMiniGameController());

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      addMiniGameController.getMiniGame(id: widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              if (addMiniGameController.miniGameRes.value.id == null) {
                Get.back();
              } else {
                if ((addMiniGameController.miniGameRes.value.listGift ?? [])
                    .isEmpty) {
                  SahaDialogApp.showDialogYesNo(
                      mess:
                          "Bạn chưa tạo phần quà cho vòng quay này, bạn chắc chắn muốn quay lại chứ ?",
                      onClose: () {},
                      onOK: () {
                        Get.back();
                      });
                } else {
                  Get.back();
                }
              }
            },
          ),
          title: widget.id == null &&
                  addMiniGameController.miniGameRes.value.id == null
              ? Text('Thêm mini game')
              : Text('Sửa mini game'),
          actions: [
            widget.id != null
                ? GestureDetector(
                    onTap: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: "Bạn có chắc muốn xoá game này",
                          onClose: () {},
                          onOK: () {
                            addMiniGameController.deleteMiniGame(
                                id: widget.id!);
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
          () => addMiniGameController.loadInit.value
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
                                  addMiniGameController.group.value = v;
                                  addMiniGameController
                                      .miniGameReq.value.applyFor = v;
                                },
                                groupType: addMiniGameController.group.value);
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
                                            '${addMiniGameController.group.value == 0 ? "Tất cả" : addMiniGameController.group.value == 1 ? "Cộng tác viên" : addMiniGameController.group.value == 2 ? "Đại lý" : 'Nhóm khách hàng'} '),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down_rounded),
                              ],
                            ),
                          ),
                        ),
                        Obx(() => addMiniGameController.group.value == 2
                            ? InkWell(
                                onTap: () {
                                  SahaDialogApp.showDialogAgencyType(
                                      onChoose: (v) {
                                        addMiniGameController.agencyType.value =
                                            v;
                                        addMiniGameController
                                                .miniGameReq.value.agencyId =
                                            addMiniGameController
                                                .agencyType.value.id!;
                                      },
                                      type: addMiniGameController
                                          .agencyType.value.id,
                                      listAgencyType: addMiniGameController
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
                                                  '${addMiniGameController.agencyType.value.name ?? ""} '),
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
                        Obx(() => addMiniGameController.group.value == 4
                            ? InkWell(
                                onTap: () {
                                  SahaDialogApp.showDialogCustomerGroupType(
                                      onChoose: (v) {
                                        addMiniGameController
                                            .groupCustomer.value = v;
                                        addMiniGameController.miniGameReq.value
                                                .groupCustomerId =
                                            addMiniGameController
                                                .groupCustomer.value.id!;
                                      },
                                      type: addMiniGameController
                                          .groupCustomer.value.id,
                                      listGroupCustomer: addMiniGameController
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
                                                  '${addMiniGameController.groupCustomer.value.name ?? ""} '),
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
                            children: [
                              Text('Tên mini game'),
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
                                      addMiniGameController.nameMiniGame,
                                  onChanged: (v) {
                                    addMiniGameController
                                        .miniGameReq.value.name = v;
                                  },
                                  validator: (value) {
                                    if (value!.length < 1) {
                                      return 'Chưa nhập tên mini game';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "Nhập tên mini game tại đây",
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
                          child: Row(
                            children: [
                              Text('Loại mini game:'),
                              Row(
                                children: [
                                  Obx(
                                    () => Checkbox(
                                        value: addMiniGameController
                                                .miniGameReq.value.isShake ==
                                            false,
                                        onChanged: (v) {
                                          if (v == true) {
                                            addMiniGameController.miniGameReq
                                                .value.isShake = false;
                                          } else {
                                            addMiniGameController.miniGameReq
                                                .value.isShake = null;
                                          }

                                          addMiniGameController.miniGameReq
                                              .refresh();
                                        }),
                                  ),
                                  Text('Vòng quay')
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: addMiniGameController
                                              .miniGameReq.value.isShake ==
                                          true,
                                      onChanged: (v) {
                                        if (v == true) {
                                          addMiniGameController
                                              .miniGameReq.value.isShake = true;
                                        } else {
                                          addMiniGameController
                                              .miniGameReq.value.isShake = null;
                                        }
                                        addMiniGameController.miniGameReq
                                            .refresh();
                                      }),
                                  Text('Rung lắc')
                                ],
                              )
                            ],
                          ),
                        ),
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
                                        if (date.isBefore(addMiniGameController
                                                .dateStart) ==
                                            true) {
                                          setState(() {
                                            addMiniGameController
                                                .checkDayStart = true;
                                            addMiniGameController.dateStart =
                                                date;
                                          });
                                        } else {
                                          setState(() {
                                            addMiniGameController
                                                .checkDayStart = false;
                                            addMiniGameController.dateStart =
                                                date;
                                            addMiniGameController.miniGameReq
                                                .value.timeStart = date;
                                          });
                                        }
                                      },
                                          currentTime: DateTime.now(),
                                          locale: dp.LocaleType.vi);
                                    },
                                    child: Text(
                                      '${SahaDateUtils().getDDMMYY(addMiniGameController.dateStart)}',
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
                                                addMiniGameController
                                                    .dateStart.year,
                                                addMiniGameController
                                                    .dateStart.month,
                                                addMiniGameController
                                                    .dateStart.day,
                                                date.hour,
                                                date.minute,
                                                date.second);
                                            if (DateTime.now()
                                                    .isAfter(timeCheck) ==
                                                true) {
                                              setState(() {
                                                addMiniGameController
                                                    .checkDayStart = true;
                                                addMiniGameController
                                                    .timeStart = date;
                                              });
                                            } else {
                                              setState(() {
                                                addMiniGameController
                                                    .checkDayStart = false;
                                                addMiniGameController
                                                    .timeStart = date;
                                                addMiniGameController
                                                    .miniGameReq
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
                                        '  ${SahaDateUtils().getHHMM(addMiniGameController.timeStart)}',
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        addMiniGameController.checkDayStart
                            ? Container(
                                padding: EdgeInsets.all(8.0),
                                color: Colors.red[50],
                                width: Get.width,
                                child: Text(
                                  "Vui lòng nhập thời gian bắt đầu chương trình khuyến mãi sau thời gian hiện tại",
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
                                        if (date.isBefore(addMiniGameController
                                                .dateStart) ==
                                            true) {
                                          setState(() {
                                            addMiniGameController.checkDayEnd =
                                                true;
                                            addMiniGameController.dateEnd =
                                                date;
                                          });
                                        } else {
                                          setState(() {
                                            addMiniGameController.checkDayEnd =
                                                false;
                                            addMiniGameController.dateEnd =
                                                date;

                                            addMiniGameController.miniGameReq
                                                .value.timeEnd = date;
                                          });
                                        }
                                      },
                                          currentTime: DateTime.now(),
                                          locale: dp.LocaleType.vi);
                                    },
                                    child: Text(
                                      '${SahaDateUtils().getDDMMYY(addMiniGameController.dateEnd)}',
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
                                                addMiniGameController
                                                    .dateEnd.year,
                                                addMiniGameController
                                                    .dateEnd.month,
                                                addMiniGameController
                                                    .dateEnd.day,
                                                date.hour,
                                                date.minute,
                                                date.second);
                                            if (date.isBefore(
                                                    addMiniGameController
                                                        .timeStart) ==
                                                true) {
                                              setState(() {
                                                addMiniGameController
                                                    .checkDayEnd = true;
                                                addMiniGameController.timeEnd =
                                                    date;
                                              });
                                            } else {
                                              setState(() {
                                                addMiniGameController
                                                    .checkDayEnd = false;
                                                addMiniGameController.timeEnd =
                                                    date;
                                                addMiniGameController
                                                    .miniGameReq
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
                                        '  ${SahaDateUtils().getHHMM(addMiniGameController.timeEnd)}',
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        addMiniGameController.checkDayEnd
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
                              Text("Số lần chơi một ngày"),
                              Container(
                                width: Get.width * 0.5,
                                child: TextFormField(
                                  onChanged: (v) {
                                    addMiniGameController.miniGameReq.value
                                        .turnInDay = int.tryParse(v);
                                  },
                                  controller:
                                      addMiniGameController.turnInOneDay,
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
                          color: Colors.white,
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text('Hình nền'),
                              Row(
                                children: [
                                  Obx(
                                    () => Checkbox(
                                        value: addMiniGameController.miniGameReq
                                                .value.typeBackgroundImage ==
                                            0,
                                        onChanged: (v) {
                                          if (v == true) {
                                            addMiniGameController.miniGameReq
                                                .value.typeBackgroundImage = 0;
                                          } else {
                                            addMiniGameController
                                                .miniGameReq
                                                .value
                                                .typeBackgroundImage = null;
                                          }

                                          addMiniGameController.miniGameReq
                                              .refresh();
                                        }),
                                  ),
                                  Text('Ảnh mặc định')
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: addMiniGameController.miniGameReq
                                              .value.typeBackgroundImage ==
                                          1,
                                      onChanged: (v) {
                                        if (v == true) {
                                          addMiniGameController.miniGameReq
                                              .value.typeBackgroundImage = 1;
                                        } else {
                                          addMiniGameController.miniGameReq
                                              .value.typeBackgroundImage = null;
                                        }
                                        addMiniGameController.miniGameReq
                                            .refresh();
                                      }),
                                  Text('Ảnh tự đăng')
                                ],
                              )
                            ],
                          ),
                        ),
                        Obx(() => addMiniGameController
                                    .miniGameReq.value.typeBackgroundImage ==
                                0
                            ? Container(
                                child: ProductImage(
                                  listImageUrl: listImageDefault,
                                  imageUrl: addMiniGameController
                                      .backgroundImageDefault,
                                  isUpdate: widget.id == null &&
                                          addMiniGameController
                                                  .miniGameRes.value.id ==
                                              null
                                      ? false
                                      : true,
                                ),
                              )
                            : SizedBox()),
                        Obx(() => addMiniGameController
                                    .miniGameReq.value.typeBackgroundImage ==
                                1
                            ? Container(
                                color: Colors.white,
                                child: ImagePickerSingle(
                                  type: '',
                                  linkLogo:
                                      addMiniGameController.backgroundImage,
                                  onChange: (link) {
                                    addMiniGameController.backgroundImage =
                                        link;
                                    log(addMiniGameController.backgroundImage ??
                                        'null');
                                  },
                                ),
                              )
                            : SizedBox()),
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
                                  Text('Ảnh mô tả mini game'),
                                  SelectImages(
                                    type: '',
                                    title: 'Ảnh mini game',
                                    subTitle: 'Tối đa 10 hình',
                                    onUpload: () {
                                      addMiniGameController
                                          .setUploadingImages(true);
                                    },
                                    images: addMiniGameController.listImages
                                        .toList(),
                                    doneUpload: (List<ImageData> listImages) {
                                      print(
                                          "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");
                                      addMiniGameController
                                          .setUploadingImages(false);
                                      addMiniGameController
                                          .listImages(listImages);
                                      addMiniGameController.miniGameReq.value
                                          .images = (listImages
                                              .map((e) => e.linkImage ?? "x"))
                                          .toList();
                                    }, maxImage: 10,
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
                            controller: addMiniGameController.description,
                            onChanged: (v) {
                              addMiniGameController
                                  .miniGameReq.value.description = v;
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
                        if (widget.id != null ||
                            addMiniGameController.miniGameRes.value.id != null)
                          Card(
                            child: ListTile(
                              onTap: () {
                                Get.to(() => GiftScreen(
                                          id: addMiniGameController
                                              .miniGameRes.value.id!,
                                        ))!
                                    .then((value) => addMiniGameController
                                        .getMiniGame(id: widget.id!));
                              },
                              title: Text('Danh sách phần thưởng'),
                              subtitle: (addMiniGameController
                                              .miniGameRes.value.listGift ??
                                          [])
                                      .isEmpty
                                  ? Text(
                                      'Chưa có danh sách phần thưởng,mời bạn vào đây để tạo danh sách phần thưởng',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : (addMiniGameController.miniGameRes.value
                                                      .listGift ??
                                                  [])
                                              .length <
                                          2
                                      ? Text(
                                          'Danh sách quà tặng ít nhất có 2 phần thưởng')
                                      : null,
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
                text: widget.id == null &&
                        addMiniGameController.miniGameRes.value.id == null
                    ? "Thêm mini game"
                    : 'Sửa mini game',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.id == null &&
                        addMiniGameController.miniGameRes.value.id == null) {
                      addMiniGameController.addMiniGame();
                    } else {
                      addMiniGameController.updateMiniGame(
                          id: widget.id ??
                              addMiniGameController.miniGameRes.value.id!);
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
