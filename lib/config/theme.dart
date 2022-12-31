import 'package:datingo/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: ColorManager.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorManager.secondary,
    ),

    backgroundColor: ColorManager.primaryColor,
    splashColor: ColorManager.secondary,
    fontFamily: 'Optima',

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    ),

    // Text Theme
    textTheme: TextTheme(
      headline1: TextStyle(
        color: ColorManager.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 36.sm,
      ),
      headline2: TextStyle(
        color: ColorManager.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 24.sm,
      ),
      headline3: TextStyle(
        color: ColorManager.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 18.sm,
      ),
      headline4: TextStyle(
        color: ColorManager.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 16.sm,
      ),
      headline5: TextStyle(
        color: ColorManager.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 14.sm,
      ),
      headline6: TextStyle(
        color: ColorManager.primaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 14.sm,
      ),
      bodyText1: TextStyle(
        color: ColorManager.primaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 12.sm,
      ),
      bodyText2: TextStyle(
        color: ColorManager.primaryColor,
        fontWeight: FontWeight.normal,
        fontSize: 10.sm,
      ),
    ),

    // Circular Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ColorManager.primaryColor,
      linearTrackColor: ColorManager.secondary,
    ),
  );
}
