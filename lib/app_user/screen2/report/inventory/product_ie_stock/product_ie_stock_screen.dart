import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/product_last_inventory_res.dart';
import 'package:com.ikitech.store/app_user/screen2/report/choose_time/choose_time_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../components/saha_user/dialog/dialog.dart';
import '../../report_controller.dart';
import 'product_ie_stock_controller.dart';

class ProductIEStockScreen extends StatelessWidget {
  ReportController reportController = Get.find();

  ProductIEStockController productIEStockController =
      ProductIEStockController();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Xuất nhập tồn"),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Get.to(() => ChooseTimeScreen(
                        isCompare: reportController.isCompare.value,
                        initTab: reportController.indexTabTime,
                        initChoose: reportController.indexChooseTime,
                        fromDayInput: reportController.fromDay.value,
                        toDayInput: reportController.toDay.value,
                        hideCompare: true,
                        callback: (DateTime fromDate,
                            DateTime toDay,
                            DateTime fromDateCP,
                            DateTime toDayCP,
                            bool isCompare,
                            int index,
                            int indexChoose) {
                          reportController.fromDay.value = fromDate;
                          reportController.toDay.value = toDay;
                          reportController.fromDayCP.value = fromDateCP;
                          reportController.toDayCP.value = toDayCP;
                          reportController.isCompare.value = isCompare;
                          reportController.indexTabTime = index;
                          reportController.indexChooseTime = indexChoose;
                        },
                      ))!
                  .then((value) => {
                        productIEStockController.getProductIEStock(
                          isRefresh: true,
                        )
                      });
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
                      "${SahaDateUtils().getDDMMYY2(reportController.fromDay.value)} - ${SahaDateUtils().getDDMMYY2(reportController.toDay.value)}",
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
              Obx(
                () => Container(
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
                      Text(
                        "TỒN KHO CUỐI KỲ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${SahaStringUtils().convertToMoney(productIEStockController.allProductIEStock.value.totalAmountEnd ?? 0)}",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text("Tồn kho đầu kỳ"),
                          Spacer(),
                          Text(
                            "${SahaStringUtils().convertToMoney((productIEStockController.allProductIEStock.value.totalAmountBegin ?? 0))}",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text("Nhập trong kỳ"),
                          Spacer(),
                          Text(
                            "${SahaStringUtils().convertToMoney((productIEStockController.allProductIEStock.value.importTotalAmount ?? 0))}",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text("Xuất trong kỳ"),
                          Spacer(),
                          Text(
                            "${SahaStringUtils().convertToMoney(productIEStockController.allProductIEStock.value.exportTotalAmount ?? 0)}",
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Text("SL xuất trong kỳ:"),
                      //     Spacer(),
                      //     Text(
                      //       " ${SahaStringUtils().convertToMoney(productIEStockController.allProductIEStock.value.totalExportCountStock ?? 0)}",
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   children: [
                      //     Text("SL nhập trong kỳ:"),
                      //     Spacer(),
                      //     Text(
                      //       " ${SahaStringUtils().convertToMoney(productIEStockController.allProductIEStock.value.totalImportCountStock ?? 0)}",
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
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
                              "Giá trị tồn cuối kỳ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.blue),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                '= Giá trị tồn đầu kì + Giá trị nhập - Giá trị xuất'),
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
                                    'Giá trị tồn đầu kỳ: Giá trị tồn cuối kỳ trước'),
                                Divider(),
                                Text(
                                    'Giá trị nhập: Bao gồm giá trị của sản phẩm nhập mới, kiểm kê tăng, sản phẩm nhận từ kho khác, hàng trả lại và hàng huỷ giao.'),
                                Divider(),
                                Text(
                                    'Giá trị xuất: Bao gồm giá trị của sản phẩm bán ra, trả NCC, sản phẩm chuyển từ kho khác và kiểm kê giảm.'),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Lưu ý: ',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Giá trị xuất, nhập được tính bằng số lượng sản phẩm tương ứng nhân với giá nhập (đối với giá trị nhập mới, kiểm kê tăng, nhận từ kho khác và trả hàng NCC) hoặc giá vốn (đối với giá trị hàng trả lại, huỷ giao, chuyển từ kho khác và kiểm kê giảm).',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
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
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: MaterialClassicHeader(),
              footer: CustomFooter(
                builder: (
                  BuildContext context,
                  LoadStatus? mode,
                ) {
                  Widget body = Container();
                  if (mode == LoadStatus.idle) {
                    body = Obx(() => productIEStockController.isLoading.value
                        ? CupertinoActivityIndicator()
                        : Container());
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  }
                  return Container(
                    height: 100,
                    child: Center(child: body),
                  );
                },
              ),
              controller: refreshController,
              onRefresh: () async {
                await productIEStockController.getProductIEStock(
                  isRefresh: true,
                );
                refreshController.refreshCompleted();
              },
              onLoading: () async {
                await productIEStockController.getProductIEStock();
                refreshController.loadComplete();
              },
              child: Obx(
                () => SingleChildScrollView(
                  child: Column(
                    children: productIEStockController.listProduct
                        .map((e) => itemProduct(e))
                        .toList(),
                  ),
                ),
              ),
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
                        product.images != null && product.images!.isNotEmpty
                            ? (product.images![0].imageUrl ?? "")
                            : "",
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
              ],
            ),
          ),
          if (product.importExport!.isEmpty)
            SizedBox(
              height: 10,
            ),
          if (product.importExport!.isEmpty)
            Divider(
              height: 1,
            ),
          if (product.importExport!.isEmpty)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Nhập: ${SahaStringUtils().convertToMoney(product.mainImportTotalAmount ?? 0)}"),
                        Row(
                          children: [
                            Text("SL:"),
                            Text(
                              " ${SahaStringUtils().convertToMoney(product.mainImportCountStock ?? 0)}",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Xuất: ${SahaStringUtils().convertToMoney(product.mainExportTotalAmount ?? 0)}"),
                        Row(
                          children: [
                            Text("SL:"),
                            Text(
                              " ${SahaStringUtils().convertToMoney(product.mainExportCountStock ?? 0)}",
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (product.importExport != null && product.importExport!.isNotEmpty)
            Divider(
              height: 1,
            ),
          if (product.importExport != null && product.importExport!.isNotEmpty)
            ...product.importExport![0].elementDistributes!
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
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.inventory,
                        size: 20,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Phân loại: ${elementDistributes.name}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Nhập: ${SahaStringUtils().convertToMoney(elementDistributes.importTotalAmount ?? 0)}"),
                            Row(
                              children: [
                                Text("SL:"),
                                Text(
                                  " ${SahaStringUtils().convertToMoney(elementDistributes.importCountStock ?? 0)}",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Xuất: ${SahaStringUtils().convertToMoney(elementDistributes.exportTotalAmount ?? 0)}"),
                            Row(
                              children: [
                                Text("SL:"),
                                Text(
                                  " ${SahaStringUtils().convertToMoney(elementDistributes.exportCountStock ?? 0)}",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.inventory,
                            size: 20,
                            color: Theme.of(Get.context!).primaryColor,
                          ),
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
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Nhập: ${SahaStringUtils().convertToMoney(e.importTotalAmount ?? 0)}"),
                              Row(
                                children: [
                                  Text("SL:"),
                                  Text(
                                    " ${SahaStringUtils().convertToMoney(e.importCountStock ?? 0)}",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Xuất: ${SahaStringUtils().convertToMoney(e.exportTotalAmount ?? 0)}"),
                              Row(
                                children: [
                                  Text("SL:"),
                                  Text(
                                    " ${SahaStringUtils().convertToMoney(e.exportCountStock ?? 0)}",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
