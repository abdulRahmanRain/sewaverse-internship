import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/post/post_bloc.dart';
import '../bloc/post/post_event.dart';

class PostComment extends StatelessWidget {
  final TextEditingController CommentController;

  const PostComment({
    super.key,
    required this.CommentController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<PostBloc>().add(
          PostCommentEvent(
            comment: CommentController.text.trim(),
          ),
        );
      },
      child: const Text('Post'),
    );
  }
}