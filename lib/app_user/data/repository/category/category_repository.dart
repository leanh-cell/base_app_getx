import 'dart:io';
import 'package:dio/dio.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import '../handle_error.dart';

class CategoryRepository {
  Future<Category?> createCategoryChild(
      int categoryId, String? name, File? image) async {
    try {
      var res = await SahaServiceManager().service!.createCategoryChild(
        UserInfo().getCurrentStoreCode(),
        categoryId,
        {
          "name": name,
          "image":
              image == null ? null : await MultipartFile.fromFile(image.path),
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<Category?> updateCategoryChild(
      int? categoryId, int? categoryChildId, String? name, File? image) async {
    try {
      var res = await SahaServiceManager().service!.updateCategoryChild(
        UserInfo().getCurrentStoreCode(),
        categoryId,
        categoryChildId,
        {
          "name": name,
          "image":
              image == null ? null : await MultipartFile.fromFile(image.path),
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<bool> deleteCategoryChild(
    int? categoryId,
    int? categoryChildId,
  ) async {
    try {
      var res = await SahaServiceManager().service!.deleteCategoryChild(
          UserInfo().getCurrentStoreCode(), categoryId, categoryChildId);
      return true;
    } catch (err) {
      handleError(err);
      return false;
    }
  }

  Future<Category?> createCategory(String? name, File? image, bool? isShowHome) async {
    try {
      var res = await SahaServiceManager().service!.createCategory(
        UserInfo().getCurrentStoreCode(),
        {
          "name": name,
          "image":
              image == null ? null : await MultipartFile.fromFile(image.path),"is_show_home": isShowHome,
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<Category?> updateCategory(
      String? name, int? categoryId, File? image, bool? isShowHome) async {
    try {
      var res = await SahaServiceManager().service!.updateCategory(
        UserInfo().getCurrentStoreCode(),
        categoryId,
        {
          "is_show_home": isShowHome,
          "name": name,
          "image":
              image == null ? null : await MultipartFile.fromFile(image.path),
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<bool?> sortCategories(List<int> ids, List<int> positions) async {
    try {
      var res = await SahaServiceManager().service!.sortCategories(
          UserInfo().getCurrentStoreCode(),
          {"ids": ids, "positions": positions});
      return true;
    } catch (err) {
      handleError(err);
    }
  }

  Future<List<Category>?> getAllCategory() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllCategory(UserInfo().getCurrentStoreCode());
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<bool> deleteCategory(int productId) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteCategory(UserInfo().getCurrentStoreCode(), productId);
      return true;
    } catch (err) {
      handleError(err);
      return false;
    }
  }
}
