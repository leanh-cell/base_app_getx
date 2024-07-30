import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'add_product_combo_controller.dart';

class AddProductComboScreen extends StatefulWidget {
  final Function? callback;
  final List<Product>? listProductInput;

  AddProductComboScreen({this.callback, this.listProductInput});

  @override
  _AddProductComboScreenState createState() => _AddProductComboScreenState();
}

class _AddProductComboScreenState extends State<AddProductComboScreen> {
  bool isSearch = false;

  AddProductComboController addProductToSaleController =
      AddProductComboController();
  RefreshController? refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addProductToSaleController
        .listSelectedProduct(widget.listProductInput!.toList());
    addProductToSaleController.getAllProduct(isRefresh: true);
    refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => addProductToSaleController.isSearch.value
              ? SahaTextFieldSearch(
                  onSubmitted: (va) {
                    addProductToSaleController.resetListProduct();
                    addProductToSaleController.textSearch = va;
                    print(addProductToSaleController.textSearch);
                    addProductToSaleController.getAllProduct(
                        textSearch: addProductToSaleController.textSearch!,
                        isRefresh: true);
                  },
                  onClose: () {
                    addProductToSaleController.textSearch = null;
                    addProductToSaleController.isSearch.value = false;
                    addProductToSaleController.getAllProduct(
                        textSearch: addProductToSaleController.textSearch,
                        isRefresh: true);
                  },
                )
              : Text("Tất cả sản phẩm"),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {
                addProductToSaleController.isSearch.value = true;
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
              body = Obx(() => addProductToSaleController.isLoadMore.value
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
          addProductToSaleController.resetListProduct();
          await addProductToSaleController.getAllProduct(isRefresh: true);
          refreshController!.refreshCompleted();
        },
        onLoading: () async {
          await addProductToSaleController.getAllProduct(
              textSearch: addProductToSaleController.textSearch,
              isRefresh: false);
          refreshController!.loadComplete();
        },
        child: Obx(
          () => addProductToSaleController.isLoadingProduct.value == true
              ? SahaLoadingWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(
                        addProductToSaleController.listProduct.length,
                        (index) => addProductToSaleController
                                    .listProduct[index].hasInCombo ==
                                true
                            ? IgnorePointer(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Opacity(
                                      opacity: 0.4,
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                        ),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                                value: false,
                                                onChanged: (v) {}),
                                            SizedBox(
                                              width: 88,
                                              child: AspectRatio(
                                                aspectRatio: 1,
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF5F6F9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl: addProductToSaleController
                                                                  .listProduct[
                                                                      index]
                                                                  .images!
                                                                  .length ==
                                                              0
                                                          ? ""
                                                          : addProductToSaleController
                                                              .listProduct[
                                                                  index]
                                                              .images![0]
                                                              .imageUrl!,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Container(
                                                          height: 100,
                                                          child: Icon(
                                                            Icons.image,
                                                            color: Colors.grey,
                                                            size: 40,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                                                    addProductToSaleController
                                                            .listProduct[index]
                                                            .name ??
                                                        "Loi san pham",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                    maxLines: 2,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  addProductToSaleController
                                                              .listProduct[
                                                                  index]
                                                              .maxPrice ==
                                                          addProductToSaleController
                                                              .listProduct[
                                                                  index]
                                                              .minPrice
                                                      ? Text(
                                                          "${SahaStringUtils().convertToMoney(addProductToSaleController.listProduct[index].minPrice)}đ",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15),
                                                        )
                                                      : Text(
                                                          "${SahaStringUtils().convertToMoney(addProductToSaleController.listProduct[index].minPrice)}đ - ${SahaStringUtils().convertToMoney(addProductToSaleController.listProduct[index].maxPrice)}đ",
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 15),
                                                        ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        width: Get.width * 0.5,
                                        padding: EdgeInsets.all(2),
                                        child: Text(
                                          "Sản phẩm đã có Combo giảm giá",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xffff0004),
                                            fontSize: 12,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0, 0),
                                                blurRadius: 10.0,
                                                color: Colors.black12,
                                              ),
                                              Shadow(
                                                  offset: Offset(0, 0),
                                                  blurRadius: 10.0,
                                                  color: Colors.grey[200]!),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                ),
                                child: Row(
                                  children: [
                                    Checkbox(
                                        value: addProductToSaleController
                                            .listSelectedProduct
                                            .map((e) => e.id)
                                            .contains(addProductToSaleController
                                                .listProduct[index].id),
                                        onChanged: (v) {
                                          setState(() {
                                            if (addProductToSaleController
                                                .listSelectedProduct
                                                .map((e) => e.id)
                                                .contains(
                                                    addProductToSaleController
                                                        .listProduct[index]
                                                        .id)) {
                                              addProductToSaleController
                                                  .listSelectedProduct
                                                  .removeWhere((e) =>
                                                      e.id ==
                                                      addProductToSaleController
                                                          .listProduct[index]
                                                          .id);
                                            } else {
                                              addProductToSaleController
                                                  .listSelectedProduct
                                                  .add(
                                                      addProductToSaleController
                                                          .listProduct[index]);
                                            }
                                          });
                                        }),
                                    SizedBox(
                                      width: 88,
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF5F6F9),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: addProductToSaleController
                                                          .listProduct[index]
                                                          .images!
                                                          .length ==
                                                      0
                                                  ? ""
                                                  : addProductToSaleController
                                                      .listProduct[index]
                                                      .images![0]
                                                      .imageUrl!,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  height: 100,
                                                  child: Icon(
                                                    Icons.image,
                                                    size: 40,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
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
                                            addProductToSaleController
                                                    .listProduct[index].name ??
                                                "Loi san pham",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                            maxLines: 2,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          addProductToSaleController
                                                      .listProduct[index]
                                                      .maxPrice ==
                                                  addProductToSaleController
                                                      .listProduct[index]
                                                      .minPrice
                                              ? Text(
                                                  "${SahaStringUtils().convertToMoney(addProductToSaleController.listProduct[index].minPrice)}đ",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                )
                                              : Text(
                                                  "${SahaStringUtils().convertToMoney(addProductToSaleController.listProduct[index].minPrice)}đ - ${SahaStringUtils().convertToMoney(addProductToSaleController.listProduct[index].maxPrice)}đ",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                        ],
                                      ),
                                    )
                                  ],
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
              Row(
                children: [
                  Text(
                    addProductToSaleController.listSelectedProduct.length
                        .toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Đã Chọn'),
                ],
              ),
              InkWell(
                onTap: () {
                  widget.callback!(
                      addProductToSaleController.listSelectedProduct);
                  Get.back();
                },
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                    child: Text('Thêm'),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
