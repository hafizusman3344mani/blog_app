import 'package:blog_app/features/blogs/data/datasource/local/blog_local_data_source.dart';
import 'package:blog_app/features/blogs/data/models/blog_model.dart';
import 'package:hive/hive.dart';

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box _box;

  BlogLocalDataSourceImpl({required Box box}) : _box = box;
  @override
  List<BlogModel> loadLocalBlogs() {
    List<BlogModel> blogs = [];
    _box.read(() {
      for (int i = 0; i < _box.length; i++) {
        blogs.add(BlogModel.fromJson(_box.get(i.toString())));
      }
    });
    return blogs;
  }

  @override
  void uploadLocalBlogs(List<BlogModel> blogs) {
    _box.clear();

    _box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        _box.put(i.toString(), blogs[i].toJson());
      }
    });
  }
}
