// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:nin2byo2i/Common/ThemeColor.dart';
// import 'package:nin2byo2i/Common/colo_extension.dart';
// import 'package:nin2byo2i/Common/appfontsize.dart';

// class DisplayDataPage extends StatelessWidget {
//   final Map<String, dynamic> responseData;

//   // Constructor to receive the response data
//   DisplayDataPage({required this.responseData});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ThemeManager.themeColor,
//         centerTitle: true,
//         elevation: 0,
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//             Navigator.pop(context);
//           },
//           child: Container(
//             margin: const EdgeInsets.all(8),
//             height: 40,
//             width: 40,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//                 color: ThemeManager.themelightColor,
//                 borderRadius: BorderRadius.circular(10)),
//             child: Image.asset(
//               "assets/img/black_btn.png", // Replace with your health app logo asset path
//               width: 15,
//               height: 15,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//         title: Text(
//           "Display Watch Data ",
//           style: TextStyle(
//               color: Colors.black,
//               fontSize: AppFontSizes.mediumDefault,
//               fontWeight: FontWeight.w700),
//         ),
//       ),
//       backgroundColor: ThemeManager.themeColor,
//       body: WillPopScope(
//         onWillPop: () async {
//           // Your custom logic here, return true if you allow the back button press, or false to prevent it.
//           debugPrint('Back button pressed');
//           Navigator.pop(context);
//           Navigator.pop(context);
//           return true; // Set to false to prevent back navigation
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 'Response Data:',
//                 style: TextStyle(
//                   fontSize: AppFontSizes.mediumDefault,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 10),
//               // Display the response data in a formatted way
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: SingleChildScrollView(
//                     child: Text(
//                       _formatJson(responseData),
//                       style: TextStyle(
//                         fontSize: AppFontSizes.mediumDefault,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper method to format JSON data for better readability
//   String _formatJson(Map<String, dynamic> jsonData) {
//     const JsonEncoder encoder = JsonEncoder.withIndent('  ');
//     return encoder.convert(jsonData);
//   }
// }
