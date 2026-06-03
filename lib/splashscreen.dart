// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
// import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
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
                sizedBox30(),
                Image.asset(
                  "assets/NIN-logo.png",
                  width: 244,
                  height: 65,
                ),
              ],
            ),
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
          // Add your copyright information or logo here
          const Spacer(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('@copyright ',
                  style: TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      color: Colors.blue)),
              Text('2023 National Institute of Nutrition',
                  style: TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      color: Colors.black)),
              // Text('National institute of nutrition',
              //     style: TextStyle(fontSize: AppFontSizes.mediumDefault, color: Colors.pink)),
            ],
          ),
          // Text('2023 National institute of nutrition',
          //     style: TextStyle(fontSize: AppFontSizes.mediumDefault, color: Colors.black)),
          sizedBox30(),
        ],
      ),
    );
  }
}
