import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: const Color(0xFF2B2E4A),
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: const Color(0xFFF4F4F4),
    splashColor: const Color(0xFFE84545),
    fontFamily: 'Optima',
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: const Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 36.sm,
      ),
      headline2: TextStyle(
        color: const Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 24.sm,
      ),
      headline3: TextStyle(
        color: const Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 18.sm,
      ),
      headline4: TextStyle(
        color: const Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 16.sm,
      ),
      headline5: TextStyle(
        color: const Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 14.sm,
      ),
      headline6: TextStyle(
        color: const Color(0xFF2B2E4A),
        fontWeight: FontWeight.normal,
        fontSize: 14.sm,
      ),
      bodyText1: TextStyle(
        color: const Color(0xFF2B2E4A),
        fontWeight: FontWeight.normal,
        fontSize: 12.sm,
      ),
      bodyText2: TextStyle(
        color: const Color(0xFF2B2E4A),
        fontWeight: FontWeight.normal,
        fontSize: 10.sm,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xFFE84545),
    ),
  );
}
