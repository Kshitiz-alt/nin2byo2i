import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/DateFormatter.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/controller/user_profile_controller.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/OtherActivity/ActitivityDiary.dart';
import 'package:nin2byo2i/view/home/PieChartSample2.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:intl/intl.dart';

//from this page user can see the todays activity data
class ToadyActivity extends StatefulWidget {
  const ToadyActivity({super.key});

  @override
  _ToadyActivityState createState() => _ToadyActivityState();
}

class _ToadyActivityState extends State<ToadyActivity> {
  // List<dynamic> healthData = []; // Holds the fetched health data
  // DateTime startDate = DateTime.now();
  // DateTime endDate = DateTime.now();

  // @override
  // void initState() {
  //   super.initState();
  //   _loadData();
  // }

  // double convertMinutesToHours(double minutes) {
  //   // 1 hour = 60 minutes
  //   const double minutesInAnHour = 60.0;
  //   // Calculate hours by dividing minutes by minutes in an hour
  //   double hours = minutes / minutesInAnHour;
  //   return hours;
  // }

  // Future<void> _loadData() async {
  //   // Example date range
  //   String startDateFormatted =
  //       "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";
  //   String endDateFormatted =
  //       "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";

  //   // Correctly fetching and casting the data as a List<dynamic>
  //   List<dynamic> data = await UserProfileController.fetchHealthDashboardData(
  //       startDateFormatted, endDateFormatted);
  //   debugPrint("dsgdfhdgjgghkh $data   $startDateFormatted $endDateFormatted");
  //   setState(() {
  //     healthData =
  //         data; // No need for casting here, as data is already List<dynamic>
  //     final item = healthData[0];
  //     List<dynamic> exerciseData = item['exerciseData'] ?? [];
  //     dataMap["Sleep"] = item['duration'] + item['manualDuration'];
  //     dataMap["Activity"] = 0;

  //     for (var exercise in exerciseData) {
  //       dataMap["Activity"] =
  //           exercise["exerciseDuration"] + dataMap["Activity"];
  //     }
  //     dataMap["Sleep"] = double.parse(
  //         convertMinutesToHours(dataMap["Sleep"]!).toStringAsFixed(2));
  //     dataMap["Activity"] = double.parse(
  //         convertMinutesToHours(dataMap["Activity"]!).toStringAsFixed(2));
  //     dataMap["Others"] = double.parse(
  //         (24 - dataMap["Sleep"]! - dataMap["Activity"]!).toStringAsFixed(2));
  //     setState(() {});
  //   });
  // }

  // Map<String, double> dataMap = {
  //   'Sleep': 0,
  //   'Activity': 0,
  //   'Others': 0, // Total hours minus sleep and activity
  // };

  // List<Color> colorList = [
  //   Colors.blueAccent,
  //   Colors.greenAccent,
  //   Colors.redAccent,
  // ];
  // String formatTime(double totalMinutes) {
  //   // Check if totalMinutes is effectively zero (considering floating point precision issues)
  //   if (totalMinutes < 0.01) {
  //     return "0 h";
  //   }

  //   // Calculate the number of hours
  //   int hours = totalMinutes ~/ 60; // Using integer division to get whole hours
  //   // Calculate the remaining minutes by first finding the total number of minutes as an integer
  //   int minutes =
  //       (totalMinutes % 60).round(); // Round the result to get a whole number

  //   // Check if hours is zero, if yes, return only minutes
  //   if (hours == 0) {
  //     return "$minutes ${Languages.of(context)!.NINTextMinutes}";
  //   }

  //   // If hours is not zero, return hours and minutes
  //   return "$hours h $minutes m";
  // }

  // @override
  // Widget build(BuildContext context) {
  //   var media = MediaQuery.of(context).size;
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: ThemeManager.themeColor,
  //       centerTitle: true,
  //       elevation: 0,
  //       leading: InkWell(
  //         onTap: () {
  //           Navigator.pop(context);
  //         },
  //         child: Container(
  //           margin: const EdgeInsets.all(8),
  //           height: 40,
  //           width: 40,
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //               color: ThemeManager.themelightColor,
  //               borderRadius: BorderRadius.circular(10)),
  //           child: Image.asset(
  //             "assets/img/black_btn.png", // Replace with your health app logo asset path
  //             width: 15,
  //             height: 15,
  //             color: ThemeManager.themeText,
  //             fit: BoxFit.contain,
  //           ),
  //         ),
  //       ),
  //       title: Text(
  //         Languages.of(context)!.TextApp1MyActivity,
  //         style: TextStyle(
  //             color: ThemeManager.themeText,
  //             fontSize: AppFontSizes.mediumDefault,
  //             fontWeight: FontWeight.w700),
  //       ),
  //       actions: [
  //         Center(
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //             child: Material(
  //               color: Colors.transparent,
  //               child: InkWell(
  //                 onTap: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => HealthDashboardPage(),
  //                     ),
  //                   );
  //                   // Add your action here
  //                 },
  //                 borderRadius: BorderRadius.circular(20), // Border radius
  //                 splashColor: Colors.blue, // Splash color
  //                 child: Container(
  //                   padding: EdgeInsets.all(12),
  //                   decoration: BoxDecoration(
  //                     border: Border.all(color: Colors.blue), // Border color
  //                     borderRadius: BorderRadius.circular(20), // Border radius
  //                   ),
  //                   child: Text(
  //                     Languages.of(context)!.TextAppCheckOthersDates,
  //                     style: TextStyle(
  //                       color: ThemeManager.themeText,
  //                     ), // Text color
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //     backgroundColor: ThemeManager.themeColor,
  //     body: Container(
  //       // padding: EdgeInsets.all(16.0),
  //       decoration: BoxDecoration(
  //         color: ThemeManager.themeColor, // Set the background color
  //         borderRadius: BorderRadius.circular(10.0), // Set the border radius
  //       ),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: [
  //             sizedBox12(),
  //             Column(
  //               children: List.generate(
  //                 healthData.length,
  //                 (index) {
  //                   final item = healthData[index];
  //                   List<dynamic> exerciseData = item['exerciseData'] ?? [];
  //                   dataMap["Sleep"] =
  //                       item['duration'] + item['manualDuration'];
  //                   dataMap["Activity"] = 0;

  //                   for (var exercise in exerciseData) {
  //                     dataMap["Activity"] =
  //                         exercise["exerciseDuration"] + dataMap["Activity"];
  //                   }
  //                   dataMap["Sleep"] = double.parse(
  //                       convertMinutesToHours(dataMap["Sleep"]!)
  //                           .toStringAsFixed(2));
  //                   dataMap["Activity"] = double.parse(
  //                       convertMinutesToHours(dataMap["Activity"]!)
  //                           .toStringAsFixed(2));
  //                   dataMap["Others"] = double.parse(
  //                       (24 - dataMap["Sleep"]! - dataMap["Activity"]!)
  //                           .toStringAsFixed(2));
  //                   setState(() {});

  //                   debugPrint("dfgdfghfhfghgf $dataMap");
  //                   return Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         decoration: BoxDecoration(
  //                           color: TColor.primaryColor1.withOpacity(0.2),
  //                           borderRadius: BorderRadius.only(
  //                             // topLeft: Radius.circular(20),
  //                             // topRight: Radius.circular(20),
  //                             bottomLeft: Radius.circular(50),
  //                             bottomRight: Radius.circular(50),
  //                           ),
  //                         ),
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(
  //                               left: 8.0, right: 8, top: 4),
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                             children: [
  //                               SizedBox(
  //                                 height: 5,
  //                               ),
  //                               Row(
  //                                 mainAxisAlignment: MainAxisAlignment.start,
  //                                 children: [
  //                                   Icon(
  //                                     Icons.date_range,
  //                                     color: Colors.black,
  //                                   ),
  //                                   SizedBox(
  //                                     width: 5,
  //                                   ),
  //                                   Center(
  //                                     child: Container(
  //                                         child: Text(
  //                                       '${Languages.of(context)!.mainlabelDate}: ${DateFormatter.convertDate(item['date'])}',
  //                                       style: TextStyle(
  //                                           fontSize:
  //                                               AppFontSizes.mediumDefault,
  //                                           color: Colors.black),
  //                                     )),
  //                                   ),
  //                                   // SizedBox(width: 5),
  //                                   // Text(
  //                                   //   Languages.of(context)!
  //                                   //       .TextAppYour24HoursChart,
  //                                   //   style: TextStyle(
  //                                   //       fontSize: AppFontSizes.mediumDefault,
  //                                   //       color: Colors.black),
  //                                   // ),
  //                                   SizedBox(
  //                                     width: 10,
  //                                   )
  //                                 ],
  //                               ),
  //                               Center(
  //                                 child: PieChartSample2(
  //                                   value1: dataMap["Sleep"] ??
  //                                       0, // Example values: 50%
  //                                   value2: dataMap["Others"] ??
  //                                       0, // Example values: 30%
  //                                   value3: dataMap["Activity"] ?? 0,
  //                                 ),
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   // Center(
  //                                   //   child: PieChart(
  //                                   //     dataMap: dataMap,
  //                                   //     colorList: colorList,
  //                                   //     ringStrokeWidth: 30,
  //                                   //     chartType: ChartType.ring,
  //                                   //     chartRadius: MediaQuery.of(context)
  //                                   //             .size
  //                                   //             .width /
  //                                   //         3,
  //                                   //     legendOptions: LegendOptions(
  //                                   //       showLegends:
  //                                   //           false, // This line hides the color indicator details
  //                                   //     ),
  //                                   //     chartValuesOptions:
  //                                   //         ChartValuesOptions(
  //                                   //       showChartValues: true,
  //                                   //       showChartValuesOutside: false,
  //                                   //       chartValueBackgroundColor:
  //                                   //           Colors.transparent,
  //                                   //       showChartValueBackground: false,
  //                                   //       showChartValuesInPercentage: true,
  //                                   //       decimalPlaces: 1,
  //                                   //     ),
  //                                   //   ),
  //                                   // ),
  //                                   SizedBox(width: 20),
  //                                   Row(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.center,
  //                                     children: [
  //                                       // Row(
  //                                       //   mainAxisAlignment:
  //                                       //       MainAxisAlignment.end,
  //                                       //   children: [
  //                                       //     Center(
  //                                       //       child: Container(
  //                                       //           child: Text(
  //                                       //         '${Languages.of(context)!.mainlabelDate}: ${item['date']}',
  //                                       //         style: TextStyle(
  //                                       //             fontSize: AppFontSizes
  //                                       //                 .mediumDefault,
  //                                       //             color: Colors.black),
  //                                       //       )),
  //                                       //     ),
  //                                       //     SizedBox(
  //                                       //       width: 10,
  //                                       //     )
  //                                       //   ],
  //                                       // ),
  //                                       // sizedBox12(),
  //                                       // Row(
  //                                       //   mainAxisAlignment:
  //                                       //       MainAxisAlignment.center,
  //                                       //   children: [
  //                                       //     SizedBox(width: 5),
  //                                       //     Text(
  //                                       //       Languages.of(context)!
  //                                       //           .TextAppYour24HoursChart,
  //                                       //       style: TextStyle(
  //                                       //           fontSize: AppFontSizes
  //                                       //               .mediumDefault,
  //                                       //           color: Colors.black),
  //                                       //     ),
  //                                       //   ],
  //                                       // ),
  //                                       SizedBox(
  //                                         height: 5,
  //                                       ),
  //                                       Row(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.spaceBetween,
  //                                         children: [
  //                                           Container(
  //                                             width: 10,
  //                                             height: 10,
  //                                             decoration: BoxDecoration(
  //                                               shape: BoxShape.circle,
  //                                               color: Color(
  //                                                   0xFFF03C59), // Color for Sleep
  //                                             ),
  //                                           ),
  //                                           SizedBox(width: 5),
  //                                           SizedBox(
  //                                             width: media.width * 0.25,
  //                                             child: Text(
  //                                               '${Languages.of(context)!.labelSleep}: ${dataMap["Sleep"]} h',
  //                                               style: TextStyle(
  //                                                   fontSize: AppFontSizes
  //                                                       .mediumDefault,
  //                                                   color: Colors.black),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       SizedBox(width: 5),
  //                                       Row(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.center,
  //                                         children: [
  //                                           Container(
  //                                             width: 10,
  //                                             height: 10,
  //                                             decoration: BoxDecoration(
  //                                               shape: BoxShape.circle,
  //                                               color: Color(
  //                                                   0xFFFF9900), // Color for Activity
  //                                             ),
  //                                           ),
  //                                           SizedBox(width: 5),
  //                                           SizedBox(
  //                                             width: media.width * 0.25,
  //                                             child: Text(
  //                                               '${Languages.of(context)!.TextAppActivity}: ${dataMap["Activity"]} h',
  //                                               style: TextStyle(
  //                                                   fontSize: AppFontSizes
  //                                                       .mediumDefault,
  //                                                   color: Colors.black),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       SizedBox(width: 5),
  //                                       Row(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.center,
  //                                         children: [
  //                                           Container(
  //                                             width: 10,
  //                                             height: 10,
  //                                             decoration: BoxDecoration(
  //                                               shape: BoxShape.circle,
  //                                               color: Color.fromARGB(
  //                                                   255,
  //                                                   34,
  //                                                   104,
  //                                                   161), // Color for Others
  //                                             ),
  //                                           ),
  //                                           SizedBox(width: 5),
  //                                           SizedBox(
  //                                             width: media.width * 0.25,
  //                                             child: Text(
  //                                               '${Languages.of(context)!.TextAppOthers}: ${dataMap["Others"]} h',
  //                                               style: TextStyle(
  //                                                   fontSize: AppFontSizes
  //                                                       .mediumDefault,
  //                                                   color: Colors.black),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ],
  //                                   )
  //                                 ],
  //                               ),
  //                               sizedBox12(),
  //                               Row(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceAround,
  //                                 children: [
  //                                   _buildColumn(
  //                                       Icons.directions_walk,
  //                                       '${Languages.of(context)!.numberOfSteps} ',
  //                                       '${item['steps']} ${Languages.of(context)!.ninTextSteps}'),
  //                                   _buildColumn(
  //                                       Icons.local_fire_department,
  //                                       Languages.of(context)!
  //                                           .TextAppCaloriesBurn,
  //                                       '${item['calory'].toStringAsFixed(0)} Kcal'),
  //                                   _buildColumn(
  //                                       Icons.access_time,
  //                                       Languages.of(context)!.labelSleep,
  //                                       '${formatTime(item['duration'] + item['manualDuration'])}'),
  //                                 ],
  //                               ),
  //                               sizedBox30()
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       sizedBox12(),
  //                       if (exerciseData.isNotEmpty)
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             Languages.of(context)!.TextAppExerciseDetails,
  //                             style: TextStyle(
  //                               fontSize: AppFontSizes.extraLargeDefault,
  //                               color: ThemeManager.themeText,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ),
  //                       if (exerciseData.isEmpty)
  //                         Center(
  //                           child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(
  //                               Languages.of(context)!.ninTextNoExercise,
  //                               style: TextStyle(
  //                                 fontSize: AppFontSizes.extraLargeDefault,
  //                                 color: ThemeManager.themeText,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             for (var exercise in exerciseData)
  //                               Container(
  //                                 // height: 40,
  //                                 width:
  //                                     MediaQuery.of(context).size.width * 0.92,
  //                                 padding: EdgeInsets.symmetric(
  //                                   vertical: 4.0,
  //                                   horizontal: 8.0,
  //                                 ),
  //                                 margin: EdgeInsets.only(
  //                                   left: 8.0,
  //                                   top: 2.0,
  //                                   bottom: 2.0,
  //                                 ),
  //                                 decoration: BoxDecoration(
  //                                   color: TColor.primaryColor1.withOpacity(
  //                                       0.2), // Set the color for each exercise
  //                                   borderRadius: BorderRadius.circular(
  //                                     20.0,
  //                                   ), // Set the border radius for each exercise container
  //                                 ),
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.all(8.0),
  //                                   child: Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text(
  //                                         '${Languages.of(context)!.TextAppActivityType} : ${exercise["activityType"]} ',
  //                                         style: TextStyle(
  //                                           color: Colors.black,
  //                                           fontSize:
  //                                               AppFontSizes.mediumDefault,
  //                                         ),
  //                                       ),
  //                                       Text(
  //                                         '${Languages.of(context)!.TextAppDuration} : ${formatTime(exercise["exerciseDuration"])} ',
  //                                         style: TextStyle(
  //                                           color: Colors.black,
  //                                           fontSize:
  //                                               AppFontSizes.mediumDefault,
  //                                         ),
  //                                       ),
  //                                       Text(
  //                                         '${Languages.of(context)!.TextAppCaloriesBurn} : ${tryConvertToString(exercise["caloriesBurned"])} ${Languages.of(context)!.ninTextKcal} ',
  //                                         style: TextStyle(
  //                                           color: Colors.black,
  //                                           fontSize:
  //                                               AppFontSizes.mediumDefault,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                           ],
  //                         ),
  //                       )
  //                     ],
  //                   );
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // String tryConvertToString(dynamic value) {
  //   try {
  //     double doubleValue;
  //     if (value is String) {
  //       doubleValue = double.parse(value);
  //     } else if (value is int || value is double) {
  //       doubleValue = value.toDouble();
  //     } else {
  //       throw FormatException('Cannot convert value to double');
  //     }

  //     return doubleValue.toStringAsFixed(doubleValue >= 99 ? 0 : 2);
  //   } catch (e) {
  //     debugPrint('Error: $e');
  //     return value;
  //   }
  // }

  // Widget _buildColumn(IconData icon, String label, String value) {
  //   var media = MediaQuery.of(context).size;
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Icon(icon),
  //       SizedBox(
  //         width: media.width * 0.3,
  //         child: Center(
  //           child: Text(
  //             label,
  //             style: TextStyle(
  //               fontSize: AppFontSizes.mediumDefault,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         width: media.width * 0.3,
  //         child: Center(
  //           child: Text(
  //             value,
  //             style: TextStyle(
  //               fontSize: AppFontSizes.mediumDefault,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  String yesterdaydate = '';
  @override
  void initState() {
    super.initState();
    fetchData0();
    DateTime now = DateTime.now();

    // Subtract one day to get yesterday's date
    DateTime yesterday = now.subtract(const Duration(days: 1));

    // Format the date as yyyy-MM-dd
    yesterdaydate = DateFormat('yyyy-MM-dd').format(yesterday);
  }

  List<Color> colorList = [
    const Color(0xFFFF9900),
    const Color.fromARGB(255, 34, 104, 161)
  ];
  String formattedDate = "2024-01-01";
  double restDuration = 0.0;
  double totalDuration = 0.0;
  double energyBalance = 0.0;
  double totalCaloriesExpenditure = 0.0;
  double mealEnergy = 0.0;
  List<dynamic> exerciseDetails = [];

  Future<void> fetchData0() async {
    DateTime today = DateTime.now();
    // DateTime yesterday =
    //     today.subtract(Duration(days: 1)); // Subtract 1 day from today

    // Format yesterday's date in "yyyy-MM-dd" format
    formattedDate = DateFormat('yyyy-MM-dd').format(today);
    final data = await UserProfileController.fetchCaloriesBurnedAndEnergyIntake(
      formattedDate,
    );
    setState(() {
      energyBalance = data?['energyBalance'] ?? 0.0;
      totalCaloriesExpenditure = data?['totalCaloriesExpenditure'] ?? 0.0;
      mealEnergy = data?['totalEnergyIntake'][0]['mealEnergy'] ?? 0.0;
      restDuration = data?['restDuration'] ?? 0.0;
      totalDuration = data?['totalDuration'] ?? 0.0;
      restDuration = restDuration;
      totalDuration = data?['totalDuration'] ?? 0.0;
      exerciseDetails = data?['exerciseDetails'] ?? [];
      dataMap['Activity'] = totalDuration;
      dataMap['Others'] = restDuration;
    });
  }

  String formatTime(double totalMinutes) {
    // Check if totalMinutes is effectively zero (considering floating point precision issues)
    if (totalMinutes < 0.01) {
      return "0 h";
    }

    // Calculate the number of hours
    int hours = totalMinutes ~/ 60; // Using integer division to get whole hours
    // Calculate the remaining minutes by first finding the total number of minutes as an integer
    int minutes =
        (totalMinutes % 60).round(); // Round the result to get a whole number

    // Check if hours is zero, if yes, return only minutes
    if (hours == 0) {
      return "$minutes ${Languages.of(context)!.NINTextMinutes}";
    }

    // If hours is not zero, return hours and minutes
    return "$hours h $minutes m";
  }

  Map<String, double> dataMap = {
    'Activity': 14,
    'Others': 10,
  };
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeManager.themeColor,
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
              "assets/img/black_btn.png", // Replace with your health app logo asset path
              width: 15,
              height: 15,
              color: ThemeManager.themeText,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.TextApp1MyActivity,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HealthDashboardPage(),
                      ),
                    );
                    // Add your action here
                  },
                  borderRadius: BorderRadius.circular(20), // Border radius
                  splashColor: Colors.blue, // Splash color
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue), // Border color
                      borderRadius: BorderRadius.circular(20), // Border radius
                    ),
                    child: Text(
                      Languages.of(context)!.TextAppCheckOthersDates,
                      style: TextStyle(
                        color: ThemeManager.themeText,
                      ), // Text color
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: TColor.primaryColor1.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  // topLeft: Radius.circular(20),
                  // topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.date_range,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Center(
                        child: Container(
                            child: Text(
                          '${Languages.of(context)!.mainlabelDate}: ${DateFormatter.convertDate(yesterdaydate)}',
                          style: const TextStyle(
                              fontSize: AppFontSizes.mediumDefault,
                              color: Colors.black),
                        )),
                      ),
                      // SizedBox(width: 5),
                      // Text(
                      //   Languages.of(context)!
                      //       .TextAppYour24HoursChart,
                      //   style: TextStyle(
                      //       fontSize: AppFontSizes.mediumDefault,
                      //       color: Colors.black),
                      // ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  // if (restDuration > 0)
                  //   Center(
                  //     child: PieChartSample2(
                  //       value1: 0 ?? 0, // Example values: 50%
                  //       value2: restDuration ?? 0, // Example values: 30%
                  //       value3: restDuration ?? 0,
                  //     ),
                  //   ),
                  PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 50,
                    chartRadius: MediaQuery.of(context).size.width / 1.5,
                    colorList: colorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.disc,
                    ringStrokeWidth: 32,
                    centerText:
                        "Total\n${(dataMap['Activity']! + dataMap['Others']!).toStringAsFixed(1)} hours",
                    legendOptions: const LegendOptions(
                      showLegendsInRow: true,
                      legendPosition: LegendPosition.bottom,
                      showLegends: true,
                      legendShape: BoxShape.circle,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                  ),
                  SizedBox(
                    width: media.width * 0.93,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Color(0xFFFF9900), // Color for Activity
                                ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                width: media.width * 0.35,
                                child: Text(
                                  '${Languages.of(context)!.TextAppActivity}: ${totalDuration.toStringAsFixed(totalDuration >= 99 ? 0 : 2)} h',
                                  style: const TextStyle(
                                      fontSize: AppFontSizes.mediumDefault,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(
                                        255, 34, 104, 161) // Color for Others
                                    ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                width: media.width * 0.35,
                                child: Text(
                                  '${Languages.of(context)!.TextAppOthers}: ${restDuration.toStringAsFixed(restDuration >= 99 ? 0 : 2)} h h',
                                  style: const TextStyle(
                                      fontSize: AppFontSizes.mediumDefault,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Row(
                        //   children: [
                        //     Icon(Icons.local_fire_department,
                        //         size:
                        //             18), // Assuming 'local_fire_department' is your desired calories icon
                        //     SizedBox(
                        //         width:
                        //             5), // Adjust the spacing between icon and text as needed
                        //     Text(
                        //       '${Languages.of(context)!.totalEnergyConsumption} : ${mealEnergy.toStringAsFixed(mealEnergy >= 99 ? 0 : 2)}',
                        //       style: TextStyle(fontSize: 18),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Icon(Icons.local_fire_department, size: 18),
                        //     SizedBox(width: 5),
                        //     Text(
                        //       '${Languages.of(context)!.totalEnergyExpenditure} : ${totalCaloriesExpenditure.toStringAsFixed(totalCaloriesExpenditure >= 99 ? 0 : 2)}',
                        //       style: TextStyle(fontSize: 18),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Icon(Icons.local_fire_department, size: 18),
                        //     SizedBox(width: 5),
                        //     Text(
                        //       '${Languages.of(context)!.energybalance}: ${energyBalance.toStringAsFixed(energyBalance >= 99 ? 0 : 2)}',
                        //       style: TextStyle(fontSize: 18),
                        //     ),
                        //   ],
                        // ),

                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildColumn(
                                Icons.local_fire_department,
                                Languages.of(context)!.totalEnergyConsumption,
                                '${mealEnergy.toStringAsFixed(mealEnergy >= 99 ? 0 : 2)} Kcal'),
                            _buildColumn(
                                Icons.local_fire_department,
                                "${Languages.of(context)!.totalEnergyExpenditure} ",
                                '${totalCaloriesExpenditure.toStringAsFixed(totalCaloriesExpenditure >= 99 ? 0 : 2)} Kcal'),
                            _buildColumn(
                                Icons.local_fire_department,
                                Languages.of(context)!.energybalance,
                                '${energyBalance.toStringAsFixed(energyBalance >= 99 ? 0 : 2)} Kcal'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            if (exerciseDetails.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Languages.of(context)!.TextAppExerciseDetails,
                  style: TextStyle(
                    fontSize: AppFontSizes.extraLargeDefault,
                    color: ThemeManager.themeText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (exerciseDetails.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Languages.of(context)!.ninTextNoExercise,
                    style: TextStyle(
                      fontSize: AppFontSizes.extraLargeDefault,
                      color: ThemeManager.themeText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            for (var exercise in exerciseDetails)
              Container(
                // height: 40,
                width: MediaQuery.of(context).size.width * 0.92,
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 8.0,
                ),
                margin: const EdgeInsets.only(
                  left: 8.0,
                  top: 2.0,
                  bottom: 2.0,
                ),
                decoration: BoxDecoration(
                  color: TColor.primaryColor1
                      .withOpacity(0.2), // Set the color for each exercise
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ), // Set the border radius for each exercise container
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${Languages.of(context)!.TextAppActivityType}: ${exercise["activityType"]}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: AppFontSizes.mediumDefault,
                        ),
                      ),
                      Text(
                        '${Languages.of(context)!.TextAppDuration} : ${formatTime(exercise["exerciseDuration"])} ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: AppFontSizes.mediumDefault,
                        ),
                      ),
                      Text(
                        '${Languages.of(context)!.TextAppCaloriesBurn} : ${exercise["caloriesBurned"].toStringAsFixed(exercise["caloriesBurned"] >= 99 ? 0 : 2)} ${Languages.of(context)!.ninTextKcal}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: AppFontSizes.mediumDefault,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: exerciseDetails.length,
            //     itemBuilder: (context, index) {
            //       final exercise = exerciseDetails[index];
            //       return ListTile(
            //         // title: Text('Exercise ${index + 1}'),
            //         subtitle: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Container(
            //               // height: 40,
            //               width: MediaQuery.of(context).size.width * 0.92,
            //               padding: EdgeInsets.symmetric(
            //                 vertical: 4.0,
            //                 horizontal: 8.0,
            //               ),
            //               margin: EdgeInsets.only(
            //                 left: 8.0,
            //                 top: 2.0,
            //                 bottom: 2.0,
            //               ),
            //               decoration: BoxDecoration(
            //                 color: TColor.primaryColor1.withOpacity(
            //                     0.2), // Set the color for each exercise
            //                 borderRadius: BorderRadius.circular(
            //                   20.0,
            //                 ), // Set the border radius for each exercise container
            //               ),
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       '${Languages.of(context)!.TextAppActivityType}: ${exercise["activityType"]}',
            //                       style: TextStyle(
            //                         color: Colors.black,
            //                         fontSize: AppFontSizes.mediumDefault,
            //                       ),
            //                     ),
            //                     Text(
            //                       '${Languages.of(context)!.TextAppDuration} : ${formatTime(exercise["exerciseDuration"])} ',
            //                       style: TextStyle(
            //                         color: Colors.black,
            //                         fontSize: AppFontSizes.mediumDefault,
            //                       ),
            //                     ),
            //                     Text(
            //                       '${Languages.of(context)!.TextAppCaloriesBurn} : ${exercise["caloriesBurned"].toStringAsFixed(exercise["caloriesBurned"] >= 99 ? 0 : 2)} ${Languages.of(context)!.ninTextKcal}',
            //                       style: TextStyle(
            //                         color: Colors.black,
            //                         fontSize: AppFontSizes.mediumDefault,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumn(IconData icon, String label, String value) {
    var media = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon),
        SizedBox(
          width: media.width * 0.3,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: AppFontSizes.mediumDefault,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: media.width * 0.3,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: AppFontSizes.mediumDefault,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
