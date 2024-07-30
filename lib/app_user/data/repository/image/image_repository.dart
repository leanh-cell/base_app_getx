import 'dart:io';
import 'package:dio/dio.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../handle_error.dart';

class ImageRepository {
  Future<String?> uploadImage(File? image) async {
    try {
      var res = await SahaServiceManager().service!.uploadImage(
        {
          "image":
              image == null ? null : await MultipartFile.fromFile(image.path),
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
      Future<String?> uploadVideo({File? video, required String type}) async {
    try {
      var res = await SahaServiceManager().service!.uploadVideo(
         
        {
          "video":
          video == null ? null : await MultipartFile.fromFile(video.path),
          "type": type
        },
      );
      return res.data;
    } catch (err) {
      handleError(err);
    }
    return null;
  }
}
