import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';

import '../../../utils/finish_handle_utils.dart';

class PostController extends GetxController {
  var loadingInit = true.obs;
  var listPost = RxList<Post>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  bool? isNeedHanding;

  var finish = FinishHandle(milliseconds: 500);

  PostController({this.isNeedHanding}) {
    getAllPost(isRefresh: true);
  }

  Future<void> getAllPost({
    bool? isRefresh,
  }) async {
    finish.run(() async {
      if (isRefresh == true) {
        currentPage = 1;
        isEnd = false;
      }

      try {
        if (isEnd == false) {
          isLoading.value = true;
          var data = await RepositoryManager.postRepository
              .getAllPost(
            search: textSearch,
            page: currentPage,
          );

          if (isRefresh == true) {
            listPost(data!.data!.data!);
          } else {
            listPost.addAll(data!.data!.data!);
          }

          if (data.data!.nextPageUrl == null) {
            isEnd = true;
          } else {
            isEnd = false;
            currentPage = currentPage + 1;
          }
        }
        isLoading.value = false;
        loadingInit.value = false;
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
      loadingInit.value = false;
    });
  }

  Future<bool?> deletePost(int? postId) async {
    try {
      var list = await RepositoryManager.postRepository.deletePost(postId!);
      SahaAlert.showSuccess(message: "Đã xóa");
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
