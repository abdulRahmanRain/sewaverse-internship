import 'package:dio/dio.dart';
import 'package:todo_app/Application%20Layer/Services/api_endpoints.dart';
import 'package:todo_app/domain/models.dart';

Future<List<PostModel>> fetchData() async {
  var dio = Dio();
  final response = await dio.get(ApiEndpoints.posts);
  final data = response.data as List;
  return data.map((json) => PostModel.fromJson(json)).toList();
}