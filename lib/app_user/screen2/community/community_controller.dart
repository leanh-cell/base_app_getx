import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/community_post.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';
import '../../components/saha_user/toast/saha_alert.dart';
import '../../data/repository/repository_manager.dart';
import '../../utils/finish_handle_utils.dart';

class CommunityController extends GetxController {
  var status = 0;

  var listPost = RxList<CommunityPost>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  var finish = FinishHandle(milliseconds: 500);
  InfoCustomer? customer;

  CommunityController({this.customer});

  Future<void> getPostCmt({bool? isRefresh, int? status}) async {
    if (textSearch == "" || textSearch == null) {
      if (isRefresh == true) {
        currentPage = 1;
        isEnd = false;
      }

      try {
        if (isEnd == false) {
          isLoading.value = true;
          var data = await RepositoryManager.communityRepository.getPostCmt(
              search: textSearch,
              page: currentPage,
              userId: customer == null ? null : customer!.id,
              status: status);

          if (isRefresh == true) {
            listPost(data!.data!.data!);
          } else {
            listPost.addAll(data!.data!.data!);
          }

          if (data.data!.nextPageUrl == null) {
            isEnd = true;
          } else {
            currentPage = currentPage + 1;
            isEnd = false;
          }
        }
        isLoading.value = false;
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
    } else {
      finish.run(() async {
        if (isRefresh == true) {
          currentPage = 1;
          isEnd = false;
        }

        try {
          if (isEnd == false) {
            isLoading.value = true;
            var data = await RepositoryManager.communityRepository.getPostCmt(
                search: textSearch,
                page: currentPage,
                userId: customer == null ? null : customer!.id,
                status: status);

            if (isRefresh == true) {
              listPost(data!.data!.data!);
            } else {
              listPost.addAll(data!.data!.data!);
            }

            if (data.data!.nextPageUrl == null) {
              isEnd = true;
            } else {
              currentPage = currentPage + 1;
              isEnd = false;
            }
          }
          isLoading.value = false;
        } catch (err) {
          SahaAlert.showError(message: err.toString());
        }
      });
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      var data =
          await RepositoryManager.communityRepository.deletePostCmt(postId);
      listPost.removeWhere((element) => postId == element.id);
      SahaAlert.showSuccess(message: "Đã xoá");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }

  Future<void> updateCommunityPost(
      int communityPostId, CommunityPost communityPost, int status) async {
    var communityPostNew = communityPost;
    communityPostNew.status = status;
    try {
      var data = await RepositoryManager.communityRepository.updatePostCmt(
        communityPostId,
        communityPostNew,
      );
      print(data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> pinPostCmt(int postId, bool isPin) async {
    try {
      var data =
          await RepositoryManager.communityRepository.pinPostCmt(postId, isPin);
      var index = listPost.indexWhere((element) => element.id == postId);
      if (index > -1) {
        listPost[index].isPin = isPin;
      }
      listPost.refresh();
      if (isPin == true) {
        SahaAlert.showSuccess(message: "Đã ghim");
      } else {
        SahaAlert.showError(message: "Đã bỏ gim");
      }
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }

  Future<void> reUpPostCmt(int postId) async {
    try {
      var data =
          await RepositoryManager.communityRepository.reUpPostCmt(postId);
      getPostCmt(isRefresh: true, status: status);
      SahaAlert.showSuccess(message: "Đã lên lại");
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }
}
