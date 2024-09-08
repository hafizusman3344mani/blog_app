import 'dart:io';

import 'package:blog_app/core/exceptions/exceptions.dart';
import 'package:blog_app/features/blogs/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'blog_data_source.dart';

class BlogDataSourceImpl implements BlogDataSource {
  final SupabaseClient _client;

  BlogDataSourceImpl({required SupabaseClient client}) : _client = client;
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      var result = await _client.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(result.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(File image, BlogModel blog) async {
    try {
      await _client.storage.from('blog_images').upload(blog.id, image);
      return _client.storage.from('blog_images').getPublicUrl(
            blog.id,
          );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await _client.from('blogs').select('*, profiles (name)');
      return blogs.map((e) {
        return BlogModel.fromJson(e);
      }).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
