import 'package:blog_app/core/exceptions/failure.dart';
import 'package:blog_app/core/usecases/use_case.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignInUseCase implements UseCase<UserEntity, UserSignInParams> {
  final AuthRepository authRepository;

  UserSignInUseCase({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(UserSignInParams params) async {
    return await authRepository.loginWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}
