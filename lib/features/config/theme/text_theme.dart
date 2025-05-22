import 'package:flutter/material.dart';

class AppTextThemes {
  static TextTheme lightTextTheme = const TextTheme(
    headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14),
  );

  static TextTheme darkTextTheme = const TextTheme(
    headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
  );
}
