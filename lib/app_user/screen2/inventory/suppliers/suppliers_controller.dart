import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/supplier.dart';

class SuppliersController extends GetxController {
  var listSupplier = RxList<Supplier>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;

  SuppliersController() {
    getAllSuppliers(isRefresh: true);
  }

  Future<void> getAllSuppliers({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.supplierRepository
            .getAllSuppliers(search: textSearch, page: currentPage);

        if (isRefresh == true) {
          listSupplier(data!.data!.data!);
        } else {
          listSupplier.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
