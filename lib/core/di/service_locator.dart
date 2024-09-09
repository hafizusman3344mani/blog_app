import 'package:blog_app/core/network/check_connectivity.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user_use_case.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up_usecase.dart';
import 'package:blog_app/features/blogs/data/datasource/local/blog_local_data_source.dart';
import 'package:blog_app/features/blogs/data/datasource/local/blog_local_data_source_impl.dart';
import 'package:blog_app/features/blogs/data/datasource/remote/blog_data_source_impl.dart';
import 'package:blog_app/features/blogs/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blogs/domain/usecases/get_all_blogs_use_case.dart';
import 'package:blog_app/features/blogs/domain/usecases/upload_blog_use_case.dart';
import 'package:blog_app/features/blogs/presentation/cubit/add_blog_cubit.dart';
import 'package:blog_app/features/blogs/presentation/cubit/all_blogs_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/domain/usecases/log_out_user_use_case.dart';
import '../../features/auth/domain/usecases/user_sign_in_use_case.dart';
import '../../features/auth/presentation/cubit/auth_bloc.dart';
import '../../features/blogs/data/datasource/remote/blog_data_source.dart';
import '../../features/blogs/domain/repositories/blog_repository.dart';
import '../app/presentation/cubits/app_user_cubit.dart';
import '../constants/app_secrets.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  Supabase supaBase = await Supabase.initialize(
      url: AppSecrets.supaBaseUrl, anonKey: AppSecrets.supaBaseApiKey);
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  /// =================== Common =====================

  sl.registerLazySingleton<SupabaseClient>(() => supaBase.client);
  sl.registerLazySingleton(() => Hive.box(name: 'blogs'));
  sl.registerFactory(() => Connectivity());
  sl.registerFactory<CheckConnectivity>(
      () => CheckConnectivityImpl(connectivity: sl()));

  /// =================== App User Dependencies =====================

  sl
    ..registerFactory(() => CurrentUserUseCase(authRepository: sl()))
    ..registerFactory(() => LogOutUserUseCase(authRepository: sl()))
    ..registerLazySingleton(
        () => AppUserCubit(currentUserUseCase: sl(), logOutUserUseCase: sl()));

  /// =================== Auth Dependencies =====================

  sl
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(client: sl()))
    ..registerFactory<AuthRepository>(() =>
        AuthRepositoryImpl(remoteDataSource: sl(), checkConnectivity: sl()))
    ..registerFactory(() => UserSignUpUseCase(authRepository: sl()))
    ..registerFactory(() => UserSignInUseCase(authRepository: sl()))
    ..registerLazySingleton(() => AuthBloc(
          signUpUseCase: sl(),
          signInUseCase: sl(),
        ));

  /// ================ Blog Dependencies ==================

  sl
    ..registerFactory<BlogDataSource>(() => BlogDataSourceImpl(client: sl()))
    ..registerFactory<BlogLocalDataSource>(
        () => BlogLocalDataSourceImpl(box: sl()))
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
        blogDataSource: sl(),
        blogLocalDataSource: sl(),
        checkConnectivity: sl()))
    ..registerFactory(() => UploadBlogUseCase(blogRepository: sl()))
    ..registerFactory(() => GetAllBlogsUseCase(blogRepository: sl()))
    ..registerLazySingleton(() => AddBlogCubit(uploadBlogUseCase: sl()))
    ..registerLazySingleton(() => AllBlogsCubit(getAllBlogsUseCase: sl()));
}
