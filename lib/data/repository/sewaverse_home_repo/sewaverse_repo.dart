import 'package:todo_app/application_layer/api_endpoints.dart';
import 'package:todo_app/application_layer/network/dio_client.dart';
import 'package:todo_app/application_layer/network/dio_crud.dart';
import 'package:todo_app/domain/models/sewa_model/sewaverse_model.dart';

class SewaverseRepo {
  final DioCrud _client;

  SewaverseRepo(this._client);

  Future<SewaverseModel> getServices()  async {
    final response = await _client.getData(
      ApiEndPointsSewa.baseUrl,
      ApiEndPointsSewa.featuredService,
    );

    return SewaverseModel.fromJson(response.data);
  }
}