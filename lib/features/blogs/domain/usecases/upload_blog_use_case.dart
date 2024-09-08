import 'dart:io';

import 'package:blog_app/core/exceptions/failure.dart';
import 'package:blog_app/core/usecases/use_case.dart';
import 'package:blog_app/features/blogs/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blogs/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUseCase implements UseCase<BlogEntity, BlogInputModel> {
  final BlogRepository _blogRepository;

  UploadBlogUseCase({required BlogRepository blogRepository})
      : _blogRepository = blogRepository;
  @override
  Future<Either<Failure, BlogEntity>> call(BlogInputModel params) async {
    return await _blogRepository.uploadBlog(
        image: params.image,
        title: params.title,
        content: params.content,
        posterId: params.posterId,
        topics: params.topics);
  }
}

class BlogInputModel {
  final File image;
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;

  BlogInputModel({
    required this.image,
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
  });
}
