import 'package:blog_app/core/usecases/use_case.dart';
import 'package:blog_app/features/blogs/domain/usecases/get_all_blogs_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/blog_entity.dart';

part 'all_blogs_state.dart';

class AllBlogsCubit extends Cubit<AllBlogsState> {
  final GetAllBlogsUseCase _allBlogsUseCase;
  AllBlogsCubit({required GetAllBlogsUseCase getAllBlogsUseCase})
      : _allBlogsUseCase = getAllBlogsUseCase,
        super(AllBlogsState.initial());

  Future<void> getAllBlogs() async {
    emit(state.copyWith(
      status: AllBlogsStatus.loading,
    ));
    final result = await _allBlogsUseCase(NoParams());

    result.fold(
      (left) => emit(
          state.copyWith(status: AllBlogsStatus.error, message: left.message)),
      (right) => emit(
        state.copyWith(
          status: AllBlogsStatus.success,
          blogs: right,
        ),
      ),
    );
  }
}
