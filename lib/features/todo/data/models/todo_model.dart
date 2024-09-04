import 'package:blog_app/features/todo/domain/entities/todo_entity.dart';

import '../../../../core/enums/todo_status.dart';

class TodoModel extends TodoEntity {
  TodoModel(
      {required super.title,
      required super.description,
      required super.date,
      super.status,
      required super.createdAt,
      required super.updatedAt});

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      status: _getStatus(json['status']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']));

  Map<String, dynamic> toJson() => {
        'tit': title,
        'description': description,
        'status': status.name,
        'date': date.toIso8601String,
        'createdAt': createdAt.toIso8601String,
        'updatedAt': updatedAt.toIso8601String,
      };

  static TodoStatus _getStatus(String currentStatus) {
    TodoStatus returnedStatus = TodoStatus.pending;
    switch (currentStatus) {
      case 'pending':
        returnedStatus = TodoStatus.pending;
        break;
      case 'inProgress':
        returnedStatus = TodoStatus.inProgress;
        break;
      case 'completed':
        returnedStatus = TodoStatus.completed;
        break;
      case 'deleted':
        returnedStatus = TodoStatus.deleted;
        break;
    }
    return returnedStatus;
  }
}
