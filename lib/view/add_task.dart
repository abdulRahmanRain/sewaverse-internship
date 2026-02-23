import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/bloc/todo_event.dart';
import 'package:todo_app/constants/constants.dart';




class TextInput{

  static textField(TextEditingController controller, String label, String hint, ){
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
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _desController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Tasks"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: AppSpacing.Large*3,),
            TextInput.textField(_titleController, "Title", "Enter your task title"),
            SizedBox(height: AppSpacing.medium,),
            TextInput.textField(_desController, "Des", "Define your task here"),
            SizedBox(height: AppSpacing.Large,),
            ElevatedButton(
                onPressed: (){
                  final title = _titleController.text.trim();
                  final des =_desController.text.trim();
                  context.read<TodoBloc>().add(
                    AddTaskEvent(title, des)
                  );
                  _titleController.clear();
                  _desController.clear();
                }
                ,child: Text("Add Task"))
          ],
        ),
      ),
    );
  }
}
