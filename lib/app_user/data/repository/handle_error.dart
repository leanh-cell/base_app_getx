import 'dart:convert';

import 'package:dio/dio.dart';

String handleError(err) {
  if (err is DioException) {
    print(err.type);
    if (err.type == DioExceptionType.unknown) {
      throw "Kết nối yếu hoặc không có mạng";
    }

    if (err.type == DioExceptionType.sendTimeout) {
      throw "Kết nối yếu hoặc không có mạng";
    }

    if (err.type == DioExceptionType.receiveTimeout) {
      throw "Kết nối yếu hoặc không có mạng";
    }

    if (err.type == DioExceptionType.badCertificate) {
      throw "Kết nối yếu hoặc không có mạng";
    }

    if (err.type == DioExceptionType.connectionTimeout) {
      throw "Kết nối yếu hoặc không có mạng";
    }

    if (err.type == DioExceptionType.connectionError) {
      throw "Kết nối yếu hoặc không có mạng";
    }

    if (err.type == DioExceptionType.badResponse) {
      throw jsonDecode((err.response ?? "").toString())['msg'] == null
          ? "Kết nối yếu hoặc không có mạng"
          : "${jsonDecode((err.response ?? "").toString())['msg']}";
    }
    print(
        "ERROR Dioooo: ${jsonDecode((err.response ?? "").toString())['msg']}");
    throw "${jsonDecode((err.response ?? "").toString())['msg']}";
  }
  print("ERROR: ${err.toString()}");
  throw "Có lỗi xảy ra";
}
