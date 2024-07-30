import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import 'product_picker_controller.dart';

class ProductPickerScreen extends StatefulWidget {
  final Function? callback;
  final List<Product>? listProductInput;
  final bool onlyOne;
  final String? textHandle;

  ProductPickerScreen(
      {this.callback,
      this.listProductInput,
      this.onlyOne = false,
      this.textHandle});

  @override
  _ProductPickerScreenState createState() => _ProductPickerScreenState();
}

class _ProductPickerScreenState extends State<ProductPickerScreen> {
  bool isSearch = false;

  ProductPickerController productPickerController = ProductPickerController();
  RefreshController? refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productPickerController.listProductInput = widget.listProductInput;
    productPickerController.getAllProduct(isRefresh: true);
    refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => productPickerController.isSearch.value
              ? SahaTextFieldSearch(
                  onSubmitted: (va) {
                    productPickerController.resetListProduct();
                    productPickerController.textSearch = va;
                    print(productPickerController.textSearch);
                    productPickerController.getAllProduct(
                        textSearch: productPickerController.textSearch!,
                        isRefresh: true);
                  },
                  onClose: () {
                    productPickerController.textSearch = null;
                    productPickerController.isSearch.value = false;
                  },
                )
              : Text("Tất cả sản phẩm"),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {
                productPickerController.isSearch.value = true;
              })
        ],
      ),
      body: SmartRefresher(
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
              body = Obx(() => productPickerController.isLoadMore.value
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
        controller: refreshController!,
        onRefresh: () async {
          productPickerController.resetListProduct();
          await productPickerController.getAllProduct(isRefresh: true);
          refreshController!.refreshCompleted();
        },
        onLoading: () async {
          await productPickerController.getAllProduct(
              textSearch: productPickerController.textSearch);
          refreshController!.loadComplete();
        },
        child: Obx(
          () => productPickerController.isLoadingProduct.value == true
              ? SahaLoadingWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(
                        productPickerController.listProduct.length,
                        (index) => InkWell(
                          onTap: () {
                            onChange(
                                productPickerController.listProduct[index]);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              children: [
                                Checkbox(
                                    value: productPickerController
                                        .listCheckSelectedProduct
                                        .contains(productPickerController
                                            .listProduct[index]),
                                    onChanged: (v) {
                                      onChange(productPickerController
                                          .listProduct[index]);
                                    }),
                                SizedBox(
                                  width: 88,
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F6F9),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: productPickerController
                                                        .listProduct[index]
                                                        .images!
                                                        .length ==
                                                    0
                                                ? ""
                                                : productPickerController
                                                        .listProduct[index]
                                                        .images![0]
                                                        .imageUrl ??
                                                    "",
                                            errorWidget:
                                                (context, url, error) => Icon(
                                                      Icons.image,
                                                      size: 40,
                                                      color: Colors.grey,
                                                    )),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  width: Get.width * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productPickerController
                                                .listProduct[index].name ??
                                            "Loi san pham",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      productPickerController.listProduct[index]
                                                  .maxPrice ==
                                              productPickerController
                                                  .listProduct[index].minPrice
                                          ? Text(
                                              "${SahaStringUtils().convertToMoney(productPickerController.listProduct[index].minPrice)}đ",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            )
                                          : Text(
                                              "${SahaStringUtils().convertToMoney(productPickerController.listProduct[index].minPrice)}đ - ${SahaStringUtils().convertToMoney(productPickerController.listProduct[index].maxPrice)}đ",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 80,
          color: Colors.white,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Row(
                  children: [
                    Text(
                      productPickerController.listCheckSelectedProduct.length
                          .toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Đã Chọn'),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  widget.callback!(
                      productPickerController.listCheckSelectedProduct);
                  Get.back(
                      result: productPickerController.listCheckSelectedProduct
                          .toList());
                },
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                    child: Text(
                      widget.textHandle == null ? 'Thêm' : 'Sao chép',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  void onChange(Product product) {
    if (widget.onlyOne) {
      productPickerController.listCheckSelectedProduct.clear();
      if (productPickerController.listCheckSelectedProduct.contains(product)) {
        productPickerController.listCheckSelectedProduct.remove(product);
      } else {
        productPickerController.listCheckSelectedProduct.add(product);
      }
    } else {
      if (productPickerController.listCheckSelectedProduct.contains(product)) {
        productPickerController.listCheckSelectedProduct.remove(product);
      } else {
        productPickerController.listCheckSelectedProduct.add(product);
      }
    }
  }
}
