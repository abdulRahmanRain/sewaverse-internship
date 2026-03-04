import 'package:dio/dio.dart';

class SewaDioClient {
  late Dio dio;

  SewaDioClient({required String baseUrl}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          print("RESPONSE[${response.statusCode}]");

          if (response.data["success"] == false) {
            return handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                error: response.data["message"],
              ),
            );
          }

          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print("ERROR: ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  // ✅ GET request using Dio
  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  // Optional: POST request
  Future<dynamic> post(
      String path, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}