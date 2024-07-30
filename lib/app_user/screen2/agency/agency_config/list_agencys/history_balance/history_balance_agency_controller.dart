import 'package:get/get.dart';
import '../../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../../data/remote/response-request/ctv/history_balance_res.dart';
import '../../../../../data/repository/repository_manager.dart';
import '../../../../../model/agency.dart';
import '../../../../../utils/finish_handle_utils.dart';

class HistoryBalanceAgencyController extends GetxController {
  var listHistoryBalance = RxList<HistoryBalance>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;
  bool? isNeedHanding;
  Agency agency;

  var finish = FinishHandle(milliseconds: 500);

  HistoryBalanceAgencyController({this.isNeedHanding, required this.agency}) {
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
          var data = await RepositoryManager.agencyRepository
              .getHistoryBalanceAgency(
                  page: currentPage, customerId: agency.id!);

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

  Future<void> addSubHistoryBalanceAgency(
      {required double money,
      required String reason,
      required bool isSub}) async {
    try {
      var data = await RepositoryManager.agencyRepository
          .addSubHistoryBalanceAgency(
              isSub: isSub, agencyId: agency.id!, money: money, reason: reason);
      getHistoryBalance(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
