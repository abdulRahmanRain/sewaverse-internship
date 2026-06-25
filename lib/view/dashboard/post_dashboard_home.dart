import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/view/full_auth_screen/splash_screen.dart';
import '../../bloc/post_app/post_bloc.dart';
import '../../bloc/post_app/post_event.dart';
import '../../bloc/post_app/post_state.dart';
import '../../constants/app_color.dart';
import '../../helper/post_helper/custom_container.dart';
import '../../helper/text_field_helper.dart';
import '../auth/login_screen.dart';
import '../auth/user_home_screen.dart';

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
  Map<int, bool> isExpandedComment = {};

  final List<String> images = [
    "https://everwallpaper.com/cdn/shop/files/mountain-wallpaper-mural_342090c2-b68e-418b-9a1f-833a6e0f2cb7.jpg?v=1653544541&width=1500",
    "https://t4.ftcdn.net/jpg/02/79/67/37/360_F_279673798_itmQUSrwFy7mldM3eqyZ5McwhHaNSds0.jpg",
    "https://external-previewredd.it/PN297qUHBKjGEb-BBAbe2XkMBvjiZHX7cgzlwRUr5_A.jpg?width=640&crop=smart&auto=webp&s=49a5a53671c9c9cdbee95f1ced077b05d3f3a2b8"
  ];

  final List<String> users = ["Abdul Rahman", "Rabin Bista", "Nabin Raj Joshi"];

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

  final _authBox = Hive.box('authBox');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.login),
              title: const Text("Login"),
              onTap: () {
                Navigator.pop(context);

                final currentUser = _authBox.get('currentUser');

                if (currentUser != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const UserHomeScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20,),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Splash Screen"),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SplashScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoadingState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (_, __) => CustomContainer.shimmer(),
              ),
            );
          }

          if (state is PostErrorState) {
            return Center(child: Text(state.message));
          }

          if (state is PostLoadedState) {
            final posts = state.posts;

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
                      onPressed: () {

                      },
                      icon: const Icon(Icons.add, size: 30),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: posts.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final post = posts[index];

                        // Initialize states if not present
                        commentControllers.putIfAbsent(post.id!, () => TextEditingController());
                        isExpandedContent.putIfAbsent(post.id!, () => false);
                        isActiveColor.putIfAbsent(post.id!, () => false);
                        likeCounters.putIfAbsent(post.id!, () => 0);
                        isExpandedComment.putIfAbsent(post.id!, () => false);

                        String imageUrl = images[index % images.length];
                        String userName = users[index % users.length];

                        return Stack(
                          children: [
                            CustomContainer.build(
                              title: userName,
                              body: post.body ?? "",
                              isExpanded: isExpandedContent[post.id!]!,
                              onTap: () {
                                setState(() {
                                  isExpandedContent[post.id!] = !isExpandedContent[post.id!]!;
                                });
                              },
                              onTapOnLike: () {
                                setState(() {
                                  isActiveColor[post.id!] = !(isActiveColor[post.id!]!);
                                  likeCounters[post.id!] = isActiveColor[post.id!]!
                                      ? likeCounters[post.id!]! + 1
                                      : likeCounters[post.id!]! - 1;
                                });
                              },
                              likeCount: likeCounters[post.id!]!,
                              isActiveColor: isActiveColor[post.id!]!,
                              onTapOnComment: () {
                                setState(() {
                                  isExpandedComment[post.id!] = !isExpandedComment[post.id!]!;
                                });
                              },
                              isExpandedComment: isExpandedComment[post.id!]!,
                              textField: TextInput.textField(
                                controller: commentControllers[post.id!]!,
                                label: "Comment",
                                hint: "Enter comment",
                              ),
                              postComment: () {
                                if (commentControllers[post.id!]!.text.trim().isEmpty) return;

                                context.read<PostBloc>().add(
                                  PostCommentEvent(
                                    comment: commentControllers[post.id!]!.text.trim(),
                                    postId: post.id!,
                                  ),
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