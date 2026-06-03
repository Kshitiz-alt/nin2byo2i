import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Classes/FitnessData.dart';
import 'package:nin2byo2i/Classes/WaterClass.dart';
import 'package:nin2byo2i/Common/DateFormatter.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/OtherActivity/AllActivityTrackers.dart';
import 'package:nin2byo2i/view/home/commongraph.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

import '../../common_widget/latest_activity_row.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/today_target_cell.dart';

import 'package:intl/intl.dart';

//this page will calories burn trend
class ShowWeeklyCaloriesBurn extends StatefulWidget {
  const ShowWeeklyCaloriesBurn({super.key});

  @override
  State<ShowWeeklyCaloriesBurn> createState() => _ShowWeeklyCaloriesBurn();
}

class _ShowWeeklyCaloriesBurn extends State<ShowWeeklyCaloriesBurn> {
  DateTime now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = '';
  String SlectedDate = '';

  final UserProfileController _controller = UserProfileController();
  FitnessData fitnessData = FitnessData.instance;
  late WaterData waterData;
  bool success = false;
  Map<String, double> daywiseSleepData = {};

  int touchedIndex = -1;
  // new WaterData(waterGoal: 0, cupCapacity: 0, noOfCups: 0, waterIntake: 0);
  List<FlSpot> convertDataToFlSpots(List<Map<String, dynamic>> data) {
    List<FlSpot> flSpots = [];

    for (int i = 0; i < data.length; i++) {
      flSpots.add(FlSpot(i.toDouble(), data[i]['value'].toDouble()));
    }

    return flSpots;
  }

  @override
  void initState() {
    super.initState();
    formattedDate = formatter.format(now);
    SlectedDate = formattedDate;
    // loadData();
    fetchDaywiseSleepData();
    _fetchExerciseData();
  }

  String formatMinutes(double minutes) {
    if (minutes < 0) {
      throw ArgumentError('Minutes should be a non-negative number.');
    }

    int hours = minutes ~/ 60;
    int remainingMinutes = (minutes % 60).floor();
    int seconds = ((minutes * 60) % 60).floor();

    return '${hours}h ${remainingMinutes}m ${seconds}s';
  }

  double totalCal = 0.0;
  List<Map<String, dynamic>> exerciseData = [];
  // bool _isLoading = false;
  Future<void> _fetchExerciseData() async {
    // setState(() {
    //   _isLoading = true;
    // });

    try {
      debugPrint("fsdgfsdgdfhgd $SlectedDate");
      List<Map<String, dynamic>> data =
          await _controller.getExercisesByDate(SlectedDate);
      debugPrint("fsdgfsdgdfhgd $data");
      setState(() {
        exerciseData = data; // Wrap the data in a list
        // _isLoading = false;

        for (var activity in data) {
          totalCal += activity['caloriesBurned'];
        }
      });
    } catch (e) {
      debugPrint("Error: $e");
      setState(() {
        // _isLoading = false;
      });
    }
  }

  DateTime currentDate = DateTime.now();

  // Get end date (previous 7 days)
  DateTime endDate = DateTime.now().subtract(const Duration(days: 7));

  List<Map<String, dynamic>> DayWIseData = [
    {"date": "2024-02-13", "value": 0},
    {"date": "2024-02-14", "value": 0},
    {"date": "2024-02-15", "value": 0},
    {"date": "2024-02-16", "value": 0},
    {"date": "2024-02-17", "value": 0},
    {"date": "2024-02-18", "value": 0},
    {"date": "2024-02-18", "value": 0}
  ];
  String dropdownValue = 'Week';
  double maxValue = 1;
  Future<void> fetchDaywiseSleepData() async {
    try {
      // Format dates
      String startDateFormatted = formatDate(currentDate);
      String endDateFormatted = formatDate(endDate);
      // Assuming you have a function named getDaywiseSleepData that fetches data
      final data = await _controller.getCaloriesbargraph(
          endDateFormatted, startDateFormatted);
      debugPrint("rgtedrfyhrt $startDateFormatted $endDateFormatted $data");
      // Map<String, double> data = await getDaywiseSleepData();
      setState(() {
        if (data.isNotEmpty) {
          DayWIseData = data;
          maxValue = DayWIseData.isNotEmpty
              ? DayWIseData[0]["value"].toDouble()
              : null;
          for (int i = 1; i < data.length; i++) {
            if (data[i]["value"].toDouble() > maxValue) {
              maxValue = data[i]["value"].toDouble();

              //  debugPrint("rgtedrfyhrt $startDateFormatted $endDateFormatted $data");
            }
          }
          maxValue == 0 ? maxValue = 1 : '';
        }
      });
    } catch (e) {
      // Handle errors, such as displaying an error message to the user
      debugPrint('Error fetching daywise sleep data: $e');
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String convertTo12HourFormat(String time24) {
    // Split the time string into hours, minutes, and seconds
    List<String> parts = time24.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    // Determine if it's AM or PM
    String period = hours >= 12 ? 'PM' : 'AM';

    // Convert hours to 12-hour format
    hours = hours % 12;
    if (hours == 0) {
      hours = 12; // 12 AM is equivalent to 0 in 24-hour format
    }

    // Pad hours and minutes with leading zeros if needed
    String paddedHours = hours.toString().padLeft(2, '0');
    String paddedMinutes = minutes.toString().padLeft(2, '0');

    // Format the time into a string
    String time12 = '$paddedHours:$paddedMinutes';
    if (seconds != 0) {
      time12 += ':$seconds'; // Add seconds if present
    }
    time12 += ' $period'; // Add AM/PM indicator

    return time12;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double watchdata = double.parse(fitnessData.caloriesBurnedfromwatch);
    double totalCalBurn = double.parse(fitnessData.caloriesBurned);
    debugPrint("fgdhggfjfj ${fitnessData.caloriesBurned}");
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
          Languages.of(context)!.labelCaloriesBurn,
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
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            children: [
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => AllActivityScreen(),
              //         // ActivityTrackerScreen(),
              //         // LocationMarker(),
              //       ),
              //     );
              //   },
              //   child: Container(
              //     // width: media.width * 0.28,
              //     height: media.width * 0.15,
              //     padding:
              //         const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              //     decoration: BoxDecoration(
              //       color: TColor.primaryColor2.withOpacity(0.3),
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       crossAxisAlignment: CrossAxisAlignment.center,
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
              //             Languages.of(context)!.mainlabelTimeSpentOn,
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
              // SizedBox(
              //   height: media.width * 0.1,
              // ),
              GestureDetector(
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => stepsWeekly(),
                //       // ActivityTrackerScreen(),
                //       // LocationMarker(),
                //     ),
                //   );
                //   // Navigator.push(
                //   //   context,
                //   //   MaterialPageRoute(
                //   //       builder: (context) => BMRCalculator()),
                //   // );
                // },
                // onLongPress: () => _speak(
                //     'Your ${Languages.of(context)!.labelTodaySteps} is $_steps2  steps'),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  // decoration: BoxDecoration(
                  //   color: TColor.primaryColor2.withOpacity(0.3),
                  //   borderRadius: BorderRadius.circular(15),
                  // ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 150,
                          //  height: 41,
                          // decoration: BoxDecoration(
                          //   shape: BoxShape.circle,
                          //   color: ThemeManager
                          //       .themelightColor, // Set the background color for the circular container
                          // ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/calories.png",
                              // width: 2100, // Adjust the width of the image
                              // height: 24, // Adjust the height of the image
                              // color: ThemeManager.themeText,
                            ),
                          ),
                        ),
                      ),
                      // Spacer(),
                      SizedBox(
                        // width: media.width * 0.60,
                        child: Text(
                          "${Languages.of(context)!.labelCaloriesBurn} (from App)",
                          // $_steps2
                          style: TextStyle(
                              color: ThemeManager.themeText,
                              fontSize: AppFontSizes.extraLargeDefault,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        // width: media.width * 0.60,
                        child: Text(
                          " ${totalCalBurn.toStringAsFixed(totalCalBurn >= 99 ? 0 : 2)} Kcal",
                          // $_steps2
                          style: TextStyle(
                              color: ThemeManager.themeText,
                              fontSize: AppFontSizes.extraLargeDefault,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      if (watchdata > 0)
                        Column(
                          children: [
                            SizedBox(
                              // width: media.width * 0.60,
                              child: Text(
                                "${Languages.of(context)!.labelCaloriesBurn} (from watch)",
                                // $_steps2
                                style: TextStyle(
                                    color: ThemeManager.themeText,
                                    fontSize: AppFontSizes.extraLargeDefault,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              // width: media.width * 0.60,
                              child: Text(
                                " ${watchdata.toStringAsFixed(watchdata >= 99 ? 0 : 2)} Kcal",
                                // $_steps2
                                style: TextStyle(
                                    color: ThemeManager.themeText,
                                    fontSize: AppFontSizes.extraLargeDefault,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        )
                      // Text(
                      //   " ${fitnessData.steps} ",
                      //   // $_steps2
                      //   style: TextStyle(
                      //       color: ThemeManager.themeText,
                      //       fontSize:AppFontSizes.extraLargeDefault,
                      //       fontWeight: FontWeight.w700),
                      // ),
                      // SizedBox(
                      //   width: 70,
                      //   height: 25,
                      //   child: RoundButton(
                      //     title: Languages.of(context)!.labelCheck,
                      //     type: RoundButtonType.bgGradient,
                      //     fontSize: AppFontSizes

                      //     fontWeight: FontWeight.w400,
                      //     onPressed: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => stepsWeekly(),
                      //           // ActivityTrackerScreen(),
                      //           // LocationMarker(),
                      //         ),
                      //       );
                      //       // Navigator.push(
                      //       //   context,
                      //       //   MaterialPageRoute(
                      //       //       builder: (context) => BMRCalculator()),
                      //       // );
                      //     },
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: media.width * 0.6,
                    child: Text(
                      Languages.of(context)!.mainlabelCaloriesBurnProgress,
                      style: TextStyle(
                          color: ThemeManager.themeText,
                          fontSize: AppFontSizes.mediumDefault,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    decoration: ShapeDecoration(
                      color: const Color.fromARGB(255, 189, 20, 124),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x111D1617),
                          blurRadius: 40,
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      style: const TextStyle(color: Colors.white),
                      dropdownColor: const Color.fromARGB(255, 189, 20, 124),
                      icon: const Icon(Icons.expand_more, color: Colors.white),
                      underline: Container(),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          if (newValue == 'Week') {
                            // Set end date to previous 7 days
                            endDate = DateTime.now()
                                .subtract(const Duration(days: 7));
                          } else if (newValue == 'Month') {
                            // Set end date to previous month
                            endDate = DateTime.now()
                                .subtract(const Duration(days: 30));
                          }
                          fetchDaywiseSleepData();
                        });
                      },
                      items: <String>['Week', 'Month']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  value,
                                  style: const TextStyle(
                                      color:
                                          Colors.white // Change the text color
                                      ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: media.width * 0.05,
              ),
              if (dropdownValue == "Week")
                Container(
                  // height: media.width * 0.5,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: ThemeManager.themelightColor, blurRadius: 3)
                      ]),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        DayWIseData.length,
                        (index) {
                          final data = DayWIseData[index];
                          final double ratio =
                              data['value'].toDouble() / maxValue;
                          DateTime dateTime = DateTime.parse(
                            data["date"],
                          );

                          // Format the date
                          String formattedDate =
                              DateFormat('dd MMM').format(dateTime);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${(data['value']).toStringAsFixed(data['value'] >= 99 ? 0 : 2)} Kcal',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppFontSizes.smallDefault,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          SlectedDate = data["date"];
                                          _fetchExerciseData();
                                        });
                                      },
                                      child: SimpleAnimationProgressBar(
                                        height:
                                            150, // Set the height of the progress bar
                                        width:
                                            20, // Set the width of the progress bar
                                        backgroundColor:
                                            const Color.fromARGB(255, 221, 220, 220),
                                        foregrondColor: TColor.primaryColor1,
                                        // foregrondColor: index % 2 == 0
                                        //     ? TColor.primaryColor1
                                        //     : TColor.secondaryColor1,
                                        ratio: ratio, // Set the ratio value
                                        direction: Axis
                                            .vertical, // Set direction to vertical
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        duration: const Duration(seconds: 3),
                                        borderRadius: BorderRadius.circular(10),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: Colors.pink,
                                        //     offset: const Offset(
                                        //       5.0,
                                        //       5.0,
                                        //     ),
                                        //     blurRadius: 10.0,
                                        //     spreadRadius: 2.0,
                                        //   ),
                                        // ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      formattedDate,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppFontSizes.smallDefault,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              if (dropdownValue == "Month")
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 230,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const RotatedBox(
                          quarterTurns: -1,
                          child: Center(
                            child: Text(
                              '     Calories burnt (Kcal)',
                              style: TextStyle(
                                fontSize: AppFontSizes
                                    .smallDefault, // Adjust the font size as needed
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10), // Adjust the width as needed
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              LineChartSample2(
                                allSpots: convertDataToFlSpots(DayWIseData),
                                minX: -1,
                                maxX: 30,
                                minY: -100,
                                maxY: 4000,
                                valuetype: "Kcal",
                                keyValuePairs: const {
                                  1000: '1000',
                                  2000: '2000',
                                  3000: '3000',
                                  4000: '4000',
                                },
                              ),
                              const Text(
                                'Previous 30 days',
                                style: TextStyle(
                                  fontSize: AppFontSizes.smallDefault,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // SizedBox(
              //   height: media.width * 0.05,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Latest Workout",
              //       style: TextStyle(
              //           color: Colors.black,
              //           fontSize: AppFontSizes.mediumDefault,
              //           fontWeight: FontWeight.w700),
              //     ),
              //     TextButton(
              //       onPressed: () {},
              //       child: Text(
              //         "See More",
              //         style: TextStyle(
              //             color: TColor.gray,
              //             fontSize: AppFontSizes .mediumDefault,
              //             fontWeight: FontWeight.w700),
              //       ),
              //     )
              //   ],
              // ),
              // ListView.builder(
              //     padding: EdgeInsets.zero,
              //     physics: const NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: latestArr.length,
              //     itemBuilder: (context, index) {
              //       var wObj = latestArr[index] as Map? ?? {};
              //       return LatestActivityRow(wObj: wObj);
              //     }),
              // SizedBox(
              //   height: media.width * 0.1,
              // ),
              Divider(
                color: ThemeManager.themeText,
                height: 20, // You can adjust the height of the line
                thickness: 2, // You can adjust the thickness of the line
              ),
              sizedBox12(),

              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   child: Text(
              //     'Slected date is $SlectedDate',
              //     style: TextStyle(
              //       fontSize: AppFontSizes.mediumDefault,
              //       fontWeight: FontWeight.bold,
              //     ),
              //     textAlign: TextAlign.start,
              //   ),
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "${Languages.of(context)!.mainlabelCaloriesBurnBreakdown} ${DateFormatter.convertDate(SlectedDate)}",
                  style: TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    color: ThemeManager.themeText,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              exerciseData.isEmpty
                  ? const Center() // Return an empty widget if exerciseData is empty
                  : Column(
                      children: [
                        // if (watchdata > 1)
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 8.0, right: 8, top: 8),
                        //   child: Container(
                        //     // width: 315,
                        //     // height: 80,
                        //     decoration: ShapeDecoration(
                        //       color: ThemeManager.themelightColor,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(16),
                        //       ),
                        //       shadows: [
                        //         BoxShadow(
                        //           color: Color(0x111D1617),
                        //           blurRadius: 40,
                        //           offset: Offset(0, 10),
                        //           spreadRadius: 0,
                        //         )
                        //       ],
                        //     ),
                        //     child: Center(
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: [
                        //           SizedBox(width: 10),
                        //           SizedBox(
                        //             width: 40,
                        //             height: 40,
                        //             child: Image.asset(
                        //               "assets/img/burn.png",
                        //               width: 40,
                        //               height: 40,
                        //               // color: TColor.secondaryColor2,
                        //               fit: BoxFit.contain,
                        //             ),
                        //           ),
                        //           SizedBox(width: 15),
                        //           Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Column(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               crossAxisAlignment: CrossAxisAlignment
                        //                   .start, // Align text to the left
                        //               children: [
                        //                 SizedBox(
                        //                   width: screenWidth * 0.50,
                        //                   child: Text(
                        //                     "Type : Connected Watch",
                        //                     style: TextStyle(
                        //                       color: ThemeManager.themeText,
                        //                       fontSize:
                        //                           AppFontSizes.mediumDefault,
                        //                       fontFamily: 'Poppins',
                        //                       fontWeight: FontWeight.w500,
                        //                       height:
                        //                           1.2, // Increase the line height
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 // SizedBox(height: 4),
                        //                 // SizedBox(
                        //                 //   width: screenWidth * 0.50,
                        //                 //   child: Text(
                        //                 //     fObj["name"],
                        //                 //     style: TextStyle(
                        //                 //       color: ThemeManager.themeText,
                        //                 //       fontSize:
                        //                 //           AppFontSizes.mediumDefault,
                        //                 //       fontFamily: 'Poppins',
                        //                 //       fontWeight: FontWeight.w500,
                        //                 //       height:
                        //                 //           1.2, // Increase the line height
                        //                 //     ),
                        //                 //   ),
                        //                 // ),

                        //                 SizedBox(
                        //                     height:
                        //                         4), // Add some vertical spacing
                        //                 SizedBox(
                        //                   width: screenWidth * 0.50,
                        //                   child: Text(
                        //                     '${Languages.of(context)!.TextAppCaloriesBurn} : ${tryConvertToString(watchdata)} Kcal',
                        //                     style: TextStyle(
                        //                       color: TColor.secondaryColor1,
                        //                       fontSize:
                        //                           AppFontSizes.mediumDefault,
                        //                       fontFamily: 'Poppins',
                        //                       fontWeight: FontWeight.w400,
                        //                       height:
                        //                           1.5, // Increase the line height
                        //                     ),
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        for (var exercise in exerciseData)
                          IndividualdataWidget(
                            fObj: {
                              "name":
                                  '${convertTo12HourFormat(exercise['startTime'])} to ${convertTo12HourFormat(exercise['endTime'])} for ${formatMinutes(exercise['duration'])} ',
                              "image": 'assets/img/burn.png',
                              "discription":
                                  '${Languages.of(context)!.TextAppCaloriesBurn} : ${tryConvertToString(exercise['caloriesBurned'])} Kcal',
                              "activityType":
                                  "${Languages.of(context)!.labelType} : ${exercise['activityType']}",
                              "id": " ${exercise['id']}",
                            },
                          ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  String tryConvertToString(dynamic value) {
    try {
      double doubleValue;
      if (value is String) {
        doubleValue = double.parse(value);
      } else if (value is int || value is double) {
        doubleValue = value.toDouble();
      } else {
        throw const FormatException('Cannot convert value to double');
      }

      return doubleValue.toStringAsFixed(doubleValue >= 99 ? 0 : 2);
    } catch (e) {
      debugPrint('Error: $e');
      return value;
    }
  }

  int tempdate2 = 0;
  Widget getTitles(double value, TitleMeta meta) {
    var style = TextStyle(
      color: ThemeManager.themeText,
      fontWeight: FontWeight.w500,
      fontSize: AppFontSizes.smallDefault,
    );

    debugPrint("fvsdgdfhgdfhdf ${value.toInt()}");

    Widget text;
    if (value.toInt() >= DayWIseData.length) {
      // tempdate = tempdate + 1;
      debugPrint("fvsdgdfhgdfhdf ${value.toInt()}");
      text = Text('', style: style);
    } else {
      debugPrint("fvsdgdfhgdfhdf ${value.toInt()}");
      DateTime dateTime = DateTime.parse(
        DayWIseData[value.toInt()]["date"],
      );

      // Format the date
      String formattedDate = DateFormat('dd MMM').format(dateTime);
      text = Text(formattedDate, style: style);
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  int tempdate = 0;
  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        if (i >= DayWIseData.length) {
          tempdate = tempdate + 1;
          return makeGroupData(tempdate, 0, TColor.primaryG,
              isTouched: i == touchedIndex);
        }
        debugPrint("data isbhnfgjgfjj here $i $DayWIseData ");
        DateTime dateTime = DateTime.parse(DayWIseData[i]["date"]);

        // Extract the day as an integer
        int day = dateTime.day;
        tempdate = day;
        switch (i) {
          case 0:
            return makeGroupData(
                i, DayWIseData[i]["value"].toDouble() ?? 0, TColor.primaryG,
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(
                i, DayWIseData[i]["value"].toDouble() ?? 0, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(
                i, DayWIseData[i]["value"].toDouble() ?? 0, TColor.primaryG,
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(
                i, DayWIseData[i]["value"].toDouble() ?? 0, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(
                i, DayWIseData[i]["value"].toDouble() ?? 0, TColor.primaryG,
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(
                i, DayWIseData[i]["value"].toDouble() ?? 0, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(
                i, DayWIseData[i]["value"].toDouble() ?? 0, TColor.primaryG,
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });
  BarChartGroupData makeGroupData(
    int x,
    double y,
    List<Color> barColor, {
    bool isTouched = false,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          gradient: LinearGradient(
              colors: barColor,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          width: width,
          borderSide: isTouched
              ? const BorderSide(color: Colors.green)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: ThemeManager.themelightColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  Widget IndividualdataWidget({required Map<String, dynamic> fObj}) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
      child: Container(
        // width: 315,
        // height: 80,
        decoration: ShapeDecoration(
          color: ThemeManager.themelightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x111D1617),
              blurRadius: 40,
              offset: Offset(0, 10),
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                  fObj["image"].toString(),
                  width: 40,
                  height: 40,
                  // color: TColor.secondaryColor2,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    SizedBox(
                      width: screenWidth * 0.50,
                      child: Text(
                        fObj["activityType"],
                        style: TextStyle(
                          color: ThemeManager.themeText,
                          fontSize: AppFontSizes.mediumDefault,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1.2, // Increase the line height
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: screenWidth * 0.50,
                      child: Text(
                        fObj["name"],
                        style: TextStyle(
                          color: ThemeManager.themeText,
                          fontSize: AppFontSizes.mediumDefault,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1.2, // Increase the line height
                        ),
                      ),
                    ),

                    const SizedBox(height: 4), // Add some vertical spacing
                    SizedBox(
                      width: screenWidth * 0.50,
                      child: Text(
                        "${fObj["discription"]}",
                        style: TextStyle(
                          color: TColor.secondaryColor1,
                          fontSize: AppFontSizes.mediumDefault,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.5, // Increase the line height
                        ),
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  bool confirmDelete = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        // title: Text("Confirm Deletion"),
                        content:
                            Text(Languages.of(context)!.confirmDeleteExercise),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(
                                  false); // Return false if cancel is pressed
                            },
                            child: Text(Languages.of(context)!.cancel),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(
                                  true); // Return true if delete is confirmed
                            },
                            child: Text(Languages.of(context)!.ninTextDelete),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmDelete == true) {
                    final UserProfileController controller =
                        UserProfileController();
                    debugPrint("asdfdgftjgfkh ${fObj["id"]}");
                    await controller.deleteExercise(fObj["id"]);

                    // Show success alert box
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          //  title: Text("Success"),
                          content: Text(Languages.of(context)!.exerciseDeleted),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(Languages.of(context)!.ok),
                            ),
                          ],
                        );
                      },
                    );
                    setState(() {
                      controller.fetchStepsOfToday();
                      _fetchExerciseData();
                    });
                  }
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class IndividualdataWidget extends StatelessWidget {
//   final Map fObj;

//   const IndividualdataWidget({super.key, required this.fObj});

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Container(
//       // width: 315,
//       // height: 80,
//       decoration: ShapeDecoration(
//         color: ThemeManager.themelightColor,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         shadows: [
//           BoxShadow(
//             color: Color(0x111D1617),
//             blurRadius: 40,
//             offset: Offset(0, 10),
//             spreadRadius: 0,
//           )
//         ],
//       ),
//       child: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(width: 10),
//             SizedBox(
//               width: 40,
//               height: 40,
//               child: Image.asset(
//                 fObj["image"].toString(),
//                 width: 40,
//                 height: 40,
//                 // color: TColor.secondaryColor2,
//                 fit: BoxFit.contain,
//               ),
//             ),
//             SizedBox(width: 15),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start, // Align text to the left
//                 children: [
//                   SizedBox(
//                     width: screenWidth * 0.5,
//                     child: Text(
//                       fObj["activityType"],
//                       style: TextStyle(
//                         color: ThemeManager.themeText,
//                         fontSize: AppFontSizes .mediumDefault,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w500,
//                         height: 1.2, // Increase the line height
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: screenWidth * 0.5,
//                     child: Text(
//                       fObj["name"],
//                       style: TextStyle(
//                         color: ThemeManager.themeText,
//                         fontSize: AppFontSizes .mediumDefault,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w500,
//                         height: 1.2, // Increase the line height
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 4), // Add some vertical spacing
//                   SizedBox(
//                     width: screenWidth * 0.5,
//                     child: Text(
//                       "${fObj["discription"]}",
//                       style: TextStyle(
//                         color: TColor.secondaryColor1,
//                         fontSize: AppFontSizes.mediumDefault,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w400,
//                         height: 1.5, // Increase the line height
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             IconButton(
//               onPressed: () async {
//                 final UserProfileController _controller =
//                     UserProfileController();
//                 debugPrint("asdfdgftjgfkh ${fObj["id"]}");
//                 await _controller.deleteExercise(fObj["id"]);

//                 // Show success alert box
//                 showDialog(
//                   context:
//                       context, // Make sure to have access to the BuildContext
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text("Success"),
//                       content: Text("Exercise deleted successfully."),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: Text("OK"),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               icon: Icon(
//                 Icons.delete,
//                 color: Colors.red,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
