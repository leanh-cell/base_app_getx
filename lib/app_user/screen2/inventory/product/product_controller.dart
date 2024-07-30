import 'package:com.ikitech.store/app_user/screen2/inventory/product/product_page/product_page_controller.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';

import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../data/remote/response-request/product/all_product_response.dart';
import '../../../data/repository/repository_manager.dart';

class ProductController extends GetxController {
  var totalHide = 0.obs;
  var isSelectAll = false.obs;
  var totalShow = 0.obs;
  var isLoadingAppbar = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingProduct = true.obs;
  var categories = RxList<Category>();
  List<Category>? categoryChooses;
  List<Category>? categoryChildChooses;
  List<ProductPageController> pagesController = [];

  ProductController() {
    getAllCategory();
  }

  Future<void> collaboratorProducts(int percentCollaborator) async {
    try {
      var data = await RepositoryManager.productRepository
          .collaboratorProducts(percentCollaborator: percentCollaborator);
      SahaAlert.showSuccess(message: "Cập nhật thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllCategory() async {
    isLoadingProduct.value = true;
    isLoadingCategory.value = true;
    try {
      var res = await RepositoryManager.categoryRepository.getAllCategory();
      categories(res!);

      categories.insert(0, Category(name: "Tất cả sản phẩm", id: null));

      categories.refresh();
    } catch (err) {
      print("======== Error in HomeController");
    }
    isLoadingCategory.value = false;
  }

  void onSearch(String text) {
    pagesController.forEach((element) {
      element.searchText = text;
      element.getAllProductV2(isRefresh: true);
    });
  }

  void refreshAll() {
    pagesController.forEach((element) {
      element.getAllProductV2(isRefresh: true);
    });
  }

  // void changeCategory(
  //     List<Category>? categoryChooses, List<Category>? categoryChildChooses) {
  //   pagesController.forEach((element) {
  //     print(element.isHide);
  //     element.categoryChoose = categoryChooses;
  //     element.categoryChildChoose = categoryChildChooses;
  //     element.searchText = "";
  //     element.getAllProductV2(isRefresh: true);
  //   });
  // }

  void closeSearch() {
    pagesController.forEach((element) {
      element.isSearch.value = false;
      element.searchText = "";
      element.getAllProductV2(isRefresh: true);
    });
  }

  void addPageController(ProductPageController pageController) {
    pagesController.add(pageController);
  }

  Future<bool?> getBagde(String? searchText) async {
    try {
      late DataPageProduct data;
      data = (await RepositoryManager.productRepository.getAllProductV2(
          search: searchText,
          idCategory: (categoryChooses ?? [])
              .map((e) => e.id)
              .toString()
              .replaceAll("(", "")
              .replaceAll(")", ""),
          categoryChildrenIds: (categoryChildChooses ?? [])
              .map((e) => e.id)
              .toString()
              .replaceAll("(", "")
              .replaceAll(")", ""),
          status: "0",
          page: 1)) as DataPageProduct;

      totalShow.value = data.totalStoking ?? 0;
      totalHide.value = data.totalHide ?? 0;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
