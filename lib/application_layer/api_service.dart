import 'package:dio/dio.dart';

class DioClient {
  late final Dio _dio;

  DioClient({required String baseUrl}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
    _addInterceptors();
  }


  void _addInterceptors(){
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler){
          print ("Response Received : ${response.statusCode}");
          return handler.next(response);
        },
        onError: (error, handler){
          print("Error: ${error.message}");
          return handler.next(error);
        }
        o
      )
    );
  }


  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try{
      return await _dio.post(path, data: data);
    } catch(e){
      throw Exception(e.toString());
    }
  }
}