import 'dart:developer';

import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:dio/dio.dart';


import '../../../utils/user_info.dart';

/// Inteceptor which used in Dio to add authentication
/// token, device code before perform any request ///

class AuthInterceptor extends InterceptorsWrapper {
  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (UserInfo().getToken() != null) {
      options.headers.putIfAbsent("token", () => UserInfo().getToken());
    }

    log('==========Link: ${options.uri.toString()}');
    log('==========Header: ${options.headers}');

    log('==========Request: ${options.data}');

    var hasImage = false;
    if (options.data is Map) {
      for (var element in (options.data as Map).values) {
        if (element is MultipartFile) {
          hasImage = true;
        }
      }
    }
    if (options.method == 'POST' && hasImage) {
      options.data = FormData.fromMap(options.data);
    }

    return super.onRequest(options, handler);
  }

   @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('------Response: ${response.data}');

    if (response.data["code"] == 401) {
      UserInfo().setToken(null);
      SahaDialogApp.showDialogNotificationOneButton(
          mess: "Hết phiên đăng nhập mời đăng nhập lại",
          barrierDismissible: false,
          onClose: () {
            UserInfo().logout();
          });
    }
    return super.onResponse(response, handler);
    }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) {
    print('On Error ${error.response}');
    switch (error.type) {
      case DioExceptionType.cancel:
        // error.error = 'Đã hủy kết nối';
        break;
      case DioExceptionType.connectionTimeout:
        // error.error = 'Không thể kết nối đến server';
        break;
      case DioExceptionType.receiveTimeout:
        // error.error = 'Không thể nhận dữ liệu từ server';
        break;
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 429) {
          //  error.error = 'Bạn gửi quá nhiều yêu cầu xin thử lại sau 1 phút';
          break;
        }
        if (error.response?.statusCode == 500) {
          // error.error = 'Lỗi mạng vui lòng thử lại sau';
          log('${error.response}');
          break;
        }
        // error.error =
        // '${dioError.response?.data["msg"] ?? "Lỗi kết nối vui lòng kiểm tra lại mạng"}';
        break;
      case DioExceptionType.sendTimeout:
        // error.error = 'Không thể gửi dữ liệu đến server';
        break;
      case DioExceptionType.unknown:
        //  error.error =
        //  "${dioError.response?.data["msg"] ?? "Lỗi kết nối vui lòng kiểm tra lại mạng"}";
        break;
      case DioExceptionType.badCertificate:
        // TODO: Handle this case.
        break;
      case DioExceptionType.connectionError:
        // TODO: Handle this case.
        break;
    }

    if (error.response?.statusCode == 401 &&
        error.response?.data["msg"] == 'Invalid Token') {
      UserInfo().logout();
      SahaDialogApp.showDialogNotificationOneButton(
          mess: "Hết phiên đăng nhập mời đăng nhập lại",
          barrierDismissible: false);
  }
  super.onError(error, handler);
}
}
