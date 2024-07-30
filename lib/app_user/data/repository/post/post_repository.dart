import 'dart:io';
import 'package:dio/dio.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:sahashop_customer/app_customer/model/category_post.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';
import '../../remote/response-request/post/all_post_response.dart';
import '../../remote/response-request/post/pos_res.dart';
import '../handle_error.dart';

class PostRepository {
  Future<CategoryPost?> createCategoryPost({
    String? title,
    File? image,
    String? description,
  }) async {
    try {
      var res = await SahaServiceManager().service!.createCategoryPost(
        UserInfo().getCurrentStoreCode(),
        {
          "title": title,
          "image":
              image == null ? null : await MultipartFile.fromFile(image.path),
          "description": description,
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<CategoryPost>?> getAllCategoryPost() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllCategoryPost(UserInfo().getCurrentStoreCode());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<Post?> createPost(
      {String? title,
      File? image,
      String? summary,
      String? content,
      bool? published,
      int? categoryId}) async {
    try {
      var res = await SahaServiceManager().service!.createPost(
        UserInfo().getCurrentStoreCode(),
        {
          "title": title,
          "image":
              image == null ? null : await MultipartFile.fromFile(image.path),
          "summary": summary,
          "content": content,
          "published": published,
          "category_id": categoryId
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<Post?> updatePost({
    String? title,
    String? imageUrl,
    File? image,
    String? summary,
    String? content,
    bool? published,
    int? categoryId,
    int? postId,
  }) async {
    try {
      var res = await SahaServiceManager().service!.updatePost(
        UserInfo().getCurrentStoreCode(),
        postId,
        {
          "title": title,
          "image":
              image == null ? null : await MultipartFile.fromFile(image.path),
          "image_url": imageUrl == "" ? null : imageUrl,
          "summary": summary,
          "content": content,
          "published": published,
          "category_id": categoryId
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<bool?> deletePost(int postId) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deletePost(UserInfo().getCurrentStoreCode(), postId);
      return true;
    } catch (err) {
      handleError(err);
      return false;
    }
  }

  Future<PostRes?> getOnePost(int postId) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getOnePost(UserInfo().getCurrentStoreCode(), postId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllPostResponse?> getAllPost({int? page, String? search}) async {
    try {
      var res = await SahaServiceManager().service!.getAllPost(
          UserInfo().getCurrentStoreCode(), page ?? 0, search ?? "");
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<bool?> deleteCategoryPost(int categoryPostId) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteCategoryPost(UserInfo().getCurrentStoreCode(), categoryPostId);
      return true;
    } catch (err) {
      handleError(err);
      return false;
    }
  }

  Future<CategoryPost?> updateCategoryPost({
    String? title,
    File? image,
    int? categoryPostId,
    String? imageUrl,
    String? description,
  }) async {
    try {
      var res = await SahaServiceManager().service!.updateCategoryPost(
        UserInfo().getCurrentStoreCode(),
        categoryPostId,
        {
          "title": title,
          "image_url": imageUrl,
          "image":
              image == null ? null : await MultipartFile.fromFile(image.path),
          "description": description,
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
