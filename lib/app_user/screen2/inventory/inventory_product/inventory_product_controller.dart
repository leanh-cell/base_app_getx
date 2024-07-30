import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/inventory_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/all_product_response.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';
import 'package:com.ikitech.store/app_user/utils/thread_data.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

class InventoryProductController extends GetxController {
  var loading = false.obs;
  var listProduct = RxList<Product>();
  Product productUpdate = Product();
  int currentPage = 1;
  bool isEndLoadMore = false;
  var productsSelected = RxList<int>();
  String searchText = "";
  var isLongPress = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingProduct = true.obs;
  var categories = RxList<Category>();
  var categoryCurrent = (-1).obs;
  var checkInventory = false.obs;
  var isSearch = false.obs;
  bool? isNearOutOfStock;
  var finish = FinishHandle(milliseconds: 500);

  List<Category>? categoryChooses;
  List<Category>? categoryChildChoose;

  InventoryProductController({this.isNearOutOfStock}) {
    EasyLoading.show();
    getAllCategory();
    getAllProduct();
  }

  Future<void> scanProduct(String barcode) async {
    try {
      var data = await RepositoryManager.productRepository.scanProduct(barcode);
      if (data?.data?.data != null) {
        if (checkInventory.value == true) {
          listProduct(data!.data!.data!
              .where((e) => e.checkInventory == true)
              .toList());
        } else {
          listProduct(data!.data!.data!);
        }
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void addOrRemoveSelected(int id) {
    if (productsSelected.contains(id)) {
      productsSelected.remove(id);
    } else {
      productsSelected.add(id);
    }
  }

  Future<bool?> deleteManyProduct(List<int> listIds) async {
    try {
      var ok = await RepositoryManager.productRepository.deleteMany(listIds);
      if (ok!) {
        listProduct.removeWhere((element) => listIds.contains(element.id));
      }
      loading.value = false;
      SahaAlert.showSuccess(message: "Đã xóa");
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
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

  Future<void> getAllProduct({
    bool isRefresh = false,
  }) async {
    finish.run(() async {
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
        loading.value = true;

        data = (await RepositoryManager.productRepository.getAllProductV2(
          search: searchText,
          idCategory: (categoryChooses ?? [])
              .map((e) => e.id)
              .toString()
              .replaceAll("(", "")
              .replaceAll(")", ""),
          categoryChildrenIds: (categoryChildChoose ?? [])
              .map((e) => e.id)
              .toString()
              .replaceAll("(", "")
              .replaceAll(")", ""),
          page: currentPage,
          isNearOutOfStock: isNearOutOfStock,
          checkInventory: checkInventory.value == false ? null : true,
        )) as DataPageProduct;

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

  Future<void> getOneProduct(int idProduct) async {
    try {
      var data =
          await RepositoryManager.productRepository.getOneProductV2(idProduct);
      productUpdate = data!.data!;
      var index = listProduct.indexWhere((e) => e.id == productUpdate.id);
      if (index != -1) {
        listProduct[index] = productUpdate;
        listProduct.refresh();
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateInventoryProduct(InventoryRequest inventoryRequest) async {
    try {
      var data = await RepositoryManager.inventoryRepository
          .updateInventoryProduct(inventoryRequest);
      getOneProduct(inventoryRequest.productId!);
      SahaAlert.showSuccess(message: "Cập nhật thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
