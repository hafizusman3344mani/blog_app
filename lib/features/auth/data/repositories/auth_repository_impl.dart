import 'dart:io';

import 'package:blog_app/core/exceptions/exceptions.dart';
import 'package:blog_app/core/exceptions/failure.dart';
import 'package:blog_app/core/network/check_connectivity.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../datasource/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final CheckConnectivity checkConnectivity;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.checkConnectivity});
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
      if (!(await checkConnectivity.isConnected)) {
        return left(Failure('No internet connected'));
      }
      final user = await fn();
      return right(user);
    }  on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
    try {
      if (!(await checkConnectivity.isConnected)) {
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure('User not logged in.'));
        } else {
          print("User session is :::::::: ${session.user.toJson()}");
          return right(UserModel(
              id: session.user.id,
              email: session.user.email ?? '',
              name: session.user.userMetadata?['name'] ?? ''));
        }
      }
      final user = await remoteDataSource.getCurrentUser();
      if (user == null) {
        return left(Failure('User not logged in.'));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> logOutUser() async {
    try {
      if (!(await checkConnectivity.isConnected)) {
        return left(Failure('No internet connected'));
      }
      final result = await remoteDataSource.logOutUser();

      return right(result);
    }  on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
