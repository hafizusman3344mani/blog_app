import '../../models/blog_model.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs(List<BlogModel> blogs);
  List<BlogModel> loadLocalBlogs();
}
