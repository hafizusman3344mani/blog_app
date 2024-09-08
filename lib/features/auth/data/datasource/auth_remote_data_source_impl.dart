import 'package:blog_app/core/exceptions/exceptions.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _client;

  AuthRemoteDataSourceImpl({required SupabaseClient client}) : _client = client;

  //TODO: Working on internet connectivity
  @override
  Session? get currentUserSession => _client.auth.currentSession;

  @override
  Future<UserModel> loginUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      AuthResponse authResponse = await _client.auth
          .signInWithPassword(password: password, email: email);
      if (authResponse.user == null) {
        throw ServerException(message: 'User not found');
      }
      return UserModel.fromJson(authResponse.user!.toJson());
    } catch (e) {
      print('Exception type is ${e.runtimeType}');
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      AuthResponse authResponse = await _client.auth
          .signUp(password: password, email: email, data: {'name': name});
      if (authResponse.user == null) {
        throw ServerException(message: 'User not found');
      }
      return UserModel.fromJson(authResponse.user!.toJson());
    } catch (e) {
      print('Exception type is ${e.runtimeType}');
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (currentUserSession != null) {
        var userData = await _client
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
        );
      }
      return null;
    } catch (e) {
      print('Exception type is ${e.runtimeType}');
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> logOutUser() async {
    try {
      await _client.auth.signOut();
      return true;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
