import 'dart:io';

import 'package:blog_app/core/exceptions/exceptions.dart';
import 'package:blog_app/core/exceptions/failure.dart';
import 'package:blog_app/features/blogs/data/datasource/blog_data_source.dart';
import 'package:blog_app/features/blogs/data/models/blog_model.dart';
import 'package:blog_app/features/blogs/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/blog_entity.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogDataSource _blogDataSource;

  BlogRepositoryImpl({required BlogDataSource blogDataSource})
      : _blogDataSource = blogDataSource;
  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: '',
          posterName: '',
          topics: topics,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());
      String imageUrl = await _blogDataSource.uploadBlogImage(image, blogModel);
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final result = await _blogDataSource.uploadBlog(blogModel);

      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      final result = await _blogDataSource.getAllBlogs();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
