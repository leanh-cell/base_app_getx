import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'calendar_time_keeping_controller.dart';

class CalendarTimeKeeping extends StatelessWidget {
  bool? isCreate;
  bool? isAllPickDate;
  Function onChange;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  CalendarTimeKeeping({required this.onChange, this.isCreate, this.isAllPickDate}) {
    c = CalendarTimeKeepingController(isCreate: isCreate);
  }

  late CalendarTimeKeepingController c;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    showDialogTextType();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Text("${c.textType.value}")),
                      Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 20,
                color: Colors.grey,
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    c.isCreate != true
                        ? InkWell(
                            onTap: () {
                              c.controllerDate(isNext: false);
                              onChange(
                                  SahaDateUtils().getDate(c.dateFrom.value),
                                  SahaDateUtils().getDate(c.dateTo.value));
                            },
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 18,
                            ),
                          )
                        : Obx(
                            () => c.checkPast(c.dateFrom.value) == false
                                ? InkWell(
                                    onTap: () {
                                      c.controllerDate(isNext: false);
                                      onChange(
                                          SahaDateUtils()
                                              .getDate(c.dateFrom.value),
                                          SahaDateUtils()
                                              .getDate(c.dateTo.value));
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      size: 18,
                                    ),
                                  )
                                : Container(),
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                      () => InkWell(
                        onTap: () {
                          if (c.textType.value == "Tuỳ chọn" ||
                              c.textType.value == "Ngày") {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Container(
                                      width: Get.width * 0.9,
                                      height: Get.height * 0.5,
                                      child: SfDateRangePicker(
                                        onCancel: () {
                                          Get.back();
                                        },
                                        onSubmit: (v) {
                                          if (c.textType.value == "Tuỳ chọn") {
                                            c.dateFrom.value = startDate;
                                            c.dateTo.value = endDate;
                                          } else {
                                            c.dateFrom.value =
                                                DateTime.parse("$v");
                                            c.dateTo.value =
                                                DateTime.parse("$v");
                                          }
                                          onChange(
                                              SahaDateUtils()
                                                  .getDate(c.dateFrom.value),
                                              SahaDateUtils()
                                                  .getDate(c.dateTo.value));
                                          Get.back();
                                        },
                                        showActionButtons: true,
                                        onSelectionChanged: chooseRangeTime,
                                        selectionMode: c.textType.value ==
                                                "Tuỳ chọn"
                                            ? DateRangePickerSelectionMode.range
                                            : DateRangePickerSelectionMode
                                                .single,
                                        initialSelectedRange:  PickerDateRange(
                                                c.dateFrom.value,
                                                c.dateTo.value,
                                              ),
                                        initialSelectedDate: c.dateFrom.value,
                                        initialDisplayDate: c.dateFrom.value,
                                        maxDate: isAllPickDate == true
                                            ? null
                                            : DateTime.now(),
                                      ),
                                    ),
                                  );
                                });
                          }
                        },
                        child: c.textType.value == "Tuỳ chọn"
                            ? c.dateFrom.value.isAtSameMomentAs(c.dateTo.value)
                                ? Text(
                                    "${SahaDateUtils().getDDMMYY4(c.dateFrom.value)}")
                                : Text(
                                    "${SahaDateUtils().getDDMMYY4(c.dateFrom.value)} - ${SahaDateUtils().getDDMMYY4(c.dateTo.value)}")
                            : SahaDateUtils()
                                    .getDate(c.dateFrom.value)
                                    .isAtSameMomentAs(
                                        SahaDateUtils().getDate(c.dateTo.value))
                                ? Text(
                                    "${SahaDateUtils().getDDMMYY4(c.dateFrom.value)}")
                                : Text(
                                    "${c.dateFrom.value.day.toString().length == 1 ? "0${c.dateFrom.value.day}" : c.dateFrom.value.day} - ${SahaDateUtils().getDDMMYY4(c.dateTo.value)}"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          c.controllerDate(isNext: true);
                          print(c.dateFrom.value);
                          print(c.dateTo.value);
                          c.dateFrom.refresh();
                          onChange(SahaDateUtils().getDate(c.dateFrom.value),
                              SahaDateUtils().getDate(c.dateTo.value));
                        },
                        child: Icon(Icons.arrow_forward_ios, size: 18)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }

  void showDialogTextType() {
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
                    "Chọn kiểu ngày",
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
                children: [
                  ...c.listType
                      .map(
                        (e) => Column(
                          children: [
                            ListTile(
                              title: Text(
                                "$e",
                              ),
                              onTap: () async {
                                c.textType.value = e;
                                c.changeType();
                                if (c.textType.value == "Tuỳ chọn") {
                                  Get.back();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Container(
                                            width: Get.width * 0.9,
                                            height: Get.height * 0.5,
                                            child: SfDateRangePicker(
                                              onCancel: () {
                                                Get.back();
                                              },
                                              onSubmit: (v) {
                                                c.dateFrom.value = startDate;
                                                c.dateTo.value = endDate;

                                                onChange(
                                                    SahaDateUtils().getDate(
                                                        c.dateFrom.value),
                                                    SahaDateUtils().getDate(
                                                        c.dateTo.value));
                                                Get.back();
                                              },
                                              showActionButtons: true,
                                              onSelectionChanged:
                                                  chooseRangeTime,
                                              selectionMode:
                                                  DateRangePickerSelectionMode
                                                      .range,
                                              initialSelectedRange:
                                                  PickerDateRange(
                                                c.dateFrom.value,
                                                c.dateTo.value,
                                              ),
                                              maxDate: DateTime.now(),
                                            ),
                                          ),
                                        );
                                      });
                                } else {
                                  onChange(
                                      SahaDateUtils().getDate(c.dateFrom.value),
                                      SahaDateUtils().getDate(c.dateTo.value));
                                  Get.back();
                                }
                              },
                              trailing: c.textType.value == e
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
                      )
                      .toList(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  void chooseRangeTime(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      startDate = args.value.startDate;
      endDate = args.value.endDate ?? args.value.startDate;
    }
  }
}
