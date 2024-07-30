import 'dart:convert';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/review.dart';

import '../review_manage_controller.dart';

class StarPageManageController extends GetxController {
  String? filterBy;
  String? filterByValue;
  int? status;

  StarPageManageController({this.filterBy, this.filterByValue, this.status});

  var listReview = RxList<Review>();
  var listImageReviewOfCustomer = RxList<List<dynamic>>([]);
  var isEndReview = false;
  var isLoading = false.obs;
  var isLoadMore = false.obs;
  int currentPage = 1;

  ReviewManagerController reviewManagerController = Get.find();

  Future<void> getReviewProduct({bool? isLoadMoreCondition}) async {
    if (isLoadMoreCondition == true) {
      isLoadMore.value = true;
    } else {
      isEndReview = false;
      isLoading.value = true;
    }
    try {
      List<Review> listRv = [];
      if (isEndReview == false) {
        var data = await RepositoryManager.reviewRepository.getReviewManage(
        filterBy:filterBy!,
        filterByValue:filterByValue!,
        );
        data!.data!.data!.forEach((element) {
          if (element.status == status) {
            listRv.add(element);
          }
        });
        listReview(listRv);
        listReview.forEach((review) {
          try {
            listImageReviewOfCustomer.add(jsonDecode(review.images!));
          } catch (err) {
            listImageReviewOfCustomer.add([]);
          }
        });
        print(listImageReviewOfCustomer);

        if (data.data!.nextPageUrl != null) {
          isEndReview = false;
          currentPage++;
        } else {
          isEndReview = true;
        }
        isLoading.value = false;
        isLoadMore.value = false;
      } else {
        isLoadMore.value = false;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  void refreshData() {
    isEndReview = false;
    currentPage = 1;
    listImageReviewOfCustomer([]);
    getReviewProduct(isLoadMoreCondition: false);
    reviewManagerController.getReviewProduct();
  }

  Future<void> deleteReview(int idReview) async {
    try {
      var res = await RepositoryManager.reviewRepository.deleteReview(idReview);
      refreshData();
      SahaAlert.showSuccess(message: "Xoá thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateReview(int idReview, int status) async {
    try {
      var res = await RepositoryManager.reviewRepository
          .updateReview(idReview, status); // 1 is accept review show
      refreshData();
      if (status != -1) {
        SahaAlert.showSuccess(message: "Duyệt thành công");
      } else {
        SahaAlert.showError(message: "Đã huỷ");
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
