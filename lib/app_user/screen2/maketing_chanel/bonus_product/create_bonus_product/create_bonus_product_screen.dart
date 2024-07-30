import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/model/bonus_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/utils/keyboard.dart';
import '../../../../components/saha_user/dialog/dialog.dart';
import '../search_bonus_product/search_bonus_product_screen.dart';
import '../update_bonus_product/list_bonus_product/list_bonus_product_screen.dart';
import 'Widget/dialog_bonus.dart';
import 'create_bonus_product_controller.dart';

class CreateBonusProductScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  BonusProduct? bonusProductInput;
  bool? isWatch;

  CreateBonusProductScreen({this.bonusProductInput, this.isWatch}) {
    createBonusProductController =
        CreateBonusProductController(bonusProductInput: bonusProductInput);
  }

  late CreateBonusProductController createBonusProductController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Tặng thưởng sản phẩm'),
        ),
        body: Obx(
          () => SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: IgnorePointer(
              ignoring: isWatch == true ? true : false,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          right: 10, left: 10, bottom: 5, top: 5),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("Thưởng theo bậc thang")),
                          Obx(() => CupertinoSwitch(
                              value: createBonusProductController
                                  .ladderReward.value,
                              onChanged: (v) {
                                createBonusProductController
                                        .ladderReward.value =
                                    !createBonusProductController
                                        .ladderReward.value;
                              })),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SahaDialogApp.showDialogGroupMarketingTypev2(
                            onChoose: (v) {
                              if (createBonusProductController.group
                                  .contains(v)) {
                                createBonusProductController.group.remove(v);
                                createBonusProductController.group.refresh();
                                if (v == 2) {
                                  createBonusProductController
                                      .agencyType.value = [];
                                }
                                if (v == 4) {
                                  createBonusProductController
                                      .groupCustomer.value = [];
                                }
                              } else {
                                createBonusProductController.group.add(v);
                                createBonusProductController.group.refresh();
                              }
                            },
                            groupType: createBonusProductController.group);
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Nhóm áp dụng: '),
                                    Expanded(
                                      child: Text(
                                        '${createBonusProductController.group.contains(0) ? "Tất cả," : ""}${createBonusProductController.group.contains(1) ? "Cộng tác viên," : ""}${createBonusProductController.group.contains(2) ? "Đại lý," : ""} ${createBonusProductController.group.contains(4) ? "Nhóm khách hàng" : ""}${createBonusProductController.group.contains(5) ? "Khách lẻ đã đăng nhập," : ""}${createBonusProductController.group.contains(6) ? "Khách lẻ chưa đăng nhập" : ""}',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded),
                          ],
                        ),
                      ),
                    ),
                    Obx(() => createBonusProductController.group.contains(2)
                        ? InkWell(
                            onTap: () {
                              SahaDialogApp.showDialogAgencyTypev2(
                                  onChoose: (v) {
                                    if (createBonusProductController.agencyType
                                        .contains(v)) {
                                      createBonusProductController.agencyType
                                          .remove(v);
                                    } else {
                                      createBonusProductController.agencyType
                                          .add(v);
                                    }
                                  },
                                  type: createBonusProductController.agencyType
                                      .map((e) => e.id ?? 0)
                                      .toList(),
                                  listAgencyType: createBonusProductController
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Chọn cấp đại lý: '),
                                          Expanded(
                                            child: Text(
                                              createBonusProductController
                                                      .agencyType.isEmpty
                                                  ? ""
                                                  : "${createBonusProductController.agencyType.map((e) => "${e.name},")}",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
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
                    Obx(() => createBonusProductController.group.contains(4)
                        ? InkWell(
                            onTap: () {
                              SahaDialogApp.showDialogCustomerGroupTypev2(
                                  onChoose: (v) {
                                    if (createBonusProductController
                                        .groupCustomer
                                        .contains(v)) {
                                      createBonusProductController.groupCustomer
                                          .remove(v);
                                    } else {
                                      createBonusProductController.groupCustomer
                                          .add(v);
                                    }
                                  },
                                  type: createBonusProductController
                                      .groupCustomer
                                      .map((e) => e.id ?? 0)
                                      .toList(),
                                  listGroupCustomer:
                                      createBonusProductController.listGroup
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
                                          Text('Chọn nhóm khách hàng: '),
                                          Expanded(
                                            child: Text(
                                              createBonusProductController
                                                      .groupCustomer.isEmpty
                                                  ? ""
                                                  : "${createBonusProductController.groupCustomer.map((e) => "${e.name},")}",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
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
                          Text('Tên chương trình'),
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
                              controller: createBonusProductController
                                  .nameProgramEditingController,
                              validator: (value) {
                                if (value!.length < 1) {
                                  return 'Chưa nhập tên chương trình';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText:
                                    "Nhập tên chương trình khuyến mãi tại đây",
                              ),
                              style: TextStyle(fontSize: 14),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
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
                                      onConfirm: (date) {
                                    createBonusProductController
                                        .onChangeDateStart(date);
                                  },
                                      currentTime: DateTime.now(),
                                      locale: dp.LocaleType.vi);
                                },
                                child: Text(
                                  '${SahaDateUtils().getDDMMYY(createBonusProductController.dateStart.value)}',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                   dp. DatePicker.showTime12hPicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        print('change $date in time zone ' +
                                            date.timeZoneOffset.inHours
                                                .toString());
                                      },
                                      onConfirm: (date) {
                                        var timeCheck = DateTime(
                                            createBonusProductController
                                                .dateStart.value.year,
                                            createBonusProductController
                                                .dateStart.value.month,
                                            createBonusProductController
                                                .dateStart.value.day,
                                            date.hour,
                                            date.minute,
                                            date.second);
                                        if (DateTime.now().isAfter(timeCheck) ==
                                            true) {
                                          createBonusProductController
                                              .checkDayStart.value = true;
                                          createBonusProductController
                                              .timeStart.value = date;
                                        } else {
                                          createBonusProductController
                                              .checkDayStart.value = false;
                                          createBonusProductController
                                              .timeStart.value = date;
                                        }
                                      },
                                      currentTime: DateTime.now(),
                                      locale: dp.LocaleType.vi,
                                    );
                                  },
                                  child: Text(
                                    '  ${SahaDateUtils().getHHMM(createBonusProductController.timeStart.value)}',
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    createBonusProductController.checkDayStart.value
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
                                              color: Colors.black,
                                              fontSize: 16)),
                                      onChanged: (date) {}, onConfirm: (date) {
                                    createBonusProductController
                                        .onChangeDateEnd(date);
                                  },
                                      currentTime: DateTime.now(),
                                      locale: dp.LocaleType.vi);
                                },
                                child: Text(
                                  '${SahaDateUtils().getDDMMYY(createBonusProductController.dateEnd.value)}',
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
                                        createBonusProductController
                                            .onChangeTimeEnd(date);
                                      },
                                      currentTime: DateTime.now(),
                                      locale: dp.LocaleType.vi,
                                    );
                                  },
                                  child: Text(
                                    '  ${SahaDateUtils().getHHMM(createBonusProductController.timeEnd.value)}',
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    createBonusProductController.checkDayEnd.value
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
                    SizedBox(
                      height: 8,
                    ),
                    if (createBonusProductController.ladderReward.value ==
                        false)
                      Container(
                        padding: EdgeInsets.only(
                            right: 10, left: 10, bottom: 5, top: 5),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child:
                                    Text("Hàng tặng nhân theo số lượng mua")),
                            Obx(() => CupertinoSwitch(
                                value: createBonusProductController
                                    .multiProduct.value,
                                onChanged: (v) {
                                  createBonusProductController
                                          .multiProduct.value =
                                      !createBonusProductController
                                          .multiProduct.value;
                                })),
                          ],
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giới hạn tặng"),
                          Container(
                            width: Get.width * 0.6,
                            child: TextFormField(
                              controller: createBonusProductController
                                  .amountCodeAvailableEditingController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Giới hạn tặng có thể sử dụng",
                              ),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Obx(
                        () =>
                            bonusProductInput != null &&
                                    createBonusProductController
                                            .ladderReward.value ==
                                        false
                                ?  Card(
                                    child: ListTile(
                                      onTap: () {
                                        Get.to(() => ListBonusProductScreen(
                                              updateBonusProductId:
                                                  bonusProductInput!.id!,
                                            ));
                                      },
                                      title: Text("Cài đặt danh sách thưởng"),
                                      trailing:
                                          Icon(Icons.keyboard_arrow_right),
                                    ),
                                  ):Column(
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        width: Get.width,
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Obx(
                                              () => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0,
                                                            bottom: 10),
                                                    child: Text("Sản phẩm mua"),
                                                  ),
                                                  if (createBonusProductController
                                                          .ladderReward ==
                                                      false)
                                                    createBonusProductController
                                                                .listSelectedProduct
                                                                .length ==
                                                            0
                                                        ? Container()
                                                        : IconButton(
                                                            icon: Icon(
                                                              Icons.add,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                            onPressed: () {
                                                              Get.to(
                                                                () =>
                                                                    SearchBonusProductScreen(
                                                                  isSearch:
                                                                      false,
                                                                  listBonusProductSelected:
                                                                      createBonusProductController
                                                                          .listSelectedProduct
                                                                          .toList(),
                                                                  onChoose: (List<
                                                                              BonusProductSelected>
                                                                          listBonusProductSelected,
                                                                      bool?
                                                                          clickDone) {
                                                                    Get.back();
                                                                    if (clickDone ==
                                                                        true) {
                                                                      createBonusProductController
                                                                          .listSelectedProduct(
                                                                              listBonusProductSelected);
                                                                    } else {
                                                                      if (createBonusProductController
                                                                          .listSelectedProduct
                                                                          .isNotEmpty) {
                                                                        createBonusProductController
                                                                            .listSelectedProduct
                                                                            .addAll(listBonusProductSelected);
                                                                      } else {
                                                                        createBonusProductController
                                                                            .listSelectedProduct(listBonusProductSelected);
                                                                      }
                                                                    }
                                                                  },
                                                                ),
                                                              );
                                                            })
                                                ],
                                              ),
                                            ),
                                            Obx(
                                              () => createBonusProductController
                                                          .listSelectedProduct
                                                          .length ==
                                                      0
                                                  ? InkWell(
                                                      onTap: () {
                                                        Get.to(
                                                          () =>
                                                              SearchBonusProductScreen(
                                                            isSearch: true,
                                                            chooseOne: true,
                                                            listBonusProductSelected:
                                                                createBonusProductController
                                                                    .listSelectedProduct
                                                                    .toList(),
                                                            onChoose: (List<
                                                                        BonusProductSelected>
                                                                    listBonusProductSelected,
                                                                bool?
                                                                    clickDone) {
                                                              Get.back();
                                                              if (clickDone ==
                                                                  true) {
                                                                createBonusProductController
                                                                    .listSelectedProduct(
                                                                        listBonusProductSelected);
                                                              } else {
                                                                if (createBonusProductController
                                                                    .listSelectedProduct
                                                                    .isNotEmpty) {
                                                                  createBonusProductController
                                                                      .listSelectedProduct
                                                                      .addAll(
                                                                          listBonusProductSelected);
                                                                } else {
                                                                  createBonusProductController
                                                                      .listSelectedProduct(
                                                                          listBonusProductSelected);
                                                                }
                                                              }
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.add,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                            Text(
                                                              'Thêm sản phẩm',
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Obx(
                                                      () => Wrap(
                                                        runSpacing: 5,
                                                        spacing: 5,
                                                        children: [
                                                          ...List.generate(
                                                              createBonusProductController
                                                                  .listSelectedProduct
                                                                  .length,
                                                              (index) {
                                                            var e = createBonusProductController
                                                                    .listSelectedProduct[
                                                                index];
                                                            return Stack(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                Theme.of(context).primaryColor),
                                                                      ),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        height:
                                                                            100,
                                                                        width:
                                                                            Get.width /
                                                                                4,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        imageUrl: e.product?.images?.length ==
                                                                                0
                                                                            ? ""
                                                                            : e.product!.images![0].imageUrl!,
                                                                        errorWidget: (context, url, error) => Container(
                                                                            height: 100,
                                                                            width: Get.width / 4,
                                                                            child: Icon(
                                                                              Icons.image,
                                                                              color: Colors.grey,
                                                                              size: 40,
                                                                            )),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10.0),
                                                                            child:
                                                                                Text(
                                                                              "${e.product?.name ?? ""}",
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ),
                                                                          if (e.elementDistributeName !=
                                                                              null)
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 10.0, right: 10),
                                                                              child: Text("Phân loại: ${e.elementDistributeName ?? ""}${e.subElementDistributeName == null ? "" : ","} ${e.subElementDistributeName == null ? "" : e.subElementDistributeName}"),
                                                                            ),
                                                                          if (createBonusProductController.ladderReward.value ==
                                                                              false)
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                IconButton(
                                                                                    icon: Icon(Icons.remove),
                                                                                    onPressed: () {
                                                                                      createBonusProductController.decreaseProductSelected(index);
                                                                                    }),
                                                                                SizedBox(
                                                                                  width: 20,
                                                                                ),
                                                                                Obx(
                                                                                  () => Text("${createBonusProductController.listSelectedProduct[index].quantity ?? 0}"),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 20,
                                                                                ),
                                                                                IconButton(
                                                                                    icon: Icon(Icons.add),
                                                                                    onPressed: () {
                                                                                      createBonusProductController.increaseProductSelected(index);
                                                                                    }),
                                                                              ],
                                                                            ),
                                                                          if (e.distributeName == null &&
                                                                              e.elementDistributeName == null &&
                                                                              e.allowsAllDistribute == true)
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 10.0),
                                                                              child: Text(
                                                                                'SP cho phép mua mọi phân loại',
                                                                                maxLines: 1,
                                                                                style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.w600),
                                                                              ),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Positioned(
                                                                  top: 0,
                                                                  left: -10,
                                                                  child: IconButton(
                                                                      icon: Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      onPressed: () {
                                                                        createBonusProductController
                                                                            .deleteProductSelected(index);
                                                                      }),
                                                                ),
                                                              ],
                                                            );
                                                          })
                                                        ],
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      createBonusProductController
                                                  .ladderReward.value ==
                                              false
                                          ? Container(
                                              color: Colors.white,
                                              width: Get.width,
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Obx(
                                                    () => Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10.0,
                                                                  bottom: 10),
                                                          child: Text(
                                                              "Sản phẩm tặng"),
                                                        ),
                                                        createBonusProductController
                                                                    .listBonusProductSelected
                                                                    .length ==
                                                                0
                                                            ? Container()
                                                            : IconButton(
                                                                icon: Icon(
                                                                  Icons.add,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ),
                                                                onPressed: () {
                                                                  Get.to(
                                                                    () =>
                                                                        SearchBonusProductScreen(
                                                                      isSearch:
                                                                          true,
                                                                      listBonusProductSelected: createBonusProductController
                                                                          .listBonusProductSelected
                                                                          .toList(),
                                                                      onChoose: (List<BonusProductSelected>
                                                                              listBonusProductSelected,
                                                                          bool?
                                                                              clickDone) {
                                                                        Get.back();
                                                                        if (clickDone ==
                                                                            true) {
                                                                          createBonusProductController
                                                                              .listBonusProductSelected(listBonusProductSelected);
                                                                        } else {
                                                                          if (createBonusProductController
                                                                              .listBonusProductSelected
                                                                              .isNotEmpty) {
                                                                            createBonusProductController.listBonusProductSelected.addAll(listBonusProductSelected);
                                                                          } else {
                                                                            createBonusProductController.listBonusProductSelected(listBonusProductSelected);
                                                                          }
                                                                        }
                                                                      },
                                                                    ),
                                                                  );
                                                                })
                                                      ],
                                                    ),
                                                  ),
                                                  Obx(
                                                    () => createBonusProductController
                                                                .listBonusProductSelected
                                                                .length ==
                                                            0
                                                        ? InkWell(
                                                            onTap: () {
                                                              Get.to(
                                                                () =>
                                                                    SearchBonusProductScreen(
                                                                  isSearch:
                                                                      true,
                                                                  listBonusProductSelected:
                                                                      createBonusProductController
                                                                          .listBonusProductSelected
                                                                          .toList(),
                                                                  onChoose: (List<
                                                                              BonusProductSelected>
                                                                          listBonusProductSelected,
                                                                      bool?
                                                                          clickDone) {
                                                                    Get.back();
                                                                    if (clickDone ==
                                                                        true) {
                                                                      createBonusProductController
                                                                          .listBonusProductSelected(
                                                                              listBonusProductSelected);
                                                                    } else {
                                                                      if (createBonusProductController
                                                                          .listBonusProductSelected
                                                                          .isNotEmpty) {
                                                                        createBonusProductController
                                                                            .listBonusProductSelected
                                                                            .addAll(listBonusProductSelected);
                                                                      } else {
                                                                        createBonusProductController
                                                                            .listBonusProductSelected(listBonusProductSelected);
                                                                      }
                                                                    }
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              height: 100,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor)),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons.add,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                                  Text(
                                                                    'Thêm sản phẩm',
                                                                    style: TextStyle(
                                                                        color: Theme.of(context)
                                                                            .primaryColor),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Obx(
                                                            () => Wrap(
                                                              runSpacing: 5,
                                                              spacing: 5,
                                                              children: [
                                                                ...List.generate(
                                                                    createBonusProductController
                                                                        .listBonusProductSelected
                                                                        .length,
                                                                    (index) {
                                                                  var e = createBonusProductController
                                                                          .listBonusProductSelected[
                                                                      index];
                                                                  return Stack(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(color: Theme.of(context).primaryColor),
                                                                            ),
                                                                            child:
                                                                                CachedNetworkImage(
                                                                              height: 100,
                                                                              width: Get.width / 4,
                                                                              fit: BoxFit.cover,
                                                                              imageUrl: e.product?.images?.length == 0 ? "" : e.product!.images![0].imageUrl!,
                                                                              errorWidget: (context, url, error) => Container(
                                                                                  height: 100,
                                                                                  width: Get.width / 4,
                                                                                  child: Icon(
                                                                                    Icons.image,
                                                                                    color: Colors.grey,
                                                                                    size: 40,
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(10.0),
                                                                                  child: Text(
                                                                                    "${e.product?.name ?? ""}",
                                                                                    maxLines: 2,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: TextStyle(fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ),
                                                                                if (e.elementDistributeName != null)
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                                                                                    child: Text("Phân loại: ${e.elementDistributeName ?? ""}${e.subElementDistributeName == null ? "" : ","} ${e.subElementDistributeName == null ? "" : e.subElementDistributeName}"),
                                                                                  ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    IconButton(
                                                                                        icon: Icon(Icons.remove),
                                                                                        onPressed: () {
                                                                                          createBonusProductController.decreaseBonusProductSelected(index);
                                                                                        }),
                                                                                    SizedBox(
                                                                                      width: 20,
                                                                                    ),
                                                                                    Obx(
                                                                                      () => Text("${createBonusProductController.listBonusProductSelected[index].quantity}"),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 20,
                                                                                    ),
                                                                                    IconButton(
                                                                                        icon: Icon(Icons.add),
                                                                                        onPressed: () {
                                                                                          createBonusProductController.increaseBonusProductSelected(index);
                                                                                        }),
                                                                                  ],
                                                                                ),
                                                                                if (e.allowsChooseDistribute == true)
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(left: 10.0),
                                                                                    child: Text(
                                                                                      'Cho phép tự chọn phân loại',
                                                                                      maxLines: 1,
                                                                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue),
                                                                                    ),
                                                                                  ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Positioned(
                                                                        top: 5,
                                                                        left:
                                                                            -10,
                                                                        child: IconButton(
                                                                            icon: Icon(
                                                                              Icons.delete,
                                                                              color: Colors.red,
                                                                            ),
                                                                            onPressed: () {
                                                                              createBonusProductController.deleteBonusProductSelected(index);
                                                                            }),
                                                                      ),
                                                                    ],
                                                                  );
                                                                })
                                                              ],
                                                            ),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Obx(
                                              () => Container(
                                                padding: EdgeInsets.all(10),
                                                color: Colors.white,
                                                child: Column(
                                                  children: [
                                                    ...(createBonusProductController
                                                                .dataLadder
                                                                .value
                                                                .list ??
                                                            [])
                                                        .map((e) =>
                                                            itemListOffer(e))
                                                        .toList(),
                                                    InkWell(
                                                      onTap: () {
                                                        DialogBonus
                                                            .dialogBonusOffer(
                                                                onAccept:
                                                                    (offer) {
                                                          print(offer);
                                                          (createBonusProductController
                                                                      .dataLadder
                                                                      .value
                                                                      .list ??
                                                                  [])
                                                              .add(offer);
                                                          createBonusProductController
                                                              .dataLadder
                                                              .refresh();
                                                        });
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        width: Get.width,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              'Thêm bậc thưởng',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.grey,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                    ],
                                  )
                                ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: IgnorePointer(
          ignoring: isWatch == true ? true : false,
          child: Container(
            height: 65,
            color: Colors.white,
            child: Column(
              children: [
                Obx(
                  () =>
                      createBonusProductController.isLoadingCreate.value == true
                          ? IgnorePointer(
                            ignoring: false,
                              child: SahaButtonFullParent(
                                text: "Lưu",
                                textColor: Colors.grey[600],
                                onPressed: () {
                                  print("fucujcuccucu");
                                },
                                color: Colors.grey[300],
                              ),
                            )
                          : SahaButtonFullParent(
                              text: "Lưu",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                
                                  KeyboardUtil.hideKeyboard(context);
                                  if (bonusProductInput != null) {
                                   
                                    createBonusProductController
                                        .updateBonusProduct();
                                         
                                      
                                    
                                  } else {
                                    createBonusProductController
                                        .createBonusProduct();
                                  }
                                }
                              },
                              color: Theme.of(context).primaryColor,
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemListOffer(ListOffer listOffer) {
    return InkWell(
      onTap: () {
        DialogBonus.dialogBonusOffer(
            listOfferInput: listOffer,
            onAccept: (offer) {
              var index =
                  (createBonusProductController.dataLadder.value.list ?? [])
                      .map((e) => e.boProductId)
                      .toList()
                      .indexWhere((e) => e == listOffer.boProductId);
              if (index != -1) {
                createBonusProductController.dataLadder.value.list![index] =
                    offer;
                print(createBonusProductController
                    .dataLadder.value.list![index].boProductId);
                createBonusProductController.dataLadder.refresh();
              }
            });
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Mua từ: ${listOffer.fromQuantity ?? 0} Sản phẩm Tặng",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      (createBonusProductController.dataLadder.value.list ?? [])
                          .removeWhere(
                              (e) => e.boProductId == listOffer.boProductId);
                      createBonusProductController.dataLadder.refresh();
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${listOffer.productName ?? ""}"),
                      if (listOffer.boElementDistributeName != null)
                        Text(
                            "Phân loại: ${listOffer.boElementDistributeName ?? ""}${listOffer.boSubElementDistributeName == null ? "" : ","} ${listOffer.boSubElementDistributeName == null ? "" : listOffer.boSubElementDistributeName}"),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Text(
                  "SL: ${listOffer.bonusQuantity ?? 0}",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
