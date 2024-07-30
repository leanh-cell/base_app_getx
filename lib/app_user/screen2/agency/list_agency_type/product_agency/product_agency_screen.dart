import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty_widget/empty_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_widget.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../../saha_data_controller.dart';
import '../../../../components/saha_user/button/saha_button.dart';
import '../../../../components/saha_user/dialog/dialog.dart';
import '../../../../model/agency_type.dart';
import '../../../../utils/debounce.dart';
import '../../../inventory/product/filter/filter_screen.dart';
import 'edit_price/edit_price_screen.dart';
import 'product_agency_controller.dart';

class ProductAgencyScreen extends StatelessWidget {
  AgencyType agencyTypeRequest;

  ProductAgencyScreen({required this.agencyTypeRequest}) {
    productAgencyController =
        ProductAgencyController(agencyTypeRequest: agencyTypeRequest);
  }

  late ProductAgencyController productAgencyController;
  RefreshController _refreshController = RefreshController();
  TextEditingController searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(left: 10),
          height: 40,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
          child: TextFormField(
            controller: searchEditingController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(right: 15, top: 15, bottom: 10),
              border: InputBorder.none,
              hintText: "Tìm kiếm",
              suffixIcon: IconButton(
                onPressed: () {
                  searchEditingController.clear();
                  productAgencyController.getAllProduct(
                      isRefresh: true, search: "");
                },
                icon: Icon(
                  Icons.clear,
                ),
              ),
            ),
            onChanged: (v) async {
              EasyDebounce.debounce(
                  'product_agency_screen', Duration(milliseconds: 300), () {
                productAgencyController.getAllProduct(search: v);
              });
            },
            minLines: 1,
            maxLines: 1,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => FilterScreen(
                      categoryInput: productAgencyController.categoryChoose,
                      categoryChildInput:
                          productAgencyController.categoryChildChoose,
                      onFilter: (List<Category>? categoryChooses,
                          List<Category>? categoryChildChooses,bool isNearOutOfStock) {
                        print(categoryChooses);
                        print(categoryChildChooses);
                        productAgencyController.categoryChoose =
                            categoryChooses;
                        productAgencyController.categoryChildChoose =
                            categoryChildChooses;
                     
                        productAgencyController.getAllProduct(isRefresh: true);
                         Get.back();
                      },
                    ));
              },
              icon: Icon(
                  ((productAgencyController.categoryChoose ?? []).isNotEmpty ||
                          (productAgencyController.categoryChildChoose ?? [])
                              .isNotEmpty)
                      ? Icons.filter_alt_rounded
                      : Icons.filter_alt_outlined)),
        ],
      ),
      body: Obx(
        () => productAgencyController.loading.value
            ? SahaLoadingFullScreen()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              productAgencyController.typeChoose(1);
                              productAgencyController.isShowCheckbox.value =
                                  true;
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: productAgencyController
                                                  .typeChoose.value ==
                                              1
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey)),
                              child: Obx(
                                () => Row(
                                  children: [
                                    Text(
                                      'Thiết lập hoa hồng',
                                      style: TextStyle(
                                          color: productAgencyController
                                                      .typeChoose.value ==
                                                  1
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey),
                                    ),
                                    if (productAgencyController
                                            .typeChoose.value ==
                                        1)
                                      SizedBox(
                                        width: 10,
                                      ),
                                    if (productAgencyController
                                            .typeChoose.value ==
                                        1)
                                      Icon(
                                        Icons.check,
                                        color: Theme.of(context).primaryColor,
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              productAgencyController.typeChoose(2);
                              productAgencyController.isShowCheckbox.value =
                                  true;
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: productAgencyController
                                                    .typeChoose.value ==
                                                2
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey)),
                                child: Row(
                                  children: [
                                    Text(
                                      'Thiết lập giá đại lý',
                                      style: TextStyle(
                                          color: productAgencyController
                                                      .typeChoose.value ==
                                                  2
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey),
                                    ),
                                    if (productAgencyController
                                            .typeChoose.value ==
                                        2)
                                      SizedBox(
                                        width: 10,
                                      ),
                                    if (productAgencyController
                                            .typeChoose.value ==
                                        2)
                                      Icon(
                                        Icons.check,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => productAgencyController.typeChoose.value != 0
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(
                                        () => Text(
                                          'Đã chọn (${productAgencyController.listProductChoose.length})',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          SahaDialogApp.showDialogInputText(
                                              title: "Nhập phần trăm thiết lập",
                                              textButton: "Xác nhận",
                                              autoFocus: true,
                                              keyboardType:
                                                  TextInputType.number,
                                              onDone: (percent) {
                                                if (productAgencyController
                                                        .typeChoose.value ==
                                                    1) {
                                                  productAgencyController
                                                      .editPercentAgency(
                                                          percentAgency:
                                                              double.tryParse(
                                                                      percent) ??
                                                                  0,
                                                          isAll: true);
                                                } else {
                                                  productAgencyController
                                                      .editAllPrice(
                                                          double.tryParse(
                                                                  percent) ??
                                                              0);
                                                }
                                                Get.back();
                                              });
                                        },
                                        child: Text(
                                          'Toàn hệ thống',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                    Container(
                      height: 8,
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      width: Get.width,
                      color: Colors.grey[200],
                    ),
                    Expanded(
                      child: Obx(() {
                        var list = productAgencyController.listProduct
                            .toList()
                            .toList();
                        if (list == null || list.length == 0) {
                          return SahaEmptyWidget(
                            tile: "Không có sản phẩm nào",
                          );
                        }
                        return SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          header: MaterialClassicHeader(),
                          onRefresh: () async {
                            await productAgencyController.getAllProduct(
                                isRefresh: true);
                            _refreshController.refreshCompleted();
                          },
                          footer: CustomFooter(
                            builder: (
                              BuildContext context,
                              LoadStatus? mode,
                            ) {
                              Widget body = Container();
                              if (mode == LoadStatus.idle) {
                                return Container();
                              } else if (mode == LoadStatus.loading) {
                                body = CupertinoActivityIndicator();
                              }
                              return Container(
                                height: 0,
                                child: Center(child: body),
                              );
                            },
                          ),
                          onLoading: () async {
                            await productAgencyController.getAllProduct(
                                isLoadMore: true);
                            _refreshController.loadComplete();
                          },
                          controller: _refreshController,
                          child: ListView.separated(
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return ItemProductWidget(
                                  agencyTypeIdRequest: agencyTypeRequest.id!,
                                  product: list[index],
                                  productAgencyController:
                                      productAgencyController,
                                );
                              }),
                        );
                      }),
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Obx(
        () => productAgencyController.listProductChoose.isEmpty
            ? Container(
                height: 1,
              )
            : Container(
                height: 65,
                color: Colors.white,
                child: Column(
                  children: [
                    SahaButtonFullParent(
                      text: "TIẾP TỤC",
                      onPressed: () {
                        SahaDialogApp.showDialogInputText(
                            title: "Nhập phần trăm thiết lập",
                            textButton: "Xác nhận",
                            autoFocus: true,
                            keyboardType: TextInputType.text,
                            formatter: FilteringTextInputFormatter.allow(
                                RegExp(r'^(\d+)?\.?\d{0,2}')),
                            onDone: (percent) {
                              if (productAgencyController.typeChoose == 2) {
                                productAgencyController.editOverridePriceAgency(
                                    commissionPercent: double.parse(percent));
                              } else {
                                productAgencyController.editPercentAgency(
                                    percentAgency: double.parse(percent));
                              }
                              Get.back();
                            });
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class ItemProductWidget extends StatelessWidget {
  final Product? product;
  int agencyTypeIdRequest;
  final ProductAgencyController? productAgencyController;
  SahaDataController sahaDataController = Get.find();

  ItemProductWidget(
      {Key? key,
      this.product,
      this.productAgencyController,
      required this.agencyTypeIdRequest})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!productAgencyController!.listProductChoose
            .map((e) => e.id)
            .contains(product!.id)) {
          productAgencyController!.listProductChoose.add(product!);
        } else {
          productAgencyController!.listProductChoose.remove(product!);
        }
      },
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                          imageUrl: product!.images != null &&
                                  product!.images!.length > 0
                              ? product!.images![0].imageUrl ?? ""
                              : "",
                          placeholder: (context, url) => new SahaLoadingWidget(
                            size: 20,
                          ),
                          errorWidget: (context, url, error) =>
                              new SahaEmptyImage(),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child: Text(product!.name ?? "")),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  product!.agencyPrice?.maxPrice ==
                          product!.agencyPrice?.minPrice
                      ? Text(
                          product!.agencyPrice?.minPrice == 0
                              ? "Liên hệ"
                              : "${SahaStringUtils().convertToMoney(product?.agencyPrice?.minPrice ?? 0)}đ",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        )
                      : Text(
                          "${SahaStringUtils().convertToMoney(product!.agencyPrice?.minPrice)}đ - ${SahaStringUtils().convertToMoney(product!.agencyPrice?.maxPrice)}đ",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Giá gốc: "),
                      product!.maxPrice == product!.minPrice
                          ? Text(
                              product!.minPrice == 0
                                  ? "Liên hệ"
                                  : "${SahaStringUtils().convertToMoney(product?.minPrice ?? 0)}đ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            )
                          : Text(
                              "${SahaStringUtils().convertToMoney(product!.minPrice)}đ - ${SahaStringUtils().convertToMoney(product!.maxPrice)}đ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Hoa hồng: ",
                        style: TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${product!.agencyPrice?.percentAgency ?? 0} %',
                        style: TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  buildItemOption(
                      title: "Chỉnh giá",
                      onTap: () {
                        print(product?.agencyPrice?.maxPrice);
                        print(product?.agencyPrice?.minPrice);

                        var index = productAgencyController!.listProduct
                            .indexWhere((p) => p.id == product!.id);
                        var page = (index ~/ 20) + 1;

                        Get.to(() => EditPriceScreen(
                                  product: product,
                                  agencyTypeIdRequest: agencyTypeIdRequest,
                                  page: page,
                                ))!
                            .then((value) => {
                                  if (value == "success")
                                    {
                                      productAgencyController!
                                          .getAllProduct(isRefresh: true)
                                    }
                                });
                      }),
                ],
              ),
            ),
            Obx(
              () => productAgencyController!.isShowCheckbox.value
                  ? Checkbox(
                      value: productAgencyController!.listProductChoose
                          .map((e) => e.id)
                          .contains(product!.id),
                      onChanged: (v) {
                        if (v == true) {
                          productAgencyController!.listProductChoose
                              .add(product!);
                        } else {
                          productAgencyController!.listProductChoose
                              .remove(product!);
                        }
                      })
                  : Container(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItemOption({required String title, Function? onTap}) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.only(right: 8, left: 8, bottom: 5, top: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [Text(title)],
            )
          ],
        ),
      ),
    );
  }
}
