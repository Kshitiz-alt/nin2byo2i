import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/DateFormatter.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/controller/user_profile_controller.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/OtherActivity/CustomIndividualActivitydatepage.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

import 'package:nin2byo2i/view/OtherActivity/testing.dart';
import 'package:nin2byo2i/view/home/PieChartSample2.dart';
import 'package:pie_chart/pie_chart.dart';

//from here user can see their all activity history
class HealthDashboardPage extends StatefulWidget {
  const HealthDashboardPage({super.key});

  @override
  _HealthDashboardPageState createState() => _HealthDashboardPageState();
}

class _HealthDashboardPageState extends State<HealthDashboardPage> {
  // List<dynamic> healthData = []; // Holds the fetched health data
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  List<Map<String, dynamic>> exerciseData = [];
  Future<void> _loadData() async {
    // Example date range
    String startDateFormatted =
        "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";
    String endDateFormatted =
        "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";
    try {
      List<Map<String, dynamic>> data = await ExerciseAPI.fetchExerciseData(
          startDateFormatted, endDateFormatted);

      setState(() {
        exerciseData = data;
      });
    } catch (e) {
      // Handle error, e.g., show an error message
      debugPrint('Error fetching exercise data: $e');
    }

    // Correctly fetching and casting the data as a List<dynamic>
    // List<dynamic> data = await UserProfileController.fetchHealthDashboardData(
    //     startDateFormatted, endDateFormatted);
    // debugPrint("hgghjmhgjkhkh $data   $startDateFormatted $endDateFormatted");
    // setState(() {
    //   healthData =
    //       data; // No need for casting here, as data is already List<dynamic>
    // });
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
      return "$minutes min";
    }

    // If hours is not zero, return hours and minutes
    return "$hours hours $minutes min";
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              primaryColor: ThemeManager
                  .themelightColor, // Background color of the header

              colorScheme: ColorScheme.dark(
                primary:
                    TColor.primaryColor1, // Background color of the calendar
                onPrimary: Colors.white, // Text color of the calendar
                surface: TColor.primaryColor1, // Background color of the modal
                onSurface: Colors.white, // Text color of the modal
              ), // Background color of the modal
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: TColor.primaryColor1, // Color of the "OK" button
                ),
              ), dialogTheme: DialogThemeData(backgroundColor: Color.fromARGB(
                  255, 91, 92, 92)),
            ),
            child: child!,
          );
        });
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        _loadData();
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              primaryColor: ThemeManager
                  .themelightColor, // Background color of the header

              colorScheme: ColorScheme.dark(
                primary:
                    TColor.primaryColor1, // Background color of the calendar
                onPrimary: Colors.white, // Text color of the calendar
                surface: TColor.primaryColor1, // Background color of the modal
                onSurface: Colors.white, // Text color of the modal
              ), // Background color of the modal
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: TColor.primaryColor1, // Color of the "OK" button
                ),
              ), dialogTheme: DialogThemeData(backgroundColor: Color.fromARGB(
                  255, 91, 92, 92)),
            ),
            child: child!,
          );
        });
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
        _loadData();
      });
    }
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
              "assets/img/black_btn.png", // Replace with your health app logo asset path
              width: 15,
              height: 15,
              color: ThemeManager.themeText,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.TextAppMyActivityOfCustomDates,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: ThemeManager.themeColor, // Set the background color
          borderRadius: BorderRadius.circular(10.0), // Set the border radius
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => _selectStartDate(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 189, 20, 124),
                          borderRadius: BorderRadius.circular(
                              10), // Example border radius
                        ),
                        padding: const EdgeInsets.all(10), // Example padding
                        child: Column(
                          children: [
                            SizedBox(
                              width: media.width * 0.3,
                              child: Text(
                                " ${DateFormatter.convertDate("${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}")}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.3,
                              child: Text(
                                Languages.of(context)!.ninTextSelectStartDate,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _selectEndDate(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 189, 20, 124),
                          borderRadius: BorderRadius.circular(
                              10), // Example border radius
                        ),
                        padding: const EdgeInsets.all(10), // Example padding
                        child: Column(
                          children: [
                            SizedBox(
                              width: media.width * 0.3,
                              child: Text(
                                " ${DateFormatter.convertDate("${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}")}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.3,
                              child: Text(
                                Languages.of(context)!.ninTextSelectEndDate,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              sizedBox12(),
              Column(
                children: [
                  for (int i = 0; i < exerciseData.length; i++)
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8, top: 4),
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: TColor.primaryColor1.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: SizedBox(
                                //     width: media.width * 0.7,
                                //     child: Text(
                                //         'Total Calories Expenditure: ${exerciseData[i]['totalCaloriesExpenditure']}'),
                                //   ),
                                // ),

                                ...exerciseData[i]['totalEnergyIntake']
                                    .map<Widget>((entry) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.local_fire_department),
                                          const SizedBox(width: 8.0),
                                          SizedBox(
                                            width: media.width * 0.6,
                                            child: Text(
                                              'Date: ${entry['date']}',
                                              style: const TextStyle(
                                                  fontSize: AppFontSizes
                                                      .mediumDefault,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.local_fire_department),
                                          const SizedBox(width: 8.0),
                                          SizedBox(
                                            width: media.width * 0.6,
                                            child: Text(
                                              '${Languages.of(context)!.totalEnergyConsumption}: ${entry['mealEnergy'].toStringAsFixed(entry['mealEnergy'] >= 99 ? 0 : 2)}Kcal ',
                                              style: const TextStyle(
                                                  fontSize: AppFontSizes
                                                      .mediumDefault,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }).toList(),
                                Row(
                                  children: [
                                    const Icon(Icons.local_fire_department),
                                    const SizedBox(width: 8.0),
                                    SizedBox(
                                      width: media.width * 0.6,
                                      child: Text(
                                        '${Languages.of(context)!.totalEnergyExpenditure} : ${exerciseData[i]['totalCaloriesExpenditure'].toStringAsFixed(exerciseData[i]['totalCaloriesExpenditure'] >= 99 ? 0 : 2)} Kcal',
                                        style: const TextStyle(
                                            fontSize:
                                                AppFontSizes.mediumDefault,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.local_fire_department),
                                    const SizedBox(width: 8.0),
                                    SizedBox(
                                      width: media.width * 0.6,
                                      child: Text(
                                        '${Languages.of(context)!.energybalance}: ${exerciseData[i]['energyBalance'].toStringAsFixed(exerciseData[i]['energyBalance'] >= 99 ? 0 : 2)} Kcal ',
                                        style: const TextStyle(
                                            fontSize:
                                                AppFontSizes.mediumDefault,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Icon(Icons.access_time),
                                //     SizedBox(width: 8.0),
                                //     SizedBox(
                                //       width: media.width * 0.6,
                                //       child: Text(
                                //         '${Languages.of(context)!.labelSleep} ${Languages.of(context)!.TextAppDuration}: ${formatTime(item['duration'] + item['manualDuration'])} ',
                                //         style: TextStyle(
                                //             fontSize:
                                //                 AppFontSizes.mediumDefault,
                                //             color: Colors.black),
                                //       ),
                                //     ),
                                //   ],
                                // ),

                                // if (exerciseData.isNotEmpty)
                                //   Padding(
                                //     padding: const EdgeInsets.only(top: 8.0),
                                //     child: Text(
                                //       'Exercise Details:',
                                //       style: TextStyle(
                                //         fontSize: AppFontSizes.mediumDefault.0,
                                //         color: Colors.black,
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     ),
                                //   ),
                                // for (var exercise in exerciseData)
                                //   Container(
                                //     padding: EdgeInsets.symmetric(
                                //       vertical: 4.0,
                                //       horizontal: 8.0,
                                //     ),
                                //     margin: EdgeInsets.only(
                                //       left: 8.0,
                                //       top: 2.0,
                                //       bottom: 2.0,
                                //     ),
                                //     decoration: BoxDecoration(
                                //       color: Colors
                                //           .red, // Set the color for each exercise
                                //       borderRadius: BorderRadius.circular(
                                //         8.0,
                                //       ), // Set the border radius for each exercise container
                                //     ),
                                //     child: Text(
                                //       '${exercise["activityType"]}: ${formatTime(exercise["exerciseDuration"])} minutes',
                                //       style: TextStyle(
                                //         color: Colors.white,
                                //         fontSize: AppFontSizes .mediumDefault.0,
                                //       ),
                                //     ),
                                //   ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExerciseDetailScreen(
                                        data: exerciseData[i]),
                                  ),
                                );
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         CustomIndividualActivitydatepage(
                                //             healthData: [item]),
                                //   ),
                                // );
                              },
                              icon: Image.asset(
                                'assets/img/ArrowRight.png', // Replace 'your_image.png' with your image asset path
                                width: 40,
                                height: 40,
                                color: const Color.fromARGB(255, 189, 20, 124),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            )
                          ],
                        ),
                      ),
                    )
                ],
              )
              // Column(
              //   children: List.generate(
              //     healthData.length,
              //     (index) {
              //       final item = healthData[index];
              //       List<dynamic> exerciseData = item['exerciseData'] ?? [];
              //       return Padding(
              //         padding:
              //             const EdgeInsets.only(left: 8.0, right: 8, top: 4),
              //         child: Container(
              //           padding: EdgeInsets.all(4.0),
              //           decoration: BoxDecoration(
              //             color: TColor.primaryColor1.withOpacity(0.2),
              //             borderRadius: BorderRadius.circular(10.0),
              //           ),
              //           child: Row(
              //             children: [
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: SizedBox(
              //                       width: media.width * 0.7,
              //                       child: Text(
              //                           '${Languages.of(context)!.mainlabelDate}:  ${DateFormatter.convertDate(item['date'])}'),
              //                     ),
              //                   ),
              //                   Row(
              //                     children: [
              //                       Icon(Icons.directions_walk),
              //                       SizedBox(width: 8.0),
              //                       SizedBox(
              //                         width: media.width * 0.6,
              //                         child: Text(
              //                           '${Languages.of(context)!.numberOfSteps}: ${item['steps']} Steps',
              //                           style: TextStyle(
              //                               fontSize:
              //                                   AppFontSizes.mediumDefault,
              //                               color: Colors.black),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   Row(
              //                     children: [
              //                       Icon(Icons.local_fire_department),
              //                       SizedBox(width: 8.0),
              //                       SizedBox(
              //                         width: media.width * 0.6,
              //                         child: Text(
              //                           '${Languages.of(context)!.TextAppCaloriesBurn}: ${item['calory'].toStringAsFixed(item['calory'] >= 99 ? 0 : 2)} Kcal ',
              //                           style: TextStyle(
              //                               fontSize:
              //                                   AppFontSizes.mediumDefault,
              //                               color: Colors.black),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   Row(
              //                     children: [
              //                       Icon(Icons.access_time),
              //                       SizedBox(width: 8.0),
              //                       SizedBox(
              //                         width: media.width * 0.6,
              //                         child: Text(
              //                           '${Languages.of(context)!.labelSleep} ${Languages.of(context)!.TextAppDuration}: ${formatTime(item['duration'] + item['manualDuration'])} ',
              //                           style: TextStyle(
              //                               fontSize:
              //                                   AppFontSizes.mediumDefault,
              //                               color: Colors.black),
              //                         ),
              //                       ),
              //                     ],
              //                   ),

              //                   // if (exerciseData.isNotEmpty)
              //                   //   Padding(
              //                   //     padding: const EdgeInsets.only(top: 8.0),
              //                   //     child: Text(
              //                   //       'Exercise Details:',
              //                   //       style: TextStyle(
              //                   //         fontSize: AppFontSizes.mediumDefault.0,
              //                   //         color: Colors.black,
              //                   //         fontWeight: FontWeight.bold,
              //                   //       ),
              //                   //     ),
              //                   //   ),
              //                   // for (var exercise in exerciseData)
              //                   //   Container(
              //                   //     padding: EdgeInsets.symmetric(
              //                   //       vertical: 4.0,
              //                   //       horizontal: 8.0,
              //                   //     ),
              //                   //     margin: EdgeInsets.only(
              //                   //       left: 8.0,
              //                   //       top: 2.0,
              //                   //       bottom: 2.0,
              //                   //     ),
              //                   //     decoration: BoxDecoration(
              //                   //       color: Colors
              //                   //           .red, // Set the color for each exercise
              //                   //       borderRadius: BorderRadius.circular(
              //                   //         8.0,
              //                   //       ), // Set the border radius for each exercise container
              //                   //     ),
              //                   //     child: Text(
              //                   //       '${exercise["activityType"]}: ${formatTime(exercise["exerciseDuration"])} minutes',
              //                   //       style: TextStyle(
              //                   //         color: Colors.white,
              //                   //         fontSize: AppFontSizes .mediumDefault.0,
              //                   //       ),
              //                   //     ),
              //                   //   ),
              //                 ],
              //               ),
              //               Spacer(),
              //               IconButton(
              //                 onPressed: () {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                       builder: (context) =>
              //                           CustomIndividualActivitydatepage(
              //                               healthData: [item]),
              //                     ),
              //                   );
              //                 },
              //                 icon: Image.asset(
              //                   'assets/img/ArrowRight.png', // Replace 'your_image.png' with your image asset path
              //                   width: 40,
              //                   height: 40,
              //                   color: const Color.fromARGB(255, 189, 20, 124),
              //                 ),
              //               ),
              //               SizedBox(
              //                 width: 15,
              //               )
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseDetailScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const ExerciseDetailScreen({super.key, required this.data});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  @override
  void initState() {
    super.initState();
    fetchData0();
  }

  List<Color> colorList = [
    const Color(0xFFFF9900),
    const Color.fromARGB(255, 34, 104, 161)
  ];
  double restDuration = 0.0;
  double totalDuration = 0.0;
  double energyBalance = 0.0;
  double totalCaloriesExpenditure = 0.0;
  double mealEnergy = 0.0;
  List<dynamic> exerciseDetails = [];

  Future<void> fetchData0() async {
    debugPrint(
        " gbfbhgngjnhgjghgh ${widget.data} fgf ${widget.data['totalEnergyIntake'][0]['date']}");
    final data = await UserProfileController.fetchCaloriesBurnedAndEnergyIntake(
      "${widget.data['date']}",
    );
    setState(() {
      energyBalance = data?['energyBalance'] ?? 0.0;
      totalCaloriesExpenditure = data?['totalCaloriesExpenditure'] ?? 0.0;
      mealEnergy = data?['totalEnergyIntake'][0]['mealEnergy'] ?? 0.0;
      restDuration = data?['restDuration'] ?? 0.0;
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
          mainAxisAlignment: MainAxisAlignment.center,
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
                          '${Languages.of(context)!.mainlabelDate}: ${DateFormatter.convertDate(widget.data['totalEnergyIntake'][0]['date'])}',
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.end,
                              //   children: [
                              //     Center(
                              //       child: Container(
                              //           child: Text(
                              //         '${Languages.of(context)!.mainlabelDate}: ${item['date']}',
                              //         style: TextStyle(
                              //             fontSize: AppFontSizes
                              //                 .mediumDefault,
                              //             color: Colors.black),
                              //       )),
                              //     ),
                              //     SizedBox(
                              //       width: 10,
                              //     )
                              //   ],
                              // ),
                              // sizedBox12(),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.center,
                              //   children: [
                              //     SizedBox(width: 5),
                              //     Text(
                              //       Languages.of(context)!
                              //           .TextAppYour24HoursChart,
                              //       style: TextStyle(
                              //           fontSize: AppFontSizes
                              //               .mediumDefault,
                              //           color: Colors.black),
                              //     ),
                              //   ],
                              // ),
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
                                      color: Color(
                                          0xFFFF9900), // Color for Activity
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
                                        color: Color.fromARGB(255, 34, 104,
                                            161) // Color for Others
                                        ),
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    width: media.width * 0.35,
                                    child: Text(
                                      '${Languages.of(context)!.TextAppOthers}: ${restDuration.toStringAsFixed(restDuration >= 99 ? 0 : 2)} h',
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
