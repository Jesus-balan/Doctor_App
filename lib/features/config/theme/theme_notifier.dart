import 'package:flutter/material.dart';
import 'app_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  bool isDark = false;

  ThemeData get currentTheme => isDark ? AppTheme.darkTheme : AppTheme.lightTheme;

  void toggleTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}


// Example usage in a widget
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ThemeNotifier(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
  
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeNotifier>(context);

//     return return MaterialApp(
//   theme: AppTheme.lightTheme,
//   darkTheme: AppTheme.darkTheme,
//   themeMode: ThemeMode.system,
// );
//   }
// }
