import 'package:dio/dio.dart';
import 'dio_client.dart';

class DioCrud {
  // GET request
  Future<Response> getData(
      String baseUrl,
      String endPoint, {
        Map<String, dynamic>? queryParameters,
      }) async {
    DioClient client = DioClient(baseUrl: baseUrl);

    Response response = await client.dio.get(
      endPoint,
      queryParameters: queryParameters,
    );

    return response;
  }

  // POST request
  Future<Response> postData(
      String baseUrl,
      String endPoint, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
      }) async {
    DioClient client = DioClient(baseUrl: baseUrl);

    Response response = await client.dio.post(
      endPoint,
      data: data,
      queryParameters: queryParameters,
    );

    return response;
  }


}