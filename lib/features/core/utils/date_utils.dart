import 'package:intl/intl.dart';

class DateUtilsHelper {
  static String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('dd-MM-yyyy hh:mm a').format(date);
  }

  static String getToday() {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }
}



// Example usage
final now = DateTime.now();
final formattedDate = DateUtilsHelper.formatDate(now);
final formattedDateTime = DateUtilsHelper.formatDateTime(now);  
  