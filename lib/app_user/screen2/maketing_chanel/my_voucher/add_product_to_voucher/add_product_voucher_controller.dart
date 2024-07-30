import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/data/repository/handle_error.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

class AddProductToVoucherController extends GetxController {
  var listProduct = RxList<Product>();
  var isLoadingProduct = false.obs;
  var listSelectedProduct = RxList<Product>();
  var quantityProductSelected = 0.obs;
  var isLoadingCreate = false.obs;
  var listProductParam = "";
  var isLoadMore = false.obs;
  var isEndProduct = false.obs;
  var currentPage = 1;
  var isLoadInit = false.obs;
  var isSearch = false.obs;
  List<Product>? listProductInput = [];
  String? textSearch;

  Future<List<Product>?> getAllProduct(
      {String? textSearch, bool? isRefresh}) async {
    if (isRefresh == true) {
      isLoadingProduct.value = true;
    } else {
      isLoadMore.value = true;
    }

    try {
      if (isEndProduct.value == false) {
        var data = await RepositoryManager.productRepository.getAllProductV2(
            page: currentPage, search: textSearch == null ? "" : textSearch);
        var list = data!.data;

        if (isRefresh == true) {
          listProduct(list!);

        } else {
          listProduct.addAll(list!);
        }


        if (data.nextPageUrl == null) {
          isEndProduct.value = true;
        } else {
          currentPage++;
        }

        isLoadingProduct.value = false;
        isLoadMore.value = false;
        return list;
      } else {
        isLoadMore.value = false;
      }
    } catch (err) {
      handleError(err);
    }
    isLoadingProduct.value = false;
  }

  void resetListProduct() {
    currentPage = 1;
    isEndProduct.value = false;
    listProductParam = "";
  }


}
