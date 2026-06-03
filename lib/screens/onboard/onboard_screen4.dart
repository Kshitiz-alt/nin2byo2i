// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:nin2byo2i/Common/ThemeColor.dart';
// import 'package:nin2byo2i/Repository/auth_repo.dart';
// import 'package:nin2byo2i/constants/assets.dart';
// import 'package:nin2byo2i/Common/appfontsize.dart';
// import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
// import 'package:nin2byo2i/screens/SignIn/create_account.dart';
// import 'package:nin2byo2i/screens/SignIn/login.dart';
// import 'package:nin2byo2i/screens/SignIn/verification.dart';
// //introduction screens

// class OnboardScreen4 extends StatelessWidget {
//   static const routeName = '/onboard4';
//   const OnboardScreen4({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ThemeManager.themeColor,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // CustomPaint(
//           //   painter: PaintDesign(),
//           //   size: Size(double.infinity, MediaQuery.of(context).size.height / 2),
//           // ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.13,
//           ),
//           Center(
//             child: Image.asset(
//               Assets.onboard4,
//               // semanticsLabel: 'onboard1',
//               fit: BoxFit.cover,
//             ),
//           ),
//           // SvgPicture.asset(
//           //   Assets.onboard4,
//           //   fit: BoxFit.cover,
//           //   semanticsLabel: 'Onboard4',
//           // ),
//           Spacer(),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 30),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: 181,
//                   height: 72,
//                   child: Text(
//                     'Track your sleep',
//                     style: TextStyle(
//                       color: ThemeManager.themeText,
//                       fontSize: AppFontSizes.largeDefault,
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   width: 315,
//                   height: 63,
//                   child: Text(
//                     "Track your daily sleep and improve the quality of your sleep.",
//                     style: TextStyle(
//                       color: Color(0xFF7B6F72),
//                       fontSize: AppFontSizes.mediumDefault,
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           sizedBox30()
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: ThemeManager.themeColor,
//         // color: Colors
//         //     .transparent, // Set the bottom app bar background to be transparent
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginScreen()),
//                   );
//                 },
//                 child: Container(
//                   width: 60,
//                   height: 40,
//                   padding: EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     border: Border.all(color: ThemeManager.themeText, width: 2),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Skip',
//                       style: TextStyle(
//                         color: ThemeManager.themeText,
//                         fontSize: AppFontSizes.smallDefault,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Spacer(), // Adds space in between Skip and Next
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: InkWell(
//                 onTap: () {
//                   AuthRepo.saveNewUser();
//                   Navigator.pushNamedAndRemoveUntil(
//                       context, LoginScreen.routeName, (route) => false);
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     boxShadow: [], // You can add box shadow properties here if needed
//                   ),
//                   child: SvgPicture.asset(Assets.floatingbutton4),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //     backgroundColor: Colors.transparent,
//       //     elevation: 0,
//       //     onPressed: () {
//       //       AuthRepo.saveNewUser();
//       //       Navigator.pushNamedAndRemoveUntil(
//       //           context, LoginScreen.routeName, (route) => false);
//       //     },
//       //     child: SvgPicture.asset(Assets.floatingbutton4)),
//     );
//   }
// }

// class PaintDesign extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..shader = const LinearGradient(
//         begin: Alignment(-1.00, 0.08),
//         end: Alignment(1, -0.08),
//         colors: [Color(0xFF92A3FD), Color(0xFF9DCEFF)],
//       ).createShader(
//           Rect.fromPoints(const Offset(0, 0), Offset(0, size.height)));
//     Path path = Path();
//     path.lineTo(0, size.height - 200);
//     path.quadraticBezierTo(size.width / 3, size.height - 400,
//         size.width / 3 + 100, size.height - 200);
//     path.lineTo(size.width, 0);
//     path.close();
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     return false;
//   }
// }
