import 'package:blog_app/core/exceptions/failure.dart';
import 'package:blog_app/core/usecases/use_case.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LogOutUserUseCase implements UseCase<bool, NoParams> {
  final AuthRepository _authRepository;

  LogOutUserUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await _authRepository.logOutUser();
  }
}
