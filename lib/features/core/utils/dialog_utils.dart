import 'package:flutter/material.dart';

class DialogUtils {
  static Future<bool?> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(child: Text('Cancel'), onPressed: () => Navigator.pop(context, false)),
          ElevatedButton(child: Text('OK'), onPressed: () => Navigator.pop(context, true)),
        ],
      ),
    );
  }
}

// Example usage
// bool? confirmed = await DialogUtils.showConfirmationDialog(
//   context: context,
//   title: "Confirm",
//   content: "Are you sure?",
// );
// if (confirmed == true) {
//   // proceed
// }
