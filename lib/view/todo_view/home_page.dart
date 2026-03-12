import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/bloc/todo_app/todo_bloc.dart';
import 'package:todo_app/bloc/todo_app/todo_event.dart';
import 'package:todo_app/bloc/todo_app/todo_state.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/view/todo_view/add_task.dart';

import '../../bloc/login_bloc/login_bloc.dart';
import '../../bloc/login_bloc/login_event.dart';
import '../../helper/build_app_drawer.dart';
import '../../storage/local_storage/hive_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();


    context.read<TodoBloc>().add(ViewTaskEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Screen"),
        centerTitle: true,
      ),
      drawer: buildAppDrawer(context: context, hiveStorage: HiveStorage(),onLogOut: (){
        context.read<LoginBloc>().add(
          LogOutEvent()
        );
      }),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {

          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TodoLoaded) {

            if (state.tasks.isEmpty) {
              return const Center(
                child: Text("No Data"),
              );
            }

            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];

                return ListTile(
                  title: Text(task["title"]),
                  subtitle: Text(task["description"]),
                  trailing: SizedBox(
                    width: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<TodoBloc>().add(
                              DeleteTaskEvent(task["id"]),
                            );
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        const SizedBox(width: AppSizes.paddingXXL),
                        InkWell(
                          onTap: () {
                            final id = task['id'];
                            context.go('/todoHome/addTaskEdit/$id');
                          },
                          child: const Text(
                            "Edit",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if (state is TodoError) {
            return Center(
              child: Text(state.message),
            );
          }

          return const SizedBox();
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/todoHome/addTask');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}