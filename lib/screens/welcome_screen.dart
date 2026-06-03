import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/screens/onboard/onboard_screen1.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//welcome screens page
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.themeColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.00, 0.08),
            end: Alignment(1, -0.08),
            colors: [Colors.white, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("NIN 2.0",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 34, 104, 161))),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'N',
                            style: TextStyle(
                              color: Color.fromARGB(255, 34, 104, 161),
                              fontSize: AppFontSizes.extraLargeDefault,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: 'utrify ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: AppFontSizes.extraLargeDefault,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: 'I',
                            style: TextStyle(
                              color: Color.fromARGB(255, 34, 104, 161),
                              fontSize: AppFontSizes.extraLargeDefault,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: 'ndia ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: AppFontSizes.extraLargeDefault,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: 'N',
                            style: TextStyle(
                              color: Color.fromARGB(255, 34, 104, 161),
                              fontSize: AppFontSizes.extraLargeDefault,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: 'ow',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: AppFontSizes.extraLargeDefault,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    // Text("Nutrify India Now",
                    //     style: TextStyle(
                    //       fontSize: AppFontSizes.extraLargeDefault,
                    //       fontWeight: FontWeight.w700,
                    //     )),
                    // Text("2.0",
                    //     style: TextStyle(
                    //         fontSize: 40,
                    //         fontWeight: FontWeight.w700,
                    //         color: TColor.primaryColor1)),
                    // Text(
                    //   'Everybody Can Train',
                    //   style: TextStyle(
                    //     color: Color(0xFF7B6F72),
                    //     fontSize: AppFontSizes.mediumDefault,
                    //     fontFamily: 'Poppins',
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    Image.asset(
                      "assets/NIN-logo.png",
                      width: 244,
                      height: 65,
                    ),
                    sizedBox12(),
                    sizedBox12(),
                    sizedBox12(), sizedBox12(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: const Text(
                        "It's authentic data from ICMR- NIN",
                        style: TextStyle(
                            fontFamily: 'Cursive',
                            fontSize: 25.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),

              // sizedBox30(),
              // ElevatedButton(
              //   onPressed: () {
              //     // Navigate to the second page when the button is clicked
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => CompleteProfile()),
              //     );
              //   },
              //   child: Text('Go to Second Page'),
              // ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 60,
                      child: RoundButton(
                        title: "Get Started",
                        type: RoundButtonType.bgGradient,
                        fontSize: AppFontSizes.mediumDefault,
                        fontWeight: FontWeight.w400,
                        onPressed: () {
                          Navigator.pushNamed(context, Onboarding1.routeName);
                        },
                      ),
                    ),
                    const SizedBox(
                        height:
                            16), // Add some space between the button and the text
                    const Text(
                      '© 2023 National Institute of Nutrition',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: AppFontSizes.smallDefault,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
