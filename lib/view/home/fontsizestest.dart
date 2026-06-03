// import 'package:flutter/material.dart';

// void main() {
//   runApp(fontsizeflutter());
// }

// class fontsizeflutter extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Text Sizes'),
//         ),
//         body: TextSizes(),
//       ),
//     );
//   }
// }

// class TextSizes extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 50,
//       itemBuilder: (context, index) {
//         // Generate different font sizes
//         final double fontSize = (index + 1) * 1.0;
//         return Container(
//           padding: EdgeInsets.all(8.0),
//           child: Text(
//             'Text with font size $fontSize',
//             style: TextStyle(fontSize: fontSize),
//           ),
//         );
//       },
//     );
//   }
// }
