import 'package:blog_app/core/exceptions/failure.dart';
import 'package:blog_app/core/usecases/use_case.dart';
import 'package:blog_app/features/blogs/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blogs/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogsUseCase implements UseCase<List<BlogEntity>, NoParams> {
  final BlogRepository _blogRepository;

  GetAllBlogsUseCase({required BlogRepository blogRepository})
      : _blogRepository = blogRepository;
  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async {
    return await _blogRepository.getAllBlogs();
  }
}
