abstract class PostEvent {}

class FetchPostsEvent extends PostEvent {}
class DataPostEvent extends PostEvent {
  String title;
  String description;
  DataPostEvent({required this.title, required this.description});
}

class PostCommentEvent extends PostEvent{
  String comment;
  PostCommentEvent({required this.comment});
}