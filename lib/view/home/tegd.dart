// import 'package:flutter/material.dart';
// import 'package:nin2byo2i/Common/appfontsize.dart';
// import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
// import 'package:nin2byo2i/view/home/spinanimation.dart';

// void main() {
//   runApp(Tgfdiuewkj());
// }

// class Tgfdiuewkj extends StatefulWidget {
//   @override
//   _TgfdiuewkjState createState() => _TgfdiuewkjState();
// }

// class _TgfdiuewkjState extends State<Tgfdiuewkj> {
//   final ScrollController _controllerScroll = ScrollController();
//   final GlobalKey _containerKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       _scrollToContainer4();
//     });
//   }

//   @override
//   void dispose() {
//     _controllerScroll.dispose();
//     super.dispose();
//   }

//   void _scrollToContainer4() {
//     if (_containerKey.currentContext != null) {
//       final RenderBox renderBox =
//           _containerKey.currentContext!.findRenderObject() as RenderBox;
//       final position = renderBox.localToGlobal(Offset.zero);
//       _controllerScroll.animateTo(
//         position.dy,
//         duration: Duration(milliseconds: 1500),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter Page'),
//         ),
//         body: Center(
//           child: ListView(
//             controller: _controllerScroll,
//             children: <Widget>[
//               Container(
//                 width: 200,
//                 height: 200,
//                 color: Colors.blue,
//                 child: Center(
//                   child: Text(
//                     'Container1',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: AppFontSizes.largeDefault,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Text Widget1',
//                 style: TextStyle(
//                   fontSize: AppFontSizes.largeDefault,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Container(
//                 width: 200,
//                 height: 200,
//                 color: Colors.blue,
//                 child: Center(
//                   child: Text(
//                     'Container2',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: AppFontSizes.largeDefault,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Text Widget2',
//                 style: TextStyle(
//                   fontSize: AppFontSizes.largeDefault,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Container(
//                 width: 200,
//                 height: 200,
//                 color: Colors.blue,
//                 child: Center(
//                   child: Text(
//                     'Container3',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: AppFontSizes.largeDefault,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Text Widget3',
//                 style: TextStyle(
//                   fontSize: AppFontSizes.largeDefault,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Container(
//                 width: 200,
//                 height: 200,
//                 color: Colors.blue,
//                 child: Center(
//                   child: Text(
//                     'Container3',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: AppFontSizes.largeDefault,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Text Widget3',
//                 style: TextStyle(
//                   fontSize: AppFontSizes.largeDefault,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Container(
//                 width: 200,
//                 height: 200,
//                 color: Colors.blue,
//                 child: Center(
//                   child: Text(
//                     'Container3',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: AppFontSizes.largeDefault,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Text Widget3',
//                 style: TextStyle(
//                   fontSize: AppFontSizes.largeDefault,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               // Container(
//               //   key: _containerKey,
//               //   width: 200,
//               //   height: 200,
//               //   color: Colors.blue,
//               //   child: Center(
//               //     child: Text(
//               //       'Container4',
//               //       style: TextStyle(
//               //         color: Colors.white,
//               //         fontSize: AppFontSizes.largeDefault,
//               //         fontWeight: FontWeight.bold,
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               SpinImageOnNavigate(),
//               sizedBox30(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
