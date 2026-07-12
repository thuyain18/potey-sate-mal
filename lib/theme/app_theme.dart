import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppConstants.primaryColor,
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      fontFamily: 'Padauk',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.surfaceColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppConstants.primaryColor),
        titleTextStyle: TextStyle(
          color: AppConstants.primaryColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'Padauk',
        ),
      ),
      // 👇 CardThemeData
      cardTheme: CardThemeData(
        color: AppConstants.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.black,
          textStyle: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Padauk'),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
