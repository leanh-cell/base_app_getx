import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/product_last_inventory_res.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../components/saha_user/dialog/dialog.dart';
import 'import_stock_report_controller.dart';

class ImportStockReportScreen extends StatefulWidget {
  @override
  State<ImportStockReportScreen> createState() =>
      _ImportStockReportScreenState();
}

class _ImportStockReportScreenState extends State<ImportStockReportScreen> {
  ImportStockReportController importStockReportController =
      ImportStockReportController();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          importStockReportController.isLoading.value == false) {
        importStockReportController.getProductLastInventory();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Báo cáo tồn kho"),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              dp.DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(1999, 1, 1),
                  maxTime: DateTime.now(),
                  theme: dp.DatePickerTheme(
                      headerColor: Colors.white,
                      backgroundColor: Colors.white,
                      itemStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      doneStyle: TextStyle(color: Colors.black, fontSize: 16)),
                  onChanged: (date) {}, onConfirm: (date) {
                importStockReportController.date.value = date;
                importStockReportController.getProductLastInventory(
                    isRefresh: true);
              },
                  currentTime: importStockReportController.date.value,
                  locale: dp.LocaleType.vi);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Obx(
                    () => Text(
                      "${SahaDateUtils().getDDMMYY(importStockReportController.date.value)}",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded)
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 10, right: 10),
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Icon(
                        Icons.inventory,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "GIÁ TRỊ TỒN KHO",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Obx(
                      () => Text(
                        "${SahaStringUtils().convertToMoney(importStockReportController.totalValueStock.value)}",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        "Số lượng tồn: ${SahaStringUtils().convertToMoney(importStockReportController.totalStock.value)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20,
                top: 5,
                child: InkWell(
                  onTap: () {
                    SahaDialogApp.showDialogSuggestion(
                        title: 'Chú giải thông số',
                        contentWidget: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Divider(),
                            Text(
                              "Giá vốn",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text('='),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          'Giá trị tồn kho + Giá trị nhập kho'),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 1,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text('SL tồn kho + SL nhập kho'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Trong đó:',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Giá vốn: là giá vốn bình quân sau mỗi lần nhập, được tính riêng cho từng sản phẩm ứng với từng kho hàng. Giá vốn này dùng để ghi nhận lãi lỗ của cửa hàng.'),
                                Divider(),
                                Text(
                                    'Giá trị tồn kho = Số lượng tồn kho trước nhập x Giá vốn trước nhập'),
                                Divider(),
                                Text(
                                    'Giá trị nhập kho = Số lượng nhập kho x Giá nhập kho đã phân bổ chi phí'),
                              ],
                            )
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
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: importStockReportController.listProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    return itemProduct(
                        importStockReportController.listProduct[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemProduct(ProductLastInventory product) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    imageUrl:
                        "${product.images != null && product.images!.isNotEmpty ? product.images![0].imageUrl : ""}",
                    placeholder: (context, url) => new SahaLoadingWidget(
                      size: 20,
                    ),
                    errorWidget: (context, url, error) => new Icon(
                      Icons.image,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product.name}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                if (product.distributeStock != null &&
                    product.distributeStock!.isEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Text(
                          "${SahaStringUtils().convertToMoney((product.mainStock?.stock ?? 0) * (product.mainStock?.costOfCapital ?? 0))}",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Text(
                          "SL tồn: ${product.mainStock?.stock ?? 0}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Text(
                          "Giá vốn: ${SahaStringUtils().convertToMoney(product.mainStock?.costOfCapital ?? 0)}",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (product.distributeStock != null &&
              product.distributeStock!.isNotEmpty)
            SizedBox(
              height: 10,
            ),
          if (product.distributeStock != null &&
              product.distributeStock!.isNotEmpty)
            Divider(
              height: 1,
            ),
          if (product.distributeStock != null &&
              product.distributeStock!.isNotEmpty)
            ...product.distributeStock![0].elementDistributes!
                .map((e) => itemDistribute(e))
                .toList(),
        ],
      ),
    );
  }

  Widget itemDistribute(ElementDistributes elementDistributes) {
    return Column(
      children: [
        if (elementDistributes.subElementDistribute == null ||
            elementDistributes.subElementDistribute!.isEmpty)
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.inventory,
                    size: 20,
                    color: Theme.of(Get.context!).primaryColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phân loại: ${elementDistributes.name}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        "${SahaStringUtils().convertToMoney((elementDistributes.stock ?? 0) * (elementDistributes.priceCapital ?? 0))}",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        "SL tồn: ${elementDistributes.stock ?? 0}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        "Giá vốn: ${SahaStringUtils().convertToMoney(elementDistributes.priceCapital ?? 0)}",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ...elementDistributes.subElementDistribute!
            .map(
              (e) => Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.inventory,
                            size: 20,
                            color: Theme.of(Get.context!).primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Phân loại: ${!(elementDistributes.subElementDistribute == null || elementDistributes.subElementDistribute!.isEmpty) ? "${elementDistributes.name}," : ""} ${e.name}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text(
                                "${SahaStringUtils().convertToMoney((e.stock ?? 0) * (e.priceCapital ?? 0))}",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text(
                                "SL tồn: ${e.stock ?? 0}",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12),
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text(
                                "Giá vốn: ${SahaStringUtils().convertToMoney(e.priceCapital ?? 0)}",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  )
                ],
              ),
            )
            .toList(),
        Divider(
          height: 1,
        )
      ],
    );
  }
}
