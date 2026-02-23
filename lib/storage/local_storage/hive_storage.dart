import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class HiveStorage {
  static final box = Hive.box('myBox');
  static final uuid = Uuid();

  // ADD TASK
  static Future<void> addTask(String title, String description) async {
    final id = uuid.v4();

    final task = {
      "id": id,
      "title": title,
      "description": description,
    };

    await box.put(id, task);
  }

  // DELETE TASK
  static Future<void> deleteTask(String id) async {
    await box.delete(id);
  }

  // UPDATE TASK
  static Future<void> updateTask(
      String id, String newTitle, String newDescription) async {
    final updatedTask = {
      "id": id,
      "title": newTitle,
      "description": newDescription,
    };

    await box.put(id, updatedTask);
  }

  // GET ALL TASKS
  static List<Map<String, dynamic>> getTasks() {
    return box.values
        .map((e) => Map<String, dynamic>.from(e)) ///{id: 11,ti:de}
        .toList();
  }

  // EDIT TASK
  static Map<String,dynamic>? getTaskById(String? id){

    final tasks = box.get(id);

    try{
      if(tasks != null) {
        return Map<String,dynamic>.from(tasks);
      }
    }catch (e){
      debugPrint("Error: $e");
    }


    return {};
  }
}