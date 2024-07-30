import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/ctv.dart';


class ListCtvController extends GetxController {
  var isSearch = false.obs;
  var isLoadMore = false.obs;
  int currentPage = 1;
  bool isEndOrder = false;
  var isLoadRefresh = true.obs;
  var listCtv = RxList<Ctv>();
  var listStatus = RxList<bool>();
  String? textSearch;

  Future<void> updateCtv(
      {required int status, required int idCtv, required int index}) async {
    try {
      var data = await RepositoryManager.ctvRepository.updateCtv(status, idCtv);
      listStatus[index] = data!.ctv!.status == 1 ? true : false;
      listStatus.refresh();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getListCtv({String? searchText, bool? isRefresh}) async {
    if (isRefresh == true) {
      isLoadRefresh.value = true;
      listCtv([]);
      listStatus([]);
      currentPage = 1;
      isEndOrder = false;
    } else {
      isLoadMore.value = true;
    }

    try {
      if (isEndOrder == false) {
        var data = await RepositoryManager.ctvRepository.getListCtv(
            search: searchText,
            sortBy: "balance",
            page: currentPage,
            descending: true);

        data!.data!.data!.forEach((e) {
          listCtv.add(e);
          listStatus.add(e.status == 1 ? true : false);
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
