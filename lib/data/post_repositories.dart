import 'package:todo_app/application_layer/api_endpoints.dart';
import 'package:todo_app/domain/models.dart';
import '../application_layer/network/dio_client.dart';
import 'package:dio/dio.dart';

class PostRepositories {
  final DioClient _dioClient;

  PostRepositories(this._dioClient);

  /// Fetch all posts
  Future<List<PostModel>> fetchData() async {
    try {
      Response response = await _dioClient.dio.get(ApiEndpoints.posts);

      if (response.statusCode == 200) {
        final data = response.data as List;
        final posts = data.map((json) => PostModel.fromJson(json)).toList();
        return posts;
      } else {
        throw Exception(
            "Failed to fetch posts. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching posts: ${e.toString()}");
    }
  }

  /// Add a new post
  Future<void> addPost(String title, String description) async {
    try {
      Response response = await _dioClient.dio.post(
        ApiEndpoints.posts,
        data: {
          "title": title,
          "description": description,
        },
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception(
            "Failed to add post. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error adding post: ${e.toString()}");
    }
  }

  /// Add a comment
  Future<void> addComment(String comment, {required int postId}) async {
    try {
      Response response = await _dioClient.dio.post(
        "${ApiEndpoints.comment}/$postId", // assuming comment endpoint needs post id
        data: {
          "comment": comment,
        },
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception(
            "Failed to add comment. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error adding comment: ${e.toString()}");
    }
  }
}