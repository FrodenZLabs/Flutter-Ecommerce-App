import 'package:flutter_ecommerce_app/core/network/network_info.dart';
import 'package:flutter_ecommerce_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/remote/user_remote_data_source.dart';
import 'package:flutter_ecommerce_app/data/repositories/user_repository_impl.dart';
import 'package:flutter_ecommerce_app/domain/repositories/user_repository.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/get_local_user_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/sign_in_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/sign_out_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/sign_up_usecase.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features --- User
  // Bloc
  sl.registerFactory(
      () => UserBloc(sl(), sl(), sl(), sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetLocalUserUsecase(sl()));
  sl.registerLazySingleton(() => SignInUsecase(sl()));
  sl.registerLazySingleton(() => SignUpUsecase(sl()));
  sl.registerLazySingleton(() => SignOutUsecase(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl())
  );

  // Data Sources
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(secureStorage: sl(), sharedPreferences: sl())
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl())
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}