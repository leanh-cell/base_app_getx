import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/ctv.dart';

class TopCtvController extends GetxController {
  var isSearch = false.obs;
  var isLoadMore = false.obs;
  int currentPage = 1;
  bool isEndOrder = false;
  var isLoadRefresh = true.obs;
  var listTopCtv = RxList<Ctv>();
  var dateFrom = DateTime.now().obs;
  var dateTo = DateTime.now().obs;
  int? indexTabTimeSave;
  int? indexChooseSave;

  String? textSearch;
  TopCtvController() {
    dateFrom.value = DateTime(dateTo.value.year, dateTo.value.month, 1);
  }

  Future<void> getTopCtv({String? searchText, bool? isRefresh}) async {
    if (isRefresh == true) {
      isLoadRefresh.value = true;
      listTopCtv([]);
      currentPage = 1;
      isEndOrder = false;
    } else {
      isLoadMore.value = true;
    }

    try {
      if (isEndOrder == false) {
        var data = await RepositoryManager.ctvRepository.getTopCtv(
          search: searchText,
          sortBy: "sum_total_final",
          page: currentPage,
          descending: true,
          timeFrom: dateFrom.value.toIso8601String(),
          timeTo: dateTo.value.toIso8601String(),
        );

        data!.data!.data!.forEach((e) {
          listTopCtv.add(e);
        });

        if (data.data!.nextPageUrl != null) {
          currentPage++;
          isEndOrder = false;
        } else {
          isEndOrder = true;
        }
      } else {
        isLoadMore.value = false;
        return;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }

    isLoadMore.value = false;
    isLoadRefresh.value = false;
  }
}
