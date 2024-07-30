import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';

import '../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../data/remote/response-request/ctv/history_balance_res.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/ctv.dart';
import '../../../../utils/finish_handle_utils.dart';

class HistoryBalanceController extends GetxController {
  var listHistoryBalance = RxList<HistoryBalance>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;
  bool? isNeedHanding;
  Ctv ctv;

  var finish = FinishHandle(milliseconds: 500);

  HistoryBalanceController({this.isNeedHanding, required this.ctv}) {
    getHistoryBalance(isRefresh: true);
  }

  Future<void> getHistoryBalance({
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
          var data = await RepositoryManager.ctvRepository
              .getHistoryBalance(page: currentPage, customerId: ctv.id!);

          if (isRefresh == true) {
            listHistoryBalance(data!.data!.data!);
          } else {
            listHistoryBalance.addAll(data!.data!.data!);
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

  Future<void> addSubHistoryBalance(
      {required double money,
      required String reason,
      required bool isSub}) async {
    try {
      var data = await RepositoryManager.ctvRepository.addSubHistoryBalance(
          isSub: isSub, ctvId: ctv.id!, money: money, reason: reason);
      getHistoryBalance(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
