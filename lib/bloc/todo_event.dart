abstract class TodoEvent {}

class AddTaskEvent extends TodoEvent {
  final String title;
  final String description;

  AddTaskEvent(this.title, this.description);
}

class EditTaskEvent extends TodoEvent {
  final String id;
  final String title;
  final String description;

  EditTaskEvent(this.id, this.title, this.description);
}

class DeleteTaskEvent extends TodoEvent {
  final String id;

  DeleteTaskEvent(this.id);
}

class ViewTaskEvent extends TodoEvent {}