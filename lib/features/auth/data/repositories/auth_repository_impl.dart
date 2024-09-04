import 'package:blog_app/core/exceptions/exceptions.dart';
import 'package:blog_app/core/exceptions/failure.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../datasource/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, UserEntity>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(() => remoteDataSource.loginUpWithEmailAndPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(() => remoteDataSource.signUpWithEmailAndPassword(
        name: name, email: email, password: password));
  }

  Future<Either<Failure, UserEntity>> _getUser(
      Future<UserEntity> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
