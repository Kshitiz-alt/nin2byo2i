import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Help%20Supports/BMICalculator.dart';
import 'package:nin2byo2i/Help%20Supports/BMRCalculator.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/Food/NutrientsGoalAccordingRda.dart';
import 'package:nin2byo2i/view/Food/SearchCookedFood.dart';
import 'package:nin2byo2i/view/Food/SearchRawFood.dart';
import 'package:nin2byo2i/view/Food/Top10FoodList.dart';
import 'package:nin2byo2i/view/HealthTrends/pdfviewer.dart';
import 'package:nin2byo2i/view/home/spinanimation.dart';

//guest logine implementation
class GuestLoginPage extends StatelessWidget {
  const GuestLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.themeColor,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ThemeManager.themelightColor,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/black_btn.png",
              color: ThemeManager.themeText,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Guest Login",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
        // actions: [
        //   InkWell(
        //     onTap: () {},
        //     child: Container(
        //       margin: const EdgeInsets.all(8),
        //       height: 40,
        //       width: 40,
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //           color: ThemeManager.themelightColor,
        //           borderRadius: BorderRadius.circular(10)),
        //       child: Image.asset(
        //         "assets/img/more_btn.png",
        //         width: 15,
        //         height: 15,
        //         fit: BoxFit.contain,
        //       ),
        //     ),
        //   )
        // ],
      ),
      backgroundColor: ThemeManager.themeColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              sizedBox12(),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(
                      12), // Optional: Add padding around the text
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(12), // Set the border radius
                    border: Border.all(
                      color: Colors.black, // Border color
                      width: 1, // Border width
                    ),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: 'Want to access more functionality? ',
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontSize: 16), // Set the font size to 16
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Click here',
                          style: const TextStyle(
                            fontSize: 16, // Set the font size to 16
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            },
                        ),
                        const TextSpan(
                          text: ' to register.',
                          style: TextStyle(
                              fontSize: 16), // Set the font size to 16
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              sizedBox12(),
              Container(
                decoration: BoxDecoration(
                  color: TColor.primaryColor2.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         NutrientInMyFood(),
                            //     // ActivityTrackerScreen(),
                            //     // LocationMarker(),
                            //   ),
                            // );
                          },
                          // onLongPress: () => _speak(
                          //     'check your time and calories burn you spent on different activivties'),
                          child: Container(
                            width: media.width * 0.95,
                            // height: media.width * 0.15,
                            // height: media.width * 0.40,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            // decoration: BoxDecoration(
                            //   color: TColor.primaryColor2
                            //       .withOpacity(0.3),
                            //   borderRadius:
                            //       BorderRadius.circular(15),
                            // ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    ClipOval(
                                      child: SizedBox(
                                        width: 50,
                                        //  height: 41,
                                        // decoration:
                                        //     BoxDecoration(
                                        //   shape:
                                        //       BoxShape.circle,
                                        //   // color: ThemeManager
                                        //   //     .themelightColor, // Set the background color for the circular container
                                        // ),
                                        child: Center(
                                          child: Image.asset(
                                            "assets/img/lunch.jpg",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width: media.width * 0.7,
                                        child: Text(
                                          Languages.of(context)!
                                              .TextAppNutrientsInMyFood,
                                          textAlign: TextAlign.center,
                                          // $_steps2
                                          style: TextStyle(
                                              color: ThemeManager.themeText,
                                              fontSize:
                                                  AppFontSizes.largeDefault,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Spacer(),

                                // SizedBox(
                                //   width: 70,
                                //   height: 35,
                                //   child: RoundButton(
                                //     title: Languages.of(context)!
                                //         .labelCheck,
                                //     type: RoundButtonType.bgGradient,
                                //     fontSize: AppFontSizes.smallDefault,,
                                //     fontWeight: FontWeight.w400,
                                //     onPressed: () {
                                //       // Navigator.push(
                                //       //   context,
                                //       //   MaterialPageRoute(s
                                //       //     builder: (context) =>
                                //       //         const ActivityTrackerView(),
                                //       //   ),
                                //       // );
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) =>
                                //               NutrientInMyFood(),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               ToadyActivity()),
                        //     );
                        //   },
                        //   onLongPress: () => _speak(
                        //       'check your time and calories burn you spent on different activivties'),
                        //   child: Container(
                        //     width: media.width * 0.41,
                        //     height: media.width * 0.28,
                        //     // height: media.width * 0.40,
                        //     padding: const EdgeInsets.symmetric(
                        //         vertical: 15, horizontal: 15),
                        //     decoration: BoxDecoration(
                        //       color: TColor.primaryColor2
                        //           .withOpacity(0.3),
                        //       borderRadius: BorderRadius.circular(15),
                        //     ),
                        //     child: Column(
                        //       mainAxisAlignment:
                        //           MainAxisAlignment.start,
                        //       crossAxisAlignment:
                        //           CrossAxisAlignment.center,
                        //       children: [
                        //         ClipOval(
                        //           child: Container(
                        //             width: 50,
                        //             //  height: 41,
                        //             decoration: BoxDecoration(
                        //               shape: BoxShape.circle,
                        //               color: ThemeManager
                        //                   .themelightColor, // Set the background color for the circular container
                        //             ),
                        //             child: Center(
                        //               child: Image.asset(
                        //                 "assets/images/exercise.png",
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         // Spacer(),
                        //         Center(
                        //           child: Text(
                        //             Languages.of(context)!
                        //                 .TextApp1MyActivity,
                        //             textAlign: TextAlign.center,
                        //             // $_steps2
                        //             style: TextStyle(
                        //                 color: ThemeManager.themeText,
                        //                 fontSize: AppFontSizes.mediumDefault,
                        //                 fontWeight: FontWeight.w700),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // sizedBox30(),
                          // sizedBox30(),
                          // Create a reusable ContainerCard for the first action
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchRawFood()),
                              );
                            },
                            child: Container(
                              //  height: media.width * 0.38,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: TColor.primaryColor1.withOpacity(0.2)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/img/raw food.jpeg.png',
                                        height: 60,
                                        // height: 50,
                                        // width: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  // Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 90,
                                      child: Text(
                                        Languages.of(context)!
                                            .ninTextNutrientsInRawFoods,
                                        style: TextStyle(
                                            color: ThemeManager.themeText,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                AppFontSizes.mediumDefault),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchCookedFood()),
                              );
                            },
                            child: Container(
                              //   height: media.width * 0.38,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: TColor.primaryColor1.withOpacity(0.2)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/img/cooked recipy.png',
                                        height: 60,
                                        // width: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  // Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 90,
                                      child: Text(
                                        Languages.of(context)!
                                            .ninTextNutrientsInRecipes,
                                        style: TextStyle(
                                            color: ThemeManager.themeText,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                AppFontSizes.mediumDefault),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Top10Foods()),
                              );
                            },
                            child: Container(
                              //    height: media.width * 0.38,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: TColor.primaryColor1.withOpacity(0.2)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/img/top 10 food.png',
                                        height: 60,
                                        //  height: 80,
                                        // width: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  // Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 90,
                                      child: Text(
                                        Languages.of(context)!
                                            .mainlabelExploreTop10Foods,
                                        style: TextStyle(
                                            color: ThemeManager.themeText,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                AppFontSizes.mediumDefault),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // ContainerCard(
                          //   imagePath: 'assets/img/top10food.png',
                          //   text: 'Explore Top 10 Foods',
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(builder: (context) => Top10Foods()),
                          //     );
                          //   },
                          // ),
                          // // Create another ContainerCard for the second action
                          // ContainerCard(
                          //   imagePath: 'assets/img/foodsafe (2).png',
                          //   text: 'Search Cooked Food',
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(builder: (context) => SearchCookedFood()),
                          //     );
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    sizedBox12(),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),

              sizedBox12(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PDFScreen2(
                                  lablename: "MY PLATE FOR THE DAY",
                                  pdfAssetPath: "assets/img/myplate.pdf",
                                )),
                      );
                    },
                    // onLongPress: () => _speak(
                    //     'check your time and calories burn you spent on different activivties'),
                    child: Container(
                      width: media.width * 0.95,

                      // height: media.width * 0.40,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: TColor.primaryColor2.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: Container(
                                  width: 45,
                                  //  height: 41,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ThemeManager
                                        .themelightColor, // Set the background color for the circular container
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/img/diary.png',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Center(
                                child: SizedBox(
                                  width: media.width * 0.7,
                                  child: Text(
                                    Languages.of(context)!
                                        .ninTextIcmrNinMyPlateForTheDay,
                                    textAlign: TextAlign.start,
                                    // $_steps2
                                    style: TextStyle(
                                        color: ThemeManager.themeText,
                                        fontSize: AppFontSizes.largeDefault,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Spacer(),

                          // SizedBox(
                          //   width: 70,
                          //   height: 35,
                          //   child: RoundButton(
                          //     title: Languages.of(context)!
                          //         .labelCheck,
                          //     type: RoundButtonType.bgGradient,
                          //     fontSize: AppFontSizes.smallDefault,,
                          //     fontWeight: FontWeight.w400,
                          //     onPressed: () {
                          //       // Navigator.push(
                          //       //   context,
                          //       //   MaterialPageRoute(s
                          //       //     builder: (context) =>
                          //       //         const ActivityTrackerView(),
                          //       //   ),
                          //       // );
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 PDFScreen2(
                          //                   lablename:
                          //                       "MY PLATE FOR THE DAY",
                          //                   pdfAssetPath:
                          //                       "assets/img/myplate.pdf",
                          //                 )),
                          //       );
                          //     },
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Container(
              //       width: 50,
              //       child: Image.asset(
              //         'assets/img/glassrotate.png',
              //       ),
              //     ),
              //     SizedBox(
              //       width: 50,
              //     )
              //   ],
              // ),
              sizedBox12(),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  SizedBox(
                    width: 50,
                    child: Image.asset(
                      'assets/img/glassrotate.png',
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PDFScreen2(
                                    lablename: "MY PLATE FOR THE DAY",
                                    pdfAssetPath: "assets/img/myplate.pdf",
                                  )),
                        );
                      },
                      child: SpinImageOnNavigate()),
                ],
              ),

              // sizedBox30(),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BMICalculator(),
                          // ActivityTrackerScreen(),
                          // LocationMarker(),
                        ),
                      );
                    },
                    // onLongPress: () => _speak(
                    //     'Your ${Languages.of(context)!.labelTodaySteps} is $_steps2  steps'),
                    child: Container(
                      width: media.width * 0.47,
                      height: media.width * 0.45,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: TColor.primaryColor2.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              //  height: 41,
                              // decoration: BoxDecoration(
                              //   shape: BoxShape.circle,
                              //   color: ThemeManager
                              //       .themelightColor, // Set the background color for the circular container
                              // ),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/bmi.png",
                                ),
                              ),
                            ),
                          ),
                          // Spacer(),
                          const SizedBox(
                            height: 4,
                          ),
                          Center(
                            child: Text(
                              Languages.of(context)!.mainlabelBMICalculator,
                              textAlign: TextAlign.center,
                              // $_steps2
                              style: TextStyle(
                                  color: ThemeManager.themeText,
                                  fontSize: AppFontSizes.largeDefault,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BMRCalculator(),
                          // ActivityTrackerScreen(),
                          // LocationMarker(),
                        ),
                      );
                    },
                    // onLongPress: () => _speak(
                    //     'Your ${Languages.of(context)!.labelTodaySteps} is $_steps2  steps'),
                    child: Container(
                      width: media.width * 0.47,
                      height: media.width * 0.45,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: TColor.primaryColor2.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ThemeManager
                                    .themelightColor, // Set the background color for the circular container
                              ),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/calculator.png",
                                ),
                              ),
                            ),
                          ),
                          // Spacer(),
                          const SizedBox(
                            height: 4,
                          ),
                          Center(
                            child: Text(
                              Languages.of(context)!.mainlabelBMRCalculator,
                              textAlign: TextAlign.center,
                              // $_steps2
                              style: TextStyle(
                                  color: ThemeManager.themeText,
                                  fontSize: AppFontSizes.largeDefault,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              sizedBox12(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NutritionPage()),
                  );
                },
                child: Container(
                  width: media.width * 0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: TColor.primaryColor2.withOpacity(0.3),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: media.width * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/img/my_nutrient_rquirement-removebg-preview.png',
                            height: 100,
                            // width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: media.width * 0.5,
                          child: Text(
                            Languages.of(context)!
                                .TextAppMyNutrientRequirements,
                            style: TextStyle(
                                color: ThemeManager.themeText,
                                fontSize: AppFontSizes.extraLargeDefault),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
