import 'package:blog_app/features/todo/domain/entities/todo_entity.dart';

abstract interface class TodoRepository {
  Future<List<TodoEntity>> fetchAllTodos();
}
