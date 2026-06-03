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
import 'package:nin2byo2i/view/home/commongraph.dart';
import 'package:provider/provider.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

import '../../common_widget/latest_activity_row.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/today_target_cell.dart';

import 'package:intl/intl.dart';

//from here user can track his weight
class WeightManager extends StatefulWidget {
  const WeightManager({super.key});

  @override
  State<WeightManager> createState() => _stepsWeekly();
}

class _stepsWeekly extends State<WeightManager> {
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

  String selectedDate = "";
  double currentWeight = 0;
  DateTime _selectedDate = DateTime.now();
  String? weightGoal = "";
  double? weightChange = 0.0;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    formattedDate = formatter.format(now);
    // loadData();
    fetchDaywiseSleepData();
    selectedDate = DateFormat("yyyy-MM-dd").format(_selectedDate);
    getLatestWeight();
    getLatestWeightandGoal();
  }

  void getLatestWeight() async {
    try {
      Map<String, dynamic> latestWeight = await _controller.getLatestWeight();
      setState(() {
        currentWeight = latestWeight["value"];
      });

      debugPrint('Latest weidsddght: ${latestWeight["value"]} $currentWeight kg');
      debugPrint('Date: ${latestWeight["date"]}');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void getLatestWeightandGoal() async {
    try {
      Map<String, dynamic> data = await _controller.getWeightGoal();
      debugPrint('Dafdgdfhgfte: $data');
      setState(() {
        weightGoal = data['weightGoal'];
        weightChange = data['weightChange'];
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching weight goal: $e");
      // Handle error
    }
  }

  DateTime currentDate = DateTime.now();

  // Get end date (previous 7 days)
  DateTime endDate = DateTime.now().subtract(const Duration(days: 30));

  List<Map<String, dynamic>> DayWIseData = [
    {"date": "2024-02-13", "value": 0},
    {"date": "2024-02-14", "value": 0},
    {"date": "2024-02-15", "value": 0},
    {"date": "2024-02-16", "value": 0},
    {"date": "2024-02-17", "value": 0},
    {"date": "2024-02-18", "value": 0},
    {"date": "2024-02-18", "value": 0}
  ];
  String dropdownValue = 'Month';
  double maxValue = 1;
  Future<void> fetchDaywiseSleepData() async {
    try {
      // Format dates
      String startDateFormatted = formatDate(currentDate);
      String endDateFormatted = formatDate(endDate);
      // Assuming you have a function named getDaywiseSleepData that fetches data
      final data = await _controller.WeightDateRange(
          endDateFormatted, startDateFormatted);
      debugPrint("rgtedrfyhrt $startDateFormatted $endDateFormatted $data");
      // Map<String, double> data = await getDaywiseSleepData();
      setState(() {
        if (data.isNotEmpty) {
          DayWIseData = data;
          // if (dropdownValue == 'Month') {
          //   DayWIseData = [
          //     {"date": "2024-01-31", "value": 40},
          //     {"date": "2024-02-01", "value": 41},
          //     {"date": "2024-02-02", "value": 42},
          //     {"date": "2024-02-03", "value": 43},
          //     {"date": "2024-02-04", "value": 44},
          //     {"date": "2024-02-05", "value": 45},
          //     {"date": "2024-02-06", "value": 46},
          //     {"date": "2024-02-07", "value": 47},
          //     {"date": "2024-02-08", "value": 48},
          //     {"date": "2024-02-09", "value": 49},
          //     {"date": "2024-02-10", "value": 50},
          //     {"date": "2024-02-11", "value": 51},
          //     {"date": "2024-02-12", "value": 52},
          //     {"date": "2024-02-13", "value": 53},
          //     {"date": "2024-02-14", "value": 54},
          //     {"date": "2024-02-15", "value": 55},
          //     {"date": "2024-02-16", "value": 56},
          //     {"date": "2024-02-17", "value": 57},
          //     {"date": "2024-02-18", "value": 58},
          //     {"date": "2024-02-19", "value": 59},
          //     {"date": "2024-02-20", "value": 60},
          //     {"date": "2024-02-21", "value": 59},
          //     {"date": "2024-02-22", "value": 58},
          //     {"date": "2024-02-23", "value": 57},
          //     {"date": "2024-02-24", "value": 56},
          //     {"date": "2024-02-25", "value": 55},
          //     {"date": "2024-02-26", "value": 54},
          //     {"date": "2024-02-27", "value": 53},
          //     {"date": "2024-02-28", "value": 52},
          //     {"date": "2024-02-29", "value": 51},
          //     {"date": "2024-03-01", "value": 56},
          //   ];
          // }
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

  Future<void> _showWeightGoalDialog(BuildContext context) async {
    String selectedGoal = 'Maintain';
    double weightChange = 0.0;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: ThemeManager.themelightColor,
              title: Text(
                Languages.of(context)!.NINTextIWantTo,
                style: TextStyle(color: ThemeManager.themeText),
              ),
              content: SizedBox(
                width: 300.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                          '${Languages.of(context)!.NINTextGain} ${Languages.of(context)!.labelWeight}'),
                      leading: Radio(
                        value: 'Gain',
                        groupValue: selectedGoal,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGoal = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                          '${Languages.of(context)!.NINTextMaintain} ${Languages.of(context)!.labelWeight}'),
                      leading: Radio(
                        value: 'Maintain',
                        groupValue: selectedGoal,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGoal = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                          '${Languages.of(context)!.NINTextLose} ${Languages.of(context)!.labelWeight}'),
                      leading: Radio(
                        value: 'Lose',
                        groupValue: selectedGoal,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGoal = value!;
                          });
                        },
                      ),
                    ),
                    if (selectedGoal == 'Gain' || selectedGoal == 'Lose')
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            weightChange = double.tryParse(value) ?? 0.0;
                          });
                        },
                        style: TextStyle(color: ThemeManager.themeText),
                        decoration: InputDecoration(
                          labelText:
                              Languages.of(context)!.NINTextWeightChangeKg,
                        ),
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
                    // Check if weightChange is zero
                    if (selectedGoal != "Maintain" && weightChange == 0) {
                      // Show error alert dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please add a weight change value.'),
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
                      return; // Exit the function early
                    }

                    Navigator.of(context).pop();
                    bool result = await _controller.SetWeightGoal(
                        selectedGoal, weightChange);
                    if (result) {
                      // Show success message with black text
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1500),
                          content: Text(
                            'Weight goal updated successfully!',
                            style: TextStyle(
                                color: Colors.black), // Text color set to black
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      // Show error message with black text
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Failed to update weight goal.',
                            style: TextStyle(
                                color: Colors.black), // Text color set to black
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    getLatestWeightandGoal();
                    // Perform actions based on selected goal and weight change
                    // For example, update the weight goal in the database
                  },

                  // onPressed: () async {
                  //   Navigator.of(context).pop();
                  //   // final data =
                  //   await _controller.SetWeightGoal(selectedGoal, weightChange);
                  //   getLatestWeightandGoal();
                  //   //  await _controller.UpdateWeightData(
                  //   //     manualWeight, selectedDate);
                  //   // Perform actions based on selected goal and weight change
                  //   // For example, update the weight goal in the database
                  // },
                ),
              ],
            );
          },
        );
      },
    );
  }

// Inside your build method, where you want to place the button:

  Future<void> _showManualWeightDialog(BuildContext context) async {
    double manualWeight = 0;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var media = MediaQuery.of(context).size;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: ThemeManager.themelightColor,
              title: Text(
                Languages.of(context)!.NINTextAddNewWeight,
                style: TextStyle(color: ThemeManager.themeText),
              ),
              content: SizedBox(
                width: 300.0, // Set the width of the modal
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      Languages.of(context)!.NINTextEnterWeight,
                      style: TextStyle(color: ThemeManager.themeText),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: media.width * 0.5,
                          child: Text(
                              "${Languages.of(context)!.labelSelectDate} : ${DateFormatter.convertDate(selectedDate)}"),
                        ),
                        IconButton(
                          onPressed: () async {
                            final DateTime now = DateTime.now();
                            final DateTime lastAllowedDate =
                                now.subtract(const Duration(days: 365));

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
                          icon: const Icon(Icons.date_range),
                        ),
                      ],
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          manualWeight = double.tryParse(value) ?? 0;
                        });
                      },
                      style: TextStyle(color: ThemeManager.themeText),
                      decoration: InputDecoration(
                        labelText:
                            '${Languages.of(context)!.TextAppWeight} (kg)',
                      ),
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
                  // onPressed: () async {
                  //   Navigator.of(context).pop();
                  //   await _controller.UpdateWeightData(
                  //     manualWeight,
                  //     selectedDate,
                  //   );
                  //   getLatestWeight();
                  //   // Call function to update weight data
                  //   // await _updateWeightData(manualWeight);
                  //   // You can perform further actions here if needed
                  // },
                  onPressed: () async {
                    Navigator.of(context).pop();
                    bool result = await _controller.UpdateWeightData(
                      manualWeight,
                      selectedDate,
                    );
                    if (result) {
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1500),
                          content: Text(
                            'Weight data updated successfully!',
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to update weight data.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    getLatestWeight();
                    // Call function to update weight data
                    // await _updateWeightData(manualWeight);
                    // You can perform further actions here if needed
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProfileController = Provider.of<UserProfileController>(context);
    int initialWeight = DayWIseData.first['value'].toInt();
    int finalWeight = DayWIseData.last['value'].toInt();
    String change = finalWeight > initialWeight ? 'Gain' : 'Lose';
    int changeValue = finalWeight - initialWeight;
    debugPrint("dsggdffdhjdjhd $changeValue");
    int weightDifference = (finalWeight - initialWeight).abs();
    var media = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
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
              Languages.of(context)!.TextAppWeightManager,
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     _showWeightGoalDialog(context);
                  //   },
                  //   child: Text(
                  //     'Set Weight Goal',
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        // height: 30,
                        child: Container(
                          decoration: BoxDecoration(
                            color: TColor.primaryColor2.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: MaterialButton(
                              onPressed: () {
                                // _showWaterDataModal(context);
                                _showManualWeightDialog(context);
                              },
                              padding: EdgeInsets.zero,
                              // height: 30,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              textColor: TColor.primaryColor1,
                              minWidth: double.maxFinite,
                              elevation: 0,
                              color: Colors.transparent,
                              child: Text(
                                Languages.of(context)!.TextAppUpdateWeight,
                                style: const TextStyle(color: Colors.black),
                              )
                              //  Icon(
                              //   Icons.add,
                              //   color: Colors.white,
                              //   size: 15,
                              // )
                              ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 120,
                        // height: 30,
                        child: Container(
                          decoration: BoxDecoration(
                            color: TColor.primaryColor2.withOpacity(0.3),
                            // gradient: LinearGradient(
                            //   colors: TColor.primaryG,
                            // ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: MaterialButton(
                              onPressed: () {
                                // _showWaterDataModal(context);
                                _showWeightGoalDialog(context);
                              },
                              padding: EdgeInsets.zero,
                              // height: 30,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              textColor: TColor.primaryColor1,
                              minWidth: double.maxFinite,
                              elevation: 0,
                              color: Colors.transparent,
                              child: Text(
                                Languages.of(context)!.TextAppSetWeightGoal,
                                style: const TextStyle(color: Colors.black),
                              )
                              //  Icon(
                              //   Icons.add,
                              //   color: Colors.white,
                              //   size: 15,
                              // )
                              ),
                        ),
                      ),
                    ],
                  ),
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
                      padding: const EdgeInsets.only(bottom: 8.0),
                      // padding:
                      //     const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      // decoration: BoxDecoration(
                      //   color: TColor.primaryColor2.withOpacity(0.3),
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          sizedBox12(),
                          SizedBox(
                            width: 150,
                            //  height: 41,
                            // decoration: BoxDecoration(
                            //   shape: BoxShape.circle,
                            //   color: ThemeManager
                            //       .themelightColor, // Set the background color for the circular container
                            // ),
                            child: Center(
                              child: Image.asset(
                                "assets/img/body weight.png",
                                // width: 2100, // Adjust the width of the image
                                // height: 24, // Adjust the height of the image
                                // color: ThemeManager.themeText,
                              ),
                            ),
                          ),
                          // Spacer(),
                          // SizedBox(
                          //   // width: media.width * 0.60,
                          //   child: Text(
                          //     Languages.of(context)!.TextAppCurrentWeight,
                          //     // $_steps2
                          //     style: TextStyle(
                          //         color: ThemeManager.themeText,
                          //         fontSize: AppFontSizes.mediumDefault,
                          //         fontWeight: FontWeight.w700),
                          //   ),
                          // ),
                          sizedBox12(),
                          SizedBox(
                            // width: media.width * 0.60,
                            child: Text(
                              "${Languages.of(context)!.TextAppCurrentWeight} $currentWeight Kg ",
                              // $_steps2
                              style: TextStyle(
                                  color: ThemeManager.themeText,
                                  fontSize: AppFontSizes.mediumDefault,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            // width: media.width * 0.60,
                            child: Text(
                              '${Languages.of(context)!.labelBMI} : ${userProfileController.userProfile?.bmi.toStringAsFixed(2)}',

                              // $_steps2
                              style: TextStyle(
                                  color: ThemeManager.themeText,
                                  fontSize: AppFontSizes.mediumDefault,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          sizedBox12(),
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
                        Languages.of(context)!.TextAppWeightProgress,
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
                              if (newValue == 'Year') {
                                // Set end date to previous 7 days
                                endDate = DateTime.now()
                                    .subtract(const Duration(days: 365));
                              } else if (newValue == 'Month') {
                                // Set end date to previous month
                                endDate = DateTime.now()
                                    .subtract(const Duration(days: 30));
                              }
                              fetchDaywiseSleepData();
                            });
                          },
                          items: <String>['Month', 'Year']
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
                                          color: Colors
                                              .white // Change the text color
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
                  // if (dropdownValue == "Week")
                  if (dropdownValue == "Year")
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
                    //     child: Row(
                    //       children: [
                    //         RotatedBox(
                    //           quarterTurns: -1,
                    //           child: Text(
                    //             'kg',
                    //             style: TextStyle(
                    //               fontSize: AppFontSizes
                    //                   .smallDefault, // Adjust the font size as needed
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(width: 1),
                    //         LineChartSample2(
                    //             allSpots: convertDataToFlSpots(DayWIseData),
                    //             minX: -5,
                    //             maxX: 365,
                    //             minY: -5,
                    //             maxY: 100,
                    //             valuetype: "kg ",
                    //             keyValuePairs: {
                    //               20: '20',
                    //               40: '40',
                    //               60: '60',
                    //               80: '80',
                    //               // 14000: '14k',
                    //             }),
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
                                '        Body weight in kg',
                                style: TextStyle(
                                  fontSize: AppFontSizes.smallDefault,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  LineChartSample2(
                                      allSpots:
                                          convertDataToFlSpots(DayWIseData),
                                      minX: -5,
                                      maxX: 365,
                                      minY: -5,
                                      maxY: 100,
                                      valuetype: "kg ",
                                      keyValuePairs: const {
                                        20: '20',
                                        40: '40',
                                        60: '60',
                                        80: '80',
                                        // 14000: '14k',
                                      }),
                                  const Text(
                                    'Previous 365 days',
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
                  if (dropdownValue == "Month")
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(20),
                    //   child: Container(
                    //     color: Colors.white,
                    //     height: 200,
                    //     child: Row(
                    //       children: [
                    //         RotatedBox(
                    //           quarterTurns: -1,
                    //           child: Text(
                    //             'kg',
                    //             style: TextStyle(
                    //               fontSize: AppFontSizes
                    //                   .smallDefault, // Adjust the font size as needed
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(width: 1),
                    //         LineChartSample2(
                    //             allSpots: convertDataToFlSpots(DayWIseData),
                    //             minX: -0.5,
                    //             maxX: 30,
                    //             minY: -5,
                    //             maxY: 100,
                    //             valuetype: "kg",
                    //             keyValuePairs: {
                    //               20: '20 kg',
                    //               40: '40 kg',
                    //               60: '60 kg',
                    //               80: '80 kg',
                    //               // 14000: '14k',
                    //             }),
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
                                '        Body weight in kg',
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
                                      allSpots:
                                          convertDataToFlSpots(DayWIseData),
                                      minX: -0.5,
                                      maxX: 30,
                                      minY: -5,
                                      maxY: 100,
                                      valuetype: "kg",
                                      keyValuePairs: const {
                                        20: '20 ',
                                        40: '40 ',
                                        60: '60 ',
                                        80: '80 ',
                                        // 14000: '14k',
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
                  Divider(
                    color: ThemeManager.themeText,
                    height: 20, // You can adjust the height of the line
                    thickness: 2, // You can adjust the thickness of the line
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.grey), // Add a grey border
                    //   borderRadius: BorderRadius.circular(
                    //       10), // Optional: Add border radius for rounded corners
                    // ),
                    decoration: BoxDecoration(
                      color: TColor.primaryColor2.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: isLoading
                            ? const CircularProgressIndicator() // Show loading indicator while data is being fetched
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${Languages.of(context)!.TextAppYourWeightGoalIsSet} ${weightGoal.toString().toLowerCase()} ${Languages.of(context)!.TextAppWeight.toLowerCase()}',
                                    style: const TextStyle(
                                        fontSize: AppFontSizes.mediumDefault),
                                  ),
                                  const SizedBox(height: 10),
                                  if (weightChange! > 0)
                                    Text(
                                      '${Languages.of(context)!.TextAppAndYourWeightChangeIsSet}: ${weightChange?.toStringAsFixed(1)} kg', // Display weight change with two decimal places
                                      style: const TextStyle(
                                          fontSize: AppFontSizes.mediumDefault),
                                    ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  sizedBox12(),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: TColor.primaryColor2.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: media.width * 0.75,
                                  child: Text(
                                    '${Languages.of(context)!.TextAppInitialWeightOf} : $initialWeight kg ${Languages.of(context)!.ninTextason} ${DateFormatter.convertDate(DayWIseData.first['date'])}',
                                    style: TextStyle(
                                        fontSize: AppFontSizes.mediumDefault,
                                        color: ThemeManager
                                            .themeText), // Adjust text size and color
                                  ),
                                ),
                                SizedBox(
                                  width: media.width * 0.75,
                                  child: Text(
                                    '${Languages.of(context)!.TextAppFinalWeightOf} : $finalWeight kg ${Languages.of(context)!.ninTextason} ${DateFormatter.convertDate(DayWIseData.last['date'])}',
                                    style: TextStyle(
                                        fontSize: AppFontSizes.mediumDefault,
                                        color: ThemeManager
                                            .themeText), // Adjust text size and color
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 20,
                              color: ThemeManager
                                  .themeText, // Adjust icon color to contrast with gradient
                            ),
                            Text(
                              // '${Languages.of(context)!.labelWeight} $change: $weightDifference',
                              '${Languages.of(context)!.ninTextChangeInWeight} : $weightDifference kg',
                              style: TextStyle(
                                  fontSize: AppFontSizes.mediumDefault,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeManager
                                      .themeText), // Adjust text size and color
                            ),
                          ],
                        ),
                        // if (myWeightGoalis == change)
                        // if( changeValue >=weightChange)
                        // if (weightGoal == "Gain" && changeValue >= weightChange!)
                        //   Text(
                        //     Languages.of(context)!
                        //         .TextAppYouAreAchievedYourWeightGoalKeepGoing,
                        //     style: TextStyle(
                        //         fontSize: AppFontSizes.mediumDefault,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.green),
                        //   )
                        // else if (weightGoal == "Lose" &&
                        //     changeValue < 0 &&
                        //     changeValue >= -weightChange!)
                        //   Text(
                        //     Languages.of(context)!
                        //         .TextAppYouAreAchievedYourWeightGoalKeepGoing,
                        //     style: TextStyle(
                        //         fontSize: AppFontSizes.mediumDefault,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.green),
                        //   )
                        // else
                        //   Text(
                        //     weightGoal == change
                        //         ? 'Congratulations! You are achieving your weight goal.'
                        //         : Languages.of(context)!
                        //             .TextAppYouAreNotYetAchievingYourWeightGoalKeepGoing,
                        //     style: TextStyle(
                        //       fontSize: AppFontSizes.mediumDefault,
                        //       fontWeight: FontWeight.bold,
                        //       color:
                        //           weightGoal == change ? Colors.green : Colors.red,
                        //     ),
                        //   )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_controller.isLoading)
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(100, 0, 0, 0), // Semi-transparent black
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(TColor.primaryColor1),
                  strokeWidth: 4.0,
                ),
              ),
            ),
          ),
        if (_controller.isConnected)
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(100, 0, 0, 0), // Semi-transparent black
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          sizedBox30(),
                          const Text(
                            "Internet not working, please check",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                              height:
                                  20), // Adds some spacing between the text and the button
                          ElevatedButton(
                            onPressed: () {
                              // Perform your action here
                              debugPrint('Button Pressed');
                              _controller.setcheckInternet(false);
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColor
                                  .secondaryColor1, // Button background color
                              foregroundColor: Colors.white, // Button text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              Languages.of(context)!.tryLater,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          sizedBox30(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        if (_controller.checkModalBool)
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(100, 0, 0, 0), // Semi-transparent black
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          sizedBox30(),
                          Text(
                            _controller.modalMessage,
                            style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                              height:
                                  20), // Adds some spacing between the text and the button
                          ElevatedButton(
                            onPressed: () {
                              // Perform your action here
                              debugPrint('Button Pressed');
                              _controller.setCheckModalBool(false);
                              _controller.setModalMessage("");
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColor
                                  .secondaryColor1, // Button background color
                              foregroundColor: Colors.white, // Button text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              Languages.of(context)!.tryLater,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          sizedBox30(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        if (_controller.checkModalBoolSuccess)
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(100, 0, 0, 0), // Semi-transparent black
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          sizedBox30(),
                          Text(
                            Languages.of(context)!
                                .NINTextSubmittedSuccessfully1,
                            style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                              height:
                                  20), // Adds some spacing between the text and the button
                          ElevatedButton(
                            onPressed: () {
                              // Perform your action here
                              debugPrint('Button Pressed');
                              _controller.setCheckModalBoolSuccess(false);

                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColor
                                  .secondaryColor1, // Button background color
                              foregroundColor: Colors.white, // Button text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              Languages.of(context)!.ok,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          sizedBox30(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ],
    );
  }
}
