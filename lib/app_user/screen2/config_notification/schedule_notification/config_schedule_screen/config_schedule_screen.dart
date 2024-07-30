import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/model/schedule_noti.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/category_post.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import '../../../../components/picker/category_post/category_post_picker.dart';
import '../../../../components/picker/post/post_picker.dart';
import '../../../../components/picker/product/product_picker.dart';
import '../../../../components/saha_user/dialog/dialog.dart';
import '../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../const/banner_ads_define.dart';
import '../../../config_app/screens_config/main_component_config/banner_ads/banner_ads_edit_detail/widget/dialog_choose_banner_ads.dart';
import '../../../inventory/categories/category_screen.dart';
import 'config_schedule_controller.dart';

class ConfigScheduleScreen extends StatefulWidget {
  ScheduleNoti? scheduleInput;

  ConfigScheduleScreen({this.scheduleInput});

  @override
  _ConfigScheduleScreenState createState() => _ConfigScheduleScreenState();
}

class _ConfigScheduleScreenState extends State<ConfigScheduleScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  late ConfigScheduleController configScheduleController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    configScheduleController =
        ConfigScheduleController(scheduleInput: widget.scheduleInput);
    typeSchedule = [
      timeRun(),
      Container(),
      dayOfWeek(),
      dayOfMonth(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
              "${widget.scheduleInput != null ? "Chỉnh sửa" : "Lên lịch"}"),
        ),
        body: DirectSelectContainer(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  itemInput(
                      title: "Tiêu đề thông báo:",
                      asset: "assets/icons/title.svg",
                      controller:
                          configScheduleController.titleEditingController,
                      validator: (value) {
                        if (value!.length == 0) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      subText: "Nhập tiêu đề"),
                  SizedBox(
                    height: 10,
                  ),
                  itemInput(
                      title: "Mô tả thông báo:",
                      asset: "assets/icons/description.svg",
                      validator: (value) {
                        if (value!.length == 0) {
                          return 'Không được để trống';
                        }
                        return null;
                      },
                      controller: configScheduleController.desEditingController,
                      subText: "Nhập mô tả"),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Gửi tới:",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: Get.width,
                        child: Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                  child: Padding(
                                      child: DirectSelectList<String>(
                                          onUserTappedListener: () {
                                            _showScaffold();
                                          },
                                          values: configScheduleController
                                              .listSendTo,
                                          defaultItemIndex:
                                              configScheduleController
                                                  .indexSendTo.value,
                                          itemBuilder: (String value) =>
                                              getDropDownMenuItem(value),
                                          focusedItemDecoration:
                                              _getDslDecoration(),
                                          onItemSelectedListener:
                                              (item, index, context) {
                                            FocusScope.of(context).unfocus();
                                            configScheduleController
                                                .indexSendTo.value = index;
                                          }),
                                      padding: EdgeInsets.only(left: 22))),
                              Icon(
                                Icons.unfold_more,
                                color: Colors.blueAccent,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Obx(() => configScheduleController.indexSendTo.value == 2
                          ? InkWell(
                              onTap: () {
                                SahaDialogApp.showDialogAgencyType(
                                    onChoose: (v) {
                                      configScheduleController
                                          .agencyType.value = v;
                                    },
                                    type: configScheduleController
                                        .indexSendTo.value,
                                    listAgencyType: configScheduleController
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
                                                child:
                                                    Text('Chọn cấp đại lý: ')),
                                            Text(
                                                '${configScheduleController.agencyType.value.name ?? ""} '),
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
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Kiểu thông báo:",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: Get.width,
                        child: Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                  child: Padding(
                                      child: DirectSelectList<String>(
                                          onUserTappedListener: () {
                                            _showScaffold();
                                          },
                                          values: configScheduleController
                                              .listTypeSchedule,
                                          defaultItemIndex:
                                              configScheduleController
                                                  .indexTypeSchedule.value,
                                          itemBuilder: (String value) =>
                                              getDropDownMenuItem(value),
                                          focusedItemDecoration:
                                              _getDslDecoration(),
                                          onItemSelectedListener:
                                              (item, index, context) {
                                            FocusScope.of(context).unfocus();
                                            configScheduleController
                                                .indexTypeSchedule
                                                .value = index;
                                          }),
                                      padding: EdgeInsets.only(left: 22))),
                              Icon(
                                Icons.unfold_more,
                                color: Colors.blueAccent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => typeSchedule[
                      configScheduleController.indexTypeSchedule.value]),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => configScheduleController.indexTypeSchedule.value != 0
                        ? Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Thời gian thông báo trong ngày:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          dp.DatePicker.showTime12hPicker(
                                            Get.context!,
                                            showTitleActions: true,
                                            onChanged: (date) {
                                              print(
                                                  'change $date in time zone ' +
                                                      date.timeZoneOffset
                                                          .inHours
                                                          .toString());
                                            },
                                            onConfirm: (date) {
                                              configScheduleController
                                                  .timeNotificationDay
                                                  .value = date;
                                              print(TimeOfDay.fromDateTime(date)
                                                  .format(context));
                                            },
                                            currentTime:
                                                configScheduleController
                                                    .timeNotificationDay.value,
                                            locale: dp.LocaleType.vi,
                                          );
                                        },
                                        child: Text(
                                          '  ${SahaDateUtils().getHHMM(configScheduleController.timeNotificationDay.value)}',
                                          style: TextStyle(color: Colors.blue),
                                        )),
                                    Icon(
                                      Icons.unfold_more,
                                      color: Colors.blueAccent,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Khi click vào thông báo chuyển hướng tới:",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  InkWell(
                    onTap: () {
                      DialogBannerAds.showTypeAction(
                          typeActionInput:
                              configScheduleController.typeAction.value,
                          onTap: (t) {
                            configScheduleController.typeAction.value = t;
                            configScheduleController.reminiscentName.value = "";
                            configScheduleController.valueAction.value = "";
                            Get.back();
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => Text(
                                mapDefineTypeAction[configScheduleController
                                        .typeAction.value] ??
                                    'Chọn chuyển hướng',
                                style: TextStyle(
                                  color: mapDefineTypeAction[
                                              configScheduleController
                                                  .typeAction.value] ==
                                          null
                                      ? Colors.red
                                      : null,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: showValueBox(),
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
                text:
                    "${widget.scheduleInput != null ? "Cập nhật" : "Xác nhận"}",
                onPressed: configScheduleController.pushing.value
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.scheduleInput != null) {
                            configScheduleController.updateScheduleNoti();
                          } else {
                            configScheduleController.setScheduleNoti();
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

  Widget showValueBox() {
    var codeCurrent = configScheduleController.typeAction.value;
    if (codeCurrent == "LINK") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nhập địa chỉ Website",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  controller: configScheduleController.textEditingController,
                  decoration: new InputDecoration(
                    prefixText: "https://",
                  ),
                  onSubmitted: (v) {
                    if (GetUtils.isURL(v)) {
                      configScheduleController.valueAction.value = "https://$v";
                    } else {
                      configScheduleController.textEditingController.text = "";
                      configScheduleController.reminiscentName.value = '';
                      SahaAlert.showError(
                          message: "Không tồn tại địa chỉ web này");
                    }
                  },
                ),
              )
            ],
          ),
        ],
      );
    } else if (codeCurrent == "PRODUCT") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chọn Sản phẩm",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              configScheduleController.typeAction.value = 'PRODUCT';
              addValueAction('PRODUCT');
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: Theme.of(Get.context!).primaryColor)),
              child: Center(
                child: Obx(
                  () => Text(
                    "${configScheduleController.reminiscentName.value == "" ? "Nhấn chọn" : configScheduleController.reminiscentName.value}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (codeCurrent == "CATEGORY_PRODUCT") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chọn Danh mục sản phẩm",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              configScheduleController.typeAction.value = 'CATEGORY_PRODUCT';
              addValueAction('CATEGORY_PRODUCT');
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: Theme.of(Get.context!).primaryColor)),
              child: Center(
                child: Obx(
                  () => Text(
                    "${configScheduleController.reminiscentName.value == "" ? "Nhấn chọn" : configScheduleController.reminiscentName.value}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (codeCurrent == "POST") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chọn Bài viết",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              configScheduleController.typeAction.value = 'POST';
              addValueAction('POST');
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: Theme.of(Get.context!).primaryColor)),
              child: Center(
                child: Obx(
                  () => Text(
                    "${configScheduleController.reminiscentName.value == "" ? "Nhấn chọn" : configScheduleController.reminiscentName.value}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (codeCurrent == "CATEGORY_POST") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chọn Danh mục bài viết",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              configScheduleController.typeAction.value = 'CATEGORY_POST';
              addValueAction('CATEGORY_POST');
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: Theme.of(Get.context!).primaryColor)),
              child: Center(
                child: Obx(
                  () => Text(
                    "${configScheduleController.reminiscentName.value == "" ? "Nhấn chọn" : configScheduleController.reminiscentName.value}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  void addValueAction(String typeAction) async {
    if (typeAction == 'LINK') {}
    if (typeAction == 'PRODUCT') {
      List<Product>? productsCheck;
      await Get.to(() => ProductPickerScreen(
                listProductInput: [],
                onlyOne: true,
                callback: (List<Product> products) {
                  if (products.length > 1) {
                    SahaAlert.showError(message: "Chọn tối đa 1 sản phẩm");
                  } else {
                    productsCheck = products;
                    configScheduleController.valueAction.value =
                        products[0].id.toString();
                    configScheduleController.reminiscentName.value =
                        products[0].name.toString();
                  }
                },
              ))!
          .then((value) => {
                if (productsCheck != null && productsCheck!.length > 1)
                  {
                    SahaAlert.showError(message: "Chọn tối đa 1 sản phẩm"),
                  }
              });
      return;
    }

    if (typeAction == 'CATEGORY_PRODUCT') {
      await Get.to(() => CategoryScreen(
                isSelect: true,
              ))!
          .then((categories) {
        List<Category> categories2 = categories["list_cate"];
        if (categories2.length > 1) {
          SahaAlert.showError(message: "Chọn tối đa 1 Danh mục");
        } else if (categories2.length == 1) {
          print(categories);
          configScheduleController.valueAction.value =
              categories2[0].id.toString();
          configScheduleController.reminiscentName.value =
              categories2[0].name.toString();
        }
      });
      return;
    }

    if (typeAction == 'POST') {
      await Get.to(() => PostPickerScreen(
            listPostInput: [],
            onlyOne: true,
            callback: (List<Post> post) {
              if (post.length > 1 || post.length == 0) {
                SahaAlert.showError(message: "Chọn tối đa 1 Bài viết");
              } else {
                configScheduleController.valueAction.value =
                    post[0].id.toString();
                configScheduleController.reminiscentName.value =
                    post[0].title.toString();
              }
            },
          ));
      return;
    }

    if (typeAction == 'CATEGORY_POST') {
      await Get.to(() => CategoryPostPickerScreen(
                isSelect: true,
              ))!
          .then((categories) {
        List<CategoryPost> categories2 = categories;
        if (categories2.length == 1) {
          configScheduleController.valueAction.value =
              categories2[0].id.toString();
          configScheduleController.reminiscentName.value =
              categories2[0].title.toString();
        } else if (categories2.length > 1) {
          SahaAlert.showError(message: "Chọn tối đa 1 Danh mục bài viết");
        }
      });
      return;
    }
  }

  late List<Widget> typeSchedule;

  Widget timeRun() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Thời gian thông báo:',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  dp.DatePicker.showDatePicker(Get.context!,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2050, 1, 1),
                      theme: dp.DatePickerTheme(
                          headerColor: Colors.white,
                          backgroundColor: Colors.white,
                          itemStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.black, fontSize: 16)),
                      onConfirm: (date) {
                    configScheduleController.onChangeDate(date);
                  },
                      currentTime:
                          configScheduleController.dateNotification.value,
                      locale: dp.LocaleType.vi);
                },
                child: Obx(
                  () => Text(
                    '${SahaDateUtils().getDDMMYY(configScheduleController.dateNotification.value)}',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    dp.DatePicker.showTime12hPicker(
                      Get.context!,
                      showTitleActions: true,
                      onChanged: (date) {
                        print('change $date in time zone ' +
                            date.timeZoneOffset.inHours.toString());
                      },
                      onConfirm: (date) {
                        print('confirm $date');
                        configScheduleController.timeNotification.value = date;
                      },
                      currentTime:
                          configScheduleController.timeNotification.value,
                      locale: dp.LocaleType.vi,
                    );
                  },
                  child: Obx(
                    () => Text(
                      '  ${SahaDateUtils().getHHMM(configScheduleController.timeNotification.value)}',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget dayOfWeek() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Chọn ngày:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          height: 50,
          width: Get.width,
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        child: DirectSelectList<String>(
                            onUserTappedListener: () {
                              _showScaffold();
                            },
                            values: configScheduleController.listDayWeek,
                            defaultItemIndex:
                                configScheduleController.indexOfWeek.value,
                            itemBuilder: (String value) =>
                                getDropDownMenuItem(value),
                            focusedItemDecoration: _getDslDecoration(),
                            onItemSelectedListener: (item, index, context) {
                              FocusScope.of(context).unfocus();
                              configScheduleController.indexOfWeek.value =
                                  index;
                            }),
                        padding: EdgeInsets.only(left: 22))),
                Icon(
                  Icons.unfold_more,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget dayOfMonth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Chọn ngày:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          height: 50,
          width: Get.width,
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        child: DirectSelectList<String>(
                            onUserTappedListener: () {
                              _showScaffold();
                            },
                            values: configScheduleController.listDayMonth,
                            defaultItemIndex:
                                configScheduleController.indexOfMonth.value,
                            itemBuilder: (String value) =>
                                getDropDownMenuItem(value),
                            focusedItemDecoration: _getDslDecoration(),
                            onItemSelectedListener: (item, index, context) {
                              FocusScope.of(context).unfocus();
                              configScheduleController.indexOfMonth.value =
                                  index;
                            }),
                        padding: EdgeInsets.only(left: 22))),
                Icon(
                  Icons.unfold_more,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showScaffold() {
    SahaAlert.showError(message: 'Giữ và kéo thay vì chạm');
  }

  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value);
        });
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  Widget itemInput(
      {required String title,
      required String subText,
      required String asset,
      TextEditingController? controller,
      TextInputType? keyboardType,
      String? Function(String?)? validator,
      Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        Divider(
          height: 1,
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: subText,
                        hintStyle:
                            TextStyle(fontSize: 14, color: Colors.grey[500])),
                    validator: validator,
                    style: TextStyle(fontSize: 15),
                    minLines: 1,
                    maxLines: 5,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
