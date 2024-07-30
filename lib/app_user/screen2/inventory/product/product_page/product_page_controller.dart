import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/all_product_response.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/product/product_controller.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

enum TYPE_PAGE { STOCKING, OUT_OF_STOCK, HIDE }

class ProductPageController extends GetxController {
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
  List<Category>? categoryChoose;
  List<Category>? categoryChildChoose;
  bool isHide = false;
  var isSearch = false.obs;
  var finish = FinishHandle(milliseconds: 500);
  Product productEdit = Product();
  ProductController productController = Get.find();

  ProductPageController() {
    EasyLoading.show();
    getAllProductV2(isRefresh: true);
  }

  Future<void> collaboratorProducts(int percentCollaborator) async {
    try {
      var data = await RepositoryManager.productRepository
          .collaboratorProducts(percentCollaborator: percentCollaborator);
      Get.back();
      SahaAlert.showSuccess(message: "Cập nhật thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getOneProduct(int idProduct) async {
    productController.getBagde(searchText);
    try {
      var data =
          await RepositoryManager.productRepository.getOneProductV2(idProduct);
      productEdit = data!.data!;
      var index = listProduct.indexWhere((e) => e.id == idProduct);
      if (index != -1) {
        if (isHide) {
          if (productEdit.status == 0) {
            listProduct.removeAt(index);
            productController.pagesController[0].listProduct
                .insert(0, productEdit);
          } else {
            listProduct[index] = productEdit;
          }
        } else {
          if (productEdit.status == -1) {
            listProduct.removeAt(index);
            productController.pagesController[1].listProduct
                .insert(0, productEdit);
          } else {
            listProduct[index] = productEdit;
          }
        }

        listProduct.refresh();
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
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
      productsSelected([]);
      loading.value = false;
      productController.getBagde(searchText);
      getAllProductV2(isRefresh: true);
      SahaAlert.showSuccess(message: "Đã xóa");
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<bool?> getAllProductV2({
    bool isRefresh = false,
  }) async {
    finish.run(() async {
      loading.value = true;

      if (isRefresh == true) {
        currentPage = 1;
        isEndLoadMore = false;
      }

      if (isEndLoadMore) {
        return;
      }

      try {
        late DataPageProduct data;
        print(
          (categoryChoose ?? [])
              .map((e) => e.id)
              .toString()
              .replaceAll("(", "")
              .replaceAll(")", ""),
        );
        if (isHide == true) {
          data = (await RepositoryManager.productRepository.getAllProductV2(
              search: searchText,
              idCategory: (categoryChoose ?? [])
                  .map((e) => e.id)
                  .toString()
                  .replaceAll("(", "")
                  .replaceAll(")", ""),
              categoryChildrenIds: (categoryChildChoose ?? [])
                  .map((e) => e.id)
                  .toString()
                  .replaceAll("(", "")
                  .replaceAll(")", ""),
              filterBy: "status",
              filterOption: "ne",
              filterByValue: "0",
              page: currentPage)) as DataPageProduct;
        } else {
          data = (await RepositoryManager.productRepository.getAllProductV2(
              search: searchText,
              idCategory: (categoryChoose ?? [])
                  .map((e) => e.id)
                  .toString()
                  .replaceAll("(", "")
                  .replaceAll(")", ""),
              categoryChildrenIds: (categoryChildChoose ?? [])
                  .map((e) => e.id)
                  .toString()
                  .replaceAll("(", "")
                  .replaceAll(")", ""),
              status: "0",
              page: currentPage)) as DataPageProduct;
        }

        productController.getBagde(searchText);

        productController.totalShow.value = data.totalStoking ?? 0;
        productController.totalHide.value = data.totalHide ?? 0;

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
}
