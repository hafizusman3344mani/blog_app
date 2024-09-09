import 'dart:io';

import '../../models/blog_model.dart';

abstract interface class BlogDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage(File image, BlogModel blog);
  Future<List<BlogModel>> getAllBlogs();
}
