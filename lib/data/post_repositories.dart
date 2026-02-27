// need ot make get post repo metho



import 'package:todo_app/application_layer/api_endpoints.dart';
import 'package:todo_app/application_layer/api_service.dart';
import 'package:todo_app/domain/models.dart';

class PostRepositories {


  final DioClient _dioClient;

  PostRepositories(this._dioClient);

  Future<List<PostModel>> fetchData()async{

    try{
      final data = await _dioClient.get(ApiEndpoints.posts);
      final posts = (data as List).map(
          (json)=>PostModel.fromJson(
            json
          )
      ).toList();

      return posts;
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  Future<void> addPost(String title, String description) async{
    
    try{
      _dioClient.post(ApiEndpoints.posts,data: {"title":title, "description":description});
    }
    catch (e){
      throw Exception(e.toString());
    }
  }

  Future<void> addComment(String comment) async{
    try{
      _dioClient.post(ApiEndpoints.comment,data: {"comment":comment});
    }
    catch (e){
      throw Exception(e.toString());
    }
  }
}

