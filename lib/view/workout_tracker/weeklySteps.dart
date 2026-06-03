import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Classes/FitnessData.dart';
import 'package:nin2byo2i/Classes/WaterClass.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/view/home/commongraph.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import '../../common_widget/latest_activity_row.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/today_target_cell.dart';

import 'package:intl/intl.dart';

//this page will show step trend
class stepsWeekly extends StatefulWidget {
  const stepsWeekly({super.key});

  @override
  State<stepsWeekly> createState() => _stepsWeekly();
}

class _stepsWeekly extends State<stepsWeekly> {
  DateTime now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = '';

  final UserProfileController _controller = UserProfileController();
  FitnessData fitnessData = FitnessData.instance;
  late WaterData waterData;
  bool success = false;

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
    // loadData();
    fetchDaywiseSleepData();
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
      final data =
          await _controller.getCsvData(endDateFormatted, startDateFormatted);
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
            margin: EdgeInsets.all(8),
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
          Languages.of(context)!.labelStepsTracker,
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
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            children: [
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
                        child: Container(
                          width: 150,
                          //  height: 41,
                          // decoration: BoxDecoration(
                          //   shape: BoxShape.circle,
                          //   color: ThemeManager
                          //       .themelightColor, // Set the background color for the circular container
                          // ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/shoes.png",
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
                          "${Languages.of(context)!.labelTodaySteps} ",
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
                          " ${fitnessData.steps} ",
                          // $_steps2
                          style: TextStyle(
                              color: ThemeManager.themeText,
                              fontSize: AppFontSizes.extraLargeDefault,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
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
                  Text(
                    Languages.of(context)!.mainlabelStepProgress,
                    style: TextStyle(
                        color: ThemeManager.themeText,
                        fontSize: AppFontSizes.mediumDefault,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    width: 100,
                    height: 30,
                    decoration: ShapeDecoration(
                      color: Color.fromARGB(255, 189, 20, 124),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: [
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
                      style: TextStyle(color: Colors.white),
                      dropdownColor: Color.fromARGB(255, 189, 20, 124),
                      icon: Icon(Icons.expand_more, color: Colors.white),
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
                                  style: TextStyle(
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
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
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
                                Column(
                                  children: [
                                    Text(
                                      '${(data['value']).toInt().toStringAsFixed((data['value']).toInt() >= 99 ? 0 : 2)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppFontSizes.smallDefault,
                                      ),
                                    ),
                                    Text(
                                      Languages.of(context)!.ninTextSteps,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppFontSizes.smallDefault,
                                      ),
                                    ),
                                    // ClipOval(
                                    //   child: Container(
                                    //     width: 25,
                                    //     //  height: 41,
                                    //     // decoration: BoxDecoration(
                                    //     //   shape: BoxShape.circle,
                                    //     //   color: ThemeManager
                                    //     //       .themelightColor, // Set the background color for the circular container
                                    //     // ),
                                    //     child: Center(
                                    //       child: Image.asset(
                                    //         "assets/images/shoes.png",
                                    //         // width: 2100, // Adjust the width of the image
                                    //         // height: 24, // Adjust the height of the image
                                    //         // color: ThemeManager.themeText,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Column(
                                  children: [
                                    SimpleAnimationProgressBar(
                                      height:
                                          150, // Set the height of the progress bar
                                      width:
                                          20, // Set the width of the progress bar
                                      backgroundColor:
                                          Color.fromARGB(255, 221, 220, 220),
                                      // foregrondColor: index % 2 == 0
                                      //     ? TColor.primaryColor1
                                      //     : TColor.secondaryColor1,
                                      foregrondColor: TColor.primaryColor1,
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
                                    SizedBox(height: 8),
                                    Text(
                                      formattedDate,
                                      style: TextStyle(
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
                        RotatedBox(
                          quarterTurns: -1,
                          child: Text(
                            '            kg',
                            style: TextStyle(
                              fontSize: AppFontSizes
                                  .smallDefault, // Adjust the font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Adjust the width as needed
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              LineChartSample2(
                                  allSpots: convertDataToFlSpots(DayWIseData),
                                  minX: -1,
                                  maxX: 30,
                                  minY: -200,
                                  maxY: 8000,
                                  valuetype: "steps",
                                  keyValuePairs: {
                                    2000: '2k',
                                    4000: '4k',
                                    6000: '6k',
                                    8000: '8k',
                                    // 14000: '14k',
                                  }),
                              Text(
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
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(20),
              //   child: Container(
              //     height: 200,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       // gradient: LinearGradient(
              //       //   begin: Alignment.topLeft,
              //       //   end: Alignment.bottomRight,
              //       //   colors: [TColor.primaryColor1, TColor.secondaryColor1],
              //       // ),
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: LineChartSample2(
              //         allSpots: convertDataToFlSpots(DayWIseData),
              //         minX: -1,
              //         maxX: 30,
              //         minY: -200,
              //         maxY: 8000,
              //         valuetype: "steps",
              //         keyValuePairs: {
              //           2000: '2k',
              //           4000: '4k',
              //           6000: '6k',
              //           8000: '8k',
              //           // 14000: '14k',
              //         }),
              //   ),
              // ),

              Divider(
                color: ThemeManager.themeText,
                height: 20, // You can adjust the height of the line
                thickness: 2, // You can adjust the thickness of the line
              ),
            ],
          ),
        ),
      ),
    );
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
}
