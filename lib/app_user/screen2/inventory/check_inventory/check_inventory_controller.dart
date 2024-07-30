import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/tally_sheet.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';

class CheckInventoryController extends GetxController {
  var listTallySheet = RxList<TallySheet>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  bool? isNeedHanding;
  var loadInit = true.obs;
  var finish = FinishHandle(milliseconds: 500);

  CheckInventoryController({this.isNeedHanding}) {
    getAllTallySheet(isRefresh: true);
  }

  Future<void> getAllTallySheet({
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
          var data = await RepositoryManager.inventoryRepository
              .getAllTallySheet(
                  search: textSearch,
                  currentPage: currentPage,
                  status: isNeedHanding == true ? 0 : null);

          if (isRefresh == true) {
            listTallySheet(data!.data!.data!);
          } else {
            listTallySheet.addAll(data!.data!.data!);
          }

          if (data.data!.nextPageUrl == null) {
            isEnd = true;
          } else {
            isEnd = false;
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
