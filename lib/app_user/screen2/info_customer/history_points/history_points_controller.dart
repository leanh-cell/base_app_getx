import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/score_history_item.dart';

import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';

class HistoryPointsController extends GetxController {


  int currentPage = 1;
  var isDoneLoadMore = false.obs;
  var isLoadInit = true.obs;
  bool isEnd = false;
  var listHistoryPoint = RxList<ScoreHistoryItem>();

  int customerId;

  HistoryPointsController({required this.customerId}) {
    getHistoryPoints(isRefresh: true);
  }

  Future<void> getHistoryPoints({bool? isRefresh}) async {
    isDoneLoadMore.value = false;

    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (!isEnd) {
        var res = await RepositoryManager.customerRepository.getHistoryPoints(
            page: currentPage,
            idCustomer: customerId);

        if (isRefresh == true) {
          listHistoryPoint(res!.data!.data!);
        } else {
          res!.data!.data!.forEach((element) {
            listHistoryPoint.add(element);
          });
        }

        if (res.data!.nextPageUrl != null) {
          currentPage++;
          isEnd = false;
        } else {
          isEnd = true;
        }
      } else {
        isDoneLoadMore.value = true;
        isLoadInit.value = false;
        return;
      }
      isLoadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isDoneLoadMore.value = true;
    isLoadInit.value = false;
  }
}