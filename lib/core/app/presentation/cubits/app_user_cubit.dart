import 'package:blog_app/core/usecases/use_case.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/auth/domain/usecases/log_out_user_use_case.dart';

part '../cubits/app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final CurrentUserUseCase _currentUserUseCase;
  final LogOutUserUseCase _logOutUserUseCase;
  AppUserCubit(
      {required CurrentUserUseCase currentUserUseCase,
      required LogOutUserUseCase logOutUserUseCase})
      : _currentUserUseCase = currentUserUseCase,
        _logOutUserUseCase = logOutUserUseCase,
        super(AppUserState.initial());

  Future<void> checkUser() async {
    emit(state.copyWith(userStatus: AppUserStatus.loading));
    var result = await _currentUserUseCase(NoParams());
    result.fold((left) {
      emit(state.copyWith(
          userEntity: null,
          userStatus: AppUserStatus.error,
          message: left.message));
    }, (right) {
      emit(state.copyWith(userEntity: right, userStatus: AppUserStatus.loaded));
    });
  }

  Future<void> logout() async {
    emit(state.copyWith(userStatus: AppUserStatus.loading));
    var result = await _logOutUserUseCase(NoParams());
    result.fold((left) {
      emit(state.copyWith(userStatus: AppUserStatus.loaded));
    }, (right) {
      emit(state.copyWith(userEntity: null, userStatus: AppUserStatus.loaded));
    });
  }
}
