import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/bloc/auth_bloc/logout_bloc/logout_bloc.dart';
import 'package:todo_app/bloc/auth_bloc/logout_bloc/logout_event.dart';
import 'package:todo_app/bloc/todo_app/todo_bloc.dart';
import 'package:todo_app/bloc/todo_app/todo_event.dart';
import 'package:todo_app/bloc/todo_app/todo_state.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/helper/sewa_helper/custom_cricle_avtar.dart';
import 'package:todo_app/helper/sewa_helper/expendable_text.dart';
import 'package:todo_app/view/todo_view/add_task.dart';

import '../../bloc/auth_bloc/login_bloc/login_bloc.dart';
import '../../bloc/auth_bloc/login_bloc/login_event.dart';
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
        backgroundColor: Colors.blue,
      ),
      drawer: buildAppDrawer(context: context, hiveStorage: HiveStorage(),onLogOut: (){
        context.read<LogoutBloc>().add(
          LogoutConfirmed()
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

            return ListView.separated(
              itemCount: state.tasks.length,
              separatorBuilder: (context,index) => SizedBox(height: AppSizes.paddingMD),
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                late Color bgColor;
                if(index%2 == 0){
                  bgColor = Colors.red;
                } else{
                  bgColor= Colors.blue;
                }

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingXL, vertical: AppSizes.paddingSM),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Colors.black),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingXL,
                        vertical: AppSizes.paddingSM,
                      ),
                      leading: CustomCircleAvtar.providerAvatar(providerName: task["title"], providerImage: "",bgColor: bgColor),

                      title: Text(
                        task["title"],
                        style: const TextStyle(
                          fontSize: AppSizes.fontLarge,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: AppSizes.paddingXS),
                        child: ExpandableText(text:  task["description"],maxLines: 1,),
                      ),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Edit Button
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              final id = task['id'];
                              context.go('/todoHome/addTaskEdit/$id');
                            },
                          ),

                          /// Delete Button
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              context.read<TodoBloc>().add(
                                DeleteTaskEvent(task["id"]),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
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