import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/inventory_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

class InventoryEditController extends GetxController {
  var loading = false.obs;
  var product = Product().obs;
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
  Product productInput;

  InventoryEditController({required this.productInput}) {
    getOneProduct(productInput.id!);
  }

  Future<void> getOneProduct(int idProduct) async {
    try {
      var data =
      await RepositoryManager.productRepository.getOneProductV2(idProduct);
      product(data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateInventoryProduct(InventoryRequest inventoryRequest) async {
    try {
      var data = await RepositoryManager.inventoryRepository
          .updateInventoryProduct(inventoryRequest);
      getOneProduct(productInput.id!);
      SahaAlert.showSuccess(message: "Cập nhật thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
