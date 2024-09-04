import '../../../../core/enums/todo_status.dart';

class TodoEntity {
  final String title;
  final String description;
  final DateTime date;
  final TodoStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  TodoEntity(
      {required this.title,
      required this.description,
      required this.date,
      this.status = TodoStatus.pending,
      required this.createdAt,
      required this.updatedAt});
}
