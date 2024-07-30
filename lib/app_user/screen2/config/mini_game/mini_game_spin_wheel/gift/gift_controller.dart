import 'package:com.ikitech.store/app_user/model/gift.dart';
import 'package:get/get.dart';

import '../../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../../data/repository/repository_manager.dart';

class GiftController extends GetxController {
  var listGift = RxList<Gift>();
  int currentPage = 1;
  bool isEnd = false;

  var isLoading = false.obs;
  var loadInit = true.obs;
  int id;

  GiftController({required this.id}) {
    getAllGift(isRefresh: true);
  }

  Future<void> getAllGift({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.miniGameRepository
            .getAllGift(page: currentPage, id: id);

        if (isRefresh == true) {
          listGift(data!.data!.data!);
        } else {
          listGift.addAll(data!.data!.data!);
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
