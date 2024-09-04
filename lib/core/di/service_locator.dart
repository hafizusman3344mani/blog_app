import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/app_secrets.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  Supabase supaBase = await Supabase.initialize(
      url: AppSecrets.supaBaseUrl, anonKey: AppSecrets.supaBaseApiKey);
  sl.registerLazySingleton<SupabaseClient>(() => supaBase.client);

  /// =================== Auth Dependencies =====================
  sl.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()));

  sl.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()));

  sl.registerFactory(() => UserSignUpUseCase(authRepository: sl()));
}
