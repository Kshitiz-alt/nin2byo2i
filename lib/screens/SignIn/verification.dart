import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Providers/auth_provider.dart';
import 'package:nin2byo2i/constants/assets.dart';
import 'package:nin2byo2i/custom%20widgets/button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/screens/SignIn/complete_profile.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:provider/provider.dart';

//Email verification page
class VerificationScreen extends StatefulWidget {
  static const routeName = '/verification';
  const VerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool status = false;
  final UserProfileController _controller = UserProfileController();
  bool isButtonDisabled = false;
  int timerSeconds = 30;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    // Start the timer immediately when the page is loaded
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (timerSeconds > 0) {
            timerSeconds--;
          } else {
            // Enable the button when the timer reaches 0
            isButtonDisabled = false;
            _timer.cancel(); // Stop the timer when it reaches 0
          }
        });
      } else {
        // If the widget is disposed, cancel the timer
        _timer.cancel();
      }
    });
  }

  Future<void> resendMail() async {
    // Add your logic for resending the mail here
    // For example, you can call an API to send the email
    // Simulating the API call with a debugPrint statement
    debugPrint("Resending mail...");
// debugPrint('jfksedfgsfgr ${widget.email}');
    final data = await _controller.ResenDEmail(widget.email);
    // if (data) {
    //   status = true;
    // }
    if (mounted) {
      setState(() {
        status = data;
      });
    }
    // Disable the button
    setState(() {
      isButtonDisabled = true;
      // Reset the timer to 30 seconds when the button is clicked
      timerSeconds = 30;
    });

    // Start the timer again
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.themeColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            SvgPicture.asset(
              Assets.verification,
              color: ThemeManager.themeText,
            ),
            const SizedBox(
              height: 42,
            ),
            Text(
              'We have just send email verification link on\nyour email ${widget.email}. Please check email \nand click on that link to verify your Email address.\n\nIf not auto redirected after verification, click\non the Continue button.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeManager.themeText,
                fontSize: AppFontSizes.smallDefault,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 41,
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: AppFontSizes.mediumDefault,
                  ),
                  children: [
                    TextSpan(
                      text: 'Please wait ',
                    ),
                    TextSpan(
                      text: 'after clicking on the register button ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text: 'to validate mobile and send OTP.',
                    ),
                    TextSpan(
                      text:
                          ' Please verfy email (check mail box) and then click on Continue Button',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            sizedBox12(),
            InkWell(
              onTap: () async {
                await Provider.of<AuthProviderNin>(context, listen: false)
                    .login();
                Navigator.pushNamedAndRemoveUntil(
                    context, CompleteProfile.routeName, (route) => false);
                // Navigator.pushReplacementNamed(context, OtpScreen.routeName);
                // Navigator.pushNamed(context, SuccessRegistration.routeName);
              },
              child: const CustomButton(
                text: 'Continue',
                isColored: true,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            // GestureDetector(
            //   onTap: () async {
            //     // debugPrint('jfksedfgsfgr ${widget.email}');
            //     final data = await _controller.ResenDEmail('${widget.email}');
            //     // if (data) {
            //     //   status = true;
            //     // }
            //     if (mounted) {
            //       setState(() {
            //         status = data;
            //       });
            //     }
            //   },
            //   child: const Text(
            //     'Resend',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       color: Color(0xFFC58BF2),
            //       fontSize: AppFontSizes .mediumDefault,
            //       fontFamily: 'Poppins',
            //       fontWeight: FontWeight.w500,
            //       decoration: TextDecoration.underline,
            //     ),
            //   ),
            // ),
            Text(
              'Timer: $timerSeconds seconds',
              style: TextStyle(
                  fontSize: AppFontSizes.mediumDefault,
                  color: ThemeManager.themeText),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: isButtonDisabled ? null : resendMail,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // You can adjust the value as needed
                  ), backgroundColor: TColor.primaryColor1, // Set the background color
                ),
                child: const Text('Resend')),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the timer when the page is disposed
    _timer.cancel();
    super.dispose();
  }
}
