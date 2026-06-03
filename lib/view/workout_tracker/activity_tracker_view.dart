import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Classes/FitnessData.dart';
import 'package:nin2byo2i/Classes/WaterClass.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/CommonLoadingSCreen.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/home/commongraph.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

import '../../common_widget/latest_activity_row.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/today_target_cell.dart';
import 'package:intl/intl.dart';

//this page for water tracker
class WaterTrackerView extends StatefulWidget {
  const WaterTrackerView({super.key});

  @override
  State<WaterTrackerView> createState() => _WaterTrackerViewState();
}

class _WaterTrackerViewState extends State<WaterTrackerView> {
  List<FlSpot> convertDataToFlSpots(List<Map<String, dynamic>> data) {
    List<FlSpot> flSpots = [];

    for (int i = 0; i < data.length; i++) {
      flSpots.add(FlSpot(i.toDouble(), data[i]['value'].toDouble()));
    }

    return flSpots;
  }

  final UserProfileController _controller = UserProfileController();
  FitnessData fitnessData = FitnessData.instance;
  late WaterData waterData;
  bool success = false;
  Map<String, double> daywiseWaterData = {};

  bool isLoadingScreenCheck = true;
  int touchedIndex = -1;
  // new WaterData(waterGoal: 0, cupCapacity: 0, noOfCups: 0, waterIntake: 0);
  List waterArr = [
    // {"title": "0am", "subtitle": "0 l"},
    // {"title": "0am ", "subtitle": "0 l"},
    // {"title": "0am", "subtitle": "0 l"},
    // {"title": "2pm - 4pm", "subtitle": "700ml"},
    // {"title": "4pm - now", "subtitle": "900ml"},
  ];

  @override
  void initState() {
    super.initState();
    allApiFunctionOfSCreen();
    selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  }

  String selectedDate = "";
  DateTime _selectedDate = DateTime.now();

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != _selectedDate) {
  //     setState(() {
  //       _selectedDate = picked;
  //       selectedDate = DateFormat("yyyy-MM-dd").format(picked);
  //     });
  //   }
  // }

  // void _showModal(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Modal Title'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(_selectedDate != null
  //                 ? 'Selected Date: ${_selectedDate.toString()}'
  //                 : 'No Date Selected'),
  //             ElevatedButton(
  //               onPressed: () => _selectDate(context),
  //               child: Text('Select Date'),
  //             ),
  //           ],
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Close the dialog
  //             },
  //             child: Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  allApiFunctionOfSCreen() async {
    await loadData();
    await loadRealtimeData();
    await fetchDaywiseSleepData();
    setState(() {
      isLoadingScreenCheck = false;
    });
  }

  List<dynamic> _waterIntakeData = [];
  bool _isLoading = true;
  String Selecteddateforrealtime =
      DateFormat('yyyy-MM-dd').format(DateTime.now());
  Future<void> loadRealtimeData() async {
    final data = await UserProfileController.fetchWaterIntakeData(
        Selecteddateforrealtime);
    setState(() {
      _waterIntakeData = data;
      _isLoading = false;
    });
  }

  Future<void> _deleteEntry(int entryId) async {
    try {
      await UserProfileController.deleteWaterIntakeEntry(entryId);
      await loadRealtimeData();
    } catch (e) {
      debugPrint('Failed to delete entry: $e');
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
      final data =
          await _controller.GetWaterGraph(endDateFormatted, startDateFormatted);
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

  Future<void> loadData() async {
    final data = await _controller.GetWaterDataOfUser();
    setState(() {
      waterData = data;
      fitnessData.waterIntakeToday = waterData.waterIntake
          .toStringAsFixed(waterData.waterIntake >= 99 ? 0 : 2);
      fitnessData.waterGoal = waterData.waterGoal
          .toStringAsFixed(waterData.waterGoal >= 99 ? 0 : 2);
      success = true;
      debugPrint('water data i8s ${waterData.waterGoal}');
    });
  
    // await _controller.GetWaterDataOfUser().then((data) {
    //   setState(() {
    //     waterData = data;
    //     success = true;
    //     debugPrint('water data i8s ${waterData.noOfCups}');
    //   });
    // }).catchError((error) {
    //   // Handle error
    //   debugPrint('error i sherer');
    // });
  }

  List latestArr = [
    {
      "image": "assets/img/pic_4.png",
      "title": "Drinking 300ml Water",
      "time": "About 1 minutes ago"
    },
    {
      "image": "assets/img/pic_5.png",
      "title": "Eat Snack (Fitbar)",
      "time": "About 3 hours ago"
    },
  ];

  Future<void> _showWaterDataModal(BuildContext context) async {
    int noOfCups = 0;
    int CupCapacity = 0;

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var media = MediaQuery.of(context).size;
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            backgroundColor: ThemeManager.themelightColor,
            title: Text(
              Languages.of(context)!.addCup,
              style: TextStyle(color: ThemeManager.themeText),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Text(_selectedDate != null
                    //     ? 'Selected Date: ${_selectedDate.toString()}'
                    //     : 'No Date Selected'),
                    Row(
                      children: [
                        SizedBox(
                          width: media.width * 0.5,
                          child: Text(
                              "${Languages.of(context)!.TextAppSelectDate} : $selectedDate"),
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
                    // SizedBox(
                    //   width: 120,
                    //   height: 30,
                    //   child: RoundButton(
                    //     title: "Select Date",
                    //     type: RoundButtonType.bgSGradient,
                    //     fontSize: AppFontSizes

                    //     fontWeight: FontWeight.w400,
                    //     onPressed: () async {
                    //       final DateTime? picked = await showDatePicker(
                    //         context: context,
                    //         initialDate: DateTime.now(),
                    //         firstDate: DateTime(2000),
                    //         lastDate: DateTime(2101),
                    //       );
                    //       if (picked != null && picked != _selectedDate) {
                    //         setState(() {
                    //           _selectedDate = picked;
                    //           selectedDate =
                    //               DateFormat("yyyy-MM-dd").format(picked);
                    //         });
                    //       }
                    //     },
                    //   ),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () => _selectDate(context),
                    //   child: Text('Select Date'),
                    // ),
                  ],
                ),
                TextField(
                  style: TextStyle(color: ThemeManager.themeText),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: ThemeManager.themeText,
                      ),
                      labelText: Languages.of(context)!.numberOfCups,
                      labelStyle: TextStyle(color: ThemeManager.themeText)),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    noOfCups = int.tryParse(value) ?? 0;
                  },
                ),
                TextField(
                  style: TextStyle(color: ThemeManager.themeText),
                  decoration: InputDecoration(
                      labelText: Languages.of(context)!.addCupCapacityInMl,
                      labelStyle: TextStyle(color: ThemeManager.themeText)),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    CupCapacity = int.tryParse(value) ?? 0;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  Languages.of(context)!.cancel,
                  style: TextStyle(color: TColor.secondaryColor1),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 80,
                  // height: 20,
                  child: RoundButton(
                    title: Languages.of(context)!.submit,
                    type: RoundButtonType.bgGradient,
                    fontSize: AppFontSizes.smallDefault,
                    fontWeight: FontWeight.w400,
                    onPressed: () async {
                      if (noOfCups > 0 && CupCapacity > 0) {
                        final waterData = {
                          "cupCapacity": CupCapacity,
                          "noOfCups": noOfCups,
                          "localDate": selectedDate
                        };
// ;
//                        {
//                         'noOfCups': noOfCups,
//                       };

                        // final success =
                        // await _controller.AddWaterIntake(waterData);
                        bool result =
                            await _controller.AddWaterIntake(waterData);
                        if (result) {
                          // Show success message with black text and duration of 1500 milliseconds
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Water intake added successfully!',
                                style: TextStyle(
                                    color: Colors
                                        .black), // Text color set to black
                              ),
                              backgroundColor: Colors.green,
                              duration: Duration(
                                  milliseconds: 1500), // Snackbar duration
                            ),
                          );
                        } else {
                          // Show error message with black text and duration of 1500 milliseconds
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Failed to add water intake.',
                                style: TextStyle(
                                    color: Colors
                                        .black), // Text color set to black
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(
                                  milliseconds: 1500), // Snackbar duration
                            ),
                          );
                        }
                        Navigator.of(context).pop();
                        setState(() {
                          loadData();
                          loadRealtimeData();
                          allApiFunctionOfSCreen();
                          loadRealtimeData();
                        });
                        // fitnessData.percentage = 10;
                        //   if (success) {
                        //     setState(() {
                        //       loadData();
                        //       loadRealtimeData();
                        //       allApiFunctionOfSCreen();
                        //     });
                        //     debugPrint('success level is $success');
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         duration: Duration(milliseconds: 1500),
                        //         content: Text(
                        //           Languages.of(context)!
                        //               .NINTextSubmittedSuccessfully1,
                        //           style: TextStyle(color: ThemeManager.themeText),
                        //         ),
                        //         backgroundColor: Colors
                        //             .green, // Set the snackbar color to green
                        //       ),
                        //     );
                        //   }
                        //   Navigator.of(context).pop();
                        // } else {
                        //   // Show an error message or handle the validation failure.
                        //   // For example, you can display a snackbar or an error dialog.
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       backgroundColor: Colors.white,
                        //       duration: Duration(milliseconds: 1500),
                        //       content: Text(
                        //         Languages.of(context)!
                        //             .pleaseEnterValidValuesForAllFields,
                        //         style: TextStyle(color: Colors.black),
                        //       ),
                        //     ),
                        //   );
                        // }
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> _showWaterDataModalPost(BuildContext context) async {
    double waterGoal = 0.0;
    int cupCapacity = 0;
    int noOfCups = 0;
    double waterIntake = 0.0;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeManager.themelightColor,
          title: Text(
            Languages.of(context)!.enterWater,
            style: TextStyle(color: ThemeManager.themeText),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                style: TextStyle(color: ThemeManager.themeText),
                decoration: InputDecoration(
                    labelText: Languages.of(context)!.waterGoalLiters,
                    labelStyle: TextStyle(color: ThemeManager.themeText)),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  waterGoal = double.tryParse(value) ?? 0.0;
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
                // height: 20,
                child: RoundButton(
                  title: Languages.of(context)!.submit,
                  type: RoundButtonType.bgGradient,
                  fontSize: AppFontSizes.smallDefault,
                  fontWeight: FontWeight.w400,
                  onPressed: () async {
                    if (waterGoal > 0) {
                      // final waterData = {
                      //   'waterGoal': waterGoal,
                      //   'cupCapacity': cupCapacity,
                      //   // 'noOfCups': noOfCups,
                      //   // 'waterIntake': waterIntake,
                      // };
                      // final success =
                      // await _controller.SaveWaterData(waterGoal);
                      bool result = await _controller.SaveWaterData(waterGoal);
                      if (result) {
                        // Show success message with black text and duration of 1500 milliseconds
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Water data saved successfully!',
                              style: TextStyle(
                                  color:
                                      Colors.black), // Text color set to black
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(
                                milliseconds: 1500), // Snackbar duration
                          ),
                        );
                      } else {
                        // Show error message with black text and duration of 1500 milliseconds
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Failed to save water data.',
                              style: TextStyle(
                                  color:
                                      Colors.black), // Text color set to black
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(
                                milliseconds: 1500), // Snackbar duration
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                      setState(() {
                        loadData();
                      });
                      //   if (success) {
                      //     setState(() {
                      //       loadData();
                      //     });
                      //     debugPrint('success level is $success');
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(
                      //         duration: Duration(milliseconds: 1500),
                      //         content: Text(Languages.of(context)!
                      //             .NINTextSubmittedSuccessfully1),
                      //         backgroundColor:
                      //             Colors.green, // Set the snackbar color to green
                      //       ),
                      //     );
                      //   }
                      //   Navigator.of(context).pop();
                      // } else {
                      //   // Show an error message or handle the validation failure.
                      //   // For example, you can display a snackbar or an error dialog.
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       backgroundColor: Colors.red,
                      //       duration: Duration(milliseconds: 1500),
                      //       content: Text(
                      //         Languages.of(context)!
                      //             .pleaseEnterValidValuesForAllFields,
                      //       ),
                      //     ),
                      //   );
                      // }
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
    return isLoadingScreenCheck
        ? const CommonDataLoadingScreen()
        : Stack(
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
                    Languages.of(context)!.labelWaterTarget,
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Languages.of(context)!.labelTodayTarget,
                                        style: TextStyle(
                                            color: ThemeManager.themeText,
                                            fontSize:
                                                AppFontSizes.mediumDefault,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        Languages.of(context)!.ninTextToday,
                                        style: TextStyle(
                                            color: ThemeManager.themeText,
                                            fontSize:
                                                AppFontSizes.mediumDefault,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 130,
                                    // height: 25,
                                    child: RoundButton(
                                      title: Languages.of(context)!
                                          .labelChangeGoal,
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
                                            _showWaterDataModal(context);
                                          },
                                          padding: EdgeInsets.zero,
                                          height: 30,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
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
                                    child: success != false
                                        ? TodayTargetCell(
                                            icon: "assets/img/water.png",
                                            value:
                                                "${waterData.waterIntake.toStringAsFixed(waterData.waterIntake >= 99 ? 0 : 2)} L ",
                                            title: Languages.of(context)!
                                                .labelWaterIntake,
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator()),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: success != false
                                        ? TodayTargetCell(
                                            icon: "assets/img/water.png",
                                            value:
                                                "${waterData.waterGoal.toStringAsFixed(waterData.waterGoal >= 99 ? 0 : 2)} L ",
                                            title: Languages.of(context)!
                                                .labelWaterGoal,
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator()),
                                  ),
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
                              Languages.of(context)!.labelWaterProgress,
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
                                dropdownColor:
                                    const Color.fromARGB(255, 189, 20, 124),
                                icon: const Icon(Icons.expand_more,
                                    color: Colors.white),
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
                                items: <String>[
                                  'Week',
                                  'Month'
                                ].map<DropdownMenuItem<String>>((String value) {
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
                            //                         color: ThemeManager.themeText,
                            //                         fontSize: AppFontSizes .mediumDefault),
                            //                   ),
                            //                 ))
                            //             .toList(),
                            //         onChanged: (value) {},
                            //         // icon: Icon(Icons.expand_more,
                            //         //     color: ThemeManager.themeColor),
                            //         hint: Text(
                            //           // "Weekly",
                            //           Languages.of(context)!.labelWeekly,
                            //           textAlign: TextAlign.center,
                            //           style: TextStyle(
                            //               color: ThemeManager.themeText,
                            //               fontSize: AppFontSizes

                            //         ),
                            //       ),
                            //     )),
                          ],
                        ),
                        SizedBox(
                          height: media.width * 0.05,
                        ),
                        if (dropdownValue == "Week")
                          Container(
                            // height: media.width * 0.5,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: ThemeManager.themelightColor,
                                      blurRadius: 3)
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
                                      double waterGoal =
                                          double.parse(fitnessData.waterGoal);
                                      if (waterGoal == 0) {
                                        ratio = 1.0;
                                      } else {
                                        ratio = data['value'].toDouble() /
                                            waterGoal;
                                      }
                                    } catch (e) {
                                      // If an error occurs during parsing, set ratio to 1
                                      ratio = 1.0;
                                    }

                                    // final double ratio = data['value'].toDouble() /
                                    //     double.parse(fitnessData.waterGoal);
                                    DateTime dateTime = DateTime.parse(
                                      data["date"],
                                    );

                                    // Format the date
                                    String formattedDate =
                                        DateFormat('dd MMM').format(dateTime);
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${(data['value']).toDouble().toStringAsFixed((data['value']).toDouble() >= 99 ? 0 : 2)} L',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  AppFontSizes.smallDefault,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    Selecteddateforrealtime =
                                                        data["date"];
                                                    debugPrint(
                                                        "efgvhgfjg $Selecteddateforrealtime");
                                                    loadRealtimeData();
                                                  });
                                                },
                                                child:
                                                    SimpleAnimationProgressBar(
                                                  height:
                                                      150, // Set the height of the progress bar
                                                  width:
                                                      20, // Set the width of the progress bar
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 221, 220, 220),
                                                  foregrondColor: ratio > 0.99
                                                      ? TColor.primaryColor1
                                                      : TColor.secondaryColor1,
                                                  // foregrondColor:
                                                  //     TColor.primaryColor1,

                                                  ratio:
                                                      ratio, // Set the ratio value
                                                  direction: Axis
                                                      .vertical, // Set direction to vertical
                                                  curve: Curves
                                                      .fastLinearToSlowEaseIn,
                                                  duration: const Duration(
                                                      seconds: 3),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                  fontSize:
                                                      AppFontSizes.smallDefault,
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
                                      '        Liters',
                                      style: TextStyle(
                                        fontSize: AppFontSizes
                                            .smallDefault, // Adjust the font size as needed
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  //     SizedBox(width: 1), // Adjust the width as needed
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        LineChartSample2(
                                            allSpots: convertDataToFlSpots(
                                                DayWIseData),
                                            minX: -1,
                                            maxX: 30,
                                            minY: -1,
                                            maxY: 12,
                                            valuetype: "L",
                                            keyValuePairs: const {
                                              // 1: '1 L',
                                              3: '3',
                                              6: '6',
                                              9: '9',
                                              12: '12',
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
                        //       // gradient: LinearGradient(
                        //       //   begin: Alignment.topLeft,
                        //       //   end: Alignment.bottomRight,
                        //       //   colors: [
                        //       //     TColor.primaryColor1,
                        //       //     TColor.secondaryColor1
                        //       //   ],
                        //       // ),
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //     child: LineChartSample2(
                        //         allSpots: convertDataToFlSpots(DayWIseData),
                        //         minX: -1,
                        //         maxX: 30,
                        //         minY: -1,
                        //         maxY: 11,
                        //         valuetype: "L",
                        //         keyValuePairs: {
                        //           // 1: '1 L',
                        //           2: '2 L',
                        //           5: '5 L',
                        //           10: '10L',
                        //         }),
                        //   ),
                        // ),
                        Divider(
                          color: ThemeManager.themeText,
                          height: 20, // You can adjust the height of the line
                          thickness:
                              2, // You can adjust the thickness of the line
                        ),
                        SizedBox(
                          height: media.width * 0.05,
                        ),
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
                        if (_waterIntakeData.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${Languages.of(context)!.mainlabelRealTimeIntakes} on $Selecteddateforrealtime",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSizes.mediumDefault,
                              ),
                            ),
                          ),
                        _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : SingleChildScrollView(
                                child: Column(
                                children: [
                                  for (var intake in _waterIntakeData)
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: (intake['waterEntries']
                                              as List<dynamic>)
                                          .map((entry) {
                                        return ListTile(
                                          title: Text(
                                              'Time: ${entry['localTime']}'),
                                          subtitle: Text(
                                              'Intake: ${entry['waterIntake'].toStringAsFixed(entry['waterIntake'] >= 99 ? 0 : 2)} L'),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () {
                                              // Show confirmation dialog
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title:
                                                      const Text('Confirm Deletion'),
                                                  content: const Text(
                                                      'Are you sure you want to delete this entry?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                      child: const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        await _deleteEntry(
                                                            entry['entryId']);
                                                      },
                                                      child: const Text('Delete'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                ],
                              )

                                // _buildWaterIntakeList(),
                                ),

                        if (waterArr.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${Languages.of(context)!.mainlabelRealTimeIntakes} of today",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSizes.mediumDefault,
                              ),
                            ),
                          ),
                        if (waterArr.isNotEmpty)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: waterArr.map((wObj) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              width:
                                                  50, // Adjust width as needed
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: TColor
                                                    .secondaryColor1, // Adjust color as needed
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            DottedDashedLineh(
                                              width:
                                                  50, // Adjust width as needed
                                              height: 0,
                                              dashColor: TColor.secondaryColor1
                                                  .withOpacity(0.5),
                                              axis: Axis.horizontal,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              wObj["title"].toString(),
                                              style: const TextStyle(
                                                fontSize:
                                                    AppFontSizes.mediumDefault,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              wObj["subtitle"].toString(),
                                              style: const TextStyle(
                                                fontSize:
                                                    AppFontSizes.mediumDefault,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        // LineChartSample2(
                        //     allSpots: convertDataToFlSpots(DayWIseData))
                        // Center(
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       _showModal(context);
                        //     },
                        //     child: Text('Open Modal'),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_controller.isLoading)
                Positioned.fill(
                  child: Container(
                    color:
                        const Color.fromARGB(100, 0, 0, 0), // Semi-transparent black
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
                    color:
                        const Color.fromARGB(100, 0, 0, 0), // Semi-transparent black
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
                                    foregroundColor:
                                        Colors.white, // Button text color
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
                    color:
                        const Color.fromARGB(100, 0, 0, 0), // Semi-transparent black
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
                                    foregroundColor:
                                        Colors.white, // Button text color
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
                    color:
                        const Color.fromARGB(100, 0, 0, 0), // Semi-transparent black
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
                                    foregroundColor:
                                        Colors.white, // Button text color
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

class DottedDashedLineh extends StatelessWidget {
  final double width;
  final double height;
  final Color dashColor;
  final Axis axis;

  const DottedDashedLineh({super.key, 
    required this.width,
    required this.height,
    required this.dashColor,
    required this.axis,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CustomPaint(
        painter: DashedPainter(dashColor: dashColor, axis: axis),
      ),
    );
  }
}

class DashedPainter extends CustomPainter {
  final Color dashColor;
  final Axis axis;

  DashedPainter({required this.dashColor, required this.axis});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = dashColor
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.square;

    if (axis == Axis.horizontal) {
      double dashWidth = 5;
      double dashSpace = 5;
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
            Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
        startX += dashWidth + dashSpace;
      }
    } else {
      double dashHeight = 5;
      double dashSpace = 5;
      double startY = 0;
      while (startY < size.height) {
        canvas.drawLine(
            Offset(0, startY), Offset(0, startY + dashHeight), paint);
        startY += dashHeight + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
