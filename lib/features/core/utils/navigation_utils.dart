import 'package:flutter/material.dart';

class NavigationUtils {
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }

  static pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  static pushAndRemoveUntil(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => page), (route) => false);
  }
}
// Example usage
// NavigationUtils.push(context, HomePage());
// NavigationUtils.pop(context);
// NavigationUtils.pushReplacement(context, LoginPage());
// NavigationUtils.pushAndRemoveUntil(context, HomePage());

