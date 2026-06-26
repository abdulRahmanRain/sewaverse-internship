import 'package:todo_app/application_layer/api_endpoints.dart';
import 'package:todo_app/application_layer/network/dio_crud.dart';

import '../../../domain/models/gray_volf_model/job_type_model.dart';

class JobTypesRepo {
  final DioCrud _dioCrud;

  JobTypesRepo(this._dioCrud);

  Future<List<JobModel>> getJob() async {
    final response = await _dioCrud.getData(
      "https://qc.lab.sewaverse.com/api",
      "/home/featured-services",
    );

    final List data = response.data["data"];

    final List services = data[0]["services"];

    return services
        .map((e) => JobModel.fromJson(e))
        .toList();
  }
}