import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nin2byo2i/constants/assets.dart';
import 'package:nin2byo2i/custom%20widgets/button.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//success page
class SuccessRegistration extends StatelessWidget {
  static const routeName = '/successrig';
  const SuccessRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            SvgPicture.asset(Assets.successRegistration),
            const SizedBox(height: 44),
            const Text(
              'Welcome, Stefani',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1D1517),
                fontSize: AppFontSizes.mediumDefault,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(
              width: 214,
              child: Text(
                'You are all set now, let’s reach your goals together with us',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF7B6F72),
                  fontSize: AppFontSizes.smallDefault,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, RootScreen.routeName);
                  Navigator.pushNamed(context, '/root');
                },
                child: const CustomButton(
                  text: "Go To Home",
                  isColored: true,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
