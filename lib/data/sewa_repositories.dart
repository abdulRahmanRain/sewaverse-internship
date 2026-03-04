import 'package:todo_app/application_layer/api_endpoints.dart';
import 'package:todo_app/application_layer/sewa_api_service.dart';
import 'package:todo_app/domain/sewa_model.dart';

class SewaRepositories {
  final SewaDioClient _sewaDioClient;
  SewaRepositories(this._sewaDioClient);

  Future<List<SewaModel>> fetchData() async {
    try {
      final response = await _sewaDioClient.get(ApiEndPointsSewaverse.baseUrl);

      // Map the full JSON into one SewaModel
      final sewaModel = SewaModel.fromJson(response);

      // If you want a list (even if it’s one), wrap the model in a list
      return [sewaModel];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}