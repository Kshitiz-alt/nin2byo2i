import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/constants/assets.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/screens/SignIn/login.dart';
import 'package:nin2byo2i/screens/onboard/onboard_screen3.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
//introduction screens

class OnboardScreen2 extends StatelessWidget {
  static const routeName = '/onboard2';
  const OnboardScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.themeColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomPaint(
          //   painter: PaintDesign(),
          //   size: Size(double.infinity, MediaQuery.of(context).size.height / 2),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.13,
          ),
          Center(
            child: Image.asset(
              Assets.onboard2,
              // semanticsLabel: 'onboard1',
              fit: BoxFit.cover,
            ),
          ),
          // SvgPicture.asset(
          //   Assets.onboard2,
          //   fit: BoxFit.cover,
          // ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Calories Burnt',
                  style: TextStyle(
                    color: ThemeManager.themeText,
                    fontSize: AppFontSizes.largeDefault,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 0.06,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  width: 315,
                  height: 63,
                  child: Text(
                    "You can track calories burnt based on your physical activity",
                    style: TextStyle(
                      color: Color(0xFF7B6F72),
                      fontSize: AppFontSizes.mediumDefault,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          sizedBox30()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: ThemeManager.themeColor,
        // color: Colors
        //     .transparent, // Set the bottom app bar background to be transparent
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: Container(
                  width: 95,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: ThemeManager.themeText,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: ThemeManager.themeText,
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(), // Adds space in between Skip and Next
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, OnboardScreen3.routeName);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [], // You can add box shadow properties here if needed
                  ),
                  child: SvgPicture.asset(Assets.floatingbutton2),
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: Colors.transparent,
      //     elevation: 0,
      //     onPressed: () {
      //       Navigator.pushNamed(context, OnboardScreen3.routeName);
      //     },
      //     child: SvgPicture.asset(Assets.floatingbutton2)),
    );
  }
}

class PaintDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        begin: const Alignment(-1.00, 0.08),
        end: const Alignment(1, -0.08),
        colors: [TColor.primaryColor1, TColor.primaryColor2],
      ).createShader(
          Rect.fromPoints(const Offset(0, 0), Offset(0, size.height)));
    Path path = Path();
    path.lineTo(0, size.height - 200);
    path.quadraticBezierTo(size.width / 3, size.height - 400,
        size.width / 3 + 100, size.height - 200);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
