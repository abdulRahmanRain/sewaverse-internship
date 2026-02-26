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
  final _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(height: AppSpacing.Large),

                  TextInput.textField(
                      controller: title,
                      label: "title",
                      hint: "Enter your title",
                      validator: (value){
                        if (value == null|| value.isEmpty){
                          return "Title cannot be empty";
                        }
                      }
                  ),

                  SizedBox(height: AppSpacing.medium),

                  TextInput.textField(
                    controller: description,
                    label: "Description",
                    hint: "Enter Your description",
                    validator: (value){
                      if (value == null|| value.isEmpty){
                        return "Description cannot be empty";
                      }
                    }
                  ),

                  SizedBox(height: AppSpacing.Large),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()){
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
      ),
    );
  }
}
