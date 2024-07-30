import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/add_product/add_product_screen.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'product_page_controller.dart';

class ProductPage extends StatefulWidget {
  bool isHide;
  final Function? onReturnController;

  ProductPageController productController = ProductPageController();

  ProductPage({required this.isHide, this.onReturnController}) {
    onReturnController!(productController..isHide = isHide);
  }

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var timeInputSearch = DateTime.now();
  ScrollController _scrollController = ScrollController();

  TextEditingController searchEditingController = TextEditingController();
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          widget.productController.loading.value == false) {
        widget.productController.getAllProductV2();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(
      () => SmartRefresher(
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
              body = Obx(() => widget.productController.loading.value
                  ? CupertinoActivityIndicator()
                  : Container());
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            }
            return Center(
              child: Container(
                child: Center(child: body),
              ),
            );
          },
        ),
        controller: refreshController,
        onRefresh: () async {
          await widget.productController.getAllProductV2(isRefresh: true);
          refreshController.refreshCompleted();
        },
        onLoading: () async {
          await widget.productController.getAllProductV2();
          refreshController.loadComplete();
        },
        child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8),
            itemCount: widget.productController.listProduct.length,
            itemBuilder: (BuildContext context, int index) {
              return itemProduct(
                  widget.productController.listProduct[index], index);
            }),
      ),
    );
  }

  Widget itemProduct(Product product, int index) {
    return InkWell(
      onTap: () {
        if (widget.productController.isLongPress.value == true) {
          widget.productController.addOrRemoveSelected(product.id!);
        } else {
          Get.to(() => AddProductScreen(
                    product: product,
                  ))!
              .then((value) => {
                    print(
                        "===========================================${value}"),
                    if (value != null)
                      {widget.productController.getOneProduct(value)}
                  });
        }
      },
      onLongPress: () {
        widget.productController.isLongPress.value = true;
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text((index + 1).toString()),
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
                      errorWidget: (context, url, error) =>
                          new SahaEmptyImage()),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product.name}",
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
                    product.productDiscount == null
                        ? Container()
                        : Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text(
                              product.maxPrice == product.minPrice
                                  ? "${SahaStringUtils().convertToMoney(product.minPrice)}₫"
                                  : "${SahaStringUtils().convertToMoney(product.minPrice)}₫ - ${SahaStringUtils().convertToMoney(product.maxPrice)}₫",
                              style: TextStyle(
                                  decoration: product.maxPrice == 0
                                      ? null
                                      : TextDecoration.lineThrough,
                                  color: product.productDiscount == null
                                      ? Theme.of(Get.context!).primaryColor
                                      : Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: product.productDiscount == null
                                      ? 14
                                      : 10),
                            ),
                          ),
                    product.maxPrice == product.minPrice
                        ? Text(
                            product.minPrice == 0
                                ? "Liên hệ"
                                : product.productDiscount == null
                                    ? "${SahaStringUtils().convertToMoney(product.minPrice)}đ"
                                    : "${SahaStringUtils().convertToMoney((product.minPrice ?? 0) - ((product.minPrice ?? 0) * ((product.productDiscount?.value ?? 0) / 100)))}đ",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          )
                        : Text(
                            "${SahaStringUtils().convertToMoney((product.minPrice ?? 0) - ((product.minPrice ?? 0) * ((product.productDiscount?.value ?? 0) / 100)))}đ - ${SahaStringUtils().convertToMoney((product.maxPrice ?? 0) - ((product.maxPrice ?? 0) * ((product.productDiscount?.value ?? 0) / 100)))}đ",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                  ],
                ),
                Obx(
                  () => widget.productController.isLongPress.value == true
                      ? Checkbox(
                          value: widget.productController.productsSelected
                              .contains(product.id!),
                          onChanged: (v) {
                            widget.productController
                                .addOrRemoveSelected(product.id!);
                          })
                      : const SizedBox(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              width: Get.width - 60,
              color: Colors.grey[300],
            )
          ],
        ),
      ),
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    widget.productController.scanProduct(barcodeScanRes);
  }
}
