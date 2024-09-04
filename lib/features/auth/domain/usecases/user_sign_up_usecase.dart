import 'package:blog_app/core/exceptions/failure.dart';
import 'package:blog_app/core/usecases/use_case.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUpUseCase implements UseCase<String, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUpUseCase({required this.authRepository});
  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
