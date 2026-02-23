import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/bloc/todo_event.dart';
import 'package:todo_app/constants/constants.dart';
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
    // TODO: implement initState
    super.initState();
    if (widget.taskId!=null) {
      final task = HiveStorage.getTaskById(widget.taskId);
      _titleController.text = task!['title'] ?? "";
      _desController.text = task['description'] ?? "";
    }
  }
  @override void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _desController.dispose();
  }

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
                  if (widget.taskId!=null){
                    context.read<TodoBloc>().add(
                        EditTaskEvent(widget.taskId!,title,des)
                    );
                  } else{
                    context.read<TodoBloc>().add(
                        AddTaskEvent(title, des)
                    );
                  }

                }
                ,child: Text("Add Task"))
          ],
        ),
      ),
    );
  }
}
