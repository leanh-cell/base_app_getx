import 'package:com.ikitech.store/app_user/data/remote/response-request/review_manage/all_review_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/review_manage/review_delete_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/review_manage/update_review_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import '../handle_error.dart';

class ReviewRepository {
  Future<AllReviewResponse?> getReviewManage({
    String? filterBy,
    String? filterByValue,
      }) async {
    try {
      var res = await SahaServiceManager().service!.getReviewManage(
          UserInfo().getCurrentStoreCode()!, filterBy, filterByValue);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ReviewDeleteResponse?> deleteReview(
    int idReview,
  ) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteReview(UserInfo().getCurrentStoreCode()!, idReview);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<UpdateReviewResponse?> updateReview(
    int idReview,
    int status,
  ) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateReview(UserInfo().getCurrentStoreCode()!, idReview, {
        "status": status,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
