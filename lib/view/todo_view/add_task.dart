import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/bloc/todo_app/todo_bloc.dart';
import 'package:todo_app/bloc/todo_app/todo_event.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/helper/eleveted_button.dart';
import 'package:todo_app/helper/fcm_helper.dart';
import 'package:todo_app/helper/text_field_helper.dart';
import 'package:todo_app/helper/toast_helper.dart';
import 'package:todo_app/storage/local_storage/hive_storage.dart';

import '../../constants/constants.dart';

class AddTaskPage extends StatefulWidget {
  final String? taskId;
  const AddTaskPage({super.key, this.taskId});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.taskId != null) {
      _loadTask();
    }
  }

  Future<void> _loadTask() async {
    final task = await HiveStorage.getTaskById(widget.taskId!);
    if (task != null) {
      setState(() {
        _titleController.text = task['title'] ?? "";
        _desController.text = task['description'] ?? "";
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _desController.dispose();
    super.dispose();
  }

  void clear() {
    _titleController.clear();
    _desController.clear();
  }

  void _submitTask() async{

    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final des = _desController.text.trim();

      if (widget.taskId != null) {
        // Edit existing task
        context.read<TodoBloc>().add(EditTaskEvent(widget.taskId!, title, des));
        ToastHelper.show(message: "Task updated successfully");
        await FCMHelper.showNotification("Task updated successfully", title);

        print("CALLING TOKEN..."); // debug

        String? token = await FCMHelper.getToken();

        print("TOKEN RESULT: $token");
        await Future.delayed(Duration(seconds: 1)); // MU
      } else {
        // Add new task
        context.read<TodoBloc>().add(AddTaskEvent(title, des));
        ToastHelper.show(message: "Task added successfully");
        print("CALLING TOKEN..."); // debug

        String? token = await FCMHelper.getToken();

        print("TOKEN RESULT: $token");
        await Future.delayed(Duration(seconds: 1)); //
        await FCMHelper.showNotification("Task added successfully", title);

      }

      clear();
      context.pop();
    } else {
      ToastHelper.show(message: "Please fill all fields correctly", bgColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.taskId != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Task" : "Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // attach form key
          child: Column(
            children: [
              SizedBox(height: AppSpacing.large * 3),
              TextInput.textField(
                controller: _titleController,
                label: "Title",
                hint: "Enter your task title",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Title cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSpacing.medium),
              TextInput.textField(
                controller: _desController,
                label: "Description",
                hint: "Define your task here",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Description cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSpacing.large),
              ElevatedButton(
                onPressed: _submitTask,
                child: Text(isEditing ? "Update Task" : "Add Task"),
              ),
              SizedBox(height: AppSizes.paddingXXL),
              customElevatedButton(
                text: "Back Home",
                onPressed: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}