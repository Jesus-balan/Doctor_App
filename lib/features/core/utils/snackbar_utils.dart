import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
// Example usage

// SnackbarUtils.showSuccess(context, "Profile updated!");
// SnackbarUtils.showError(context, "Something went wrong");