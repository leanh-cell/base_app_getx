// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/const/order_constant.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/home_data/home_data_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/store/all_store_response.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/cart.dart';
import 'package:com.ikitech.store/app_user/model/cart_info.dart';
import 'package:com.ikitech.store/app_user/model/combo.dart';
import 'package:com.ikitech.store/app_user/model/filter_order.dart';
import 'package:com.ikitech.store/app_user/model/printer.dart';
import 'package:com.ikitech.store/app_user/screen2/config/print/printers_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/order/order_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/time_keeping_staff/time_keeping_staff_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:com.ikitech.store/app_user/utils/thread_data.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:intl/intl.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import 'package:tiengviet/tiengviet.dart';
import '../../../saha_data_controller.dart';
import 'add_store/add_store.dart';

class HomeController extends GetxController {
  var isLoadingOrder = false.obs;
  var isLoadingAddress = false.obs;
  var infoCustomer = InfoCustomer().obs;
  var isSearch = false.obs;
  var isLoadingScreen = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingProduct = true.obs;
  var isLoadingProductMore = false.obs;
  var categories = RxList<Category>();
  var categoriesChild = RxList<Category>();
  var products = RxList<Product>();
  var categoryCurrent = (-1).obs;
  var categoryCurrentChild = (-1).obs;
  String textSearch = "";
  var sortByShow = "views".obs;
  var descendingShow = true.obs;
  var currentPage = 1;
  var isChooseDiscountSort = false.obs;
  var canLoadMore = true;
  var isDown = false.obs;
  var animateAddCart = false.obs;
  var isShowBanner = true.obs;
  Order? orderResponse;
  Category? categoryChoose;
  String? sortByCurrent;
  bool isPercentInput = false;
  var isShipment = false.obs;

  var listOrder = RxList<LineItem>();
  List<LineItem> listCheckCombo = [];
  var listQuantityProduct = RxList<int>();
  var listCombo = RxList<Combo>();
  var listUsedCombo = RxList<UsedCombo>();
  var enoughCondition = RxList<bool>([]);
  var enoughConditionCB = RxList<bool>([]);

  var balanceCollaboratorCanUse = 0.0.obs;
  var balanceCollaboratorUsed = 0.0.obs;
  var isUseBalanceCollaborator = false.obs;
  var isLoadingRefresh = false.obs;
  var isShowBill = false.obs;
  var timeInputSearch = DateTime.now();
  var listProductCombo = RxList<ProductsCombo>();
  var listQuantityProductNeedBuy = RxList<int>();
  var listQuantityProductBuy = RxList<int>();
  var discountComboType = 0.obs;
  var valueComboType = 0.0.obs;

  List<Product> listProductSave = [];
  List<int> listQuantityProductBuySave = [];
  Rx<int> idCurrentCombo = Rx<int>(-1);
  Rx<Store>? storeCurrent = Store().obs;
  var isLoadingStore = false.obs;
  var errMsg = "".obs;
  var checkNoStore = false.obs;
  var isHideInputQuantity = false.obs;
  int indexInputQuantity = 0;
  List<DistributesSelected> distributeSelected = [];
  SahaDataController sahaDataController = Get.find();
  var homeData = HomeDataUser().obs;
  var listCart = RxList<CartInfo>();
  var cartCurrent = CartInfo(id: 0).obs;
  var indexCart = 0;

  var finish = FinishHandle(milliseconds: 500);

  HomeController() {
    FlowData().setIsOnline(true);
    getHomeData();
    loadStoreCurrent();
    getListPrint();
    print(listPrinter);
    listPrinter
        .map((element) => {print("===================${element.ipPrinter}")});
  }

  void getHomeData() async {
    try {
      var data = await RepositoryManager.homeDataRepository.getHomeData();
      homeData(data);
    } catch (err) {}
  }

  void onDecreaseItem(int index) {
    if (listQuantityProductBuy[index] > 1) {
      listQuantityProductBuy[index] = listQuantityProductBuy[index] - 1;
    }
  }

  void onIncreaseItem(int index) {
    listQuantityProductBuy[index] = listQuantityProductBuy[index] + 1;
  }

  Future<void> refreshData() async {
    if (UserInfo().getCurrentStoreCode() != null) {
      searchProduct();
      getCart();
      getComboCustomer();
      getListPrint();
      sahaDataController.getBadge();
    }
  }

  Future<void> createCard(String name) async {
    try {
      var data = await RepositoryManager.cartRepository.createCart(name);
      listCart(data!.data!);
      if (listCart.isNotEmpty) {
        cartCurrent(listCart[0]);
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> scanProduct(String barcode) async {
    try {
      var data =
          await RepositoryManager.productRepository.scanProductHome(barcode);
      distributeSelected.addAll(data!.data!.distributes ?? []);
      var product = data.data!.product;
      if (product != null) {
        if (distributeSelected.isEmpty) {
          products([data.data!.product!]);
          listQuantityProductBuy([1]);
        } else {
          SahaDialogApp.showDialogInput(
              textInputType: TextInputType.number,
              title: "Nhập số lượng sản phẩm",
              onInput: (v) {
                if ((data.data?.quantity ?? 0) >= int.parse(v)) {
                  // addItemCart(product.id, int.parse(v), distributeSelected);
                  Get.back();
                } else {
                  SahaAlert.showError(
                      message: "Còn: ${(data.data?.quantity ?? 0)} Sản phẩm");
                }
              });
        }
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllCart() async {
    try {
      var data = await RepositoryManager.cartRepository.getAllCart();
      listCart(data!.data!);
      if (listCart.isNotEmpty) {
        cartCurrent(listCart[0]);
        getCart();
      } else {
        createCard("Giỏ 1");
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> createCartSave(String nameCart) async {
    try {
      var data =
          await RepositoryManager.cartRepository.createCartSave(nameCart);
      cartCurrent.value.id = 0;
      getCart();
      SahaAlert.showSuccess(message: "Đã lưu");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getCart() async {
    List<int> listQuantityProductNew = [];
    try {
      var res =
          await RepositoryManager.cartRepository.getCart(cartCurrent.value.id!);
      listOrder(res!.data!.cartData!.lineItems!);
      listCheckCombo = (res.data!.cartData!.lineItems!);
      listUsedCombo(res.data!.cartData!.usedCombos ?? []);
      res.data!.cartData!.lineItems!.forEach((element) {
        listQuantityProductNew.add(element.quantity!);
      });
      cartCurrent.value = res.data!;
      balanceCollaboratorCanUse.value =
          res.data!.cartData!.balanceCollaboratorCanUse ?? 0;
      balanceCollaboratorUsed.value =
          res.data!.cartData!.balanceCollaboratorUsed ?? 0;
      listQuantityProduct(listQuantityProductNew);
      checkProductInCombo();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void loadStoreCurrent({bool? isRefresh}) async {
    isLoadingStore.value = true;
    errMsg.refresh();
    if (isRefresh == true) {
      cartCurrent.value.id = 0;
    }
    try {
      var list = await RepositoryManager.storeRepository.getAll();

      if (list != null && list.isNotEmpty) {
        var indexStoreSelected;
        if (UserInfo().getCurrentStoreCode() != null) {
          indexStoreSelected = list.indexWhere(
              (storeE) => storeE.storeCode == UserInfo().getCurrentStoreCode());
        }

        if (indexStoreSelected != null && indexStoreSelected >= 0) {
        } else {
          indexStoreSelected = 0;
        }

        Store store;
        store = list[indexStoreSelected];
        await setNewStoreCurrent(store);
        await sahaDataController.getAllBranch().then((value) async {
          OrderController orderController = Get.find();
          orderController.filterOrder.value = FilterOrder(
              name: "Tất cả",
              listSource: [],
              listPaymentStt: [],
              listOrderStt: [],
              listBranch: [sahaDataController.branchCurrent.value]);
          if (value == true) {
            setUserIdCurrent(store);
            getAllCategory();
            searchProduct();
            getCart();
            getComboCustomer();
            await sahaDataController.getBadge();
            if (isRefresh != true) {
              Get.offAllNamed("home_screen");
            }
            // if (sahaDataController.badgeUser.value.isStaff == true &&
            //     sahaDataController.badgeUser.value.staffHasCheckin == false) {
            //   Get.to(() => TimeKeepingStaffScreen());
            // }
          }
        });
      } else {
        Get.to(() => AddStore())!.then((value) async {
          if (value == "create_success") {
            await sahaDataController.getAllBranch();
            getAllCategory();
            searchProduct();
            getCart();
            getComboCustomer();
            await sahaDataController.getBadge();
            if (isRefresh != true) {
              Get.offAllNamed("home_screen");
            }
            if (sahaDataController.badgeUser.value.isStaff == true &&
                sahaDataController.badgeUser.value.staffHasCheckin == false) {
              Get.to(() => TimeKeepingStaffScreen());
            }
          } else {
            UserInfo().logout();
          }
        });
        UserInfo().setCurrentStoreCode(null);
        StoreInfo().setCustomerStoreCode(null);
      }
      isLoadingStore.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      errMsg.value = err.toString();
      isLoadingStore.value = false;
    }
  }

  Future<void> setNewStoreCurrent(Store store) async {
    checkNoStore.value = false;
    await UserInfo().setCurrentStoreCode(store.storeCode);
    StoreInfo().setCustomerStoreCode(store.storeCode);
    storeCurrent!.value = store;
  }

  void setUserIdCurrent(Store store) {
    UserInfo().setCurrentIdUser(store.userId);
  }

  Future<void> clearCart() async {
    try {
      var data = await RepositoryManager.cartRepository
          .clearCart(cartId: cartCurrent.value.id!);
      getCart();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> orderCart(
      {required int paymentMethod, double? amountMoney, int? orderFrom}) async {
    if (listOrder.isEmpty) {
      SahaAlert.showError(message: "Giỏ hàng trống");
      return;
    }
    isLoadingOrder.value = true;
    if (cartCurrent.value.cartData?.voucherDiscountAmount == 0 &&
        cartCurrent.value.codeVoucher != null &&
        cartCurrent.value.codeVoucher != "") {
      cartCurrent.value.codeVoucher = null;
      await useVoucher((err) {});
    }
    try {
      var data = await RepositoryManager.cartRepository.orderCart(
          cartCurrent.value.id!,
          paymentMethod,
          amountMoney ?? 0,
          orderFrom ?? ORDER_FROM_POS_IN_STORE);
      isLoadingOrder.value = false;
      SahaAlert.showSuccess(message: "Tạo đơn thành công");
      orderResponse = data?.data;

      printAll();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingOrder.value = false;
  }

  Future<void> getAllCategory() async {
    isLoadingProduct.value = true;
    isLoadingCategory.value = true;
    try {
      var res = await RepositoryManager.categoryRepository.getAllCategory();
      categories(res!);
      if (categoryCurrent.value != -1) {}
      if (FlowData().isOnline()) {
        categories.insert(0, Category(name: "Tất cả mặt hàng", id: null));
      }
      categories.refresh();
    } catch (err) {
      print("======== Error in HomeController");
    }
    isLoadingCategory.value = false;
  }

  Future<void> searchProduct(
      {bool? descending, bool isLoadMore = false}) async {
    finish.run(() async {
      if (isLoadMore == false) {
        currentPage = 1;
        canLoadMore = true;
        isLoadingProduct.value = true;
      }

      if (isLoadMore == true) {
        isLoadingProductMore.value = true;
      }

      if (canLoadMore == false) {
        isLoadingProductMore.value = false;
        return;
      }

      try {
        var list = (await RepositoryManager.productRepository.searchProduct(
            page: currentPage,
            search: textSearch,
            idCategory: "${categoryChoose?.id ?? ""}",
            idCategoryChild: "",
            sortBy: "sales"))!;

        if (isLoadMore == false) {
          products(list);
          listQuantityProductBuy(list.map((e) => 1).toList());
        } else {
          products.addAll(list);
          listQuantityProductBuy.addAll(list.map((e) => 1).toList());
        }
        listProductSave = products.toList();
        listQuantityProductBuySave = listQuantityProductBuy.toList();

        print(listProductSave);
        if (list.length < 20) {
          canLoadMore = false;
        } else {
          currentPage++;
        }

        isLoadingProduct.value = false;
        isLoadingProductMore.value = false;
        return;
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
      isLoadingProduct.value = false;
      isLoadingProductMore.value = false;
    });
  }

  void increaseItem({
    required index,
    String? distributeName,
    String? elementDistributeName,
    String? subElementDistributeName,
  }) async {
    listQuantityProduct[index] = listQuantityProduct[index] + 1;
    listOrder.refresh();
    timeInputSearch = DateTime.now();
    await Future.delayed(Duration(milliseconds: 700));
    var diff = DateTime.now().difference(timeInputSearch);
    if (diff.inMilliseconds > 700) {
      updateItemCart(
        lineItemId: listOrder[index].id!,
        productId: listOrder[index].product!.id!,
        quantity: listQuantityProduct[index],
        distributeName: distributeName,
        elementDistributeName: elementDistributeName,
        subElementDistributeName: subElementDistributeName,
      );
    }
  }

  void decreaseItem({
    required index,
    String? distributeName,
    String? elementDistributeName,
    String? subElementDistributeName,
  }) async {
    if (listQuantityProduct[index] > 1) {
      listQuantityProduct[index] = listQuantityProduct[index] - 1;
      listOrder.refresh();
      timeInputSearch = DateTime.now();
      await Future.delayed(Duration(milliseconds: 700));
      var diff = DateTime.now().difference(timeInputSearch);
      if (diff.inMilliseconds > 700) {
        updateItemCart(
          lineItemId: listOrder[index].id!,
          productId: listOrder[index].product!.id!,
          quantity: listQuantityProduct[index],
          distributeName: distributeName,
          elementDistributeName: elementDistributeName,
          subElementDistributeName: subElementDistributeName,
        );
      }
    } else {
      return;
    }
  }

  Future<void> refresh() async {
    isLoadingRefresh.value = true;
    listCombo([]);
    listUsedCombo([]);
    listOrder([]);
    listQuantityProduct([]);
    getComboCustomer();
    getCart();
  }

  List<LineItem> listOrderNew = [];

  void checkProductInCombo() {
    listQuantityProductNeedBuy([]);
    listCheckCombo = listOrder.toList();
    listOrderNew = [];
    listProductCombo.forEach((element) {
      listQuantityProductNeedBuy.add(element.quantity!);
    });
    listOrderNew = [];

    listCheckCombo.toList().forEach((o) {
      var index =
          listOrderNew.indexWhere((e) => e.product!.id == o.product!.id);

      if (index != -1) {
        listOrderNew[index].quantity =
            (listOrderNew[index].quantity ?? 0) + (o.quantity ?? 0).toInt();
      } else {
        listOrderNew.add(o);
      }
    });

    if (listOrderNew.length == 0) {
      for (int i = 0; i < listProductCombo.length; i++) {
        listQuantityProductNeedBuy[i] = listProductCombo[i].quantity!;
      }
    } else {
      if (listOrderNew.length >= listProductCombo.length) {
        listOrderNew.forEach((e) {
          var checkHasInCombo = listProductCombo
              .indexWhere((element) => element.product!.id == e.product!.id);
          if (checkHasInCombo != -1) {
            if (listProductCombo[checkHasInCombo].quantity! >= e.quantity!) {
              // print(listProductCombo[checkHasInCombo].quantity!);
              // print(e.quantity!);
              listQuantityProductNeedBuy[checkHasInCombo] =
                  listProductCombo[checkHasInCombo].quantity! - e.quantity!;
            } else {
              listQuantityProductNeedBuy[checkHasInCombo] = 0;
            }
          }
        });
      } else {
        for (int i = 0; i < listProductCombo.length; i++) {
          var checkHasInCombo = listOrderNew.indexWhere((element) =>
              element.product!.id == listProductCombo[i].product!.id);
          if (checkHasInCombo != -1) {
            if (listProductCombo[i].quantity! >=
                listOrderNew[checkHasInCombo].quantity!) {
              listQuantityProductNeedBuy[i] = listProductCombo[i].quantity! -
                  listOrderNew[checkHasInCombo].quantity!;
            } else {
              listQuantityProductNeedBuy[i] = 0;
            }
          } else {
            listQuantityProductNeedBuy[i] = listProductCombo[i].quantity!;
          }
        }
      }
    }
    print(listQuantityProductNeedBuy);
  }

  bool checkEnoughCombo(Combo combo) {
    if (cartCurrent.value.cartData?.usedCombos == null ||
        (cartCurrent.value.cartData?.usedCombos ?? []).isEmpty) {
      return false;
    }
    if (cartCurrent.value.cartData!.usedCombos!
        .map((e) => e.combo)
        .toList()
        .map((e) => e!.id)
        .toList()
        .contains(combo.id)) {
      return true;
    }
    return false;
  }

  bool checkChooseCombo(int idCombo) {
    if (idCurrentCombo.value == idCombo) {
      return true;
    }
    return false;
  }

  Future<void> getComboCustomer() async {
    try {
      var res = await RepositoryManager.marketingChanel.getAllCombo();
      listCombo(res!.data!);
      if (res.data!.isNotEmpty) {
        listProductCombo(res.data![0].productsCombo);
      }
      listCheckCombo = listOrder.toList();
      checkProductInCombo();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    cartCurrent.refresh();
  }

  Future<void> useVoucher(Function error) async {
    try {
      var data = await RepositoryManager.cartRepository.useVoucher(
          cartCurrent.value.id, cartCurrent.value.codeVoucher ?? "");
      cartCurrent.value = data!.data!;
      error('success');
    } catch (err) {
      error('${err.toString()}');
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateInfoCart() async {
    List<int> listQuantityProductNew = [];
    try {
      var res = await RepositoryManager.cartRepository.updateInfoCart(
        cartCurrent.value.id!,
        cartCurrent.value,
      );
      listOrder(res!.data!.cartData!.lineItems!);
      checkProductInCombo();
      listUsedCombo(res.data!.cartData!.usedCombos ?? []);
      res.data!.cartData!.lineItems!.forEach((element) {
        listQuantityProductNew.add(element.quantity!);
      });
      listQuantityProduct(listQuantityProductNew);
      cartCurrent.value = res.data!;
      balanceCollaboratorCanUse.value =
          res.data!.cartData!.balanceCollaboratorCanUse ?? 0;
      balanceCollaboratorUsed.value =
          res.data!.cartData!.balanceCollaboratorUsed ?? 0;
      checkProductInCombo();
      print(
          "=======================${cartCurrent.value.cartData?.isUsePoints}");
    } catch (err) {
      print(err);
      // SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateItemCart({
    required int lineItemId,
    required int productId,
    required int quantity,
    String? distributeName,
    String? elementDistributeName,
    String? subElementDistributeName,
  }) async {
    List<int> listQuantityProductNew = [];
    try {
      var res = await RepositoryManager.cartRepository.updateItemCart(
        cartCurrent.value.id,
        lineItemId,
        productId,
        quantity,
        distributeName,
        elementDistributeName,
        subElementDistributeName,
      );
      listOrder(res!.data!.cartData!.lineItems!);
      listOrder.forEach((element) {
        print(element.quantity);
        listQuantityProductNew.add(element.quantity!);
      });
      listQuantityProduct(listQuantityProductNew);
      checkProductInCombo();
      listUsedCombo(res.data!.cartData!.usedCombos ?? []);
      cartCurrent.value = res.data!;
    } catch (err) {
      refresh();
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> noteItemCart({String? note,int? cartItemId}) async {
    try {
      var res = await RepositoryManager.cartRepository
          .noteItemCart(cartCurrent.value.id, cartItemId, note);
      cartCurrent.value = res!.data!;
      listOrder(res.data!.cartData!.lineItems!);
      
      SahaAlert.showSuccess(message: "Thành công");
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> addItemCart({
    required int idProduct,
    required int quantity,
    String? distributeName,
    String? elementDistributeName,
    String? subElementDistributeName,
  }) async {
    List<int> listQuantityProductNew = [];
    try {
      var res = await RepositoryManager.cartRepository.addItemCart(
        cartCurrent.value.id,
        idProduct,
        quantity,
        distributeName,
        elementDistributeName,
        subElementDistributeName,
      );
      listOrder(res!.data!.cartData!.lineItems!);
      checkProductInCombo();
      listUsedCombo(res.data!.cartData!.usedCombos ?? []);
      res.data!.cartData!.lineItems!.forEach((element) {
        listQuantityProductNew.add(element.quantity!);
      });
      listQuantityProduct(listQuantityProductNew);
      cartCurrent.value = res.data!;
      // getComboCustomer();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  var listPrinter = RxList<Printer>();
  void getListPrint() async {
    var box = await Hive.openBox('printers');
    print(box.values);
    listPrinter([]);
    box.values.forEach((element) {
      listPrinter.add(element);
    });
  }

  Future<void> printAll() async {
    if (UserInfo().getIsPrint() == false) {
      return;
    }
    bool isNoPrinterAuto = false;
    await Future.wait(listPrinter.map((e) {
      if (e.autoPrint == true) {
        if (e.ipPrinter == null) {
          return Future.value(null);
        } else {
          isNoPrinterAuto = true;
          return printBill(e.ipPrinter!);
        }
      } else {
        return Future.value(null);
      }
    }));
    if (isNoPrinterAuto == false) {
      if (listPrinter.isNotEmpty) {
        Get.to(() => PrintScreen(isChoosePrint: true));
      }
    }
  }

  Future<void> sendOrderEmail(String email) async {
    try {
      if (orderResponse?.orderCode == null) return;
      var data = await RepositoryManager.orderRepository
          .sendOrderEmail(email, orderResponse!.orderCode!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> printBill(String ipDevice) async {
    // const paper = PaperSize.mm80;
    // final profile = await CapabilityProfile.load();
    // final printer = NetworkPrinter(paper, profile);

    // final PosPrintResult res = await printer.connect(ipDevice, port: 9100);

    // if (res == PosPrintResult.success) {
    //   testReceipt(printer);
    //   printer.disconnect();
    //   // SahaAlert.showSuccess(message: "Đã in");
    // } else {
    //   SahaAlert.showError(message: "Không thể kết nối với máy in");
    // }

    // print('Print result: ${res.msg}');
  }

  // void testReceipt(NetworkPrinter printer) async {
  //   var data = sahaDataController.badgeUser.value.infoAddress;
  //   var order = orderResponse;
  //   if (order == null) return;
  //   printer.text(
  //       TiengViet.parse('${storeCurrent?.value.name ?? ""}'.toUpperCase()),
  //       styles: PosStyles(
  //         height: PosTextSize.size2,
  //         width: PosTextSize.size2,
  //         bold: true,
  //         align: PosAlign.center,
  //       ),
  //       linesAfter: 1);

  //   printer.text(TiengViet.parse('${storeCurrent?.value.address ?? ""}'),
  //       styles: PosStyles(align: PosAlign.center), linesAfter: 1);
  //   printer.text("Phone: ${data?.phone ?? ""}",
  //       styles: PosStyles(align: PosAlign.center), linesAfter: 1);

  //   printer.text(
  //     TiengViet.parse('HOÁ ĐƠN'),
  //     styles: PosStyles(
  //       height: PosTextSize.size2,
  //       width: PosTextSize.size2,
  //       bold: true,
  //       align: PosAlign.center,
  //     ),
  //   );
  //   printer.feed(1);
  //   printer.text(TiengViet.parse('Mã đơn hàng: ${order.orderCode ?? ""}'),
  //       styles: PosStyles(
  //         align: PosAlign.center,
  //       ));
  //   printer.feed(1);
  //   printer.text(
  //       TiengViet.parse(
  //           'Ngày: ${SahaDateUtils().getDDMMYY(DateTime.now())}  ${DateFormat('HH:mm:ss').format(DateTime.now())}'),
  //       styles: PosStyles(
  //         align: PosAlign.left,
  //       ));
  //   printer.feed(1);

  //   printer.hr();
  //   printer.row([
  //     PosColumn(
  //         text: 'San pham', width: 6, styles: PosStyles(align: PosAlign.left)),
  //     PosColumn(text: 'SL', width: 1, styles: PosStyles(align: PosAlign.left)),
  //     PosColumn(text: 'Gia', width: 2, styles: PosStyles(align: PosAlign.left)),
  //     PosColumn(
  //         text: 'Total', width: 3, styles: PosStyles(align: PosAlign.left)),
  //   ]);
  //   if (order.lineItemsAtTime != null) {
  //     order.lineItemsAtTime!.forEach((e) {
  //       printer.row([
  //         PosColumn(
  //           text: '${TiengViet.parse(e.name ?? "")}',
  //           width: 6,
  //           styles: PosStyles(
  //             align: PosAlign.left,
  //           ),
  //         ),
  //         PosColumn(
  //           text: '${e.quantity}',
  //           width: 1,
  //           styles: PosStyles(
  //             align: PosAlign.left,
  //           ),
  //         ),
  //         PosColumn(
  //           text: '${SahaStringUtils().convertToK(e.itemPrice ?? 0)}',
  //           width: 2,
  //           styles: PosStyles(
  //             align: PosAlign.left,
  //           ),
  //         ),
  //         PosColumn(
  //           text:
  //               '${SahaStringUtils().convertToK(e.itemPrice! * (e.quantity!))}',
  //           width: 3,
  //           styles: PosStyles(
  //             align: PosAlign.left,
  //           ),
  //         ),
  //       ]);
  //     });
  //   }
  //   if (order.totalShippingFee != null) {
  //     printer.row([
  //       PosColumn(
  //         text: 'Phi giao hang',
  //         width: 6,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text: '1',
  //         width: 1,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text: '${SahaStringUtils().convertToK(order.totalShippingFee ?? 0)}',
  //         width: 2,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text: '${SahaStringUtils().convertToK(order.totalShippingFee ?? 0)}',
  //         width: 3,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //     ]);
  //   }
  //   if (order.productDiscountAmount != null &&
  //       order.productDiscountAmount != 0) {
  //     printer.row([
  //       PosColumn(
  //         text: 'Sale san pham',
  //         width: 6,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text: '1',
  //         width: 1,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text:
  //             '-${SahaStringUtils().convertToK(order.productDiscountAmount ?? 0)}',
  //         width: 2,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text:
  //             '-${SahaStringUtils().convertToK(order.productDiscountAmount ?? 0)}',
  //         width: 3,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //     ]);
  //   }
  //   if (order.voucherDiscountAmount != null &&
  //       order.voucherDiscountAmount != 0) {
  //     printer.row([
  //       PosColumn(
  //         text: 'Voucher',
  //         width: 6,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text: '1',
  //         width: 1,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text:
  //             '-${SahaStringUtils().convertToK(order.voucherDiscountAmount ?? 0)}',
  //         width: 2,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text:
  //             '-${SahaStringUtils().convertToK(order.voucherDiscountAmount ?? 0)}',
  //         width: 3,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //     ]);
  //   }
  //   if (order.comboDiscountAmount != null && order.comboDiscountAmount != 0) {
  //     printer.row([
  //       PosColumn(
  //         text: 'Combo',
  //         width: 6,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text: '1',
  //         width: 1,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text:
  //             '-${SahaStringUtils().convertToK(order.comboDiscountAmount ?? 0)}',
  //         width: 2,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text:
  //             '-${SahaStringUtils().convertToK(order.comboDiscountAmount ?? 0)}',
  //         width: 3,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //     ]);
  //   }
  //   printer.hr();
  //   printer.row([
  //     PosColumn(
  //         text: 'TOTAL',
  //         width: 3,
  //         styles: PosStyles(
  //           height: PosTextSize.size2,
  //           width: PosTextSize.size2,
  //         )),
  //     PosColumn(
  //         text:
  //             '${SahaStringUtils().convertToMoney(order.totalFinal ?? 0)} VND',
  //         width: 9,
  //         styles: PosStyles(
  //           align: PosAlign.right,
  //           height: PosTextSize.size2,
  //           width: PosTextSize.size2,
  //         )),
  //   ]);

  //   if (order.customerNote != null) {
  //     printer.feed(1);
  //     printer.text('Ghi chu: ${order.customerNote ?? ""}',
  //         styles: PosStyles(align: PosAlign.center, bold: true));
  //   }

  //   printer.hr(ch: '=', linesAfter: 1);

  //   printer.feed(1);
  //   printer.text('Xin cam on!',
  //       styles: PosStyles(align: PosAlign.center, bold: true));
  //   printer.feed(1);
  //   printer.text('COPYRIGHT © IKITECH.VN',
  //       styles:
  //           PosStyles(align: PosAlign.center, bold: true, codeTable: 'CP1252'));
  //   printer.feed(2);
  //   printer.cut();
  // }
}
