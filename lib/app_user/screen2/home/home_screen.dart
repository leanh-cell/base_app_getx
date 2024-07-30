import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/item_cart_animation/item_cart_animation.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/widget/text_sized.dart';
import 'package:com.ikitech.store/app_user/screen2/home/list_cart/list_cart_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/info_customer/info_customer_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/widget/item_product.dart';
import 'package:com.ikitech.store/app_user/screen2/widget/modal_bottom_option_buy_product.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'choose_customer/choose_customer_screen.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.find();

  RefreshController _refreshController = RefreshController();
  RefreshController _refreshController2 = RefreshController();

  TextEditingController searchEditingController = TextEditingController();
  TextEditingController inputQuantityEditingController =
      TextEditingController();

  var timeInputSearch = DateTime.now();

  FocusNode focusNode = FocusNode();

  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCardAnimation;

  var _cartQuantityItems = 0;

  List<String> choices = ["Xoá nội dung trong giỏ hàng", "Đơn lưu tạm"];

  FocusNode inputQuantityFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AddToCartAnimation(
      // To send the library the location of the Cart icon
      gkCart: gkCart,
      rotation: false,
      dragToCardCurve: Curves.easeIn,
      dragToCardDuration: const Duration(milliseconds: 200),
      previewCurve: Curves.linearToEaseOut,
      previewDuration: const Duration(milliseconds: 0),
      opacity: 1,
      initiaJump: true,
      receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
        this.runAddToCardAnimation = addToCardAnimationMethod;
      },
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            title: GestureDetector(
              onTap: () {
                homeController.isShowBill.value =
                    !homeController.isShowBill.value;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (homeController.isShowBill.value == true)
                    InkWell(
                      onTap: () {
                        homeController.isShowBill.value = false;
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 10, bottom: 5, top: 5),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  Text(
                    "${homeController.cartCurrent.value.isDefault == true ? "Giỏ hàng" : homeController.cartCurrent.value.name ?? ""}",
                    key: gkCart,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/cart.svg",
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                      Positioned(
                        top: 7,
                        child: Obx(
                          () => Text(
                            "${homeController.listOrder.length}",
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (homeController.cartCurrent.value.isDefault != true)
                    IconButton(
                        onPressed: () {
                          SahaDialogApp.showDialogYesNo(
                              mess: "Trở về giỏ hàng mặc định",
                              onOK: () {
                                homeController.cartCurrent.value.id = 0;
                                homeController.getCart();
                              });
                        },
                        icon: Icon(Icons.settings_backup_restore)),
                ],
              ),
            ),
            actions: [
              PopupMenuButton(
                elevation: 3.2,
                onCanceled: () {},
                icon: Icon(Icons.more_vert),
                onSelected: (v) async {
                  print(v);
                  if (v == "Xoá nội dung trong giỏ hàng") {
                    homeController.clearCart();
                  } else {
                    Get.to(() => ListCartScreen())!.then((value) => {
                          if (value != null && value['cart_info'] != null)
                            {
                              homeController.cartCurrent.value =
                                  value['cart_info'],
                              homeController.getCart(),
                            }
                        });
                  }
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
            ],
          ),
          body: Obx(
            () => homeController.isShowBill.value == true
                ? showBill()
                : Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if (homeController.listOrder.isNotEmpty) {
                                  Get.toNamed("pay_screen");
                                }
                              },
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.only(
                                    top: 15, bottom: 15, left: 10, right: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "THANH TOÁN",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.totalBeforeDiscount ?? 0)}₫",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!)),
                        child: Obx(
                          () => homeController.isSearch.value
                              ? TextFormField(
                                  controller: searchEditingController,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 15,
                                        bottom: 15),
                                    border: InputBorder.none,
                                    hintText: "Tìm kiếm",
                                    hintStyle: TextStyle(fontSize: 15),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        searchEditingController.clear();
                                        homeController.isSearch.value = false;
                                        homeController.textSearch = "";
                                        homeController.searchProduct();
                                      },
                                      icon: Icon(Icons.clear),
                                    ),
                                  ),
                                  onChanged: (v) async {
                                    homeController.textSearch = v;
                                    homeController.searchProduct();
                                  },
                                  style: TextStyle(fontSize: 14),
                                  minLines: 1,
                                  maxLines: 1,
                                )
                              : Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => DropdownButton<Category>(
                                          //iconSize: 0,
                                          underline: SizedBox(),
                                          value: homeController.categoryChoose,
                                          hint: Text(
                                            "Tất cả mặt hàng",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                          items: homeController.categories
                                              .map((Category cate) {
                                            return DropdownMenuItem<Category>(
                                              value: cate,
                                              child: SizedBox(
                                                width: Get.width - 200,
                                                child:
                                                    Text("${cate.name ?? ""}"),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (v) {
                                            homeController.categoryChoose = v;
                                            homeController.categories.refresh();
                                            homeController.searchProduct();
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 2,
                                      height: 30,
                                      color: Colors.grey[200],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          scanBarcodeNormal();
                                        },
                                        icon: Icon(
                                          Ionicons.barcode_outline,
                                        )),
                                    Container(
                                      width: 2,
                                      height: 30,
                                      color: Colors.grey[200],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          homeController.isSearch.value = true;
                                          focusNode.requestFocus();
                                        },
                                        icon: Icon(Icons.search))
                                  ],
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Obx(
                            () => Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: [
                                ...List.generate(
                                  homeController.listCombo.length,
                                  (index) => InkWell(
                                    onTap: () async {
                                      homeController.products(homeController
                                          .listCombo[index].productsCombo!
                                          .map((e) => e.product!)
                                          .toList());
                                      homeController.listQuantityProductBuy(
                                          homeController
                                              .listCombo[index].productsCombo!
                                              .map((e) => 1)
                                              .toList());
                                      homeController.listProductCombo(
                                          homeController
                                              .listCombo[index].productsCombo!);
                                      homeController.checkProductInCombo();
                                      if (homeController.idCurrentCombo.value ==
                                          homeController.listCombo[index].id) {
                                        homeController.idCurrentCombo.value =
                                            -1;
                                        homeController.products(
                                            homeController.listProductSave);
                                        homeController.listQuantityProductBuy(
                                            homeController
                                                .listQuantityProductBuySave);
                                      } else {
                                        homeController.idCurrentCombo.value =
                                            homeController.listCombo[index].id!;
                                      }
                                    },
                                    child: TextSized(
                                      "Combo ${homeController.listCombo[index].name}",
                                      colorBox: Colors.white,
                                      colorBorder: homeController
                                              .checkEnoughCombo(homeController
                                                  .listCombo[index])
                                          ? Colors.green
                                          : homeController.checkChooseCombo(
                                                  homeController
                                                      .listCombo[index].id!)
                                              ? null
                                              : Colors.grey,
                                      style: TextStyle(
                                        color: homeController.checkEnoughCombo(
                                                homeController.listCombo[index])
                                            ? Colors.green
                                            : homeController.checkChooseCombo(
                                                    homeController
                                                        .listCombo[index].id!)
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (homeController.idCurrentCombo.value != -1)
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...List.generate(
                                homeController.listProductCombo.length,
                                (index) => homeController
                                                .listQuantityProductNeedBuy[
                                            index] ==
                                        0
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                homeController
                                                        .listProductCombo[index]
                                                        .product!
                                                        .name ??
                                                    "",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                            Text(
                                                "x ${homeController.listQuantityProductNeedBuy[index]}"),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                      ),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      Expanded(
                        child: Obx(
                          () => homeController.products.isEmpty ? Center(
                            child: Text("Không có sản phẩm nào"),
                          ) : SmartRefresher(
                            enablePullDown: true,
                            enablePullUp:
                                homeController.idCurrentCombo.value != -1
                                    ? false
                                    : true,
                            header: MaterialClassicHeader(),
                            footer: CustomFooter(
                              builder: (
                                BuildContext context,
                                LoadStatus? mode,
                              ) {
                                Widget body = Container();
                                if (mode == LoadStatus.idle) {
                                  body = Obx(() =>
                                      homeController.isLoadingProductMore.value
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
                            controller: _refreshController,
                            onRefresh: () async {
                              await homeController.refreshData();
                              _refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              homeController.searchProduct(isLoadMore: true);
                              _refreshController.loadComplete();
                            },
                            child: ListView.builder(
                              itemCount: homeController.products.length,
                              itemBuilder: (context, index) {
                                return ItemCartAnimation(
                                  onDecreaseItem: () {
                                    setState(() {
                                      homeController.onDecreaseItem(index);
                                    });
                                  },
                                  onIncreaseItem: (GlobalKey gkImageContainer) {
                                    setState(() {
                                      if (homeController.products[index]
                                                  .distributes !=
                                              null &&
                                          homeController.products[index]
                                              .distributes!.isNotEmpty) {
                                        ModalBottomOptionBuyProductUser
                                            .showModelOption(
                                                isLoadingProduct: true,
                                                textButton: "Thêm vào giỏ hàng",
                                                product: homeController
                                                    .products[index],
                                                onSubmit: (int quantity,
                                                    Product product,
                                                    List<DistributesSelected>
                                                        distributesSelected) async {
                                                  Get.back();
                                                  listClick(gkImageContainer);
                                                  if (distributesSelected
                                                      .isNotEmpty) {
                                                    await homeController
                                                        .addItemCart(
                                                      idProduct: product.id!,
                                                      quantity: quantity,
                                                      distributeName:
                                                          distributesSelected[0]
                                                              .name,
                                                      elementDistributeName:
                                                          distributesSelected[0]
                                                              .value,
                                                      subElementDistributeName:
                                                          distributesSelected[0]
                                                              .subElement,
                                                    );
                                                  } else {
                                                    await homeController
                                                        .addItemCart(
                                                      idProduct: product.id!,
                                                      quantity: quantity,
                                                    );
                                                  }
                                                  homeController.getCart();
                                                });
                                      } else {
                                        homeController.onIncreaseItem(index);
                                      }
                                    });
                                  },
                                  quantityInput: (GlobalKey gkImageContainer) {
                                    if (homeController
                                                .products[index].distributes !=
                                            null &&
                                        homeController.products[index]
                                            .distributes!.isNotEmpty) {
                                      ModalBottomOptionBuyProductUser
                                          .showModelOption(
                                              isLoadingProduct: true,
                                              textButton: "Thêm vào giỏ hàng",
                                              product: homeController
                                                  .products[index],
                                              onSubmit: (int quantity,
                                                  Product product,
                                                  List<DistributesSelected>
                                                      distributesSelected) async {
                                                Get.back();
                                                listClick(gkImageContainer);
                                                if (distributesSelected
                                                    .isNotEmpty) {
                                                  await homeController
                                                      .addItemCart(
                                                    idProduct: product.id!,
                                                    quantity: quantity,
                                                    distributeName:
                                                        distributesSelected[0]
                                                            .name,
                                                    elementDistributeName:
                                                        distributesSelected[0]
                                                            .value,
                                                    subElementDistributeName:
                                                        distributesSelected[0]
                                                            .subElement,
                                                  );
                                                } else {
                                                  await homeController
                                                      .addItemCart(
                                                    idProduct: product.id!,
                                                    quantity: quantity,
                                                  );
                                                }
                                                homeController.getCart();
                                              });
                                    } else {
                                      homeController.indexInputQuantity = index;
                                      homeController.isHideInputQuantity.value =
                                          true;
                                      inputQuantityEditingController.text = homeController
                                          .listQuantityProductBuy[index].toString();
                                      inputQuantityFocusNode.requestFocus();
                                    }
                                  },
                                  quantity: homeController
                                      .listQuantityProductBuy[index],
                                  onTap: (GlobalKey gkImageContainer) async {
                                    if (homeController
                                                .products[index].distributes !=
                                            null &&
                                        homeController.products[index]
                                            .distributes!.isNotEmpty) {
                                      ModalBottomOptionBuyProductUser
                                          .showModelOption(
                                              isLoadingProduct: true,
                                              textButton: "Thêm vào giỏ hàng",
                                              product: homeController
                                                  .products[index],
                                              onSubmit: (int quantity,
                                                  Product product,
                                                  List<DistributesSelected>
                                                      distributesSelected) async {
                                                Get.back();
                                                listClick(gkImageContainer);
                                                if (distributesSelected
                                                    .isNotEmpty) {
                                                  await homeController
                                                      .addItemCart(
                                                    idProduct: product.id!,
                                                    quantity: quantity,
                                                    distributeName:
                                                        distributesSelected[0]
                                                            .name,
                                                    elementDistributeName:
                                                        distributesSelected[0]
                                                            .value,
                                                    subElementDistributeName:
                                                        distributesSelected[0]
                                                            .subElement,
                                                  );
                                                } else {
                                                  await homeController
                                                      .addItemCart(
                                                    idProduct: product.id!,
                                                    quantity: quantity,
                                                  );
                                                }
                                                homeController.getCart();
                                              });
                                    } else {
                                      listClick(gkImageContainer);
                                      await homeController.addItemCart(
                                        idProduct:
                                            homeController.products[index].id!,
                                        quantity: homeController
                                            .listQuantityProductBuy[index],
                                      );
                                      homeController
                                          .listQuantityProductBuy[index] = 1;
                                      homeController.getCart();
                                    }
                                  },
                                  product: homeController.products[index],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      if (homeController.isHideInputQuantity.value)
                        Container(
                          width: Get.width,
                          height: 130,
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Column(
                            children: [
                              Text("Nhập số lượng"),
                              TextField(
                                controller: inputQuantityEditingController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                focusNode: inputQuantityFocusNode,
                              ),
                              TextButton(
                                  onPressed: () {
                                    homeController.isHideInputQuantity.value =
                                        false;
                                    FocusScope.of(context).unfocus();
                                    homeController.listQuantityProductBuy[
                                        homeController
                                            .indexInputQuantity] = int.parse(
                                        inputQuantityEditingController.text);
                                  },
                                  child: Text("Xong"))
                            ],
                          ),
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void listClick(GlobalKey gkImageContainer) async {
    await runAddToCardAnimation(gkImageContainer);
    await gkCart.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());
  }

  Widget showBill() {
    return Obx(() {
      return Container(
        child: Column(
          children: [
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
                      body = Obx(() => homeController.isLoadingProductMore.value
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
                controller: _refreshController2,
                onRefresh: () async {
                  homeController.getCart();
                  _refreshController2.refreshCompleted();
                },
                child: Column(
                  children: [
                    // if (homeController.listOrder.isEmpty)
                    //   SahaEmptyCart(
                    //     width: 50,
                    //     height: 50,
                    //   ),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => InkWell(
                        onTap: () {
                          if (homeController.cartCurrent.value.infoCustomer !=
                              null) {
                            Get.to(() => InfoCustomerScreen(
                                  infoCustomerId: homeController
                                      .cartCurrent.value.customerId!,
                                  isCancel: true,
                                  isInPayScreen: false,
                                ));
                          } else {
                            Get.to(() => ChooseCustomerScreen(
                                  isInPayScreen: false,
                                ));
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              homeController.cartCurrent.value.infoCustomer !=
                                      null
                                  ? Text(
                                      "${homeController.cartCurrent.value.infoCustomer?.name ?? ""} ${homeController.cartCurrent.value.infoCustomer?.phoneNumber ?? ""}")
                                  : Text("Chọn khách hàng"),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.builder(
                              itemCount: homeController.listOrder.length,
                              itemBuilder: (context, index) {
                                print(homeController.listOrder[index].quantity);
                                return ItemProductInCartWidget(
                                  lineItem: homeController.listOrder[index],
                                  onDismissed: () async {
                                    if (homeController.listOrder[index]
                                                .distributesSelected !=
                                            null &&
                                        homeController.listOrder[index]
                                            .distributesSelected!.isNotEmpty) {
                                      homeController.listQuantityProduct
                                          .removeAt(index);
                                      homeController.updateItemCart(
                                        lineItemId:
                                            homeController.listOrder[index].id!,
                                        productId: homeController
                                            .listOrder[index].product!.id!,
                                        quantity: 0,
                                        distributeName: homeController
                                            .listOrder[index]
                                            .distributesSelected![0]
                                            .name,
                                        elementDistributeName: homeController
                                            .listOrder[index]
                                            .distributesSelected![0]
                                            .value,
                                        subElementDistributeName: homeController
                                            .listOrder[index]
                                            .distributesSelected![0]
                                            .subElement,
                                      );
                                    } else {
                                      homeController.updateItemCart(
                                        lineItemId:
                                            homeController.listOrder[index].id!,
                                        productId: homeController
                                            .listOrder[index].product!.id!,
                                        quantity: 0,
                                      );
                                    }

                                    homeController.listOrder.removeAt(index);
                                  },
                                  onDecreaseItem: () {
                                    if (homeController.listOrder[index]
                                                .distributesSelected !=
                                            null &&
                                        homeController.listOrder[index]
                                            .distributesSelected!.isNotEmpty) {
                                      homeController.decreaseItem(
                                        index: index,
                                        distributeName: homeController
                                            .listOrder[index]
                                            .distributesSelected![0]
                                            .name,
                                        elementDistributeName: homeController
                                            .listOrder[index]
                                            .distributesSelected![0]
                                            .value,
                                        subElementDistributeName: homeController
                                            .listOrder[index]
                                            .distributesSelected![0]
                                            .subElement,
                                      );
                                    } else {
                                      homeController.decreaseItem(
                                        index: index,
                                      );
                                    }
                                  },
                                  onIncreaseItem: () {
                                    if (homeController.listOrder[index]
                                                .distributesSelected !=
                                            null &&
                                        homeController.listOrder[index]
                                            .distributesSelected!.isNotEmpty) {
                                      homeController.increaseItem(
                                        index: index,
                                        distributeName: homeController
                                            .listOrder[index]
                                            .distributesSelected![0]
                                            .name,
                                        elementDistributeName: homeController
                                            .listOrder[index]
                                            .distributesSelected![0]
                                            .value,
                                        subElementDistributeName: homeController
                                            .listOrder[index]
                                            .distributesSelected![0]
                                            .subElement,
                                      );
                                    } else {
                                      homeController.increaseItem(
                                        index: index,
                                      );
                                    }
                                  },
                                  onUpdateProduct:
                                      (quantity, distributesSelected) {
                                    if (distributesSelected.isNotEmpty) {
                                      homeController.updateItemCart(
                                        lineItemId:
                                            homeController.listOrder[index].id!,
                                        productId: homeController
                                            .listOrder[index].product!.id!,
                                        quantity: quantity,
                                        distributeName:
                                            distributesSelected[0].name,
                                        elementDistributeName:
                                            distributesSelected[0].value,
                                        subElementDistributeName:
                                            distributesSelected[0].subElement,
                                      );
                                    } else {
                                      homeController.updateItemCart(
                                        lineItemId:
                                            homeController.listOrder[index].id!,
                                        productId: homeController
                                            .listOrder[index].product!.id!,
                                        quantity: quantity,
                                      );
                                    }
                                  },
                                  quantity:
                                      homeController.listQuantityProduct[index],
                                  onNote: (int cartItemId,String? note){
                                    homeController.noteItemCart(note : note,cartItemId: cartItemId);
                                  },
                                );
                              }),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(top: 8),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Tiền hàng",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18),
                                ),
                                Spacer(),
                                Obx(
                                  () => Text(
                                    "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.totalBeforeDiscount ?? 0)}₫",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Row(
                            children: [
                              if (homeController.cartCurrent.value.isDefault ==
                                  true)
                                Expanded(
                                  child: SahaButtonFullParent(
                                    text: "LƯU TẠM",
                                    textColor: Theme.of(context).primaryColor,
                                    onPressed: () async {
                                      SahaDialogApp.showDialogInput(
                                          title: "Nhập đơn lưu tạm",
                                          onInput: (v) {
                                            homeController.createCartSave(v);
                                            Get.back();
                                            homeController.isShowBill.value =
                                                false;
                                          },
                                          onCancel: () {
                                            Get.back();
                                          });
                                    },
                                    color: Colors.white,
                                  ),
                                ),
                              Expanded(
                                child: SahaButtonFullParent(
                                  text: "THANH TOÁN",
                                  onPressed: () async {
                                    if ((homeController
                                                .cartCurrent
                                                .value
                                                .cartData
                                                ?.totalBeforeDiscount ??
                                            0) >
                                        0) {
                                      Get.toNamed("pay_screen");
                                    }
                                  },
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
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

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    homeController.scanProduct(barcodeScanRes);
  }
}
