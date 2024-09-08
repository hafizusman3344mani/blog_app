import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/user_sign_in_use_case.dart';
import '../../domain/usecases/user_sign_up_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _signUpUseCase;
  final UserSignInUseCase _signInUseCase;

  AuthBloc({
    required UserSignUpUseCase signUpUseCase,
    required UserSignInUseCase signInUseCase,
  })  : _signUpUseCase = signUpUseCase,
        _signInUseCase = signInUseCase,
        super(AuthInitial()) {
    on<AuthSignUpEvent>(_signUp);

    on<AuthSignInEvent>(_signIn);
  }

  void _signUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _signUpUseCase(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    res.fold((left) => emit(AuthError(message: left.message)),
        (right) => _emitAuthSuccess(right, emit));
  }

  void _signIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _signInUseCase(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold((left) => emit(AuthError(message: left.message)),
        (right) => _emitAuthSuccess(right, emit));
  }

  void _emitAuthSuccess(UserEntity user, Emitter<AuthState> emit) {
    emit(AuthSuccess(user: user));
  }
}
