import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/post/post_bloc.dart';
import 'package:todo_app/bloc/post/post_event.dart';
import 'package:todo_app/bloc/post/post_state.dart';
import 'package:todo_app/constants/constants.dart';
import 'package:todo_app/view/add_post.dart';
import 'add_task.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
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
              if (posts.isEmpty) {
                return const Center(child: Text("No Data"));
              }

              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];

                          return ListTile(
                            title: Text(post.title.toString()),
                            subtitle: Text(post.body.toString()),

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPost(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}