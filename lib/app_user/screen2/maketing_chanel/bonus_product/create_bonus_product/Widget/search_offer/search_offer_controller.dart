import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/all_product_response.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import '../../../../../../model/bonus_product.dart';

class SearchOfferController extends GetxController {
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
  var listBonusProductItem = RxList<ListOffer>();
  List<ListOffer>? inputListBonusProductSelected;
  var finish = FinishHandle(milliseconds: 500);

  SearchOfferController({
    this.inputListBonusProductSelected,
  }) {
    if (inputListBonusProductSelected != null) {
      listBonusProductItem(inputListBonusProductSelected);
    }
    EasyLoading.show();
    getAllProduct();
  }

  void addAll() {
    listBonusProductItem([]);
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
                  listBonusProductItem.add(
                    ListOffer(
                      boProductId: product.id,
                      boDistributeName: (product.distributes != null &&
                              product.distributes!.isNotEmpty)
                          ? product.distributes![0].name
                          : null,
                      boElementDistributeName: elm.name,
                      boSubElementDistributeName: sub.name,
                      productName: product.name ?? "",
                    ),
                  );
                });
              } else {
                listBonusProductItem.add(ListOffer(
                  boProductId: product.id,
                  boDistributeName: (product.distributes != null &&
                          product.distributes!.isNotEmpty)
                      ? product.distributes![0].name
                      : null,
                  boElementDistributeName: elm.name,
                  boSubElementDistributeName: null,
                  productName: product.name ?? "",
                ));
              }
            },
          );
        }
      } else {
        listBonusProductItem.add(ListOffer(
          boProductId: product.id,
          boDistributeName: null,
          boElementDistributeName: null,
          boSubElementDistributeName: null,
          productName: product.name ?? "",
        ));
      }
    });
  }

  void addOrRemoveSelected({
    required ListOffer bonusProductSelected,
  }) {
    var index = listBonusProductItem.indexWhere((transferStock) =>
        (transferStock.boProductId == bonusProductSelected.boProductId &&
            transferStock.boDistributeName ==
                bonusProductSelected.boDistributeName &&
            transferStock.boElementDistributeName ==
                bonusProductSelected.boElementDistributeName &&
            transferStock.boSubElementDistributeName ==
                bonusProductSelected.boSubElementDistributeName));

    if (index == -1) {
      listBonusProductItem.add(bonusProductSelected);
    } else {
      listBonusProductItem.removeAt(index);
    }
  }

  bool checkChoose({
    int? productId,
    String? distributeName,
    String? elementDistributeName,
    String? subElementDistributeName,
  }) {
    if (checkChooseAll(productId: productId) == true) return true;

    var index = listBonusProductItem.indexWhere((importStock) =>
        (importStock.boProductId == productId &&
            importStock.boDistributeName == distributeName &&
            importStock.boElementDistributeName == elementDistributeName &&
            importStock.boSubElementDistributeName == subElementDistributeName));
    if (index == -1) {
      return false;
    } else {
      return true;
    }
  }

  bool checkChooseAll({
    int? productId,
  }) {
    var index = listBonusProductItem.indexWhere((importStock) =>
        (importStock.boProductId == productId &&
            importStock.boDistributeName == null &&
            importStock.boElementDistributeName == null &&
            importStock.boSubElementDistributeName == null));
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
