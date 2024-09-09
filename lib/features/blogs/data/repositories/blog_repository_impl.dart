import 'dart:io';

import 'package:blog_app/core/exceptions/exceptions.dart';
import 'package:blog_app/core/exceptions/failure.dart';
import 'package:blog_app/features/blogs/data/datasource/local/blog_local_data_source.dart';
import 'package:blog_app/features/blogs/data/models/blog_model.dart';
import 'package:blog_app/features/blogs/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/network/check_connectivity.dart';
import '../../domain/entities/blog_entity.dart';
import '../datasource/remote/blog_data_source.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogDataSource _blogDataSource;
  final BlogLocalDataSource _blogLocalDataSource;
  final CheckConnectivity _checkConnectivity;

  BlogRepositoryImpl(
      {required BlogDataSource blogDataSource,
      required BlogLocalDataSource blogLocalDataSource,
      required CheckConnectivity checkConnectivity})
      : _blogDataSource = blogDataSource,
        _blogLocalDataSource = blogLocalDataSource,
        _checkConnectivity = checkConnectivity;
  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!(await _checkConnectivity.isConnected)) {
        return left(Failure('No internet connected'));
      }
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
      if (!(await _checkConnectivity.isConnected)) {
        return right(_blogLocalDataSource.loadLocalBlogs());
      }
      final result = await _blogDataSource.getAllBlogs();
      _blogLocalDataSource.uploadLocalBlogs(result);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
