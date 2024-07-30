import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/handle_error.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/combo/combo_request.dart';
import 'package:com.ikitech.store/app_user/model/combo.dart';

class MyComboController extends GetxController {
  var isRefreshingData = false.obs;
  var isDeletingDiscount = false.obs;
  var listComboIsComing = RxList<Combo>();
  var listComboIsRunning = RxList<Combo>();
  var listComboIsEnd = RxList<Combo>();
  var listAll = RxList<List<Combo>>([[], [], []]);
  var listAllSaveStateBefore = RxList<List<Combo>>([[], [], []]);
  var pageLoadMore = 1;
  var isEndPageCombo = false;
  DateTime timeNow = DateTime.now();

  Future<void> getAllCombo() async {
    DateTime timeNow = DateTime.now();
    try {
      var res = await RepositoryManager.marketingChanel.getAllCombo();

      res!.data!.forEach((element) {
        if (element.startTime!.isAfter(timeNow)) {
          listComboIsComing.add(element);
        } else {
          if (element.endTime!.isAfter(timeNow)) {
            listComboIsRunning.add(element);
          }
          // else {
          //   listComboIsEnd.value.add(element);
          // }
        }
      });

      listAll[0] = listComboIsComing;
      listAll[1] = listComboIsRunning;
      listAll[2] = listComboIsEnd;
      listAllSaveStateBefore.value = listAll;
    } catch (err) {
      handleError(err);
    }
  }

  Future<void> refreshData() async {
    isRefreshingData.value = true;
    listComboIsComing = RxList<Combo>();
    listComboIsRunning = RxList<Combo>();
    listAll = RxList<List<Combo>>([[], [], []]);
    await getAllCombo();
    isRefreshingData.value = false;
  }

  void loadInitEndCombo() {
    pageLoadMore = 1;
    isEndPageCombo = false;
    listComboIsEnd([]);
    loadMoreEndCombo();
  }

  Future<void> loadMoreEndCombo() async {
    try {
      var res = await RepositoryManager.marketingChanel
          .getEndComboFromPage(pageLoadMore);

      if (!isEndPageCombo) {
        res!.data!.data!.forEach((element) {
          listComboIsEnd.add(element);
        });
      } else {
        return;
      }

      listAll[2] = listComboIsEnd;
      listAllSaveStateBefore = listAll;
      if (res.data!.nextPageUrl != null) {
        pageLoadMore++;
        isEndPageCombo = false;
      } else {
        isEndPageCombo = true;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> endCombo(int? idCombo) async {
    try {
      var data = await RepositoryManager.marketingChanel
          .updateCombo(idCombo, ComboRequest(isEnd: true));
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    refreshData();
  }

  Future<void> deleteCombo(
    int? idCombo,
  ) async {
    isDeletingDiscount.value = true;
    try {
      var data = await RepositoryManager.marketingChanel.deleteCombo(
        idCombo,
      );
      SahaAlert.showSuccess(message: "Xoá thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isDeletingDiscount.value = false;
    refreshData();
  }
}
