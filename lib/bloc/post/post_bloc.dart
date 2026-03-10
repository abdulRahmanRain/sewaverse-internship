import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/post/post_event.dart';
import 'package:todo_app/bloc/post/post_state.dart';
import 'package:todo_app/data/post_repositories.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepositories _postRepositories;

  PostBloc(this._postRepositories) : super(PostInitialState()) {

    /// Fetch posts
    on<FetchPostsEvent>((event, emit) async {
      emit(PostLoadingState());
      try {
        final posts = await _postRepositories.fetchData();
        emit(PostLoadedState(posts));
      } catch (e) {
        emit(PostErrorState("Failed to fetch posts: ${e.toString()}"));
      }
    });

    /// Add a new post
    on<DataPostEvent>((event, emit) async {
      emit(PostLoadingState());
      await Future.delayed(const Duration(seconds: 10));
      try {
        await _postRepositories.addPost(event.title, event.description);
        emit(PostAddedState("Post successfully added!"));

        // Refresh the list after adding
        final posts = await _postRepositories.fetchData();
        emit(PostLoadedState(posts));
      } catch (e) {
        emit(PostErrorState("Failed to add post: ${e.toString()}"));
      }
    });

    /// Add comment to a post
    on<PostCommentEvent>((event, emit) async {
      emit(PostLoadingState());
      try {
        // Ensure you pass postId if your repository requires it
        await _postRepositories.addComment(event.comment, postId: event.postId);
        emit(PostAddedState("Comment successfully added!"));

        // Refresh the list after adding comment
        final posts = await _postRepositories.fetchData();
        emit(PostLoadedState(posts));
      } catch (e) {
        emit(PostErrorState("Failed to add comment: ${e.toString()}"));
      }
    });
  }
}