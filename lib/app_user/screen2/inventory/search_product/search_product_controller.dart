import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/tally_sheet_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/all_product_response.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';
import 'package:com.ikitech.store/app_user/utils/thread_data.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../product/product_page/product_page_controller.dart';

class SearchProductController extends GetxController {
  var loading = false.obs;
  var listProduct = RxList<Product>();
  int currentPage = 1;
  bool isEndLoadMore = false;
  var productsSelected = RxList<int>();
  String searchText = "";
  TYPE_PAGE? typePage = TYPE_PAGE.STOCKING;
  var isLongPress = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingProduct = true.obs;
  var categories = RxList<Category>();
  var categoryCurrent = (-1).obs;
  Category? categoryChoose;
  var isSearch = false.obs;
  var isChooseMany = false.obs;
  var listTallySheetItem = RxList<TallySheetItem>();
  var listImportStockItem = RxList<ImportStockItem>();
  List<TallySheetItem>? inputListTallySheetItem;
  List<ImportStockItem>? inputListImportStockItem;
  bool? checkInventory;
  var finish = FinishHandle(milliseconds: 500);

  SearchProductController(
      {this.inputListTallySheetItem,
      this.inputListImportStockItem,
      this.checkInventory}) {
    if (inputListTallySheetItem != null) {
      listTallySheetItem(inputListTallySheetItem);
    }
    if (inputListImportStockItem != null) {
      listImportStockItem(inputListImportStockItem);
    }
    EasyLoading.show();
    getAllCategory();
    getAllProduct();
  }

  void addAll({
    required bool isTallySheet,
  }) {
    listTallySheetItem([]);
    listImportStockItem([]);
    listProduct.forEach((product) {
      if (isTallySheet) {
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
                    listTallySheetItem.add(TallySheetItem(
                      stockOnline: sub.stock,
                      imageProductUrl:
                          (product.images != null && product.images!.isNotEmpty)
                              ? product.images![0].imageUrl
                              : "",
                      productId: product.id,
                      nameProduct: "${product.name}",
                      distributeName: (product.distributes != null &&
                              product.distributes!.isNotEmpty)
                          ? product.distributes![0].name
                          : null,
                      elementDistributeName: elm.name,
                      subElementDistributeName: sub.name,
                    ));
                  });
                } else {
                  listTallySheetItem.add(
                    TallySheetItem(
                      stockOnline: elm.stock,
                      imageProductUrl:
                          (product.images != null && product.images!.isNotEmpty)
                              ? product.images![0].imageUrl
                              : "",
                      productId: product.id,
                      nameProduct: "${product.name}",
                      distributeName: (product.distributes != null &&
                              product.distributes!.isNotEmpty)
                          ? product.distributes![0].name
                          : null,
                      elementDistributeName: elm.name,
                      subElementDistributeName: null,
                    ),
                  );
                }
              },
            );
          }
        } else {
          listTallySheetItem.add(TallySheetItem(
            stockOnline: product.inventory?.mainStock ?? 0,
            imageProductUrl:
                (product.images != null && product.images!.isNotEmpty)
                    ? product.images![0].imageUrl
                    : "",
            productId: product.id,
            nameProduct: "${product.name}",
            distributeName: null,
            elementDistributeName: null,
            subElementDistributeName: null,
          ));
        }
      } else {
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
                    listImportStockItem.add(
                      ImportStockItem(
                        productId: product.id,
                        distributeName: (product.distributes != null &&
                                product.distributes!.isNotEmpty)
                            ? product.distributes![0].name
                            : null,
                        quantity: 1,
                        elementDistributeName: elm.name,
                        subElementDistributeName: sub.name,
                        importPrice: sub.priceImport,
                        product: product,
                      ),
                    );
                  });
                } else {
                  listImportStockItem.add(ImportStockItem(
                    productId: product.id,
                    distributeName: (product.distributes != null &&
                            product.distributes!.isNotEmpty)
                        ? product.distributes![0].name
                        : null,
                    quantity: 1,
                    elementDistributeName: elm.name,
                    subElementDistributeName: null,
                    importPrice: elm.priceImport,
                    product: product,
                  ));
                }
              },
            );
          }
        } else {
          listImportStockItem.add(ImportStockItem(
            productId: product.id,
            distributeName: null,
            quantity: 1,
            elementDistributeName: null,
            subElementDistributeName: null,
            importPrice: product.priceImport,
            product: product,
          ));
        }
      }
    });
  }

  void addOrRemoveSelected({
    required bool isTallySheet,
    required TallySheetItem tallySheetItem,
    required ImportStockItem importStockItem,
  }) {
    if (isTallySheet) {
      var index = listTallySheetItem.indexWhere((tallySheet) =>
          (tallySheet.productId == tallySheetItem.productId &&
              tallySheet.distributeName == tallySheetItem.distributeName &&
              tallySheet.elementDistributeName ==
                  tallySheetItem.elementDistributeName &&
              tallySheet.subElementDistributeName ==
                  tallySheetItem.subElementDistributeName));

      if (index == -1) {
        listTallySheetItem.add(tallySheetItem);
      } else {
        listTallySheetItem.removeAt(index);
      }
      print(listTallySheetItem);
    } else {
      var index = listImportStockItem.indexWhere((importStock) =>
          (importStock.productId == importStockItem.productId &&
              importStock.distributeName == importStockItem.distributeName &&
              importStock.elementDistributeName ==
                  importStockItem.elementDistributeName &&
              importStock.subElementDistributeName ==
                  importStockItem.subElementDistributeName));

      if (index == -1) {
        listImportStockItem.add(importStockItem);
      } else {
        listImportStockItem.removeAt(index);
      }
    }
  }

  bool checkChoose({
    required bool isTallySheet,
    int? productId,
    String? distributeName,
    String? elementDistributeName,
    String? subElementDistributeName,
  }) {
    if (isTallySheet) {
      var index = listTallySheetItem.indexWhere((tallySheet) =>
          (tallySheet.productId == productId &&
              tallySheet.distributeName == distributeName &&
              tallySheet.elementDistributeName == elementDistributeName &&
              tallySheet.subElementDistributeName == subElementDistributeName));
      if (index == -1) {
        return false;
      } else {
        return true;
      }
    } else {
      var index = listImportStockItem.indexWhere((importStock) =>
          (importStock.productId == productId &&
              importStock.distributeName == distributeName &&
              importStock.elementDistributeName == elementDistributeName &&
              importStock.subElementDistributeName ==
                  subElementDistributeName));
      if (index == -1) {
        return false;
      } else {
        return true;
      }
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

        if (this.typePage == TYPE_PAGE.STOCKING) {
          data = (await RepositoryManager.productRepository.getAllProductV2(
              search: searchText,
              idCategory: searchText != "" ? "" : "${categoryChoose?.id ?? ""}",
              checkInventory: checkInventory,
              page: currentPage)) as DataPageProduct;
        }

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
