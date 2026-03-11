import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/bloc/todo_app/todo_bloc.dart';
import 'package:todo_app/bloc/todo_app/todo_event.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/constants/constants.dart';
import 'package:todo_app/helper/eleveted_button.dart';
import 'package:todo_app/helper/toast_helper.dart';
import 'package:todo_app/storage/local_storage/hive_storage.dart';




class TextInput{

  static Widget textField(TextEditingController controller, String label, String hint, ){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }

}


class AddTaskPage extends StatefulWidget {
  final String? taskId;
  const AddTaskPage({super.key,this.taskId,});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

 final TextEditingController _titleController = TextEditingController();
 final TextEditingController _desController = TextEditingController();


 @override
 void initState() {
   super.initState();
   if (widget.taskId != null) {
     _loadTask();
   }
 }

 Future<void> _loadTask() async {
   final task = await HiveStorage.getTaskById(widget.taskId!);
   print('Loaded task: $task'); // <-- Add this
   if (task != null) {
     setState(() {
       _titleController.text = task['title'] ?? "";
       _desController.text = task['description'] ?? "";
     });
   }
 }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _desController.dispose();
  }


  void clear(){
   _titleController.clear();
   _desController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Tasks"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: AppSpacing.large*3,),
            TextInput.textField(_titleController, "Title", "Enter your task title"),
            SizedBox(height: AppSpacing.medium,),
            TextInput.textField(_desController, "Des", "Define your task here"),
            SizedBox(height: AppSpacing.large,),
            ElevatedButton(
                onPressed: (){
                  final title = _titleController.text.trim();
                  final des =_desController.text.trim();
                  if (widget.taskId!=null){
                    context.read<TodoBloc>().add(
                        EditTaskEvent(widget.taskId!,title,des)
                    );
                    clear();
                    ToastHelper.show(message: "Task Add successfully");


                  } else{
                    context.read<TodoBloc>().add(
                        AddTaskEvent(title, des),
                    );
                    clear();
                    ToastHelper.show(message: "Task Add successfully");

                  }

                }
                ,child: Text("Add Task")
            ),
            SizedBox(height: AppSizes.paddingXXL,),
            customElevatedButton(text: "Back Home", onPressed: (){context.pop();})
          ],
        ),
      ),
    );
  }
}
