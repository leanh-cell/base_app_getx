import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/all_product_response.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';
import 'package:com.ikitech.store/app_user/utils/thread_data.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../model/transfer_stock_item.dart';

class SearchProductTransferController extends GetxController {
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
  int branchIdInput;
  var listTransferStockItem = RxList<TransferStockItem>();
  List<TransferStockItem>? inputListTransferStockItem;
  var finish = FinishHandle(milliseconds: 500);

  SearchProductTransferController({
    this.inputListTransferStockItem,
    required this.branchIdInput,
  }) {
    if (inputListTransferStockItem != null) {
      listTransferStockItem(inputListTransferStockItem);
    }
    EasyLoading.show();
    getAllCategory();
    getAllProduct();
  }

  void addAll() {
    listTransferStockItem([]);
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
                  listTransferStockItem.add(
                    TransferStockItem(
                      productId: product.id,
                      distributeName: (product.distributes != null &&
                              product.distributes!.isNotEmpty)
                          ? product.distributes![0].name
                          : null,
                      quantity: 1,
                      elementDistributeName: elm.name,
                      subElementDistributeName: sub.name,
                      product: product,
                    ),
                  );
                });
              } else {
                listTransferStockItem.add(TransferStockItem(
                  productId: product.id,
                  distributeName: (product.distributes != null &&
                          product.distributes!.isNotEmpty)
                      ? product.distributes![0].name
                      : null,
                  quantity: 1,
                  elementDistributeName: elm.name,
                  subElementDistributeName: null,
                  product: product,
                ));
              }
            },
          );
        }
      } else {
        listTransferStockItem.add(TransferStockItem(
          productId: product.id,
          distributeName: null,
          quantity: 1,
          elementDistributeName: null,
          subElementDistributeName: null,
          product: product,
        ));
      }
    });
  }

  void addOrRemoveSelected({
    required TransferStockItem transferStockItem,
  }) {
    var index = listTransferStockItem.indexWhere((transferStock) =>
        (transferStock.productId == transferStockItem.productId &&
            transferStock.distributeName == transferStockItem.distributeName &&
            transferStock.elementDistributeName ==
                transferStockItem.elementDistributeName &&
            transferStock.subElementDistributeName ==
                transferStockItem.subElementDistributeName));

    if (index == -1) {
      listTransferStockItem.add(transferStockItem);
    } else {
      listTransferStockItem.removeAt(index);
    }
  }

  bool checkChoose({
    int? productId,
    String? distributeName,
    String? elementDistributeName,
    String? subElementDistributeName,
  }) {
    var index = listTransferStockItem.indexWhere((importStock) =>
        (importStock.productId == productId &&
            importStock.distributeName == distributeName &&
            importStock.elementDistributeName == elementDistributeName &&
            importStock.subElementDistributeName == subElementDistributeName));
    if (index == -1) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> getAllProduct({
    bool isRefresh = false,
  }) async {
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
            checkInventory: true,
            branchId: branchIdInput,
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
        listProduct(
            data!.data!.data!.where((e) => e.checkInventory == true).toList());
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
