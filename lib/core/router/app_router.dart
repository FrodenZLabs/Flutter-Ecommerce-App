import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/error/exceptions.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart/cart_item.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/product.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/user.dart';
import 'package:flutter_ecommerce_app/presentation/views/authentication/signin_view.dart';
import 'package:flutter_ecommerce_app/presentation/views/authentication/signup_view.dart';
import 'package:flutter_ecommerce_app/presentation/views/main/home/filter/filter_view.dart';
import 'package:flutter_ecommerce_app/presentation/views/main/main_view.dart';
import 'package:flutter_ecommerce_app/presentation/views/main/other/about/about_view.dart';
import 'package:flutter_ecommerce_app/presentation/views/main/other/delivery-info/delivery_info_view.dart';
import 'package:flutter_ecommerce_app/presentation/views/main/other/notification/notification_view.dart';
import 'package:flutter_ecommerce_app/presentation/views/main/other/orders/order_view.dart';
import 'package:flutter_ecommerce_app/presentation/views/main/other/profile/profile_view.dart';
import 'package:flutter_ecommerce_app/presentation/views/main/other/settings/settings_view.dart';
import 'package:flutter_ecommerce_app/presentation/views/order_checkout/order_checkout_view.dart';
import 'package:flutter_ecommerce_app/presentation/views/product/product_details_view.dart';

class AppRouter {
  static const String home = "/";
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";
  static const String productDetails = "/product-details";
  static const String userProfile = "/user-profile";
  static const String orderCheckout = "/order-checkout";
  static const String deliveryDetails = "/delivery-details";
  static const String orders = "/orders";
  static const String settings = "/settings";
  static const String notifications = "/notifications";
  static const String about = "/about";
  static const String filter = "/filter";

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const MainView());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SigninView());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignupView());
      case productDetails:
        Product product = routeSettings.arguments as Product;
        return MaterialPageRoute(builder: (_) => ProductDetailsView(product: product));
      case userProfile:
        User user = routeSettings.arguments as User;
        return MaterialPageRoute(builder: (_) => UserProfileView(user: user));
      case orderCheckout:
        List<CartItem> items = routeSettings.arguments as List<CartItem>;
        return MaterialPageRoute(builder: (_) => OrderCheckoutView(items: items));
      case deliveryDetails:
        return MaterialPageRoute(builder: (_) => const DeliveryInfoView());
      case orders:
        return MaterialPageRoute(builder: (_) => const OrderView());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationView());
      case about:
        return MaterialPageRoute(builder: (_) => const AboutView());
      case filter:
        return MaterialPageRoute(builder: (_) => const FilterView());
      default:
        throw const RouterException("Route not found");
    }
  }
}