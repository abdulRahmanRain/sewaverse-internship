
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/post/post_event.dart';
import 'package:todo_app/bloc/post/post_state.dart';
import 'package:todo_app/data/post_repositories.dart';



class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepositories _postRepositories;
  PostBloc(this._postRepositories) : super(PostInitialState()) {
    on<FetchPostsEvent>((event, emit) async {
      emit(PostLoadingState());
      try {
        final response = await _postRepositories.fetchData();
        emit(PostLoadedState(response));
      } catch (e) {
        emit(PostErrorState(e.toString()));
      }
    });
    on<DataPostEvent>((event, emit) async{
      try{
        await _postRepositories.addPost(event.title,event.description);
        emit(PostAddedState("Post successfully added!"));
        final response = await _postRepositories.fetchData();
        emit(PostLoadedState(response));
      }catch(e){
        emit(PostErrorState(e.toString()));
      }
    });
  }
}