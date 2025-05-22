import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeUtils {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static bool isSystemDarkMode() {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  }
}

// Example usage
// bool isDarkMode = ThemeUtils.isDarkMode(context);
// bool isSystemDarkMode = ThemeUtils.isSystemDarkMode();