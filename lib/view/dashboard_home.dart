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

import '../bloc/post/post_event.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  Map<int, TextEditingController> commentControllers = {};
  Map<int, bool> isExpandedContent = {};
  Map<int, bool> isActiveColor = {};
  Map<int, int> likeCounters = {};
  List<bool> isExpandedComment = [];

  final List<String> images = [
    "https://everwallpaper.com/cdn/shop/files/mountain-wallpaper-mural_342090c2-b68e-418b-9a1f-833a6e0f2cb7.jpg?v=1653544541&width=1500",
    "https://t4.ftcdn.net/jpg/02/79/67/37/360_F_279673798_itmQUSrwFy7mldM3eqyZ5McwhHaNSds0.jpg",
    "https://external-previewredd.it/PN297qUHBKjGEb-BBAbe2XkMBvjiZHX7cgzlwRUr5_A.jpg?width=640&crop=smart&auto=webp&s=49a5a53671c9c9cdbee95f1ced077b05d3f3a2b8"
  ];

  final List<String> users = ["Abdul Rahman","Rabin Bista","Nabin Raj Joshi"];

  @override
  void dispose() {
    for (var controller in commentControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoadingState) {
            return ListView.separated(
              itemCount: 5,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) => CustomContainer.postSkeleton(),
            );
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 0, right: 0),
                    title: const Text(
                      "Add New Post",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 30),
                    ),
                  ),
                  SizedBox(height: AppSpacing.medium),
                  Expanded(
                    child: ListView.separated(
                      itemCount: posts.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        bool isExpanded = isExpandedContent[post.id] ?? false;
                        bool isActive = isActiveColor[post.id] ?? false;
                        int likeCount = likeCounters[post.id] ?? 0;

                        commentControllers.putIfAbsent(
                          post.id!,
                              () => TextEditingController(),
                        );

                        String imageUrl = images[index % images.length];
                        String userName  = users[index % users.length];

                        return Stack(
                          children: [
                            CustomContainer.build(
                              title: userName,
                              body: post.body ?? "",
                              isExpanded: isExpanded,
                              onTap: () {
                                setState(() {
                                  isExpandedContent[post.id!] = !isExpanded;
                                });
                              },
                              onTapOnLike: () {
                                setState(() {
                                  isActiveColor[post.id!] = !(isActiveColor[post.id!] ?? false);
                                  if (isActiveColor[post.id!] == true) {
                                    likeCounters[post.id!] =
                                        (likeCounters[post.id!] ?? 0) + 1;
                                  } else {
                                    likeCounters[post.id!] =
                                        (likeCounters[post.id!] ?? 1) - 1;
                                  }
                                });
                              },
                              likeCount: likeCount,
                              isActiveColor: isActive,
                              onTapOnComment: () {
                                setState(() {
                                  isExpandedComment[index] =
                                  !isExpandedComment[index];
                                });
                              },
                              isExpandedComment: isExpandedComment[index],
                              textField: TextInput.textField(
                                controller: commentControllers[post.id!]!,
                                label: "comment",
                                hint: "Enter comment",
                              ),
                              postComment: () {
                                PostComment(
                                  CommentController: commentControllers[post.id!]!,
                                );
                                commentControllers[post.id!]!.clear();
                              },
                              imageUrl: imageUrl,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_horiz),
                              ),
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