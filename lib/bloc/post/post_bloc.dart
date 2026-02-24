
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/post/post_event.dart';
import 'package:todo_app/bloc/post/post_state.dart';

import '../../Application Layer/Services/api_service.dart';


class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitialState()) {
    on<FetchPostsEvent>((event, emit) async {
      emit(PostLoadingState());
      try {
        final response = await fetchData();
        emit(PostLoadedState(response));
      } catch (e) {
        emit(PostErrorState(e.toString()));
      }
    });
  }
}