abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginUpWithEmailAndPassword({
    required String email,
    required String password,
  });
}
