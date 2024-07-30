import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/add_product/add_product_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';

import '../../../../saha_data_controller.dart';
import 'filter/filter_screen.dart';
import 'product_page/product_page.dart';

class ProductMainScreen extends StatefulWidget {
  @override
  _ProductMainScreenState createState() => _ProductMainScreenState();
}

class _ProductMainScreenState extends State<ProductMainScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  final PageStorageBucket bucket = PageStorageBucket();
  var timeInputSearch = DateTime.now();

  TextEditingController searchEditingController = TextEditingController();
  RefreshController refreshController = RefreshController();
  RefreshController refreshController2 = RefreshController();

  ProductController productControllerAll = Get.put(ProductController());
  SahaDataController sahaDataController = Get.find();

  late TabController tabController;

  List<Widget> listPage = [];

  List<String> choices = [
    "Thiết lập hoa hồng toàn bộ sản phẩm",
  ];

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
    listPage = [
      ProductPage(
        isHide: false,
        onReturnController: (pageController) {
          productControllerAll.addPageController(pageController);
        },
      ),
      ProductPage(
        isHide: true,
        onReturnController: (pageController) {
          productControllerAll.addPageController(pageController);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Obx(
        () {
          var productController =
              productControllerAll.pagesController[tabController.index];
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading:
                  productControllerAll.isLoadingAppbar.value
                      ? true
                      : productController.isLongPress.value == true
                          ? false
                          : true,
              title: Obx(
                () => productController.isLongPress.value == true
                    ? Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                productController.isLongPress.value = false;
                              },
                              icon: Icon(Icons.clear)),
                          Text("${productController.productsSelected.length}"),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                productController.productsSelected(
                                    productController.listProduct
                                        .map((e) => e.id!)
                                        .toList());
                              },
                              child: Text(
                                "Chọn tất cả",
                                style: TextStyle(color: Colors.white),
                              )),
                          TextButton(
                              onPressed: () {
                                productController.productsSelected([]);
                              },
                              child: Text(
                                "Bỏ chọn",
                                style: TextStyle(color: Colors.white),
                              )),
                          IconButton(
                              onPressed: () {
                                 if(sahaDataController.badgeUser.value.decentralization?.productRemoveHide != true){
                                SahaAlert.showError(message: 'Bạn không có quyền xoá sản phẩm');
                                return;
                              }
                                SahaDialogApp.showDialogYesNo(
                                    mess:
                                        "Bạn có chắc chắn xoá ${productController.productsSelected.length} sản phẩm đã chọn chứ ?",
                                    onOK: () async {
                                      productController.deleteManyProduct(
                                          productController.productsSelected
                                              .toList());
                                      productController.isLongPress.value =
                                          false;
                                    });
                              },
                              icon: Icon(Icons.delete))
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => productController.isSearch.value
                                  ? Container(
                                      padding: EdgeInsets.only(left: 10),
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextFormField(
                                        controller: searchEditingController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.only(
                                             top: 7),
                                          border: InputBorder.none,
                                          hintText: "Tìm kiếm",
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              searchEditingController.clear();
                                              productControllerAll
                                                  .closeSearch();
                                            },
                                            icon: Icon(
                                              Icons.clear,
                                            ),
                                          ),
                                        ),
                                        onChanged: (v) async {
                                          productControllerAll.onSearch(v);
                                        },
                                        minLines: 1,
                                        maxLines: 1,
                                      ),
                                    )
                                  : Text('Sản phẩm'),
                              // Theme(
                              //         data: Theme.of(context).copyWith(
                              //           canvasColor:
                              //               Theme.of(context).primaryColor,
                              //         ),
                              //         child: DropdownButton<Category>(
                              //           underline: SizedBox(),
                              //           isExpanded: true,
                              //           value: productController.categoryChoose,
                              //           icon: Icon(
                              //             Icons.arrow_drop_down_rounded,
                              //             color: Colors.white,
                              //           ),
                              //           hint: Text(
                              //             "Tất cả sản phẩm",
                              //             style: TextStyle(
                              //                 fontSize: 14,
                              //                 color: Colors.white),
                              //           ),
                              //           items: [
                              //             ...productControllerAll.categories
                              //                 .map((Category cate) {
                              //               return DropdownMenuItem<Category>(
                              //                 value: cate,
                              //                 child: Container(
                              //                   width: 130,
                              //                   child: Text(
                              //                     "${cate.name ?? ""}",
                              //                     style: TextStyle(
                              //                         color: Colors.white,
                              //                         fontSize: 14),
                              //                   ),
                              //                 ),
                              //               );
                              //             }).toList(),
                              //           ],
                              //           onChanged: (v) {
                              //             productControllerAll
                              //                 .changeCategory(v);
                              //           },
                              //         ),
                              //       ),
                            ),
                          ),
                        ],
                      ),
              ),
              actions: productController.isLongPress.value == true
                  ? null
                  : [
                      IconButton(
                          onPressed: () {
                            scanBarcodeNormal();
                          },
                          icon: Icon(
                            Ionicons.barcode_outline,
                          )),
                      IconButton(
                          onPressed: () {
                            productController.isSearch.value = true;
                          },
                          icon: Icon(Icons.search)),
                      PopupMenuButton(
                        elevation: 3.2,
                        initialValue: choices[0],
                        onCanceled: () {},
                        icon: Icon(Icons.more_vert),
                        onSelected: (v) async {
                          SahaDialogApp.showDialogInput(
                              title: 'Phần trăm hoa hồng',
                              hintText: 'Nhập phần trăm hoa hồng',
                              textInputType: TextInputType.number,
                              onInput: (v) {
                                productController.collaboratorProducts(
                                    int.tryParse('$v') ?? 0);
                              });
                        },
                        itemBuilder: (BuildContext context) {
                          return choices.map((String choice) {
                            return PopupMenuItem(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            Get.to(() => FilterScreen(
                                  categoryInput:
                                      productController.categoryChoose,
                                  categoryChildInput:
                                      productController.categoryChildChoose,
                                  onFilter: (List<Category>? categoryChooses,
                                      List<Category>? categoryChildChooses,bool isNearOutOfStock) {
                                    print(categoryChooses);
                                    print(categoryChildChooses);
                                    productController.categoryChoose =
                                        categoryChooses;
                                    productController.categoryChildChoose =
                                        categoryChildChooses;
                                    productControllerAll.categoryChooses =
                                        categoryChooses;
                                    productControllerAll.categoryChildChooses =
                                        categoryChildChooses;
                                    productController.getAllProductV2(
                                        isRefresh: true);
                                    Get.back();
                                  },
                                ));
                          },
                          icon: Icon(((productControllerAll.categoryChooses ??
                                          [])
                                      .isNotEmpty ||
                                  (productControllerAll.categoryChildChooses ??
                                          [])
                                      .isNotEmpty)
                              ? Icons.filter_alt_rounded
                              : Icons.filter_alt_outlined))
                    ],
              bottom: TabBar(
                onTap: (v) {
                  if (v == 0) {
                    tabController.animateTo(0);
                  }
                  if (v == 1) {
                    tabController.animateTo(1);
                  }
                },
                tabs: [
                  Tab(
                    child: Text(
                      "Còn hàng (${productControllerAll.totalShow})",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Đã ẩn (${productControllerAll.totalHide})",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            body: PageStorage(
              bucket: bucket,
              child: TabBarView(controller: tabController, children: listPage),
            ),
            bottomNavigationBar: Container(
              height: 65,
              color: Colors.white,
              child: Column(
                children: [
                  SahaButtonFullParent(
                    text: "Thêm sản phẩm mới",
                    onPressed: () {
                      if (sahaDataController
                              .badgeUser.value.decentralization?.productAdd !=
                          true) {
                        SahaAlert.showError(
                          message: "Bạn không có quyền thêm sản phẩm",
                        );
                        return;
                      }
                      Get.to(() => AddProductScreen())!.then((value) => {
                            if (value == "reload")
                              {
                                productController.getAllProductV2(
                                    isRefresh: true)
                              },
                            if (value == "reload_hide")
                              {
                                productControllerAll.pagesController[1]
                                    .getAllProductV2(isRefresh: true)
                              }
                          });
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> scanBarcodeNormal() async {
    var productController =
        productControllerAll.pagesController[tabController.index];
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    productController.scanProduct(barcodeScanRes);
  }
}
