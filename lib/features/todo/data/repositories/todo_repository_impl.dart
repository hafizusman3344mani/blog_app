import 'package:blog_app/features/todo/data/models/todo_model.dart';
import 'package:blog_app/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  @override
  Future<List<TodoModel>> fetchAllTodos() async {
    return [];
  }
}
