import 'package:com.ikitech.store/app_user/model/product_commerce.dart';
import 'package:get/get.dart';

import '../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../data/remote/response-request/e_commerce/all_product_commerce_res.dart';
import '../../../../data/remote/response-request/e_commerce/sync_res.dart';
import '../../../../data/repository/repository_manager.dart';

class CommerceProductController extends GetxController {
  var listProductCommerce = RxList<ProductCommerces>();
  int currentPage = 1;
  bool isEnd = false;
  int pageCommerce = 1;
  var isLoading = false.obs;
  var loadInit = true.obs;
  var isSync = true;
  var dataSync = SyncData();
  String shopId;
  int? totalProduct;

  var isLongPress = false.obs;

  var listProductId = <String>[].obs;

  CommerceProductController({required this.shopId}) {
    getAllProductCommerce(isRefresh: true);
  }

  Future<void> getAllProductCommerce({
    bool? isRefresh,
    bool? isShowSuccess,
    int? skuPairType,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var res = await RepositoryManager.eCommerceRepo.getAllProductCommerce(
            page: currentPage, shopId: shopId, skuPairType: skuPairType ?? 0);

        if (isRefresh == true) {
          listProductCommerce(res!.data!.data!);
        } else {
          listProductCommerce.addAll(res!.data!.data!);
        }

        if (res.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
      loadInit.value = false;
      if (isShowSuccess == true) {
        SahaAlert.showSuccess(
            message: "Đồng bộ thành công $totalProduct sản phẩm");
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> syncProduct() async {
    try {
      var res = await RepositoryManager.eCommerceRepo
          .syncProduct(shopId: [shopId], page: pageCommerce);
      dataSync = res!.data!;
    } on Exception catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
