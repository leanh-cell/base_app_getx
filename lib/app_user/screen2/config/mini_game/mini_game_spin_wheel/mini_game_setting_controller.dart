import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/mini_game.dart';
import 'package:get/get.dart';

import '../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../data/remote/response-request/mini_game/all_mini_game-res.dart';

class MiniGameSettingController extends GetxController {
  var listMiniGame = RxList<MiniGame>();
  int currentPage = 1;
  bool isEnd = false;
  var status = 0.obs;
  var isLoading = false.obs;
  var loadInit = true.obs;

  MiniGameSettingController() {
    getAllMiniGame(isRefresh: true);
  }

  Future<void> getAllMiniGame({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var res = await RepositoryManager.miniGameRepository
            .getAllMiniGame(page: currentPage);
        print('ssss');
        ////// Check TimeStart and TimeEnd
        if (status == 0) {
          //status = 0 : Sắp diễn ra
          res!.data!.data = res.data!.data!
              .where((e) =>
                  (e.timeStart ?? DateTime.now()).isAfter(DateTime.now()))
              .toList();
        } else if (status == 2) {
          //status = 2 : Đang diễn ra
          res!.data!.data = res.data!.data!
              .where((e) =>
                  (e.timeStart ?? DateTime.now()).isBefore(DateTime.now()) &&
                  (e.timeEnd ?? DateTime.now()).isAfter(DateTime.now()))
              .toList();
        } else {
          //status = 1 : Đã kết thúc
          res!.data!.data = res.data!.data!
              .where(
                  (e) => (e.timeEnd ?? DateTime.now()).isBefore(DateTime.now()))
              .toList();
        }
        ///////

        if (isRefresh == true) {
          listMiniGame(res.data!.data!);
        } else {
          listMiniGame.addAll(res.data!.data!);
        }

        if (res.data!.nextPageUrl == null) {
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
