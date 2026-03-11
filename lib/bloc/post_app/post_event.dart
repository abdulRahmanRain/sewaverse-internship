abstract class PostEvent {}

/// Fetch all posts
class FetchPostsEvent extends PostEvent {}

/// Add a new post
class DataPostEvent extends PostEvent {
  final String title;
  final String description;

  DataPostEvent({
    required this.title,
    required this.description,
  });
}

/// Add a comment to a post
class PostCommentEvent extends PostEvent {
  final String comment;
  final int postId; // Added postId

  PostCommentEvent({
    required this.comment,
    required this.postId,
  });
}