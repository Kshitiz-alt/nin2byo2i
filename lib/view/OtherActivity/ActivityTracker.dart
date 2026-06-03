import 'package:flutter/material.dart';
import 'package:nin2byo2i/Classes/FitnessData.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/view/OtherActivity/AllActivityTrackers.dart';
import 'package:nin2byo2i/view/workout_tracker/ShowWeeklyCaloriesBurn.dart';
import 'package:nin2byo2i/view/workout_tracker/weeklySteps.dart';
import 'package:provider/provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

//from here user can see the activity listed
class ActivityTrackerPage extends StatefulWidget {
  const ActivityTrackerPage({super.key});

  @override
  _ActivityTrackerPageState createState() => _ActivityTrackerPageState();
}

class _ActivityTrackerPageState extends State<ActivityTrackerPage> {
  FitnessData fitnessData = FitnessData.instance;
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
            Languages.of(context)!.labelActivityTrack,
            style: TextStyle(
                color: ThemeManager.themeText,
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.w700),
          ),
          // actions: [
          //   InkWell(
          //     onTap: () {},
          //     child: Container(
          //       margin: EdgeInsets.all(8),
          //       height: 40,
          //       width: 40,
          //       alignment: Alignment.center,
          //       decoration: BoxDecoration(
          //           color: ThemeManager.themelightColor,
          //           borderRadius: BorderRadius.circular(10)),
          //       child: Image.asset(
          //         "assets/img/more_btn.png",
          //         color: ThemeManager.themeText,
          //         width: 15,
          //         height: 15,
          //         fit: BoxFit.contain,
          //       ),
          //     ),
          //   )
          // ],
        ),
        backgroundColor: ThemeManager.themeColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                sizedBox12(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const stepsWeekly()
                          //  AllActivityScreen(),
                          //  AllActivityScreen(),
                          // ActivityTrackerScreen(),
                          // LocationMarker(),
                          ),
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => BMRCalculator()),
                    // );
                  },
                  child: Container(
                    // height: media.width * 0.45,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      color: TColor.primaryColor2.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 80,
                            //  height: 41,
                            // decoration: BoxDecoration(
                            //   shape: BoxShape.circle,
                            //   color: ThemeManager
                            //       .themelightColor, // Set the background color for the circular container
                            // ),
                            child: Center(
                              child: Image.asset(
                                "assets/images/shoes.png",
                                //    "assets/img/running.png",
                                // width: 2100, // Adjust the width of the image
                                // height: 24, // Adjust the height of the image
                                // color: ThemeManager.themeText,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: media.width * 0.41,
                              child: Text(
                                "${Languages.of(context)!.labelTodaySteps}  ",
                                //
                                // $_steps2
                                style: TextStyle(
                                    color: ThemeManager.themeText,
                                    fontSize: AppFontSizes.extraLargeDefault,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.41,
                              child: Text(
                                fitnessData.steps,
                                //
                                // $_steps2
                                style: TextStyle(
                                    color: ThemeManager.themeText,
                                    fontSize: AppFontSizes.extraLargeDefault,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ),
                sizedBox12(),
                GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowWeeklyCaloriesBurn(),
                      ),
                    );
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      color: TColor.primaryColor2.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // height: media.width * 0.45,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          ClipOval(
                            child: SizedBox(
                              width: 80,
                              //  height: 41,
                              // decoration: BoxDecoration(
                              //   shape: BoxShape.circle,
                              //   color: ThemeManager
                              //       .themelightColor, // Set the background color for the circular container
                              // ),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/calories.png",
                                  //    "assets/img/running.png",
                                  // width: 2100, // Adjust the width of the image
                                  // height: 24, // Adjust the height of the image
                                  // color: ThemeManager.themeText,
                                ),
                              ),
                            ),
                          ),
                          // Container(
                          //   alignment: Alignment.center,
                          //   child: SizedBox(
                          //     width: media.width * 0.2,
                          //     height: media.width * 0.2,
                          //     child: Stack(
                          //       alignment: Alignment.center,
                          //       children: [
                          //         Container(
                          //           width: media.width * 0.15,
                          //           height: media.width * 0.15,
                          //           alignment: Alignment.center,
                          //           decoration: BoxDecoration(
                          //             gradient: LinearGradient(
                          //                 colors: TColor.primaryG),
                          //             borderRadius: BorderRadius.circular(
                          //                 media.width * 0.075),
                          //           ),
                          //           child: FittedBox(
                          //             child: Text(
                          //               // "$caloriesburnleft kCal\nleft",
                          //               "${fitnessData.caloriesLeft} Kcal\nleft",
                          //               textAlign: TextAlign.center,
                          //               style: TextStyle(
                          //                   color: ThemeManager.themeColor,
                          //                   fontSize:
                          //                       AppFontSizes.smallDefault),
                          //             ),
                          //           ),
                          //         ),
                          //         // ClipOval(
                          //         //   child: Container(
                          //         //     width: 50,
                          //         //     child: Center(
                          //         //       child: Image.asset(
                          //         //         "assets/images/calories.png",
                          //         //       ),
                          //         //     ),
                          //         //   ),
                          //         // ),
                          //         SimpleCircularProgressBar(
                          //           progressStrokeWidth: 10,
                          //           backStrokeWidth: 10,
                          //           progressColors: TColor.primaryG,
                          //           backColor: Colors.grey.shade100,
                          //           valueNotifier: ValueNotifier(
                          //               fitnessData.caloriesProgressBar),
                          //           startAngle: -180,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: media.width * 0.41,
                                child: Text(
                                  Languages.of(context)!.labelCalories,
                                  style: TextStyle(
                                      color: ThemeManager.themeText,
                                      fontSize: AppFontSizes.extraLargeDefault,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              sizedBox12(),
                              SizedBox(
                                width: media.width * 0.41,
                                child: Text(
                                  "${double.parse(fitnessData.caloriesBurned).toStringAsFixed(double.parse(fitnessData.caloriesBurned) >= 99 ? 0 : 2)} Kcal",
                                  //
                                  // $_steps2
                                  style: TextStyle(
                                      color: ThemeManager.themeText,
                                      fontSize: AppFontSizes.extraLargeDefault,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              // Text(
                              //   // "$caloriesburn kCal",
                              //   "${double.parse(fitnessData.caloriesBurned).toStringAsFixed(1)} kCal",
                              //   style: TextStyle(
                              //       color: ThemeManager.themeText, fontSize: AppFontSizes.mediumDefault),
                              // ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ]),
                  ),
                ),
                sizedBox12(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllActivityScreen(),
                        // ActivityTrackerScreen(),
                        // LocationMarker(),
                      ),
                    );
                  },
                  child: Container(
                    // width: media.width * 0.28,
                    // height: media.width * 0.45,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      color: TColor.primaryColor2.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            width: 80,
                            //  height: 41,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ThemeManager
                                  .themelightColor, // Set the background color for the circular container
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/images/exercise.png",
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            SizedBox(
                              width: media.width * 0.41,
                              child: Text(
                                Languages.of(context)!.mainlabelTimeSpentOn,
                                textAlign: TextAlign.start,
                                // $_steps2
                                style: TextStyle(
                                    color: ThemeManager.themeText,
                                    fontSize: AppFontSizes.extraLargeDefault,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
