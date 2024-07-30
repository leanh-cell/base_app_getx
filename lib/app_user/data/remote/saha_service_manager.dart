import 'package:dio/dio.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'inteceptors/auth_interceptor.dart';
import 'service.dart';

/// Class holds reference to Dio clients
class SahaServiceManager {
  /// Singleton
  static final SahaServiceManager _instance = SahaServiceManager._internal();

  factory SahaServiceManager() {
    return _instance;
  }

  SahaServiceManager._internal();

  /// Service getter
  SahaService? get service => _service;

  /// Dio client uses to perform normal requests
  Dio? dioClient;

  /// Dio client uses to perform upload requests
  Dio? uploadClient;
  SahaService? _service;

  /// Initialzation function
  static void initialize() {
      _instance.getNewInstance();
  }

  /// Return the one and the only instance
  void getNewInstance() async {
    var isRelease = UserInfo().getIsRelease();
    final options = BaseOptions(
            receiveDataWhenStatusError: true,
            connectTimeout: Duration(seconds: 10),
            receiveTimeout: Duration(seconds: 10),
            responseType: ResponseType.json), // seconds);
        dioClient = Dio(options);
    dioClient.interceptors.add(AuthInterceptor());
    _service = SahaService( dioClient,
        baseUrl:  isRelease == null
            ? "https://main.doapp.vn/api/"
            : "https://dev.doapp.vn/api/");
  }
}
