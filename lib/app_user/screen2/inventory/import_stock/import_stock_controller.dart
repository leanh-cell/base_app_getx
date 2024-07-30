import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';

class ImportStockController extends GetxController {
  var listImportStock = RxList<ImportStock>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;
  bool? isNeedHanding;

  var finish = FinishHandle(milliseconds: 500);

  ImportStockController({this.isNeedHanding}) {
    getAllImportStock(isRefresh: true);
  }

  Future<void> getAllImportStock({
    bool? isRefresh,
  }) async {
    finish.run(() async {
      if (isRefresh == true) {
        currentPage = 1;
        isEnd = false;
      }

      try {
        if (isEnd == false) {
          isLoading.value = true;
          var data = await RepositoryManager.importStockRepository
              .getAllImportStock(
                  search: textSearch,
                  currentPage: currentPage,
                  status: isNeedHanding == true ? "0,1,2" : null);

          if (isRefresh == true) {
            listImportStock(data!.data!.data!);
          } else {
            listImportStock.addAll(data!.data!.data!);
          }

          if (data.data!.nextPageUrl == null) {
            isEnd = true;
          } else {
            isEnd = false;
            currentPage = currentPage + 1;
          }
        }
        isLoading.value = false;
        loadInit.value = false;
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
    });
  }
}
