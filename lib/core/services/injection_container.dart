import 'package:bloc_tdd_clean_arch/features/authentication/data/datasource/remote/auth_data_source.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/repositories/auth_repo.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/usecase/create_user.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/domain/usecase/get_users.dart';
import 'package:bloc_tdd_clean_arch/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    //App Logic
    ..registerFactory(() => AuthCubit(createUser: sl(), getUsers: sl()))
    //Use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))
    //Repositories
    ..registerLazySingleton<AuthenticationRepo>(() => AuthRepoImpl(sl()))
    //DataSource
    ..registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(sl()))
    //External dependency
    ..registerLazySingleton(Client.new);
}
