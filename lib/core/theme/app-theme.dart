import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/constant/colors.dart';

class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: kLightPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: kBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: kLightPrimaryColor,
      foregroundColor: kBackgroundColor,
    ),
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: kLightSecondaryColor),),
    colorScheme: ColorScheme.light(secondary: kLightSecondaryColor).copyWith(surface: kLightBackgroundColor)
  );
}