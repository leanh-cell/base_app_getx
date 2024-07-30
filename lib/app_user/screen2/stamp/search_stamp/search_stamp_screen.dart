import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/model/stamp.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import 'search_stamp_controller.dart';

class SearchStampScreen extends StatefulWidget {
  Function? onChoose;
  List<Stamp>? listStamp;

  SearchStampScreen({this.onChoose, this.listStamp});

  @override
  _SearchStampScreenState createState() => _SearchStampScreenState();
}

class _SearchStampScreenState extends State<SearchStampScreen> {
  late SearchStampController searchStampController;
  var timeInputSearch = DateTime.now();
  ScrollController _scrollController = ScrollController();

  TextEditingController searchEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchStampController = SearchStampController(
      listStampInput: widget.listStamp,
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          searchStampController.loading.value == false) {
        searchStampController.getAllProduct();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading:
              searchStampController.isLongPress.value == true ? false : true,
          title: Obx(
            () => searchStampController.isLongPress.value == true
                ? Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            searchStampController.isLongPress.value = false;
                          },
                          icon: Icon(Icons.clear)),
                      Text("${searchStampController.productsSelected.length}"),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            searchStampController.isLongPress.value = false;
                            searchStampController.productsSelected([]);
                          },
                          child: Text(
                            "Bỏ chọn",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => searchStampController.isSearch.value
                              ? Container(
                                  padding: EdgeInsets.only(left: 10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: TextFormField(
                                    controller: searchEditingController,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(
                                          right: 15, top: 15, bottom: 10),
                                      border: InputBorder.none,
                                      hintText: "Tìm kiếm",
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          searchEditingController.clear();
                                          searchStampController.isSearch.value =
                                              false;
                                          searchStampController.searchText = "";
                                          searchStampController.getAllProduct(
                                              isRefresh: true);
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                        ),
                                      ),
                                    ),
                                    onChanged: (v) async {
                                      searchStampController.searchText = v;
                                      searchStampController.getAllProduct(
                                          isRefresh: true);
                                    },
                                    minLines: 1,
                                    maxLines: 1,
                                  ),
                                )
                              : Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: Theme.of(context).primaryColor,
                                  ),
                                  child: DropdownButton<Category>(
                                    underline: SizedBox(),
                                    value: searchStampController.categoryChoose,
                                    icon: Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: Colors.white,
                                    ),
                                    hint: Text(
                                      "Tất cả sản phẩm",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    items: searchStampController.categories
                                        .map((Category cate) {
                                      return DropdownMenuItem<Category>(
                                        value: cate,
                                        child: Container(
                                          child: Text(
                                            "${cate.name ?? ""}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (v) {
                                      searchStampController.categoryChoose = v;
                                      searchStampController.searchText = "";
                                      searchStampController.categories
                                          .refresh();
                                      searchStampController.getAllProduct(
                                          isRefresh: true);
                                    },
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  scanBarcodeNormal();
                },
                icon: Icon(Icons.qr_code)),
            IconButton(
                onPressed: () {
                  searchStampController.isSearch.value = true;
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: Obx(
          () => Column(
            children: [
              Container(
                color: Colors.white,
                height: 55,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      "Chọn nhiều (${searchStampController.listStamp.length})",
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Obx(() => searchStampController.isChooseMany.value
                        ? TextButton(
                            onPressed: () {
                              searchStampController.listStamp([]);
                            },
                            child: Text("Bỏ chọn"))
                        : Container()),
                    Obx(() => searchStampController.isChooseMany.value
                        ? TextButton(
                            onPressed: () {
                              searchStampController.addAll();
                            },
                            child: Text("Chọn tất cả"))
                        : Container()),
                    Obx(
                      () => CupertinoSwitch(
                        value: searchStampController.isChooseMany.value,
                        onChanged: (bool value) {
                          searchStampController.isChooseMany.value =
                              !searchStampController.isChooseMany.value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: searchStampController.listProduct.length,
                    itemBuilder: (BuildContext context, int index) {
                      return itemProduct(
                          searchStampController.listProduct[index]);
                    }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Xong",
                onPressed: () {
                  if (widget.onChoose != null) {
                    widget.onChoose!(searchStampController.listStamp.toList());
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

  Widget itemProduct(Product product) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
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
            onTap: () {
              if (widget.onChoose != null &&
                      product.inventory?.distributes == null ||
                  product.inventory!.distributes!.isEmpty) {
                if (searchStampController.listStamp.isNotEmpty) {
                  searchStampController.listStamp.add(Stamp(
                    quantity: product.inventory?.mainStock ?? 0,
                    productId: product.id,
                    barcode: product.barcode,
                    nameProduct: "${product.name}",
                    price: product.price,
                    priceImport: product.priceImport,
                    priceCapital: product.priceCapital,
                    distributeName: null,
                    elementDistributeName: null,
                    subElementDistributeName: null,
                  ));
                  widget.onChoose!(
                    searchStampController.listStamp.toList(),
                  );
                } else {
                  widget.onChoose!([
                    Stamp(
                      quantity: product.inventory?.mainStock ?? 0,
                      productId: product.id,
                      barcode: product.barcode,
                      nameProduct: "${product.name}",
                      price: product.price,
                      priceImport: product.priceImport,
                      priceCapital: product.priceCapital,
                      distributeName: null,
                      elementDistributeName: null,
                      subElementDistributeName: null,
                    )
                  ]);
                }
              }
            },
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
                    Container(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        "${!(product.inventory?.distributes != null && product.inventory!.distributes!.isNotEmpty) ? "Kho: ${product.inventory?.mainStock ?? 0}" : ""}",
                        style: TextStyle(
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                if (!(product.inventory?.distributes != null &&
                    product.inventory!.distributes!.isNotEmpty))
                  Obx(
                    () => !searchStampController.isChooseMany.value
                        ? searchStampController.checkChoose(
                            productId: product.id,
                            distributeName: null,
                            elementDistributeName: null,
                            subElementDistributeName: null,
                          )
                            ? Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Container()
                        : Checkbox(
                            value: searchStampController.checkChoose(
                              productId: product.id,
                              distributeName: null,
                              elementDistributeName: null,
                              subElementDistributeName: null,
                            ),
                            onChanged: (v) {
                              print("ssss");
                              searchStampController.addOrRemoveSelected(
                                stampCheck: Stamp(
                                  quantity: product.inventory?.mainStock ?? 0,
                                  barcode: product.barcode,
                                  productId: product.id,
                                  nameProduct: "${product.name}",
                                  price: product.price,
                                  priceImport: product.priceImport,
                                  priceCapital: product.priceCapital,
                                  distributeName: null,
                                  elementDistributeName: null,
                                  subElementDistributeName: null,
                                ),
                              );
                              setState(() {});
                            }),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 1,
          ),
          if (product.inventory?.distributes != null &&
              product.inventory!.distributes!.isNotEmpty)
            ...product.inventory!.distributes![0].elementDistributes!
                .map((e) => itemDistribute(
                    e,
                    product.distributes![0].elementDistributes![product
                        .distributes![0].elementDistributes!
                        .indexWhere((e2) => e2.id == e.id)],
                    product))
                .toList(),
        ],
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

    searchStampController.scanProduct(barcodeScanRes);
  }

  Widget itemDistribute(ElementDistributes elementDistributes,
      ElementDistributes elementDistributes2, Product product) {
    return Column(
      children: [
        if (elementDistributes.subElementDistribute == null ||
            elementDistributes.subElementDistribute!.isEmpty)
          InkWell(
            onTap: () {
              if (widget.onChoose != null) {
                if (searchStampController.listStamp.isNotEmpty) {
                  searchStampController.listStamp.add(
                    Stamp(
                      quantity: elementDistributes.stock,
                      productId: product.id,
                      nameProduct: "${product.name}",
                      barcode: elementDistributes2.barcode,
                      distributeName: (product.distributes != null &&
                              product.distributes!.isNotEmpty)
                          ? product.distributes![0].name
                          : null,
                      elementDistributeName: elementDistributes.name,
                      subElementDistributeName: null,
                      price: elementDistributes.price,
                      priceImport: elementDistributes.priceImport,
                      priceCapital: elementDistributes.priceCapital,
                    ),
                  );
                  widget.onChoose!(
                    searchStampController.listStamp.toList(),
                  );
                } else {
                  widget.onChoose!([
                    Stamp(
                      quantity: elementDistributes.stock,
                      productId: product.id,
                      nameProduct: "${product.name}",
                      barcode: elementDistributes2.barcode,
                      distributeName: (product.distributes != null &&
                              product.distributes!.isNotEmpty)
                          ? product.distributes![0].name
                          : null,
                      elementDistributeName: elementDistributes.name,
                      subElementDistributeName: null,
                      price: elementDistributes.price,
                      priceImport: elementDistributes.priceImport,
                      priceCapital: elementDistributes.priceCapital,
                    ),
                  ]);
                }
              }
            },
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
                    color: Theme.of(context).primaryColor,
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
                        style: TextStyle(fontSize: 13),
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
                    Container(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        "Kho: ${elementDistributes.stock ?? 0}",
                        style: TextStyle(
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => !searchStampController.isChooseMany.value
                      ? searchStampController.checkChoose(
                          productId: product.id,
                          distributeName: (product.distributes != null &&
                                  product.distributes!.isNotEmpty)
                              ? product.distributes![0].name
                              : null,
                          elementDistributeName: elementDistributes.name,
                          subElementDistributeName: null,
                        )
                          ? Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 12,
                              ),
                            )
                          : Container()
                      : Checkbox(
                          value: searchStampController.checkChoose(
                            productId: product.id,
                            distributeName: (product.distributes != null &&
                                    product.distributes!.isNotEmpty)
                                ? product.distributes![0].name
                                : null,
                            elementDistributeName: elementDistributes.name,
                            subElementDistributeName: null,
                          ),
                          onChanged: (v) {
                            print("ssss");
                            searchStampController.addOrRemoveSelected(
                              stampCheck: Stamp(
                                quantity: elementDistributes.stock,
                                productId: product.id,
                                nameProduct: "${product.name}",
                                barcode: elementDistributes2.barcode,
                                distributeName: (product.distributes != null &&
                                        product.distributes!.isNotEmpty)
                                    ? product.distributes![0].name
                                    : null,
                                elementDistributeName: elementDistributes.name,
                                subElementDistributeName: null,
                                price: elementDistributes.price,
                                priceImport: elementDistributes.priceImport,
                                priceCapital: elementDistributes.priceCapital,
                              ),
                            );
                            setState(() {});
                          }),
                ),
              ],
            ),
          ),
        ...elementDistributes.subElementDistribute!
            .map(
              (e) => Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (widget.onChoose != null) {
                        if (searchStampController.listStamp.isNotEmpty) {
                          searchStampController.listStamp.add(Stamp(
                            quantity: e.stock,
                            productId: product.id,
                            barcode: elementDistributes2
                                .subElementDistribute![(elementDistributes2
                                    .subElementDistribute!
                                    .indexWhere((sub) => sub.id == e.id))]
                                .barcode,
                            nameProduct: "${product.name}",
                            distributeName: (product.distributes != null &&
                                    product.distributes!.isNotEmpty)
                                ? product.distributes![0].name
                                : null,
                            elementDistributeName: elementDistributes.name,
                            subElementDistributeName: e.name,
                            price: e.price,
                            priceImport: e.priceImport,
                            priceCapital: e.priceCapital,
                          ));
                          widget.onChoose!(
                            searchStampController.listStamp.toList(),
                          );
                        } else {
                          widget.onChoose!(
                            [
                              Stamp(
                                productId: product.id,
                                nameProduct: "${product.name}",
                                quantity: e.stock,
                                barcode: elementDistributes2
                                    .subElementDistribute![(elementDistributes2
                                        .subElementDistribute!
                                        .indexWhere((sub) => sub.id == e.id))]
                                    .barcode,
                                distributeName: (product.distributes != null &&
                                        product.distributes!.isNotEmpty)
                                    ? product.distributes![0].name
                                    : null,
                                elementDistributeName: elementDistributes.name,
                                subElementDistributeName: e.name,
                                price: e.price,
                                priceImport: e.priceImport,
                                priceCapital: e.priceCapital,
                              )
                            ],
                          );
                        }
                      }
                    },
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
                            color: Theme.of(context).primaryColor,
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
                                style: TextStyle(fontSize: 13),
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
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text(
                                "Kho: ${e.stock ?? 0}",
                                style: TextStyle(
                                    color: SahaColorUtils()
                                        .colorPrimaryTextWithWhiteBackground(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => !searchStampController.isChooseMany.value
                              ? searchStampController.checkChoose(
                                  productId: product.id,
                                  distributeName:
                                      (product.distributes != null &&
                                              product.distributes!.isNotEmpty)
                                          ? product.distributes![0].name
                                          : null,
                                  elementDistributeName:
                                      elementDistributes.name,
                                  subElementDistributeName: e.name,
                                )
                                  ? Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container()
                              : Checkbox(
                                  value: searchStampController.checkChoose(
                                    productId: product.id,
                                    distributeName:
                                        (product.distributes != null &&
                                                product.distributes!.isNotEmpty)
                                            ? product.distributes![0].name
                                            : null,
                                    elementDistributeName:
                                        elementDistributes.name,
                                    subElementDistributeName: e.name,
                                  ),
                                  onChanged: (v) {
                                    print("ssss");
                                    searchStampController.addOrRemoveSelected(
                                      stampCheck: Stamp(
                                        quantity: e.stock,
                                        productId: product.id,
                                        nameProduct: "${product.name}",
                                        barcode: elementDistributes2
                                            .subElementDistribute![
                                                (elementDistributes2
                                                    .subElementDistribute!
                                                    .indexWhere((sub) =>
                                                        sub.id == e.id))]
                                            .barcode,
                                        distributeName: (product.distributes !=
                                                    null &&
                                                product.distributes!.isNotEmpty)
                                            ? product.distributes![0].name
                                            : null,
                                        elementDistributeName:
                                            elementDistributes.name,
                                        subElementDistributeName: e.name,
                                        price: e.price,
                                        priceImport: e.priceImport,
                                        priceCapital: e.priceCapital,
                                      ),
                                    );
                                    setState(() {});
                                  }),
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
