import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecommerce_app/core/constant/strings.dart';
import 'package:flutter_ecommerce_app/core/router/app_router.dart';
import 'package:flutter_ecommerce_app/core/theme/app-theme.dart';
import 'package:flutter_ecommerce_app/domain/usecases/product/get_product_usecase.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/cart/cart_bloc.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/category/category_bloc.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/filter/filter_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/home/navbar_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/product/product_bloc.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/user/user_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import 'core/services/services_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NavbarCubit()),
          BlocProvider(create: (context) => FilterCubit()),
          BlocProvider(create: (context) => di.sl<UserBloc>()..add(CheckUser())),
          BlocProvider(create: (context) => di.sl<ProductBloc>()..add(const GetProducts(FilterProductParams()))),
          BlocProvider(create: (context) => di.sl<CategoryBloc>()..add(const GetCategories())),
          BlocProvider(create: (context) => di.sl<CartBloc>()..add(const GetCart())),

        ],
        child: OKToast(
            child: Sizer(
                builder: (context, orientation, deviceType) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    initialRoute: AppRouter.home,
                    onGenerateRoute: AppRouter.onGenerateRoute,
                    title: appTitle,
                    theme: AppTheme.lightTheme,
                    builder: EasyLoading.init(),
                  );
                }
            )
        )
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = true;
}


