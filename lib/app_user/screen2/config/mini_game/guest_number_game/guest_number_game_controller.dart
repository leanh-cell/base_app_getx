import 'package:com.ikitech.store/app_user/model/guess_number_game.dart';
import 'package:get/get.dart';

import '../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';

class GuestNumberGameController extends GetxController {
  var listGuessGame = RxList<GuessNumberGame>();
  int currentPage = 1;
  bool isEnd = false;
  var status = 0.obs;
  var isLoading = false.obs;
  var loadInit = true.obs;

  GuestNumberGameController() {
    getAllGuessNumberGame(isRefresh: true);
  }

  Future<void> getAllGuessNumberGame({
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
            .getAllGuessNumberGame(page: currentPage, status: status.value);

        if (isRefresh == true) {
          listGuessGame(res!.data!.data!);
        } else {
          listGuessGame.addAll(res!.data!.data!);
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
