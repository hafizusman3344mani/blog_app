import 'package:blog_app/core/exceptions/failure.dart';
import 'package:blog_app/core/usecases/use_case.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUserUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository _authRepository;

  CurrentUserUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await _authRepository.currentUser();
  }
}
