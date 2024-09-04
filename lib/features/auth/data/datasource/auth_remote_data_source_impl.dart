import 'package:blog_app/core/exceptions/exceptions.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _client;

  AuthRemoteDataSourceImpl({required SupabaseClient client}) : _client = client;
  @override
  Future<String> loginUpWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement loginUpWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      AuthResponse authResponse = await _client.auth
          .signUp(password: password, email: email, data: {'name': name});
      if (authResponse.user == null) {
        throw ServerException(message: 'User not found');
      }
      return authResponse.user!.id;
    } on AuthException catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: e.statusCode,
        errorCode: e.code,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
