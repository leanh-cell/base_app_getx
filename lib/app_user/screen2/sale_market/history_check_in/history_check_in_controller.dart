import 'package:get/get.dart';

import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/history_check_in.dart';

class HistoryCheckInController extends GetxController{
  var loadInit = true.obs;
  var isLoading = false.obs;
  int currentPage = 1;
  final int agencyId;


  bool isEnd = false;

  var listHistoryCheckIn = RxList<HistoryCheckIn>();
  HistoryCheckInController({required this.agencyId}){
    getAllHistoryCheckIn(isRefresh: true);
  }
  Future<void> getAllHistoryCheckIn({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.agencyRepository.getAllHistoryCheckIn(
          page: currentPage,
          agencyId: agencyId
        );

        

        if (isRefresh == true) {
          listHistoryCheckIn(data!.data!.data!);
          listHistoryCheckIn.refresh();
        } else {
          listHistoryCheckIn.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      loadInit.value = false;
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}