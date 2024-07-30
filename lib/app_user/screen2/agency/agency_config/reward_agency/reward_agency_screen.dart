import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/model/step_bonus.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import '../../../../components/saha_user/button/saha_button.dart';
import '../../../../components/saha_user/dialog/dialog.dart';
import '../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../const/constant.dart';
import '../../../../model/bonus_level.dart';
import 'reward_agency_controller.dart';
import 'widget/add_step_bonus_dialog.dart';

class RewardAgencyScreen extends StatefulWidget {
  @override
  _RewardAgencyScreenState createState() => _RewardAgencyScreenState();
}

class _RewardAgencyScreenState extends State<RewardAgencyScreen>
    with SingleTickerProviderStateMixin {
  RewardAgencyController rewardAgencyController =
      Get.put(RewardAgencyController());

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    print(rewardAgencyController.dataBonusConfig.value.config?.startTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Cấu hình thưởng"),
        actions: [
          Obx(() => (rewardAgencyController.indexW.value == 2)
              ? IconButton(
                  onPressed: () {
                    rewardAgencyController.listImages = [];
                    AddStepBonusDialog.showDialogInputText(
                        title: "Thêm Mức thưởng",
                        textButton: "Xác nhận",
                        onDone: (v) {
                          rewardAgencyController.addBonusStepAgency(StepBonus(
                            rewardImageUrl:
                                rewardAgencyController.listImages!.isEmpty
                                    ? null
                                    : rewardAgencyController
                                        .listImages![0].linkImage,
                            threshold: v["threshold"].toInt(),
                            rewardName: v["name"],
                            rewardValue: v["value"].toInt(),
                            limit: v["limit"].toInt(),
                            rewardDescription: v["des"],
                          ));
                          Get.back();
                        });
                  },
                  icon: Icon(Icons.add))
              : Container())
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 45,
            width: Get.width,
            child: ColoredBox(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                onTap: (v) {
                  rewardAgencyController.indexW.value = v;
                },
                tabs: [
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Thưởng hoa hồng',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Thưởng doanh số',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Thưởng theo đơn',
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          Expanded(
            child: Obx(() => rewardAgencyController.loadingRose.value == true ||
                    rewardAgencyController.isLoadingImport.value == true
                ? SahaLoadingWidget()
                : SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      children: [
                        if (rewardAgencyController.indexW.value == 0) rose(),
                        if (rewardAgencyController.indexW.value == 1) revenue(),
                        if (rewardAgencyController.indexW.value == 2) order(),
                      ],
                    ),
                  )),
          )
        ],
      ),
    );
  }

  Widget rose() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Obx(
        () => rewardAgencyController.loadingRose.value == true
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cách tính thưởng đại lý theo hoa hồng:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "(Là phần thưởng dành cho đại lý khi chinh phục được các mức hoa hồng)",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Thông tin cấu hình: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => rewardAgencyController.isLoading.value == true
                        ? Container()
                        : Column(
                            children: [
                              if (rewardAgencyController
                                  .listLevelBonus.isNotEmpty)
                                ...List.generate(
                                  rewardAgencyController.listLevelBonus.length,
                                  (index) => itemLevel(
                                      bonusLevel: rewardAgencyController
                                          .listLevelBonus[index],
                                      index: index,
                                      indexLast: rewardAgencyController
                                              .listLevelBonus.length -
                                          1),
                                ),
                              rewardAgencyController.listLevelBonus.isEmpty
                                  ? itemLevel(
                                      bonusLevel:
                                          BonusLevel(limit: 0, bonus: 0),
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
    );
  }

  Widget revenue() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Obx(
        () => rewardAgencyController.isLoadingImport.value == true &&
                rewardAgencyController.loadingRose.value == true
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cách tính thưởng đại lý theo doanh số:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "(Là phần thưởng dành cho đại lý khi chinh phục được các mức doanh số)",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showDialogType(
                          type: rewardAgencyController
                              .typeBonusPeriodImport.value,
                          onChoose: (v) {
                            rewardAgencyController.typeBonusPeriodImport.value =
                                v;
                            rewardAgencyController
                                .configTypeBonusPeriodImport();
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
                                getText(rewardAgencyController
                                    .typeBonusPeriodImport.value),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down_rounded)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Thông tin cấu hình: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => rewardAgencyController.isLoadingImport.value ==
                                true &&
                            rewardAgencyController.loadingRose.value == true
                        ? Container()
                        : Column(
                            children: [
                              if (rewardAgencyController
                                  .listImportBonusStep.isNotEmpty)
                                ...List.generate(
                                  rewardAgencyController
                                      .listImportBonusStep.length,
                                  (index) => itemLevelImport(
                                      bonusLevel: rewardAgencyController
                                          .listImportBonusStep[index],
                                      index: index,
                                      indexLast: rewardAgencyController
                                              .listImportBonusStep.length -
                                          1),
                                ),
                              rewardAgencyController.listImportBonusStep.isEmpty
                                  ? itemLevelImport(
                                      bonusLevel:
                                          BonusLevel(limit: 0, bonus: 0),
                                      index: 0,
                                      indexLast: 0)
                                  : Container(),
                            ],
                          ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
      ),
    );
  }

  Widget order() {
    return Obx(
      () => rewardAgencyController.isLoading.value == true
          ? Container()
          : Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hoạt động"),
                    Obx(
                      () => CupertinoSwitch(
                        value: !(rewardAgencyController
                                .dataBonusConfig.value.config?.isEnd ??
                            false),
                        onChanged: (bool value) async {
                          rewardAgencyController.dataBonusConfig.value.config
                              ?.isEnd = !(rewardAgencyController
                                  .dataBonusConfig.value.config?.isEnd ??
                              false);
                          rewardAgencyController.dataBonusConfig.refresh();
                          rewardAgencyController.updateBonusAgencyConfig(
                            rewardAgencyController
                                    .dataBonusConfig.value.config?.isEnd ??
                                false,
                            DateTime(
                                rewardAgencyController.dateStart.value.year,
                                rewardAgencyController.dateStart.value.month,
                                rewardAgencyController.dateStart.value.day,
                                rewardAgencyController.timeStart.value.hour,
                                rewardAgencyController.timeStart.value.minute),
                            DateTime(
                                rewardAgencyController.dateEnd.value.year,
                                rewardAgencyController.dateEnd.value.month,
                                rewardAgencyController.dateEnd.value.day,
                                rewardAgencyController.timeEnd.value.hour,
                                rewardAgencyController.timeEnd.value.minute),
                          );
                        },
                      ),
                    ),
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
                                        color: Colors.black, fontSize: 16)),
                                onChanged: (date) {}, onConfirm: (date) {
                              if (date.isBefore(
                                      rewardAgencyController.dateStart.value) ==
                                  true) {
                                setState(() {
                                  rewardAgencyController.checkDayStart.value =
                                      true;
                                  rewardAgencyController.dateStart.value = date;
                                });
                              } else {
                                setState(() {
                                  rewardAgencyController.checkDayStart.value =
                                      false;
                                  rewardAgencyController.dateStart.value = date;
                                });
                                rewardAgencyController.updateBonusAgencyConfig(
                                  rewardAgencyController
                                      .dataBonusConfig.value.config!.isEnd!,
                                  DateTime(
                                      rewardAgencyController
                                          .dateStart.value.year,
                                      rewardAgencyController
                                          .dateStart.value.month,
                                      rewardAgencyController
                                          .dateStart.value.day,
                                      rewardAgencyController
                                          .timeStart.value.hour,
                                      rewardAgencyController
                                          .timeStart.value.minute),
                                  DateTime(
                                      rewardAgencyController.dateEnd.value.year,
                                      rewardAgencyController
                                          .dateEnd.value.month,
                                      rewardAgencyController.dateEnd.value.day,
                                      rewardAgencyController.timeEnd.value.hour,
                                      rewardAgencyController
                                          .timeEnd.value.minute),
                                );
                              }
                            },
                                currentTime: rewardAgencyController
                                        .dataBonusConfig
                                        .value
                                        .config
                                        ?.startTime ??
                                    DateTime.now(),
                                locale: dp.LocaleType.vi);
                          },
                          child: Text(
                            '${SahaDateUtils().getDDMMYY(rewardAgencyController.dateStart.value)}',
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
                                      date.timeZoneOffset.inHours.toString());
                                },
                                onConfirm: (date) {
                                  if (date.isBefore(rewardAgencyController
                                          .timeStart.value) ==
                                      true) {
                                    setState(() {
                                      rewardAgencyController
                                          .checkDayStart.value = true;
                                      rewardAgencyController.timeStart.value =
                                          date;
                                    });
                                  } else {
                                    setState(() {
                                      rewardAgencyController
                                          .checkDayStart.value = false;
                                      rewardAgencyController.timeStart.value =
                                          date;
                                    });
                                    rewardAgencyController
                                        .updateBonusAgencyConfig(
                                      rewardAgencyController
                                          .dataBonusConfig.value.config!.isEnd!,
                                      DateTime(
                                          rewardAgencyController
                                              .dateStart.value.year,
                                          rewardAgencyController
                                              .dateStart.value.month,
                                          rewardAgencyController
                                              .dateStart.value.day,
                                          rewardAgencyController
                                              .timeStart.value.hour,
                                          rewardAgencyController
                                              .timeStart.value.minute),
                                      DateTime(
                                          rewardAgencyController
                                              .dateEnd.value.year,
                                          rewardAgencyController
                                              .dateEnd.value.month,
                                          rewardAgencyController
                                              .dateEnd.value.day,
                                          rewardAgencyController
                                              .timeEnd.value.hour,
                                          rewardAgencyController
                                              .timeEnd.value.minute),
                                    );
                                  }
                                },
                                currentTime: rewardAgencyController
                                        .dataBonusConfig
                                        .value
                                        .config
                                        ?.startTime ??
                                    DateTime.now(),
                                locale: dp.LocaleType.vi,
                              );
                            },
                            child: Text(
                              '  ${SahaDateUtils().getHHMM(rewardAgencyController.timeStart.value)}',
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              rewardAgencyController.checkDayStart.value
                  ? Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.red[50],
                      width: Get.width,
                      child: Text(
                        "Vui lòng nhập thời gian bắt đầu chương trình khuyến mãi sau thời gian hiện tại",
                        style: TextStyle(fontSize: 13, color: Colors.red),
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
                                        color: Colors.black, fontSize: 16)),
                                onChanged: (date) {}, onConfirm: (date) {
                              if (date.isBefore(
                                      rewardAgencyController.dateStart.value) ==
                                  true) {
                                setState(() {
                                  rewardAgencyController.checkDayEnd.value =
                                      true;
                                  rewardAgencyController.dateEnd.value = date;
                                });
                              } else {
                                setState(() {
                                  rewardAgencyController.checkDayEnd.value =
                                      false;
                                  rewardAgencyController.dateEnd.value = date;
                                });
                                rewardAgencyController.updateBonusAgencyConfig(
                                  rewardAgencyController
                                      .dataBonusConfig.value.config!.isEnd!,
                                  DateTime(
                                      rewardAgencyController
                                          .dateStart.value.year,
                                      rewardAgencyController
                                          .dateStart.value.month,
                                      rewardAgencyController
                                          .dateStart.value.day,
                                      rewardAgencyController
                                          .timeStart.value.hour,
                                      rewardAgencyController
                                          .timeStart.value.minute),
                                  DateTime(
                                      rewardAgencyController.dateEnd.value.year,
                                      rewardAgencyController
                                          .dateEnd.value.month,
                                      rewardAgencyController.dateEnd.value.day,
                                      rewardAgencyController.timeEnd.value.hour,
                                      rewardAgencyController
                                          .timeEnd.value.minute),
                                );
                              }
                            },
                                currentTime: rewardAgencyController
                                        .dataBonusConfig
                                        .value
                                        .config
                                        ?.endTime ??
                                    DateTime.now(),
                                locale: dp.LocaleType.vi);
                          },
                          child: Text(
                            '${SahaDateUtils().getDDMMYY(rewardAgencyController.dateEnd.value)}',
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
                                      date.timeZoneOffset.inHours.toString());
                                },
                                onConfirm: (date) {
                                  if (date.isBefore(rewardAgencyController
                                          .timeStart.value) ==
                                      true) {
                                    setState(() {
                                      rewardAgencyController.checkDayEnd.value =
                                          true;
                                      rewardAgencyController.timeEnd.value =
                                          date;
                                    });
                                  } else {
                                    setState(() {
                                      rewardAgencyController.checkDayEnd.value =
                                          false;
                                      rewardAgencyController.timeEnd.value =
                                          date;
                                    });
                                    rewardAgencyController
                                        .updateBonusAgencyConfig(
                                      rewardAgencyController
                                          .dataBonusConfig.value.config!.isEnd!,
                                      DateTime(
                                          rewardAgencyController
                                              .dateStart.value.year,
                                          rewardAgencyController
                                              .dateStart.value.month,
                                          rewardAgencyController
                                              .dateStart.value.day,
                                          rewardAgencyController
                                              .timeStart.value.hour,
                                          rewardAgencyController
                                              .timeStart.value.minute),
                                      DateTime(
                                          rewardAgencyController
                                              .dateEnd.value.year,
                                          rewardAgencyController
                                              .dateEnd.value.month,
                                          rewardAgencyController
                                              .dateEnd.value.day,
                                          rewardAgencyController
                                              .timeEnd.value.hour,
                                          rewardAgencyController
                                              .timeEnd.value.minute),
                                    );
                                  }
                                },
                                currentTime: rewardAgencyController
                                        .dataBonusConfig
                                        .value
                                        .config
                                        ?.endTime ??
                                    DateTime.now(),
                                locale: dp.LocaleType.vi,
                              );
                            },
                            child: Text(
                              '  ${SahaDateUtils().getHHMM(rewardAgencyController.timeEnd.value)}',
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              rewardAgencyController.checkDayEnd.value
                  ? Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.red[50],
                      width: Get.width,
                      child: Text(
                        "Thời gian kết thúc phải sau thời gian bắt đầu",
                        style: TextStyle(fontSize: 13, color: Colors.red),
                      ),
                    )
                  : Divider(
                      height: 1,
                    ),
              ...rewardAgencyController.dataBonusConfig.value.stepBonus!
                  .map((e) => itemBonusStep(e))
                  .toList(),
            ]),
    );
  }

  Widget itemBonusStep(StepBonus stepBonus) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          imageUrl: stepBonus.rewardImageUrl ?? "",
                          placeholder: (context, url) => new SahaLoadingWidget(
                            size: 20,
                          ),
                          errorWidget: (context, url, error) =>
                              SahaEmptyImage(),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(stepBonus.rewardName ?? ""),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text("Đạt mức: "),
                            Text(
                                "${SahaStringUtils().convertToMoney(stepBonus.threshold ?? "")}₫"),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text("Thưởng: "),
                            Text(
                                "${SahaStringUtils().convertToMoney(stepBonus.rewardValue ?? "")}₫"),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text("Giới hạn: "),
                            Text("${stepBonus.limit ?? ""}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 10),
              child: Text(
                stepBonus.rewardDescription ?? "",
                maxLines: 4,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Container(
              height: 5,
              color: Colors.grey[200],
            )
          ],
        ),
        Positioned(
          right: 10,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.grey,
                ),
                onPressed: () {
                  rewardAgencyController.listImages = [];
                  AddStepBonusDialog.showDialogInputText(
                      title: "Sửa Mức thưởng",
                      textButton: "Xác nhận",
                      rewardDescriptionIp: stepBonus.rewardDescription,
                      rewardImageUrlIp: stepBonus.rewardImageUrl,
                      rewardNameIp: stepBonus.rewardName,
                      rewardValueIp: stepBonus.rewardValue,
                      thresholdIp: stepBonus.threshold,
                      limitIp: stepBonus.limit,
                      onDone: (v) {
                        rewardAgencyController.updateBonusStepAgency(
                          stepBonus.id!,
                          StepBonus(
                            rewardImageUrl:
                                rewardAgencyController.listImages!.isEmpty
                                    ? stepBonus.rewardImageUrl
                                    : rewardAgencyController
                                        .listImages![0].linkImage,
                            threshold: v["threshold"].toInt(),
                            rewardName: v["name"],
                            rewardValue: v["value"].toInt(),
                            limit: v["limit"].toInt(),
                            rewardDescription: v["des"],
                          ),
                        );
                        Get.back();
                      });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  rewardAgencyController.deleteBonusStepAgency(stepBonus.id!);
                },
              ),
            ],
          ),
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
          await rewardAgencyController.addLevelBonusAgency(
              int.tryParse(SahaStringUtils()
                      .convertFormatText(levelEditingController.text)) ??
                  0,
              int.tryParse(SahaStringUtils()
                      .convertFormatText(percentEditingController.text)) ??
                  0);

          rewardAgencyController.listLevelBonus
              .add(BonusLevel(limit: 0, bonus: 0));
          rewardAgencyController.checkInput.add(false);
        } else {
          rewardAgencyController.listLevelBonus
              .add(BonusLevel(limit: 0, bonus: 0));
          rewardAgencyController.checkInput.add(false);
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
                          rewardAgencyController.checkInput[index!] = true;
                        } else {
                          rewardAgencyController.checkInput[index!] = false;
                        }
                        print(rewardAgencyController.checkInput[index]);
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
                          rewardAgencyController.checkInput[index!] = true;
                        } else {
                          rewardAgencyController.checkInput[index!] = false;
                        }
                        print(rewardAgencyController.checkInput[index]);
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
                      rewardAgencyController.checkInput[index!] == false) {
                    SahaDialogApp.showDialogYesNo(
                        mess: "Bạn có chắc chắn muốn xoá mức thưởng này chứ",
                        onOK: () async {
                          rewardAgencyController
                              .deleteLevelBonus(bonusLevel.id!);
                          rewardAgencyController.listLevelBonus.removeAt(index);
                        });
                  } else if (rewardAgencyController.checkInput[index!] ==
                          true &&
                      bonusLevel.limit.toString() != "" &&
                      bonusLevel.bonus.toString() != "") {
                    await rewardAgencyController.updateLevelBonusAgency(
                        int.parse(SahaStringUtils().convertFormatText(
                            levelEditingController.text == ""
                                ? "0"
                                : levelEditingController.text)),
                        int.parse(SahaStringUtils().convertFormatText(
                            percentEditingController.text == ""
                                ? "0"
                                : percentEditingController.text)),
                        bonusLevel.id!);
                  } else {
                    rewardAgencyController.listLevelBonus.removeAt(index);
                  }
                },
                child: Container(
                  height: 35,
                  width: 35,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: rewardAgencyController.checkInput[index!] == false
                          ? Colors.red
                          : rewardAgencyController.checkInput[index] == true &&
                                  bonusLevel.limit.toString() != "0" &&
                                  bonusLevel.bonus.toString() != "0"
                              ? Colors.blue
                              : Colors.red,
                      shape: BoxShape.circle),
                  child: Center(
                      child: Text(
                    rewardAgencyController.checkInput[index] == false
                        ? "Xoá"
                        : rewardAgencyController.checkInput[index] == true &&
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

  ///
  Widget itemLevelImport(
      {required BonusLevel bonusLevel, int? index, int? indexLast}) {
    TextEditingController levelEditingController = TextEditingController(
        text: SahaStringUtils()
                    .convertFormatText((bonusLevel.limit ?? '0').toString()) ==
                "0"
            ? ""
            : SahaStringUtils()
                .convertToUnit((bonusLevel.limit ?? '0').toString()));
    TextEditingController percentEditingController = TextEditingController(
        text: SahaStringUtils()
                    .convertFormatText((bonusLevel.bonus ?? '0').toString()) ==
                "0"
            ? ""
            : SahaStringUtils()
                .convertToUnit((bonusLevel.bonus ?? '0').toString()));

    void addLevelBonus() async {
      if (levelEditingController.text != "" &&
          percentEditingController.text != "") {
        if (bonusLevel.limit.toString() !=
                SahaStringUtils()
                    .convertFormatText(levelEditingController.text) &&
            bonusLevel.bonus.toString() !=
                SahaStringUtils()
                    .convertFormatText(percentEditingController.text)) {
          await rewardAgencyController.addImportBonusStepAgency(BonusLevel(
              limit: int.tryParse(SahaStringUtils()
                  .convertFormatText(levelEditingController.text)),
              bonus: int.tryParse(SahaStringUtils()
                  .convertFormatText(percentEditingController.text))));

          rewardAgencyController.listImportBonusStep
              .add(BonusLevel(limit: null, bonus: null));
        } else {
          rewardAgencyController.listImportBonusStep
              .add(BonusLevel(limit: null, bonus: null));
        }
      } else {
        SahaAlert.showError(message: "Chưa nhập Mức hoặc Tỉ lệ");
      }
    }

    var refreshItem = false.obs;

    var checkUpdate = false.obs;

    return Obx(
      () => refreshItem.value
          ? Container()
          : Padding(
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
                        decoration: BoxDecoration(
                            border: Border.all(color: SahaPrimaryColor)),
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
                                print(SahaStringUtils().convertFormatText(
                                    levelEditingController.text));
                                print(SahaStringUtils().convertFormatText(
                                    bonusLevel.limit.toString()));
                                if (SahaStringUtils().convertFormatText(
                                            levelEditingController.text) !=
                                        bonusLevel.limit.toString() ||
                                    SahaStringUtils().convertFormatText(
                                            percentEditingController.text) !=
                                        bonusLevel.bonus.toString()) {
                                  print(checkUpdate.value);
                                  checkUpdate.value = true;
                                } else {
                                  print(checkUpdate.value);

                                  checkUpdate.value = false;
                                }
                                refreshItem.refresh();
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
                        decoration: BoxDecoration(
                            border: Border.all(color: SahaPrimaryColor)),
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
                                  checkUpdate.value = true;
                                }

                                refreshItem.refresh();
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
                  InkWell(
                    onTap: () async {
                      if (bonusLevel.id != null &&
                          bonusLevel.limit != null &&
                          bonusLevel.bonus != null) {
                        SahaDialogApp.showDialogYesNo(
                            mess:
                                "Bạn có chắc chắn muốn xoá mức thưởng này chứ",
                            onOK: () async {
                              rewardAgencyController
                                  .deleteImportBonusStepAgency(bonusLevel.id!);
                              rewardAgencyController.listImportBonusStep
                                  .removeAt(index!);
                            });
                      } else if (bonusLevel.limit != null &&
                          bonusLevel.bonus != null &&
                          bonusLevel.limit.toString() != "" &&
                          bonusLevel.bonus.toString() != "") {
                        await rewardAgencyController
                            .updateImportBonusStepAgency(
                          bonusLevel.id!,
                          BonusLevel(
                              limit: int.tryParse(SahaStringUtils()
                                  .convertFormatText(
                                      levelEditingController.text)),
                              bonus: int.parse(SahaStringUtils()
                                  .convertFormatText(
                                      percentEditingController.text))),
                        );
                      } else {
                        rewardAgencyController.listImportBonusStep
                            .removeAt(index!);
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Center(
                          child: Text(
                        "Xoá",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                  Obx(
                    () => checkUpdate.value && bonusLevel.id != null
                        ? InkWell(
                            onTap: () async {
                              await rewardAgencyController
                                  .updateImportBonusStepAgency(
                                bonusLevel.id!,
                                BonusLevel(
                                    limit: int.tryParse(SahaStringUtils()
                                        .convertFormatText(
                                            levelEditingController.text)),
                                    bonus: int.parse(SahaStringUtils()
                                        .convertFormatText(
                                            percentEditingController.text))),
                              );
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.blue, shape: BoxShape.circle),
                              child: Center(
                                  child: Text(
                                "Lưu",
                                style: TextStyle(color: Colors.white),
                              )),
                            ))
                        : Container(),
                  ),
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
            ),
    );
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

  String getText(int? type) {
    if (type == 0) return "Theo tháng";
    if (type == 1) return "Theo tuần";
    if (type == 2) return "Theo quý";
    if (type == 3) return "Theo năm";
    return "Chọn kỳ";
  }
}
