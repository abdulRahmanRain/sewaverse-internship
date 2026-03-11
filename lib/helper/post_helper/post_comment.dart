import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/post_app/post_bloc.dart';
import '../../bloc/post_app/post_event.dart';

class PostComment extends StatelessWidget {
  final TextEditingController commentController;
  final int postId; // Added postId

  const PostComment({
    super.key,
    required this.commentController,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: commentController.text.trim().isEmpty
          ? null // disables button if empty
          : () {
        context.read<PostBloc>().add(
          PostCommentEvent(
            comment: commentController.text.trim(),
            postId: postId, // pass postId here
          ),
        );

        // Clear the text field after posting
        commentController.clear();
      },
      child: const Text('Post'),
    );
  }
}