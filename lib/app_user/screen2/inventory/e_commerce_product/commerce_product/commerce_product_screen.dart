import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/model/product_commerce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../components/saha_user/button/saha_button.dart';
import '../../../../components/saha_user/empty/saha_empty_image.dart';
import '../../../../components/saha_user/loading/loading_full_screen.dart';
import '../../../../components/saha_user/loading/loading_widget.dart';
import '../../../../data/remote/response-request/e_commerce/all_product_commerce_res.dart';
import '../../../../utils/string_utils.dart';
import 'commerce_product_controller.dart';
import 'commerce_product_detail/commerce_product_detail_screen.dart';

class CommerceProductScreen extends StatefulWidget {
  CommerceProductScreen({Key? key, required this.shopId}) {}

  final String shopId;

  @override
  State<CommerceProductScreen> createState() => _CommerceProductScreenState();
}

class _CommerceProductScreenState extends State<CommerceProductScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late CommerceProductController commerceProductController;
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    commerceProductController =
        CommerceProductController(shopId: widget.shopId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách sản phẩm'),
        actions: [
          // IconButton(
          //     onPressed: () async {
          //       if (commerceProductController.loadInit.value == true) {
          //         return;
          //       }
          //       commerceProductController.loadInit.value = true;
          //       commerceProductController.pageCommerce = 1;
          //       await commerceProductController.syncProduct();
          //       commerceProductController.totalProduct =
          //           commerceProductController.dataSync.totalInPage;
          //       while (commerceProductController.dataSync.totalInPage != 0) {
          //         commerceProductController.pageCommerce =
          //             commerceProductController.pageCommerce + 1;

          //         await commerceProductController.syncProduct();
          //         commerceProductController.totalProduct =
          //             (commerceProductController.totalProduct ?? 0) +
          //                 (commerceProductController.dataSync.totalInPage ?? 0);
          //       }
          //       commerceProductController.getAllProductCommerce(
          //           isRefresh: true, isShowSucces: true);
          //     },
          //     icon: Icon(Icons.sync))
        ],
        bottom: TabBar(
          controller: _tabController,
          onTap: (v) {
            commerceProductController.getAllProductCommerce(
                isRefresh: true, skuPairType: v);
          },
          tabs: [
            Tab(child: Text('Tất cả')),
            Tab(child: Text('Chưa ghép')),
            Tab(child: Text('Đã ghép')),
          ],
        ),
      ),
      body: Obx(
        () => commerceProductController.loadInit.value
            ? SahaLoadingFullScreen()
            : commerceProductController.listProductCommerce.isEmpty
                ? const Center(
                    child: Text('Không có sản phẩm nào'),
                  )
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const MaterialClassicHeader(),
                    footer: CustomFooter(
                      builder: (
                        BuildContext context,
                        LoadStatus? mode,
                      ) {
                        Widget body = Container();
                        if (mode == LoadStatus.idle) {
                          body = Obx(() =>
                              commerceProductController.isLoading.value
                                  ? const CupertinoActivityIndicator()
                                  : Container());
                        } else if (mode == LoadStatus.loading) {
                          body = const CupertinoActivityIndicator();
                        }
                        return SizedBox(
                          height: 100,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: refreshController,
                    onRefresh: () async {
                      await commerceProductController.getAllProductCommerce(
                          isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await commerceProductController.getAllProductCommerce();
                      refreshController.loadComplete();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            ...commerceProductController.listProductCommerce
                                .map((e) => productCommerce(e))
                                .toList(),
                          ]),
                    ),
                  ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Đồng bộ sản phẩm",
                onPressed: () {
                  // Get.to(() => CommerceProductDetailScreen());

                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Hãy chọn loại đồng bộ'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Card(
                                child: ListTile(
                                  onTap: () async {
                                    if (commerceProductController
                                            .loadInit.value ==
                                        true) {
                                      return;
                                    }
                                    Get.back();
                                    commerceProductController.loadInit.value =
                                        true;
                                    commerceProductController.pageCommerce = 1;
                                    await commerceProductController
                                        .syncProduct();
                                    commerceProductController.totalProduct =
                                        commerceProductController
                                            .dataSync.totalInPage;

                                    while (commerceProductController
                                            .dataSync.totalInPage !=
                                        0) {
                                      commerceProductController.pageCommerce =
                                          commerceProductController
                                                  .pageCommerce +
                                              1;

                                      await commerceProductController
                                          .syncProduct();
                                      commerceProductController.totalProduct =
                                          (commerceProductController
                                                      .totalProduct ??
                                                  0) +
                                              (commerceProductController
                                                      .dataSync.totalInPage ??
                                                  0);
                                    }
                                    commerceProductController
                                        .getAllProductCommerce(
                                            isRefresh: true,
                                            isShowSuccess: true);
                                  },
                                  title: Text('Đồng bộ tất cả'),
                                  subtitle: Text(
                                      'Đồng bộ tất cả sản phầm từ shop về. ghi đè lại tất cả sản phẩm'),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Card(
                                child: ListTile(
                                  onTap: () async {
                                    if (commerceProductController
                                            .loadInit.value ==
                                        true) {
                                      return;
                                    }
                                    Get.back();
                                    commerceProductController.loadInit.value =
                                        true;
                                    commerceProductController.pageCommerce = 1;
                                    await commerceProductController
                                        .syncProduct();
                                    commerceProductController.totalProduct =
                                        commerceProductController
                                            .dataSync.totalInPage;

                                    while (commerceProductController
                                            .dataSync.totalInPage !=
                                        0) {
                                      commerceProductController.pageCommerce =
                                          commerceProductController
                                                  .pageCommerce +
                                              1;

                                      await commerceProductController
                                          .syncProduct();
                                      commerceProductController.totalProduct =
                                          (commerceProductController
                                                      .totalProduct ??
                                                  0) +
                                              (commerceProductController
                                                      .dataSync.totalInPage ??
                                                  0);
                                    }
                                    commerceProductController
                                        .getAllProductCommerce(
                                            isRefresh: true,
                                            isShowSuccess: true);
                                  },
                                  title: Text('Đồng bộ sản phẩm mới'),
                                  subtitle: Text(
                                      'Chỉ đồng bộ những sản phẩm chưa có trên hệ thống từ shop về'),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                color: commerceProductController.loadInit.value == true
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemProduct(ProductCommerce productCommerce) {
    return InkWell(
      onTap: () {
        Get.to(() => CommerceProductDetailScreen(
                  productCommerce: productCommerce,
                ))!
            .then((value) => commerceProductController.getAllProductCommerce(
                isRefresh: true));
      },
      onLongPress: () {
        commerceProductController.isLongPress.value =
            !commerceProductController.isLongPress.value;
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  imageUrl: productCommerce.images != null &&
                          productCommerce.images!.isNotEmpty
                      ? productCommerce.images![0]
                      : "",
                  placeholder: (context, url) => new SahaLoadingWidget(
                        size: 20,
                      ),
                  errorWidget: (context, url, error) => new SahaEmptyImage()),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${productCommerce.name}",
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
                Text(
                  productCommerce.minPrice == 0
                      ? "Liên hệ"
                      : "${SahaStringUtils().convertToMoney(productCommerce.price)}đ",
                  style: TextStyle(
                      color: Theme.of(Get.context!).primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                )
              ],
            ),
            Obx(() => commerceProductController.isLongPress.value
                ? Checkbox(
                    value: commerceProductController.listProductId
                        .contains(productCommerce.productIdInEcommerce),
                    onChanged: (v) {
                      if (v == true) {
                        commerceProductController.listProductId
                            .add(productCommerce.productIdInEcommerce ?? '');
                        commerceProductController.listProductId.refresh();
                      } else {
                        commerceProductController.listProductId
                            .remove(productCommerce.productIdInEcommerce);
                        commerceProductController.listProductId.refresh();
                      }
                    })
                : const SizedBox())
          ],
        ),
      ),
    );
  }
  Widget buildErrorWidget(BuildContext context, Object error, StackTrace stackTrace) {
    return Icon(Icons.error_outline, size: 55);
  }

  Widget productCommerce(ProductCommerces productCommerces) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
      child: ExpansionTile(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                productCommerces.mainImage ?? '',
                width: 55,
                height: 55,
                fit: BoxFit.contain,
                errorBuilder: (context, url, error) =>
                    SahaEmptyImage(),
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
                  productCommerces.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(SahaStringUtils()
                    .convertToUnit(productCommerces.minPrice ?? 0)),
              ],
            )),
          ],
        ),
        controlAffinity: ListTileControlAffinity.trailing,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Column(
              children: [
                ...(productCommerces.children ?? []).map((e) => itemProduct(e))
              ],
            ),
          )
        ],
      ),
    );
  }
}
