import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

//this page will show activities
class ActivityTrackerScreen extends StatefulWidget {
  const ActivityTrackerScreen({super.key});

  @override
  _ActivityTrackerScreenState createState() => _ActivityTrackerScreenState();
}

class _ActivityTrackerScreenState extends State<ActivityTrackerScreen> {
  final UserProfileController _controller = UserProfileController();
  List<dynamic> data = [];
  DateTime _selectedDate = DateTime.now();
  double dataJog = 0;
  double dataRun = 0;
  bool dataLoadFlag = false;
  DateTime _selectedDateforjog = DateTime.now();
  String type = 'running'; // Default activity type
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
    fetchData(_selectedDate);
    // fetchDataJog(_selectedDateforjog);
    fetchDataRunJog(_selectedDateforjog, 'running');
    fetchDataRunJog(_selectedDateforjog, 'jogging');
  }

  Future<void> fetchDataRunJog(DateTime selectedDate, String StepType) async {
    try {
      if (StepType == 'running') {
        final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

        dataRun = await _controller.GetRuningJoggingDataOfUser(
            formattedDate, StepType);
      } else {
        final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        dataJog = await _controller.GetRuningJoggingDataOfUser(
            formattedDate, StepType);
      }
    } catch (e) {
      debugPrint('Error here: $e');
    }
    setState(() {
      dataLoadFlag = true;
    });
  }

  Future<void> _selectDateRunJog(BuildContext context, String StepType) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateforjog,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor:
                ThemeManager.themelightColor, // Background color of the header

            colorScheme: ColorScheme.dark(
              primary: TColor.primaryColor1, // Background color of the calendar
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
      },
    );

    if (picked != null && picked != _selectedDateforjog) {
      setState(() {
        _selectedDateforjog = picked;
      });

      fetchDataRunJog(
          _selectedDateforjog, StepType); // Reload data with the selected date
    }
  }

// Show the modal dialog
  Future<void> _showAddDataDialogRunJog(
      BuildContext context, String StepType) async {
    double value = 0.0;
    String temp = '0';
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ThemeManager.themelightColor,
          title: Text(
            Languages.of(context)!.addActivityData,
            style: TextStyle(color: ThemeManager.themeText),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                style: TextStyle(color: ThemeManager.themeText),
                decoration: InputDecoration(
                    labelText: Languages.of(context)!.enterValue,
                    labelStyle: TextStyle(color: ThemeManager.themeText)),
                keyboardType: TextInputType.number,
                onChanged: (newValue) {
                  temp = newValue;
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: TColor
                    .secondaryColor1, // Set the background color to light blue
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(25.0), // Set the border radius
                ),
              ),
              onPressed: () async {
                value = double.parse(temp);

                // Send the data to the API here using _controller
                await _controller.UpdateRuningJoggingDataOfUser(
                    value, StepType);

                // Close the dialog
                Navigator.of(context).pop();

                // Refresh data after submitting
                fetchDataRunJog(_selectedDateforjog, StepType);
              },
              child: Text(
                Languages.of(context)!.submit,
                style: TextStyle(color: ThemeManager.themeText),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchData(DateTime selectedDate) async {
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

      data = await _controller.GetActiviyDataOfUser(formattedDate);
      // Replace this line with your data fetching logic, and pass the formattedDate as needed.
      // Example: data = await _controller.GetActiviyDataOfUser(formattedDate);
    } catch (e) {
      // Handle error appropriately (e.g., show an error message).
      debugPrint('Error: $e');
    }
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor:
                ThemeManager.themelightColor, // Background color of the header

            colorScheme: ColorScheme.dark(
              primary: TColor.primaryColor1, // Background color of the calendar
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
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });

      fetchData(_selectedDate); // Reload data with the selected date
    }
  }

  Future<void> _showStepDataModal(BuildContext context) async {
    int steps = 0;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeManager.themelightColor,
          title: Text(
            Languages.of(context)!.addStepsData,
            style: TextStyle(color: ThemeManager.themeText),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                style: TextStyle(color: ThemeManager.themeText),
                decoration: InputDecoration(
                    labelText: Languages.of(context)!.numberOfSteps,
                    labelStyle: TextStyle(color: ThemeManager.themeText)),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  steps = int.tryParse(value) ?? 0;
                },
              ),
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
                //    height: 20,
                child: RoundButton(
                  title: Languages.of(context)!.submit,
                  type: RoundButtonType.bgGradient,
                  fontSize: AppFontSizes.smallDefault,
                  fontWeight: FontWeight.w400,
                  onPressed: () async {
                    if (steps > 0) {
                      final success =
                          await _controller.PostStepsDataOfUser(steps);

                      if (success) {
                        debugPrint('success level is $success');
                        setState(() {
                          fetchData(_selectedDate);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 1500),
                            content: Text(
                              Languages.of(context)!
                                  .NINTextSubmittedSuccessfully1,
                              style: TextStyle(color: ThemeManager.themeText),
                            ),
                            backgroundColor:
                                Colors.green, // Set the snackbar color to green
                          ),
                        );
                      }
                      setState(() {});
                      Navigator.of(context).pop();
                    } else {
                      // Show an error message or handle the validation failure.
                      // For example, you can display a snackbar or an error dialog.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            Languages.of(context)!
                                .pleaseEnterValidValuesForAllFields,
                            style: TextStyle(color: ThemeManager.themeText),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
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
        //       margin: const EdgeInsets.all(8),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ElevatedButton(
              //   onPressed: () => _showStepDataModal(
              //       context), // Call the _showStepDataModal method
              //   child: const Text('Add Steps'),
              // ),
              // ElevatedButton(
              //   onPressed: () => _selectDate(context),
              //   child: Text('Select Date'),
              // ),
              const SizedBox(height: 16),
              if (data.isEmpty)
                const CircularProgressIndicator()
              else
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // Languages.of(context)!.labelWorkoutProgress,
                            Languages.of(context)!.labelsteptracker,
                            style: TextStyle(
                                color: ThemeManager.themeText,
                                fontSize: AppFontSizes.mediumDefault,
                                fontWeight: FontWeight.w700),
                          ),
                          GestureDetector(
                            onTap: () => _showStepDataModal(context),
                            child: Container(
                                height: 25,
                                // padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  gradient:
                                      LinearGradient(colors: TColor.primaryG),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    Languages.of(context)!.labelAddStep,
                                    style: TextStyle(
                                      color: ThemeManager.themeText,
                                    ),
                                  ),
                                )),
                          ),
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: Container(
                                height: 25,
                                // padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  gradient:
                                      LinearGradient(colors: TColor.primaryG),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        Languages.of(context)!.labelSelectDate,
                                        style: TextStyle(
                                          color: ThemeManager.themeText,
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        "assets/img/Time_light.svg", // Replace with the path to your SVG file
                                        width: 20,
                                        color: ThemeManager.themeText,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    sizedBox12(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            height: media.width * 0.4,
                            child: CommonViewWidget(
                              fObj: {
                                'name': Languages.of(context)!.labelsteptracker,
                                "value":
                                    '${data[2]?.toStringAsFixed(2)} Km" \n ${data[0]?.toStringAsFixed(0)} Steps',
                                "image": "assets/img/Vector.svg",
                              },
                              index: 2,
                            )),
                        SizedBox(
                            height: media.width * 0.4,
                            child: CommonViewWidget(
                              fObj: {
                                'name':
                                    Languages.of(context)!.labelCaloriesBurn,
                                "value": '${data[1]} \n Kcal',
                                "image": "assets/img/Fire_light.svg",
                              },
                              index: 2,
                            )),
                      ],
                    ),
                  ],
                ),

              sizedBox30(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // Languages.of(context)!.labelWorkoutProgress,
                      Languages.of(context)!.labelRunningTracker,
                      style: TextStyle(
                          color: ThemeManager.themeText,
                          fontSize: AppFontSizes.mediumDefault,
                          fontWeight: FontWeight.w700),
                    ),
                    // SizedBox(
                    //   width: 80,
                    //   height: 25,
                    //   child: RoundButton(
                    //     title: "Add",
                    //     type: RoundButtonType.bgGradient,
                    //     fontSize: AppFontSizes

                    //     fontWeight: FontWeight.w400,
                    //     onPressed: () {
                    //       //_showWaterDataModalPost(context);
                    //       // _selectDate(context);
                    //       _showAddDataDialogRunJog(context, 'running');
                    //     },
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 80,
                    //   height: 25,
                    //   child: RoundButton(
                    //     title: "Date",
                    //     type: RoundButtonType.bgGradient,
                    //     fontSize: AppFontSizes

                    //     fontWeight: FontWeight.w400,
                    //     onPressed: () {
                    //       //_showWaterDataModalPost(context);
                    //       _selectDateRunJog(context, 'running');
                    //     },
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () => _showAddDataDialogRunJog(context, 'running'),
                      child: Container(
                          height: 25,
                          // padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: TColor.primaryG),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              Languages.of(context)!.labelAddStep,
                              style: TextStyle(
                                color: ThemeManager.themeText,
                              ),
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () => _selectDateRunJog(context, 'running'),
                      child: Container(
                          height: 25,
                          // padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: TColor.primaryG),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                Text(
                                  Languages.of(context)!.labelSelectDate,
                                  style: TextStyle(
                                    color: ThemeManager.themeText,
                                  ),
                                ),
                                SvgPicture.asset(
                                    "assets/img/Time_light.svg", // Replace with the path to your SVG file
                                    width: 20,
                                    color: ThemeManager.themeText),
                                // Icon(Icons.expand_more,
                                //     color: ThemeManager.themeColor),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              sizedBox12(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: SizedBox(
                        height: media.width * 0.4,
                        child: CommonViewWidget(
                          fObj: {
                            'name': Languages.of(context)!.labelCaloriesBurn,
                            "value": "${dataRun.toStringAsFixed(2)} \n Kcal",
                            "image": "assets/img/Fire_light.svg",
                          },
                          index: 2,
                        )),
                  ),
                ],
              ),
              sizedBox30(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // Languages.of(context)!.labelWorkoutProgress,
                      Languages.of(context)!.labelJoggingTracker,
                      style: TextStyle(
                          color: ThemeManager.themeText,
                          fontSize: AppFontSizes.mediumDefault,
                          fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () => _showAddDataDialogRunJog(context, 'jogging'),
                      child: Container(
                          height: 25,
                          // padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: TColor.primaryG),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              Languages.of(context)!.labelAddStep,
                              style: TextStyle(
                                color: ThemeManager.themeText,
                              ),
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () => _selectDateRunJog(context, 'jogging'),
                      child: Container(
                          height: 25,
                          // padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: TColor.primaryG),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                Text(
                                  Languages.of(context)!.labelSelectDate,
                                  style: TextStyle(
                                    color: ThemeManager.themeText,
                                  ),
                                ),
                                SvgPicture.asset(
                                    "assets/img/Time_light.svg", // Replace with the path to your SVG file
                                    width: 20,
                                    color: ThemeManager.themeText),

                                // Icon(Icons.expand_more,
                                //     color: ThemeManager.themeColor),
                              ],
                            ),
                          )),
                    ),
                    // SizedBox(
                    //   width: 80,
                    //   height: 25,
                    //   child: RoundButton(
                    //     title: "Add",
                    //     type: RoundButtonType.bgGradient,
                    //     fontSize: AppFontSizes
                    //     fontWeight: FontWeight.w400,
                    //     onPressed: () {
                    //       //_showWaterDataModalPost(context);
                    //       // _selectDate(context);
                    //       _showAddDataDialogRunJog(context, 'jogging');
                    //     },
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 80,
                    //   height: 25,
                    //   child: RoundButton(
                    //     title: "Date",
                    //     type: RoundButtonType.bgGradient,
                    //     fontSize: AppFontSizes

                    //     fontWeight: FontWeight.w400,
                    //     onPressed: () {
                    //       //_showWaterDataModalPost(context);
                    //       _selectDateRunJog(context, 'jogging');
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
              sizedBox12(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: SizedBox(
                        height: media.width * 0.4,
                        child: CommonViewWidget(
                          fObj: {
                            'name': Languages.of(context)!.labelCaloriesBurn,
                            "value": "${dataJog.toStringAsFixed(2)} \n Kcal",
                            "image": "assets/img/Fire_light.svg",
                          },
                          index: 2,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CommonViewWidget extends StatelessWidget {
  final Map fObj;
  final int index;
  const CommonViewWidget({super.key, required this.index, required this.fObj});

  @override
  Widget build(BuildContext context) {
    debugPrint('dataa is ${fObj["value"]}');
    var media = MediaQuery.of(context).size;
    bool isEvent = index % 2 == 0;
    return Container(
      margin: const EdgeInsets.all(5),
      width: media.width * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isEvent
                ? [
                    TColor.primaryColor2.withOpacity(0.5),
                    TColor.primaryColor1.withOpacity(0.5)
                  ]
                : [
                    TColor.secondaryColor2.withOpacity(0.5),
                    TColor.secondaryColor1.withOpacity(0.5)
                  ],
          ),
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  fObj["name"].toString(),
                  style: TextStyle(
                    color: ThemeManager.themeText,
                    fontSize: AppFontSizes.mediumDefault,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  fObj["image"], // Replace with the path to your SVG file
                  width: 27,
                  color: ThemeManager.themeText,
                ),
                // Image.asset(
                //   fObj["image"].toString(),
                //   width: 30,
                //   fit: BoxFit.contain,
                // ),
              ],
            ),
          ),

          // Image.asset(
          //   fObj["image"].toString(),
          //   width: media.width * 0.15,
          //   height: media.width * 0.10,
          //   fit: BoxFit.contain,
          // ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: media.width * 0.2,
              height: media.width * 0.2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: media.width * 0.15,
                    height: media.width * 0.15,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: TColor.primaryG),
                      borderRadius: BorderRadius.circular(media.width * 0.075),
                    ),
                    child: FittedBox(
                      child: Text(
                        fObj["value"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ThemeManager.themeText,
                            fontSize: AppFontSizes.smallDefault),
                      ),
                    ),
                  ),
                  SimpleCircularProgressBar(
                    progressStrokeWidth: 5,
                    backStrokeWidth: 5,
                    progressColors: TColor.primaryG,
                    backColor: Colors.grey.shade100,
                    valueNotifier: ValueNotifier(50),
                    startAngle: -180,
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: Text(
          //     fObj["name"],
          //     style: TextStyle(
          //         color: Colors.black,
          //         fontSize: AppFontSizes .mediumDefault,
          //         fontWeight: FontWeight.w500),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: Text(
          //     "${fObj["size"]} | ${fObj["time"]} | ${fObj["kcal"]}",
          //     style: TextStyle(color: TColor.gray, fontSize: AppFontSizes

          //   ),
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: SizedBox(
          //     width: 90,
          //     height: 35,
          //     child: RoundButton(
          //         fontSize: AppFontSizes

          //         type: isEvent
          //             ? RoundButtonType.bgGradient
          //             : RoundButtonType.bgSGradient,
          //         title: "View",
          //         onPressed: () {}),
          //   ),
          // ),
        ],
      ),
    );
  }
}
