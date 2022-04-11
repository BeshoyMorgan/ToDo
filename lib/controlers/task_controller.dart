import 'package:get/get.dart';

import '../model/task.dart';
import '../db/da_helper.dart';

class TaskController extends GetxController {
  final taskList = <Task>[].obs;
  //insert
  Future<int> addTask({Task? task}) {
    return DBHelper().insert(task!);
  }

  //show tasks from DB
  Future<void> getTasks() async {
    final tasks = await DBHelper().query();
    taskList.assignAll(tasks.map((item) => Task.fromJson(item)).toList());
  }

  // deete task from DB
  deleteTask(Task task) async {
    await DBHelper().delete(task);
    getTasks();
  }

  // deete a tasks
  deleteAllTask() async {
    await DBHelper().deleteAll();
    getTasks();
  }

//update task
  makeTaskComplete(int id) async {
    await DBHelper().update(id);
    getTasks();
  }
}
