import 'package:com.ikitech.store/app_user/data/remote/response-request/staff/all_operation_history_res.dart';
import 'package:get/get.dart';

import '../../components/saha_user/toast/saha_alert.dart';
import '../../data/repository/repository_manager.dart';
import '../../model/operation_filter.dart';

class OperationHistoryController extends GetxController {
  var listHistory = RxList<OperationHistory>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;
  var filter = OperationFilter().obs;

  OperationHistoryController() {
    getAllOperationHistory(isRefresh: true);
  }

  Future<void> getAllOperationHistory({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;

        var data =
            await RepositoryManager.staffRepository.getAllOperationHistory(
          page: currentPage,
          functionType: filter.value.functionType,
          actionType: filter.value.actionType,
          staffId: filter.value.staffId,
              branchId: filter.value.branch?.id
        );

        if (isRefresh == true) {
          listHistory(data!.data!.data!);
        } else {
          listHistory.addAll(data!.data!.data!);
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
  }
}
