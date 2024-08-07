import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/data/repository/handle_error.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';

class PostPickerController extends GetxController {
  var listPost = RxList<Post>();
  var isLoadingPost = false.obs;
  var listCheckSelectedPost = RxList<Post>();
  var listSelectedPost = RxList<Post>();
  var quantityPostSelected = 0.obs;
  var isLoadingCreate = false.obs;
  var listPostParam = "";
  var isLoadMore = false.obs;
  var isEndPost = false.obs;
  var currentPage = 1;
  var isLoadInit = false.obs;
  var isSearch = false.obs;
  List<Post>? listPostInput = [];
  String? textSearch;

  Future<List<Post>?> getAllPost({String? textSearch, bool? isRefresh}) async {
    if (isRefresh == true) {
      isLoadingPost.value = true;
    } else {
      isLoadMore.value = true;
    }

    try {
      if (isEndPost.value == false) {
        var data = await RepositoryManager.postRepository.getAllPost(
            page: currentPage, search: textSearch == null ? "" : textSearch);
        var list = data!.data!.data!;

        if (isRefresh == true) {
          listPost(list);
        } else {
          listPost.addAll(list);
        }

        if (list.length < 20) {
          isEndPost.value = true;
        } else {
          currentPage++;
        }

        isLoadingPost.value = false;
        isLoadMore.value = false;
        return list;
      } else {
        isLoadMore.value = false;
      }
    } catch (err) {
      handleError(err);
    }
    isLoadingPost.value = false;
  }

  void resetListPost() {
    currentPage = 1;
    isEndPost.value = false;
    listPostParam = "";
  }
}
