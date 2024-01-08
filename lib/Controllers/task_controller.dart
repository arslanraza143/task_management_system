// controllers/task_controller.dart

import 'package:get/get.dart';


import '../Models/task.dart';
import 'auth_controller.dart';

class TaskController extends GetxController {
  RxList<Task> tasks = <Task>[].obs;
  final AuthController authController = Get.find();

  void addTask(Task task) {
    tasks.add(task);
  }

  void updateTask(Task updatedTask) {
    int index = tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      tasks[index] = updatedTask;
    }
  }

  void deleteTask(String taskId) {
    tasks.removeWhere((task) => task.id == taskId);
  }

  void assignTask(String title, String description, String assigneeId) {
    // Create a new task
    Task task = Task(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      assignee: assigneeId, // Assignee ID from the input field
      createdBy: authController.currentUser.value!.id, // Admin ID as the creator
      status: 'To Do', // Set the default status
    );

    // Add the task to the list
    tasks.add(task);

    // Notify listeners
    update();
  }
}
