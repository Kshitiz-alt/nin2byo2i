import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Classes/FitnessData.dart';
import 'package:nin2byo2i/Classes/WaterClass.dart';
import 'package:nin2byo2i/Common/DateFormatter.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/view/home/commongraph.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

import '../../common_widget/latest_activity_row.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/today_target_cell.dart';

import 'package:intl/intl.dart';

//this page will show sleep trends
class SleepTrackerSCreen extends StatefulWidget {
  const SleepTrackerSCreen({super.key});

  @override
  State<SleepTrackerSCreen> createState() => _SleepTrackerSCreenState();
}

class _SleepTrackerSCreenState extends State<SleepTrackerSCreen> {
  DateTime now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = '';

  final UserProfileController _controller = UserProfileController();
  FitnessData fitnessData = FitnessData.instance;
  late WaterData waterData;
  bool success = false;

  int touchedIndex = -1;
  // new WaterData(waterGoal: 0, cupCapacity: 0, noOfCups: 0, waterIntake: 0);

  String convertMinutesToHoursMinutes(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    String hoursString = (hours > 0) ? '${hours}h ' : '';
    String minutesString = '${remainingMinutes}m';
    return '$hoursString$minutesString';
  }

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
    debugPrint("rgtedrfyhrt l,jklkl;;");
    fetchDaywiseSleepData();
    selectedDate = DateFormat("yyyy-MM-dd").format(_selectedDate);
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
      debugPrint("rgtedrfyhrtjhgkjhkhjkl");
      final data = await _controller.getSleepbargraph(
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

//   Future<void> loadData() async {
//     final data = await _controller.GetWaterDataOfUser();
//     if (data != null) {
//       setState(() {
//         waterData = data;
//         fitnessData.waterIntakeToday = waterData.waterIntake.toString();
//         fitnessData.waterGoal = waterData.waterGoal.toString();
//         success = true;
//         debugPrint('water data i8s ${waterData.waterGoal}');
//       });
//     }

//     // await _controller.GetWaterDataOfUser().then((data) {
//     //   setState(() {
//     //     waterData = data;
//     //     success = true;
//     //     debugPrint('water data i8s ${waterData.noOfCups}');
//     //   });
//     // }).catchError((error) {
//     //   // Handle error
//     //   debugPrint('error i sherer');
//     // });
//   }

//   List latestArr = [
//     {
//       "image": "assets/img/pic_4.png",
//       "title": "Drinking 300ml Water",
//       "time": "About 1 minutes ago"
//     },
//     {
//       "image": "assets/img/pic_5.png",
//       "title": "Eat Snack (Fitbar)",
//       "time": "About 3 hours ago"
//     },
//   ];

//   Future<void> _showWaterDataModal(BuildContext context) async {
//     int noOfCups = 0;
//     int CupCapacity = 0;

//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: ThemeManager.themelightColor,
//           title: Text(
//             'Add Cup Data',
//             style: TextStyle(color: ThemeManager.themeText),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 decoration: InputDecoration(labelText: 'Number of Cups'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   noOfCups = int.tryParse(value) ?? 0;
//                 },
//               ),
//               //   Row(
//               //   children: [
//               //     IconButton(
//               //       icon: Icon(Icons.remove),
//               //       onPressed: () {
//               //         setState(() {
//               //           noOfCups--;
//               //         });
//               //       },
//               //     ),
//               //     SizedBox(width: 16.0),
//               //     Text(
//               //       'Cup No. $noOfCups',
//               //       style: TextStyle(fontSize: AppFontSizes.mediumDefault.0),
//               //     ),
//               //     SizedBox(width: 16.0),
//               //     IconButton(
//               //       icon: Icon(Icons.add),
//               //       onPressed: () {
//               //         setState(() {
//               //           noOfCups++;
//               //         });
//               //       },
//               //     ),
//               //   ],
//               // ),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Add cupCapacity in ml'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   CupCapacity = int.tryParse(value) ?? 0;
//                 },
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text(
//                 'Cancel',
//                 style: TextStyle(color: ThemeManager.themeText),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SizedBox(
//                 width: 80,
//                 height: 20,
//                 child: RoundButton(
//                   title: "Submit",
//                   type: RoundButtonType.bgGradient,
//                   fontSize: AppFontSizes.smallDefault,,
//                   fontWeight: FontWeight.w400,
//                   onPressed: () async {
//                     if (noOfCups > 0 && CupCapacity > 0) {
//                       final waterData = {
//                         "cupCapacity": CupCapacity,
//                         "noOfCups": noOfCups
//                       };
// // ;
// //                        {
// //                         'noOfCups': noOfCups,
// //                       };

//                       final success =
//                           await _controller.AddWaterIntake(waterData);

//                       if (success) {
//                         setState(() {
//                           loadData();
//                         });
//                         debugPrint('success level is $success');
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('submitted successfully.'),
//                             backgroundColor:
//                                 Colors.green, // Set the snackbar color to green
//                           ),
//                         );
//                       }
//                       Navigator.of(context).pop();
//                     } else {
//                       // Show an error message or handle the validation failure.
//                       // For example, you can display a snackbar or an error dialog.
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                             'Please enter valid values for all fields.',
//                             style: TextStyle(color: ThemeManager.themeText),
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
  String selectedDate = "";
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        selectedDate = DateFormat("yyyy-MM-dd").format(picked);
      });
    }
  }

  Future<void> _showWaterDataModalPost(BuildContext context) async {
    double SleepGoal = 0.0;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeManager.themelightColor,
          title: Text(
            Languages.of(context)!.enterSleepTarget,
            style: TextStyle(color: ThemeManager.themeText),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                style: TextStyle(color: ThemeManager.themeText),
                decoration: InputDecoration(
                    labelText: Languages.of(context)!.sleepTargetInHours,
                    labelStyle: TextStyle(color: ThemeManager.themeText)),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  SleepGoal = double.tryParse(value) ?? 0.0;
                },
              ),

              // TextField(
              //   decoration:
              //       InputDecoration(labelText: 'Cup Capacity (Milliliters)'),
              //   keyboardType: TextInputType.number,
              //   onChanged: (value) {
              //     cupCapacity = int.tryParse(value) ?? 0;
              //   },
              // ),
              // TextField(
              //   decoration: InputDecoration(labelText: 'Number of Cups'),
              //   keyboardType: TextInputType.number,
              //   onChanged: (value) {
              //     noOfCups = int.tryParse(value) ?? 0;
              //   },
              // ),
              // TextField(
              //   decoration: InputDecoration(labelText: 'Water Intake (Liters)'),
              //   keyboardType: TextInputType.number,
              //   onChanged: (value) {
              //     waterIntake = double.tryParse(value) ?? 0.0;
              //   },
              // ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                Languages.of(context)!.cancel,
                style: TextStyle(color: ThemeManager.themeText),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 80,
                //height: 20,
                child: RoundButton(
                  title: Languages.of(context)!.submit,
                  type: RoundButtonType.bgGradient,
                  fontSize: AppFontSizes.smallDefault,
                  fontWeight: FontWeight.w400,
                  onPressed: () async {
                    if (SleepGoal > 0) {
                      // final waterData = {
                      //   'waterGoal': waterGoal,
                      //   'cupCapacity': cupCapacity,
                      //   // 'noOfCups': noOfCups,
                      //   // 'waterIntake': waterIntake,
                      // };
                      final success =
                          await _controller.ChangeSleepGoal(SleepGoal);

                      if (success) {
                        setState(() {
                          fitnessData.sleepGoal = SleepGoal.toString();
                          // loadData();
                        });
                        debugPrint('success level is $success');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 1500),
                            content: Text(Languages.of(context)!
                                .NINTextSubmittedSuccessfully1),
                            backgroundColor:
                                Colors.green, // Set the snackbar color to green
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                    } else {
                      // Show an error message or handle the validation failure.
                      // For example, you can display a snackbar or an error dialog.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          duration: const Duration(milliseconds: 1500),
                          content: Text(
                            Languages.of(context)!
                                .pleaseEnterValidValuesForAllFields,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            // TextButton(
            //   child: Text('Submit'),
            //   onPressed: () async {
            //     if (waterGoal > 0 &&
            //         cupCapacity > 0 &&
            //         noOfCups > 0 &&
            //         waterIntake > 0) {
            //       final waterData = {
            //         'waterGoal': waterGoal,
            //         'cupCapacity': cupCapacity,
            //         'noOfCups': noOfCups,
            //         'waterIntake': waterIntake,
            //       };
            //       final success = await _controller.SaveWaterData(waterData);

            //       if (success) {
            //         debugPrint('success level is $success');
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(
            //             content: Text('Heart level submitted successfully.'),
            //             backgroundColor:
            //                 Colors.green, // Set the snackbar color to green
            //           ),
            //         );
            //       }
            //       Navigator.of(context).pop();
            //     } else {
            //       // Show an error message or handle the validation failure.
            //       // For example, you can display a snackbar or an error dialog.
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content:
            //               Text('Please enter valid values for all fields.'),
            //         ),
            //       );
            //     }
            //   },
            // ),
          ],
        );
      },
    );
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
          Languages.of(context)!.headingSleepTracker,
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
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    TColor.primaryColor2.withOpacity(0.3),
                    TColor.primaryColor1.withOpacity(0.3)
                  ]),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Languages.of(context)!.labelSleepTarget,
                              style: TextStyle(
                                  color: ThemeManager.themeText,
                                  fontSize: AppFontSizes.mediumDefault,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Today",
                              style: TextStyle(
                                  color: ThemeManager.themeText,
                                  fontSize: AppFontSizes.mediumDefault,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          //  height: 25,
                          child: RoundButton(
                            title: Languages.of(context)!.labelChangeGoal,
                            type: RoundButtonType.bgGradient,
                            fontSize: AppFontSizes.smallDefault,
                            fontWeight: FontWeight.w400,
                            onPressed: () {
                              _showWaterDataModalPost(context);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: TColor.primaryG,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MaterialButton(
                                onPressed: () {
                                  // _showWaterDataModal(context);
                                  _showManualDurationDialog(context);
                                },
                                padding: EdgeInsets.zero,
                                height: 30,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                textColor: TColor.primaryColor1,
                                minWidth: double.maxFinite,
                                elevation: 0,
                                color: Colors.transparent,
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 15,
                                )),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: success != false
                    //       ? Text(
                    //           'Your Today total ${waterData.noOfCups} Cups of ${waterData.cupCapacity} ML',
                    //           style: TextStyle(
                    //               color: Color.fromARGB(255, 63, 137, 187)),
                    //         )
                    //       : Center(child: CircularProgressIndicator()),
                    // ),
                    Row(
                      children: [
                        Expanded(
                            child: TodayTargetCell(
                          icon: "assets/img/sleep.png",
                          value: "${fitnessData.sleepTime}  ",
                          title: Languages.of(context)!.labelTotalSleep,
                        )),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: TodayTargetCell(
                          icon: "assets/img/sleep.png",
                          value: "${fitnessData.sleepGoal} h",
                          title: Languages.of(context)!.labelSleepGoal,
                        )),
                        // Expanded(
                        //   child: TodayTargetCell(
                        //     icon: "assets/img/foot.png",
                        //     value: "2400",
                        //     title: "Foot Steps",
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: media.width * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Languages.of(context)!.labelSleepProgress,
                    style: TextStyle(
                        color: ThemeManager.themeText,
                        fontSize: AppFontSizes.mediumDefault,
                        fontWeight: FontWeight.w700),
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
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     Languages.of(context)!.labelWeekly,
                  //     textAlign: TextAlign.center,
                  //     style:
                  //         TextStyle(color: TColor.primaryColor1, fontSize: AppFontSizes.mediumDefault),
                  //   ),
                  // ),
                  // Container(
                  //     height: 30,
                  //     padding: EdgeInsets.symmetric(horizontal: 8),
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(colors: TColor.primaryG),
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     child: DropdownButtonHideUnderline(
                  //       child: DropdownButton(
                  //         dropdownColor: ThemeManager.themelightColor,
                  //         items: ["Weekly"]
                  //             .map((name) => DropdownMenuItem(
                  //                   value: name,
                  //                   child: Text(
                  //                     name,
                  //                     style: TextStyle(
                  //                         color: TColor.gray, fontSize: AppFontSizes.mediumDefault),
                  //                   ),
                  //                 ))
                  //             .toList(),
                  //         onChanged: (value) {},
                  //         // icon: Icon(Icons.expand_more,
                  //         //     color: ThemeManager.themeColor),
                  //         hint: Text(
                  //           Languages.of(context)!.labelWeekly,
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //               color: ThemeManager.themeText, fontSize: AppFontSizes.smallDefault,),
                  //         ),
                  //       ),
                  //     )),
                ],
              ),
              SizedBox(
                height: media.width * 0.05,
              ),
              // Center(
              //   child: DayWIseData.isNotEmpty
              //       ? Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: <Widget>[
              //             Container(
              //               height: media.width * 0.5,
              //               padding: EdgeInsets.symmetric(
              //                   vertical: 15, horizontal: 0),
              //               decoration: BoxDecoration(
              //                   color: ThemeManager.themeColor,
              //                   borderRadius: BorderRadius.circular(15),
              //                   boxShadow: [
              //                     BoxShadow(
              //                         color: ThemeManager.themelightColor,
              //                         blurRadius: 3)
              //                   ]),
              //               child: BarChart(BarChartData(
              //                 barTouchData: BarTouchData(
              //                   touchTooltipData: BarTouchTooltipData(
              //                     tooltipBgColor: Colors.grey,
              //                     tooltipHorizontalAlignment:
              //                         FLHorizontalAlignment.right,
              //                     tooltipMargin: 10,
              //                     getTooltipItem:
              //                         (group, groupIndex, rod, rodIndex) {
              //                       //   String weekDay;
              //                       // switch (group.x) {
              //                       //   case 0:
              //                       //     weekDay = 'Monday';
              //                       //     break;
              //                       //   case 1:
              //                       //     weekDay = 'Tuesday';
              //                       //     break;
              //                       //   case 2:
              //                       //     weekDay = 'Wednesday';
              //                       //     break;
              //                       //   case 3:
              //                       //     weekDay = 'Thursday';
              //                       //     break;
              //                       //   case 4:
              //                       //     weekDay = 'Friday';
              //                       //     break;
              //                       //   case 5:
              //                       //     weekDay = 'Saturday';
              //                       //     break;
              //                       //   case 6:
              //                       //     weekDay = 'Sunday';
              //                       //     break;
              //                       //   default:
              //                       //     throw Error();
              //                       // }
              //                       return BarTooltipItem(
              //                         '${DayWIseData[group.x]["date"]}\n',
              //                         TextStyle(
              //                           color: ThemeManager.themeText,
              //                           fontWeight: FontWeight.bold,
              //                           fontSize: AppFontSizes.mediumDefault,
              //                         ),
              //                         children: <TextSpan>[
              //                           TextSpan(
              //                             text: (rod.toY - 1).toString(),
              //                             style: TextStyle(
              //                               color: ThemeManager.themeColor,
              //                               fontSize: AppFontSizes.mediumDefault,
              //                               fontWeight: FontWeight.w500,
              //                             ),
              //                           ),
              //                         ],
              //                       );
              //                     },
              //                   ),
              //                   touchCallback:
              //                       (FlTouchEvent event, barTouchResponse) {
              //                     setState(() {
              //                       if (!event.isInterestedForInteractions ||
              //                           barTouchResponse == null ||
              //                           barTouchResponse.spot == null) {
              //                         touchedIndex = -1;
              //                         return;
              //                       }
              //                       touchedIndex = barTouchResponse
              //                           .spot!.touchedBarGroupIndex;
              //                     });
              //                   },
              //                 ),
              //                 titlesData: FlTitlesData(
              //                   show: true,
              //                   rightTitles: AxisTitles(
              //                     sideTitles: SideTitles(showTitles: false),
              //                   ),
              //                   topTitles: AxisTitles(
              //                     sideTitles: SideTitles(showTitles: false),
              //                   ),
              //                   bottomTitles: AxisTitles(
              //                     sideTitles: SideTitles(
              //                       showTitles: true,
              //                       getTitlesWidget: getTitles,
              //                       reservedSize: 38,
              //                     ),
              //                   ),
              //                   leftTitles: AxisTitles(
              //                     sideTitles: SideTitles(
              //                       showTitles: false,
              //                     ),
              //                   ),
              //                 ),
              //                 borderData: FlBorderData(
              //                   show: false,
              //                 ),
              //                 barGroups: showingGroups(),
              //                 gridData: FlGridData(show: false),
              //               )),
              //             ),
              //           ],
              //         )
              //       : CircularProgressIndicator(),
              // ),
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
                          double ratio;
                          try {
                            double sleepgoal =
                                double.parse(fitnessData.sleepGoal);
                            if (sleepgoal == 0) {
                              debugPrint(
                                  "dsvfdhfghngjmhg oip;op; ${fitnessData.sleepGoal}");
                              ratio = 0.0;
                            } else {
                              double numerator = data['value'].toDouble();
                              double denominatr = sleepgoal.toDouble() * 60;
                              debugPrint(
                                  "fgdgbfhngfjhjj ${data['value'].toDouble()} ${sleepgoal * 60}   ");
                              ratio = numerator / denominatr;
                              debugPrint(
                                  "fgdgbfhngfjhjj ${data['value'].toDouble()} ${sleepgoal * 60}   $ratio");
                            }
                          } catch (e) {
                            debugPrint("dsvfdhfghngjmhfghgfg $e");
                            // If an error occurs during parsing, set ratio to 1
                            ratio = 1.0;
                          }
                          // final double ratio =
                          //     data['value'].toDouble() / maxValue;
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
                                  convertMinutesToHoursMinutes((data['value']).toInt()),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppFontSizes.smallDefault,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  children: [
                                    SimpleAnimationProgressBar(
                                      height:
                                          150, // Set the height of the progress bar
                                      width:
                                          20, // Set the width of the progress bar
                                      backgroundColor:
                                          const Color.fromARGB(255, 221, 220, 220),
                                      // foregrondColor: index % 2 == 0
                                      //     ? TColor.primaryColor1
                                      //     : TColor.secondaryColor1,
                                      // foregrondColor: TColor.primaryColor1,
                                      foregrondColor: ratio > 0.99
                                          ? TColor.primaryColor1
                                          : TColor.secondaryColor1,
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
                          child: Text(
                            '      sleep in hours',
                            style: TextStyle(
                              fontSize: AppFontSizes
                                  .smallDefault, // Adjust the font size as needed
                              fontWeight: FontWeight.bold,
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
                                  minY: -30,
                                  maxY: 700,
                                  valuetype: "minutes",
                                  keyValuePairs: const {
                                    180: '3',
                                    360: '6',
                                    540: '9',
                                  }),
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
              //         minY: -30,
              //         maxY: 700,
              //         valuetype: "minutes",
              //         keyValuePairs: {
              //           180: '3 h',
              //           360: '6 h',
              //           540: '9 h',
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

  Future<void> _showManualDurationDialog(BuildContext context) async {
    // int manualDuration = 0;
    int manualHours = 0;
    int manualMinutes = 0;
    int totalManualDurationInMinutes = 0;
    void updateTotalManualDuration() {
      totalManualDurationInMinutes = manualHours * 60 + manualMinutes;
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var media = MediaQuery.of(context).size;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: ThemeManager.themelightColor,
              title: Text(
                Languages.of(context)!.labelSelectDate,
                style: TextStyle(color: ThemeManager.themeText),
              ),
              content: SizedBox(
                width: 300.0, // Set the width of the modal
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      Languages.of(context)!.labelSelectDate,
                      style: TextStyle(color: ThemeManager.themeText),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: media.width * 0.5,
                          child: Text(
                              "${Languages.of(context)!.TextAppSelectDate} : ${DateFormatter.convertDate(selectedDate)}"),
                        ),
                        IconButton(
                            onPressed: () async {
                              final DateTime now = DateTime.now();
                              final DateTime lastAllowedDate =
                                  now.subtract(const Duration(days: 7));

                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: _selectedDate,
                                firstDate: DateTime(2000),
                                lastDate:
                                    now, // Limit the maximum date to current date
                                selectableDayPredicate: (DateTime date) {
                                  return date.isAfter(lastAllowedDate) ||
                                      date.isAtSameMomentAs(lastAllowedDate) &&
                                          date.isBefore(now);
                                },
                              );

                              if (picked != null && picked != _selectedDate) {
                                setState(() {
                                  _selectedDate = picked;
                                  selectedDate =
                                      DateFormat("yyyy-MM-dd").format(picked);
                                });
                              }
                            },
                            icon: const Icon(Icons.date_range))
                      ],
                    ),
                    Row(
                      children: [
                        // Hours TextField
                        Flexible(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                manualHours = int.tryParse(value) ?? 0;
                                updateTotalManualDuration();
                              });
                            },
                            style: TextStyle(color: ThemeManager.themeText),
                            decoration: InputDecoration(
                              labelText: Languages.of(context)!.NINTextHours,
                            ),
                          ),
                        ),
                        const SizedBox(
                            width:
                                10), // Adjust the spacing between fields as needed
                        // Minutes TextField
                        Flexible(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                manualMinutes = int.tryParse(value) ?? 0;
                                updateTotalManualDuration();
                              });
                            },
                            style: TextStyle(color: ThemeManager.themeText),
                            decoration: InputDecoration(
                              labelText: Languages.of(context)!.NINTextMinutes,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    Languages.of(context)!.cancel,
                    style: TextStyle(color: ThemeManager.themeText),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    Languages.of(context)!.submit,
                    style: TextStyle(color: ThemeManager.themeText),
                  ),
                  onPressed: () async {
                    if (manualHours > 23 || manualMinutes > 59) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Alert'),
                            content: const Text(
                                'Hours must be less than 24 and minutes must be less than 60.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                    Navigator.of(context).pop();
                    await _updateSleepData(totalManualDurationInMinutes);

                    DateTime now = DateTime.now();
                    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

                    Map<String, dynamic> sleepData =
                        await _controller.fetchSleepData(formattedDate);

                    if (sleepData.isNotEmpty) {
                      // Code to execute if the map is empty
                      int durationInSeconds =
                          ((sleepData['duration'] / 1000000000).round() +
                                  (sleepData['manualDuration'] * 60))
                              .toInt();

                      Duration duration = Duration(seconds: durationInSeconds);
                      int hours = duration.inHours;
                      int minutes = (duration.inMinutes % 60);

                      fitnessData.sleepTime = '$hours h $minutes m';
                      // setState(() {
                      fitnessData.sleepTime = '$hours h $minutes m';
                      fetchDaywiseSleepData();
                      fetchDaywiseSleepData();
                      // });
                      debugPrint('The map is empty.');
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _updateSleepData(int manualDuration) async {
    Map<String, dynamic> sleepData = {
      "duration": "",
      "efficiency": "",
      "dateOfSleep": selectedDate,
      "manualDuration": manualDuration,
    };
    // Call your API to update sleep data using _controller.UpdateSleepData(sleepData)
    await _controller.UpdateSleepData(sleepData);
    debugPrint('Sleep data updated: $sleepData');
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
