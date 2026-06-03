import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Providers/auth_provider.dart';
import 'package:nin2byo2i/Providers/timer_provider.dart';
import 'package:nin2byo2i/common_widget/SuccessAlertBox.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/constants/assets.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/screens/SignIn/complete_profile.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//otp page
class OtpScreen extends StatefulWidget {
  static const routeName = '/otp';
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late String otp;

  @override
  void initState() {
    Provider.of<TimerProvider>(context, listen: false).startTimer();
    super.initState();
  }

  int _timerSeconds = 30;
  bool _isTimerActive = false;

  Future<void> _startTimer() async {
    final authProvider = Provider.of<AuthProviderNin>(context, listen: false);
    // debugPrint("dkgndkgdfnjbfdknb  ${authProvider.phoneNumber}");
    await authProvider.verifyPhoneNumber(authProvider.phoneNumber);
    setState(() {
      _timerSeconds = 30;
      _isTimerActive = true;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          _isTimerActive = false;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.themeColor,
      body: SafeArea(child: SingleChildScrollView(
        child: Consumer<AuthProviderNin>(builder: (context, authProvider, _) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'OTP Verification',
                        style: TextStyle(
                          color: ThemeManager.themeText,
                          fontSize: AppFontSizes.mediumDefault,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Image.asset(Assets.otp),
                    sizedBox30(),
                    Text(
                      'Enter OTP',
                      style: TextStyle(
                        color: ThemeManager.themeText,
                        fontSize: AppFontSizes.mediumDefault,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 246,
                      child: Text(
                        'An 6 digit code has been sent to your mobile number',
                        style: TextStyle(
                          color: ThemeManager.themeText,
                          fontSize: AppFontSizes.smallDefault,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    sizedBox12(),
                    OTPTextField(
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 45,
                      style: TextStyle(
                          fontSize: AppFontSizes.mediumDefault,
                          color: ThemeManager.themeText),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      onCompleted: (pin) {
                        debugPrint("Completed: $pin");
                      },
                      onChanged: (value) {
                        otp = value;
                      },
                    ),
                    // const Text(
                    //   'Invalid or Incorrect password . Try Again !',
                    //   style: TextStyle(
                    //     color: Color(0xFFCE0000),
                    //     fontSize: AppFontSizes.smallDefault,
                    //     fontFamily: 'Poppins',
                    //     fontWeight: FontWeight.w600,
                    //     height: 0,
                    //   ),
                    // ),
                    sizedBox30(),
                    Consumer<TimerProvider>(
                        builder: (context, timerProvider, _) {
                      return OtpTimer(
                          timeDuration: timerProvider.timerDuration);
                    }),
                    sizedBox30(),
                    // InkWell(
                    //   onTap: () async {
                    //     // Navigator.pushNamed(context, OtpScreen.routeName);
                    //     try {
                    //       await Provider.of<AuthProvider>(context,
                    //               listen: false)
                    //           .signInWithSmsCode(otp);
                    //       if (!mounted) return;

                    //       Navigator.pushNamedAndRemoveUntil(context,
                    //           CompleteProfile.routeName, (route) => false);
                    //     } catch (e) {
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //           SnackBar(content: Text(e.toString())));
                    //     }
                    //   },
                    //   child: const CustomButton(
                    //     text: 'Verify',
                    //     isColored: true,
                    //   ),
                    // ),
                    SizedBox(
                      height: 55,
                      child: RoundButton(
                        title: "Verify",
                        type: RoundButtonType.bgGradient,
                        fontSize: AppFontSizes.mediumDefault,
                        fontWeight: FontWeight.w400,
                        onPressed: () async {
                          try {
                            // await Provider.of<AuthProviderNin>(context,
                            //         listen: false)
                            //     .signInWithSmsCode(otp);
                            if (!mounted) return;

                            Navigator.pushNamedAndRemoveUntil(context,
                                CompleteProfile.routeName, (route) => false);
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomAlertWidget(
                                  title: 'Oops! Something went wrong',
                                  description: e.toString(),
                                  color: Colors.red,
                                );
                              },
                            );
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(content: Text(e.toString())));
                          }
                        },
                      ),
                    ),
                    sizedBox12(),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isTimerActive
                                ? '$_timerSeconds seconds left'
                                : 'Click to send Otp again',
                            style:
                                const TextStyle(fontSize: AppFontSizes.mediumDefault),
                          ),
                          ElevatedButton(
                            onPressed: _isTimerActive ? null : _startTimer,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // You can adjust the value as needed
                              ), backgroundColor: TColor
                                  .primaryColor1, // Set the background color
                            ),
                            child: const Text('Resend OTP'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              if (authProvider.isLoading)
                Positioned.fill(
                  child: Container(
                    color: ThemeManager.themeColor,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          );
        }),
      )),
    );
  }
}

class OtpTimer extends StatelessWidget {
  final int timeDuration;
  const OtpTimer({super.key, required this.timeDuration});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 266,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'You should recieve the OTP in ',
              style: TextStyle(
                // color: Color(0xFF575757),
                color: ThemeManager.themeText,
                fontSize: AppFontSizes.smallDefault,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: '$timeDuration Second',
              style: const TextStyle(
                color: Color(0xFF92A3FD),
                fontSize: AppFontSizes.smallDefault,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResendOtpText extends StatelessWidget {
  const ResendOtpText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 243,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Didn’t recieve the OTP?',
              style: TextStyle(
                // color: Color(0xFF575757),
                color: ThemeManager.themeText,
                fontSize: AppFontSizes.smallDefault,
                fontWeight: FontWeight.w500,
              ),
            ),
            const TextSpan(
              text: ' ',
              style: TextStyle(
                color: Color(0xFFEC6300),
                fontSize: AppFontSizes.smallDefault,
                fontWeight: FontWeight.w500,
              ),
            ),
            const TextSpan(
              text: 'Resend OTP',
              style: TextStyle(
                color: Color(0xFF92A3FD),
                fontSize: AppFontSizes.smallDefault,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
