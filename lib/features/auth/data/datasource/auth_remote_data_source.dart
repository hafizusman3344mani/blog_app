import 'package:blog_app/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginUpWithEmailAndPassword({
    required String email,
    required String password,
  });
}
