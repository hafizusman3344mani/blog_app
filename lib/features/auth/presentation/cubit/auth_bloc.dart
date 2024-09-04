import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/user_sign_up_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _signUpUseCase;
  AuthBloc({required UserSignUpUseCase signUpUseCase})
      : _signUpUseCase = signUpUseCase,
        super(AuthInitial()) {
    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final res = await _signUpUseCase(
        UserSignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );

      res.fold((left) => emit(AuthError(message: left.message)),
          (right) => emit(AuthSuccess(userId: right)));
    });
  }
}
