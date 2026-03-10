import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioClient {
  late Dio dio;

  DioClient({required String baseUrl}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        validateStatus: (status) => status != null && status < 600, // allow 500s
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          debugPrint("Response: ${response.statusCode}");
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          debugPrint("Error: ${error.message}");
          return handler.next(error);
        },
      ),
    );
  }
}