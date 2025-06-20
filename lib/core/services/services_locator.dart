import 'package:flutter_ecommerce_app/core/network/network_info.dart';
import 'package:flutter_ecommerce_app/data/data_sources/local/cart_local_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/local/category_local_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/local/delivery_info_local_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/local/order_local_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/local/product_local_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/remote/category_remote_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/remote/delivery_info_remote_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/remote/order_remote_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/remote/product_remote_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/remote/user_remote_data_source.dart';
import 'package:flutter_ecommerce_app/data/repositories/cart_repository_impl.dart';
import 'package:flutter_ecommerce_app/data/repositories/category_repository_impl.dart';
import 'package:flutter_ecommerce_app/data/repositories/delivery_info_repository_impl.dart';
import 'package:flutter_ecommerce_app/data/repositories/order_repository_impl.dart';
import 'package:flutter_ecommerce_app/data/repositories/product_repository_impl.dart';
import 'package:flutter_ecommerce_app/data/repositories/user_repository_impl.dart';
import 'package:flutter_ecommerce_app/domain/repositories/cart_repository.dart';
import 'package:flutter_ecommerce_app/domain/repositories/category_repository.dart';
import 'package:flutter_ecommerce_app/domain/repositories/delivery_info_repository.dart';
import 'package:flutter_ecommerce_app/domain/repositories/order_repository.dart';
import 'package:flutter_ecommerce_app/domain/repositories/product_repository.dart';
import 'package:flutter_ecommerce_app/domain/repositories/user_repository.dart';
import 'package:flutter_ecommerce_app/domain/usecases/cart/add_cart_item_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/cart/delete_cart_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/cart/get_local_cart_items_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/cart/get_remote_cart_items_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/category/filter_category_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/category/get_local_category_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/category/get_remote_category_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/delivery_info/add_delivery_info_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/delivery_info/delete_local_delivery_info_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/delivery_info/edit_delivery_info_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/delivery_info/get_local_delivery_info_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/delivery_info/get_remote_delivery_info_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/delivery_info/get_selected_delivery_info_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/delivery_info/selected_delivery_info_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/order/add_order_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/order/delete_local_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/order/get_local_orders_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/order/get_remote_orders_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/product/get_product_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/get_local_user_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/sign_in_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/sign_out_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/sign_up_usecase.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/cart/cart_bloc.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/category/category_bloc.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/delivery_info/delivery_info_action/delivery_info_action_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/delivery_info/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/order/order_add/order_add_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/order/order_fetch/order_fetch_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/product/product_bloc.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features --- Products
  // Bloc
  sl.registerFactory(() => ProductBloc(sl()));
  // Use Cases
  sl.registerLazySingleton(() => GetProductUsecase(sl()));
  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data Sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features --- Categories
  // Bloc
  sl.registerFactory(() => CategoryBloc(sl(), sl(), sl()));
  // Use Cases
  sl.registerLazySingleton(() => GetRemoteCategoryUsecase(sl()));
  sl.registerLazySingleton(() => GetLocalCategoryUsecase(sl()));
  sl.registerLazySingleton(() => FilterCategoryUsecase(sl()));
  // Repository
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data Sources
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features --- Cart
  // Bloc
  sl.registerFactory(() => CartBloc(sl(), sl(), sl(), sl()));
  // Use Cases
  sl.registerLazySingleton(() => GetLocalCartItemsUsecase(sl()));
  sl.registerLazySingleton(() => AddCartItemUsecase(sl()));
  sl.registerLazySingleton(() => GetRemoteCartItemsUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCartUsecase(sl()));
  // Repository
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      userLocalDataSource: sl(),
    ),
  );
  // Data Sources
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features --- Delivery Info
  // Bloc
  sl.registerFactory(() => DeliveryInfoActionCubit(sl(), sl(), sl()));
  sl.registerFactory(() => DeliveryInfoFetchCubit(sl(), sl(), sl(), sl()));
  // Use Cases
  sl.registerLazySingleton(() => GetRemoteDeliveryInfoUsecase(sl()));
  sl.registerLazySingleton(() => GetLocalDeliveryInfoUsecase(sl()));
  sl.registerLazySingleton(() => AddDeliveryInfoUsecase(sl()));
  sl.registerLazySingleton(() => EditDeliveryInfoUsecase(sl()));
  sl.registerLazySingleton(() => SelectedDeliveryInfoUsecase(sl()));
  sl.registerLazySingleton(() => GetSelectedDeliveryInfoUsecase(sl()));
  sl.registerLazySingleton(() => DeleteLocalDeliveryInfoUsecase(sl()));
  // Repository
  sl.registerLazySingleton<DeliveryInfoRepository>(
    () => DeliveryInfoRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      userLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data Sources
  sl.registerLazySingleton<DeliveryInfoRemoteDataSource>(
    () => DeliveryInfoRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<DeliveryInfoLocalDataSource>(
    () => DeliveryInfoLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features --- Order
  // Bloc
  sl.registerFactory(() => OrderAddCubit(sl()));
  sl.registerFactory(() => OrderFetchCubit(sl(), sl(), sl()));
  // Use Cases
  sl.registerLazySingleton(() => AddOrderUsecase(sl()));
  sl.registerLazySingleton(() => GetRemoteOrdersUsecase(sl()));
  sl.registerLazySingleton(() => GetLocalOrdersUsecase(sl()));
  sl.registerLazySingleton(() => DeleteLocalUsecase(sl()));
  // Repository
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      userLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data Sources
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<OrderLocalDataSource>(
    () => OrderLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features --- User
  // Bloc
  sl.registerFactory(() => UserBloc(sl(), sl(), sl(), sl()));
  // Use Cases
  sl.registerLazySingleton(() => GetLocalUserUsecase(sl()));
  sl.registerLazySingleton(() => SignInUsecase(sl()));
  sl.registerLazySingleton(() => SignUpUsecase(sl()));
  sl.registerLazySingleton(() => SignOutUsecase(sl()));
  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      localDataSource: sl(),
    ),
  );
  // Data Sources
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(secureStorage: sl(), sharedPreferences: sl()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
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
