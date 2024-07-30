import 'package:com.ikitech.store/app_user/data/remote/response-request/community/all_post_cmt_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:sahashop_customer/app_customer/model/community_post.dart';
import '../../../model/comment.dart';
import '../../../utils/user_info.dart';
import '../../remote/response-request/community/comment_all_res.dart';
import '../../remote/response-request/community/post_cmt_res.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class CommunityRepository {
  Future<AllPostCmtRes?> getPostCmt(
      {required int page,int? userId, String? search, int? status}) async {
    try {
      bool? isPin = null;
      if(status == 3) {
        isPin = true;
        status = null;
      }
      var res =
      await SahaServiceManager().service!.getPostCmt(UserInfo().getCurrentStoreCode(),page, search,userId,isPin ,status);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<PostCmtRes?> createPostCmt(CommunityPost post) async {
    try {
      var res = await SahaServiceManager().service!.createPostCmt(UserInfo().getCurrentStoreCode(),post.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<PostCmtRes?> updatePostCmt(int postId, CommunityPost post) async {
    try {
      var res =
      await SahaServiceManager().service!.updatePostCmt(UserInfo().getCurrentStoreCode(),postId, post.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> reUpPostCmt(int postId) async {
    try {
      var res =
      await SahaServiceManager().service!.reUpPostCmt(UserInfo().getCurrentStoreCode(),postId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<PostCmtRes?> pinPostCmt(int postId,bool isPin) async {
    try {
      var res =
      await SahaServiceManager().service!.pinPostCmt(UserInfo().getCurrentStoreCode(),{
        "community_post_id":postId,
        "is_pin":isPin
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<PostCmtRes?> pinPostCmtTop(int postId) async {
    try {
      var res =
      await SahaServiceManager().service!.pinPostCmtTop(UserInfo().getCurrentStoreCode(),{
        "community_post_id":postId,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deletePostCmt(int postId) async {
    try {
      var res = await SahaServiceManager().service!.deletePostCmt(UserInfo().getCurrentStoreCode(),postId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<PostCmtRes?> getOnePostCmt(int postId) async {
    try {
      var res = await SahaServiceManager().service!.getOnePostCmt(UserInfo().getCurrentStoreCode(),postId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CommentAllRes?> getComment(int page, int postId, int? status) async {
    try {
      var res = await SahaServiceManager().service!.getComment(UserInfo().getCurrentStoreCode(),
          page, postId, status);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<PostCmtRes?> createComment({required Comment comment}) async {
    try {
      var res = await SahaServiceManager().service!.createComment(UserInfo().getCurrentStoreCode(),comment.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<PostCmtRes?> updateComment({required int commentId,required Comment comment}) async {
    try {
      var res = await SahaServiceManager().service!.updateComment(UserInfo().getCurrentStoreCode(),commentId, comment.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteComment({required int commentId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteComment(UserInfo().getCurrentStoreCode(),commentId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}