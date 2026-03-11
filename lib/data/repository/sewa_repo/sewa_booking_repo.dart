import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../application_layer/api_endpoints.dart';
import '../../../application_layer/network/dio_crud.dart';
import '../../../domain/models/sewa_model/offered_service_response.dart';



class BookingRepository {
  final DioCrud dioCrud;

  BookingRepository({required this.dioCrud});

  Future<OfferedServiceResponse> fetchOfferedService({required String id}) async {
    try {
      Response response = await dioCrud.getData(
        ApiEndPointsSewa.baseUrl,
        ApiEndPointsSewa.offeredServiceResponse(id),
      );

      debugPrint("Server status: ${response.statusCode}");
      debugPrint("Server response: ${response.data}");

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return OfferedServiceResponse.fromJson(response.data);
      } else {
        throw Exception(
            "Server returned ${response.statusCode}: ${response.data.toString()}");
      }
    } catch (e) {
      throw Exception("Error fetching offered service: $e");
    }
  }
}