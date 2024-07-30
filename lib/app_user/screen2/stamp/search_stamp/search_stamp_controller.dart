import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/all_product_response.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/stamp.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';
import 'package:com.ikitech.store/app_user/utils/thread_data.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

class SearchStampController extends GetxController {
  var loading = false.obs;
  var listProduct = RxList<Product>();
  int currentPage = 1;
  bool isEndLoadMore = false;
  var productsSelected = RxList<int>();
  String searchText = "";
  var isLongPress = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingProduct = true.obs;
  var categories = RxList<Category>();
  var categoryCurrent = (-1).obs;
  Category? categoryChoose;
  var isSearch = false.obs;
  var isChooseMany = false.obs;
  var listStamp = RxList<Stamp>();
  List<Stamp>? listStampInput;
  var finish = FinishHandle(milliseconds: 500);

  SearchStampController({this.listStampInput}) {
    if (listStampInput != null) {
      listStamp(listStampInput);
    }
    EasyLoading.show();
    getAllCategory();
    getAllProduct();
  }

  void addAll() {
    listStamp([]);
    listProduct.forEach((product) {
      if (product.inventory?.distributes != null &&
          product.inventory!.distributes!.isNotEmpty) {
        var elm = product.inventory!.distributes![0].elementDistributes;
        if (elm != null && elm.isNotEmpty) {
          elm.forEach(
            (elm) {
              if (elm.subElementDistribute != null &&
                  elm.subElementDistribute!.isNotEmpty) {
                var sub = elm.subElementDistribute!;
                sub.forEach((sub) {
                  listStamp.add(Stamp(
                    productId: product.id,
                    nameProduct: "${product.name}",
                    barcode: sub.barcode,
                    price: sub.price,
                    priceImport: sub.priceImport,
                    priceCapital: sub.priceCapital,
                    quantity: sub.stock ?? 0,
                    distributeName: (product.distributes != null &&
                            product.distributes!.isNotEmpty)
                        ? product.distributes![0].name
                        : null,
                    elementDistributeName: elm.name,
                    subElementDistributeName: sub.name,
                  ));
                });
              } else {
                listStamp.add(
                  Stamp(
                    productId: product.id,
                    nameProduct: "${product.name}",
                    distributeName: (product.distributes != null &&
                            product.distributes!.isNotEmpty)
                        ? product.distributes![0].name
                        : null,
                    barcode: elm.barcode,
                    price: elm.price,
                    priceImport: elm.priceImport,
                    priceCapital: elm.priceCapital,
                    quantity: elm.stock ?? 0,
                    elementDistributeName: elm.name,
                    subElementDistributeName: null,
                  ),
                );
              }
            },
          );
        }
      } else {
        listStamp.add(Stamp(
          productId: product.id,
          nameProduct: "${product.name}",
          distributeName: null,
          elementDistributeName: null,
          subElementDistributeName: null,
          barcode: product.barcode,
          price: product.price,
          priceImport: product.priceImport,
          priceCapital: product.priceCapital,
          quantity: product.inventory?.mainStock ?? 0,
        ));
      }
    });
  }

  void addOrRemoveSelected({
    required Stamp stampCheck,
  }) {
    var index = listStamp.indexWhere((stamp) => (stamp.productId ==
            stampCheck.productId &&
        stamp.distributeName == stampCheck.distributeName &&
        stamp.elementDistributeName == stampCheck.elementDistributeName &&
        stamp.subElementDistributeName == stampCheck.subElementDistributeName));

    if (index == -1) {
      listStamp.add(stampCheck);
    } else {
      listStamp.removeAt(index);
    }
    print(listStamp);
  }

  bool checkChoose({
    int? productId,
    String? distributeName,
    String? elementDistributeName,
    String? subElementDistributeName,
  }) {
    var index = listStamp.indexWhere((stamp) => (stamp.productId == productId &&
        stamp.distributeName == distributeName &&
        stamp.elementDistributeName == elementDistributeName &&
        stamp.subElementDistributeName == subElementDistributeName));
    if (index == -1) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> getAllProduct({bool isRefresh = false}) async {
    finish.run(() async {
      loading.value = true;

      if (isRefresh == true) {
        currentPage = 1;
        isEndLoadMore = false;
        currentPage = 1;
      }

      if (isEndLoadMore) {
        return;
      }

      try {
        late DataPageProduct data;
        data = (await RepositoryManager.productRepository.getAllProductV2(
            search: searchText,
            idCategory: searchText != "" ? "" : "${categoryChoose?.id ?? ""}",
            status: "0",
            filterBy: "quantity_in_stock",
            filterOption: "ne",
            filterByValue: "0",
            page: currentPage)) as DataPageProduct;

        var list = data.data;

        if (list!.length < 20) {
          isEndLoadMore = true;
        }
        currentPage++;
        if (isRefresh == true) {
          listProduct(list);
        } else {
          listProduct.addAll(list);
        }
        EasyLoading.dismiss();
        loading.value = false;
        return;
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
      loading.value = false;
      EasyLoading.dismiss();
    });
  }

  Future<void> getAllCategory() async {
    isLoadingProduct.value = true;
    isLoadingCategory.value = true;
    try {
      var res = await RepositoryManager.categoryRepository.getAllCategory();
      categories(res!);
      if (categoryCurrent.value != -1) {}
      if (FlowData().isOnline()) {
        categories.insert(0, Category(name: "Tất cả sản phẩm", id: null));
      }
      categories.refresh();
    } catch (err) {
      print("======== Error in HomeController");
    }
    isLoadingCategory.value = false;
  }

  Future<void> scanProduct(String barcode) async {
    try {
      var data = await RepositoryManager.productRepository.scanProduct(barcode);
      if (data?.data?.data != null) {
        listProduct(data!.data!.data!);
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
