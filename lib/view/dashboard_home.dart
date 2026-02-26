import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/post/post_bloc.dart';
import 'package:todo_app/bloc/post/post_state.dart';
import 'package:todo_app/constants/app_color.dart';
import 'package:todo_app/constants/constants.dart';
import 'package:todo_app/helper/custom_container.dart';
import 'package:todo_app/helper/text_fileld_helper.dart';
import 'package:todo_app/view/add_post.dart';


class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  List<bool> isExpandedList = [];
  List<bool> isExpandedComment = [];
  List<int> likeCounters = [];

  TextEditingController commentController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: false,
        actions: [
          TextButton(onPressed: (){Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPost(),
            ),
          );}, child: Text("Add Post"))
        ],
      ),
      body:BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {

            if (state is PostLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PostErrorState) {
              return Center(child: Text(state.message));
            }


            if (state is PostLoadedState) {
              final posts = state.posts;

              if (isExpandedList.length != posts.length) {
                isExpandedList = List.filled(posts.length, false);
              }

              if (isExpandedComment.length != posts.length) {
                isExpandedComment = List.filled(posts.length, false);
              }

              if (likeCounters.length != posts.length) {
                likeCounters = List.filled(posts.length, 0);
              }

              if (posts.isEmpty) {
                return const Center(child: Text("No Data"));
              }

              return Padding(
                padding: EdgeInsets.all(AppSpacing.medium),
                child: Column(
                  children: [
                    SizedBox(height: AppSpacing.small),
                    Expanded(
                      child: ListView.separated(
                        itemCount: posts.length,
                        separatorBuilder : (context, index) => const SizedBox(height: 20,),
                        itemBuilder: (context, index) {
                          final post = posts[index];

                          return Stack(
                            children: [
                              CustomContainer.build(
                                title: post.title.toString(),
                                body: post.body.toString(),
                                isExpanded: isExpandedList[index],
                                onTap: (){
                                  setState(() {
                                    isExpandedList[index] = !isExpandedList[index];
                                  });
                                },
                                onTapOnLike: (){
                                  setState(() {
                                    likeCounters[index]++;
                                  });
                                },
                                likeCount: likeCounters[index],
                                onTapOnComment: (){
                                  setState(() {
                                    isExpandedComment[index] =!isExpandedComment[index];
                                  });
                                },
                                isExpandedComment: isExpandedComment[index],
                                textField: TextInput.textField(controller: commentController, label: "comment", hint: "Enter comment")
                              ),

                              Positioned(
                                top: 0,
                                right:0,
                                child: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
    );
  }
}