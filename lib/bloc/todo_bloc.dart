import 'package:flutter_bloc/flutter_bloc.dart';
import '../storage/local_storage/hive_storage.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {

    on<ViewTaskEvent>((event, emit) {
      emit(TodoLoading());
      final tasks = HiveStorage.getTasks();
      emit(TodoLoaded(tasks));
    });

    on<AddTaskEvent>((event, emit) async {
      emit(TodoLoading());
      await HiveStorage.addTask(event.title, event.description);
      final tasks = HiveStorage.getTasks();
      emit(TodoLoaded(tasks));
    });

    on<EditTaskEvent>((event, emit) async {
      emit(TodoLoading());
      await HiveStorage.updateTask(
        event.id,
        event.title,
        event.description,
      );
      final tasks = HiveStorage.getTasks();
      emit(TodoLoaded(tasks));
    });

    on<DeleteTaskEvent>((event, emit) async {
      emit(TodoLoading());
      await HiveStorage.deleteTask(event.id);
      final tasks = HiveStorage.getTasks();
      emit(TodoLoaded(tasks));
    });
  }
}