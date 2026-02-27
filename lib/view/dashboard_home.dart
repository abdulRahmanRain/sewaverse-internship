import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/post/post_bloc.dart';
import 'package:todo_app/bloc/post/post_state.dart';
import 'package:todo_app/constants/app_color.dart';
import 'package:todo_app/constants/constants.dart';
import 'package:todo_app/constants/users_and_time.dart';
import 'package:todo_app/helper/custom_container.dart';
import 'package:todo_app/helper/post_comment.dart';
import 'package:todo_app/helper/text_fileld_helper.dart';
import 'package:todo_app/view/add_post.dart';


class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {


  Map<int, TextEditingController> commentControllers = {};

  @override
  void dispose() {
    for (var controller in commentControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Map<int,bool> isExpandedContent = {};
  Map<int,bool> isActiveColor = {};
  Map<int,int> likeCounters = {};
  List<bool> isExpandedComment = [];



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true
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


              if (isExpandedComment.length != posts.length) {
                isExpandedComment = List.filled(posts.length, false);
              }

              if (posts.isEmpty) {
                return const Center(child: Text("No Data"));
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 0, right: 0),
                      title: Text("Add New Post", style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22),),
                      trailing: IconButton(onPressed: (){}, icon: Icon(Icons.add, size: 30,)),
                    ),
                    SizedBox(height: AppSpacing.medium,),
                    Expanded(
                      child: ListView.separated(
                        itemCount: posts.length,
                        separatorBuilder : (context, index) => const SizedBox(height: 20,),
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          bool isExpanded = isExpandedContent[post.id] ?? false;
                          bool isActive = isActiveColor[post.id] ?? false;
                          int likeCount = likeCounters[post.id] ?? 0;
                          commentControllers.putIfAbsent(
                            post.id!,
                                () => TextEditingController(),
                          );

                          return Stack(
                            children: [
                              CustomContainer.build(
                                title: UsersAndTime.name,
                                body: post.body.toString(),
                                isExpanded: isExpanded,
                                onTap: (){
                                  setState(() {
                                    isExpandedContent[post.id!] = !isExpanded;
                                  });
                                },
                                  onTapOnLike: () {
                                    setState(() {

                                      isActiveColor[post.id!] = !(isActiveColor[post.id!] ?? false);

                                      if (isActiveColor[post.id!] == true) {
                                        likeCounters[post.id!] = (likeCounters[post.id!] ?? 0) + 1;
                                      } else {
                                        likeCounters[post.id!] = (likeCounters[post.id!] ?? 1) - 1;
                                      }

                                    });
                                  },
                                likeCount: likeCount,
                                isActiveColor: isActive,
                                onTapOnComment: (){
                                  setState(() {
                                    isExpandedComment[index] =!isExpandedComment[index];
                                  });
                                },
                                isExpandedComment: isExpandedComment[index],
                                textField: TextInput.textField(
                                    controller: commentControllers[post.id!]!,
                                    label: "comment",
                                    hint: "Enter comment"
                                ),

                                postComment: (){
                                  PostComment(CommentController: commentControllers[post.id!]!);
                                }
                              ),


                              Positioned(
                                top: 0,
                                right:0,
                                child: IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz)),
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