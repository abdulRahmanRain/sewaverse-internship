import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/constants/constants.dart';
import 'package:todo_app/helper/text_fileld_helper.dart';

import '../bloc/post/post_bloc.dart';
import '../bloc/post/post_event.dart';
import '../bloc/post/post_state.dart';


class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}
class _AddPostState extends State<AddPost> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    title.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostAddedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );

          }

          if (state is PostErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: AppSpacing.Large),
          
                TextInput.textField(
                    title, "Title", "Enter Your Title"),
          
                SizedBox(height: AppSpacing.medium),
          
                TextInput.textField(
                    description, "Description", "Enter Your description"),
          
                SizedBox(height: AppSpacing.Large),
          
                ElevatedButton(
                  onPressed: () {
                    if (title.text.trim().isNotEmpty&&description.text.trim().isNotEmpty){
                      context.read<PostBloc>().add(
                        DataPostEvent(title: title.text.trim(), description: description.text.trim()),
                      );
                      title.clear();
                      description.clear();
                    }
          
                  },
                  child: Text("Add Post"),
                ),
                SizedBox(height: AppSpacing.Large*3,),
                ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("Back"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
