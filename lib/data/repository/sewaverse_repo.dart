import 'package:dio/dio.dart';
import 'package:todo_app/application_layer/api_endpoints.dart';
import '../../application_layer/network/dio_crud.dart';

import '../../domain/models/sewaverse_model.dart';

class SewaverseRepository {
  final DioCrud dioCrud;

  SewaverseRepository({required this.dioCrud});

  // Fetch data from API
  Future<SewaverseModel> fetchData({Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await dioCrud.getData(
        ApiEndPointsSewa.baseUrl,
        ApiEndPointsSewa.featuredServiceGroups,
        queryParameters: queryParameters,
      );

      if (response.data != null && response.data["data"] != null) {
        return SewaverseModel.fromJson(response.data);
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Post data to API
  Future<Response> postData({Map<String, dynamic>? data, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await dioCrud.postData(
        ApiEndpoints.baseUrl,
        ApiEndPointsSewa.featuredServiceGroups,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}