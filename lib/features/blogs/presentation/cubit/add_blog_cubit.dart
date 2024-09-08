import 'package:blog_app/features/blogs/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blogs/domain/usecases/upload_blog_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_blog_state.dart';

class AddBlogCubit extends Cubit<AddBlogState> {
  final UploadBlogUseCase _uploadBlogUseCase;
  AddBlogCubit({required UploadBlogUseCase uploadBlogUseCase})
      : _uploadBlogUseCase = uploadBlogUseCase,
        super(AddBlogState.initial());

  void selectTop(int index) {
    if (state.topics[index].isSelected) {
      state.topics[index].isSelected = false;
      emit(state.copyWith(
          topics: state.topics, addBlogStatus: AddBlogStatus.success));
    } else {
      state.topics[index].isSelected = true;
      emit(state.copyWith(
          topics: state.topics, addBlogStatus: AddBlogStatus.success));
    }
  }

  Future<void> uploadBlog({required BlogInputModel blogInputModel}) async {
    emit(state.copyWith(addBlogStatus: AddBlogStatus.loading));
    final result = await _uploadBlogUseCase(blogInputModel);

    result.fold((left) {
      emit(state.copyWith(
        topics: state.topics,
        addBlogStatus: AddBlogStatus.error,
      ));
    }, (right) {
      state.topics.forEach(clearAll);
      emit(state.copyWith(
          topics: state.topics,
          addBlogStatus: AddBlogStatus.success,
          blogEntity: right));
    });
  }

  clearAll(BlogTopic e) {
    e.isSelected = false;
  }
}
