// models/task.dart

class Task {
  late String id;
  late String title;
  late String description;
  late String assignee; // User ID of the assignee
  late String createdBy; // User ID of the creator
  late String status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.assignee,
    required this.createdBy,
    required this.status,
  });
}
