// screens/task/assign_task_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/auth_controller.dart';
import '../../../Controllers/task_controller.dart';

class AssignTaskScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TaskController taskController = Get.put(TaskController());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController assigneeController = TextEditingController();

  AssignTaskScreen({Key? key}) : super(key: key); // Add controller for assignee

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Task Description'),
            ),
            TextField(
              controller: assigneeController,
              decoration: InputDecoration(labelText: 'Assignee ID'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Call a method in your TaskController to assign the task
                taskController.assignTask(
                  titleController.text.trim(),
                  descriptionController.text.trim(),
                  assigneeController.text.trim(),
                );

                // Close the screen and go back to the previous screen
                Get.back();
              },
              child: Text('Assign Task'),
            ),
          ],
        ),
      ),
    );
  }
}
