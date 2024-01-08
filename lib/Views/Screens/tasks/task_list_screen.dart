import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/auth_controller.dart';
import '../../../Controllers/task_controller.dart';
import '../../../Models/task.dart';
import '../../../Models/user.dart';
import 'assign_task_scree.dart';

class TaskListScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              authController.logout();
              Get.offAllNamed('/login'); // Navigate to login screen
            },
          ),
        ],
      ),
      body: Obx(
            () => ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            var task = taskController.tasks[index];

            // Check user role to apply permissions
            if (authController.currentUser.value != null) {
              switch (authController.currentUser.value!.role) {
                case UserRole.Admin:
                // Admin can view all tasks
                  return buildTaskTile(task);
                case UserRole.Manager:
                // Managers can view tasks assigned to their team or tasks they created
                  if (task.assignee == authController.currentUser.value!.id ||
                      task.createdBy == authController.currentUser.value!.id) {
                    return buildTaskTile(task);
                  }
                  break;
                case UserRole.User:
                // Users can view tasks assigned to them
                  if (task.assignee == authController.currentUser.value!.id) {
                    return buildTaskTile(task);
                  }
                  break;
              }
            }

            // Default: return an empty container if no permissions
            return Container();
          },
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    // Check user role to apply permissions
    print('Current User Role from task list: ${authController.currentUser.value?.role}');

    if (authController.currentUser.value != null) {
      switch (authController.currentUser.value!.role) {
        case UserRole.Admin:
        case UserRole.Manager:
        // Admins and Managers can add tasks
          return FloatingActionButton(
            onPressed: () {
              // Navigate to the screen where you can add a new task
              Get.to(() => AssignTaskScreen());
            },
            child: Icon(Icons.add),
          );
        case UserRole.User:
        // Regular Users cannot add tasks
          return Container();
      }
    }

    // Default behavior (should not reach here)
    return Container();
  }

  Widget buildTaskTile(Task task) {
    // Your task tile UI here
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Text(task.status),
      // Implement other UI and actions based on roles and permissions
    );
  }
}
