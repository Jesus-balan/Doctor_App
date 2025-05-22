import 'package:flutter/material.dart';
import 'package:frontend/features/presentation/ui/home/doctor_list_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    late final Widget page;

    switch (settings.name) {
      case '/':
        page = HomeScreen();
        break;
      // case '/login':
      //   page = const LoginScreen();
      //   break;
      // case '/bottombar':
      //   page = BottomNavScreen();
      //   break;
      // case '/home':
      //   page = HomeScreen();
      //   break;
      // case '/resetPass':
      //   page = ResetPasswordPage();
      //   break;
      // case '/maintenance':
      //   page = MaintenanceDetailsScreen();
      //   break;
      // case '/emergency':
      //   page = EmergencyServiceDetails();
      //   break;
      // case '/profile':
      //   page = ProfilePage();
      //   break;
      default:
        page = const Scaffold(body: Center(child: Text('Page Not Found')));
    }

    return _buildPageRoute(page);
  }

  static PageRouteBuilder _buildPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetTween = Tween<Offset>(
          begin: const Offset(0, 0.1), // Slight slide from bottom
          end: Offset.zero,
        );

        final fadeTween = Tween<double>(begin: 0.0, end: 1.0);

        return SlideTransition(
          position: offsetTween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut),
          ),
          child: FadeTransition(
            opacity: fadeTween.animate(
              CurvedAnimation(parent: animation, curve: Curves.easeIn),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
