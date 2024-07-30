import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

class ReviewManagerController extends GetxController {
  ReviewManagerController() {
    getReviewProduct();
  }

  var totalPendingApproval = 0.obs;
  var totalCancel = 0.obs;
  var listStarOneToFive = RxList<int>();
  var currentIndexReview = 0.obs;
  var isLoading = false.obs;

  void changeIndexReview(int indexReview) {
    currentIndexReview.value = indexReview;
    print(currentIndexReview.value);
  }

  Future<void> getReviewProduct() async {
    isLoading.value = true;
    listStarOneToFive([]);
    try {
      var data = await RepositoryManager.reviewRepository.getReviewManage(
        //filterBy: '',filterByValue: ''
      );
      totalPendingApproval.value = data!.data!.totalPendingApproval!;
      totalCancel.value = data.data!.totalCancel!;
      listStarOneToFive.add(data.data!.total1Stars!);
      listStarOneToFive.add(data.data!.total2Stars!);
      listStarOneToFive.add(data.data!.total3Stars!);
      listStarOneToFive.add(data.data!.total4Stars!);
      listStarOneToFive.add(data.data!.total5Stars!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }
}
