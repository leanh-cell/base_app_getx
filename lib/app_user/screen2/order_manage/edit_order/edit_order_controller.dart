import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/const/order_constant.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/home_data/home_data_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/store/all_store_response.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/cart.dart';
import 'package:com.ikitech.store/app_user/model/cart_info.dart';
import 'package:com.ikitech.store/app_user/model/combo.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';
import 'package:com.ikitech.store/app_user/utils/thread_data.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import '../../../../saha_data_controller.dart';

class EditOrderController extends GetxController {
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

  String orderCode;

  EditOrderController({required this.orderCode}) {
    FlowData().setIsOnline(true);
    createCartOrder(orderCode);
  }

  void onDecreaseItem(int index) {
    if (listQuantityProductBuy[index] > 1) {
      listQuantityProductBuy[index] = listQuantityProductBuy[index] - 1;
    }
  }

  void onIncreaseItem(int index) {
    listQuantityProductBuy[index] = listQuantityProductBuy[index] + 1;
  }

  Future<void> createCartOrder(String orderCode) async {
    try {
      var data =
          await RepositoryManager.cartRepository.createCartOrder(orderCode);
      cartCurrent.value.id = data!.data!.id!;
      getCart();
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
      print(listOrder);
      listCheckCombo = (res.data!.cartData!.lineItems!);
      listUsedCombo(res.data!.cartData!.usedCombos ?? []);
      res.data!.cartData!.lineItems!.forEach((element) {
        listQuantityProductNew.add(element.quantity!);
      });
      cartCurrent.value = res.data!;
      print(cartCurrent.value.id!);
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
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingOrder.value = false;
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
}
