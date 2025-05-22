class ValidationUtils {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter email';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'Enter valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter password';
    if (value.length < 6) return 'Minimum 6 characters required';
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Enter phone number';
    if (value.length != 10) return 'Phone must be 10 digits';
    return null;
  }

  static String? validateRequired(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) return '$fieldName is required';
    return null;
  }
}
  
// Example usage
// TextFormField(
//   validator: ValidationUtils.validateEmail,
// ),

