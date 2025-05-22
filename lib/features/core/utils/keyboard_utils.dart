import 'package:flutter/material.dart';

class KeyboardUtils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}

// Example usage
// void main() { 
//   runApp(MyApp());
// }  
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Keyboard Utils Example')),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               KeyboardUtils.hideKeyboard(context);
//             },
//             child: Text('Hide Keyboard'),
//           ),
//         ),
//       ),
//     );
//   }
//   }
