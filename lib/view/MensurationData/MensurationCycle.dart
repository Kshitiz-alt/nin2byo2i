import 'package:flutter/material.dart';
import 'package:nin2byo2i/Classes/MensurationClass.dart';
import 'package:nin2byo2i/Common/DateFormatter.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:intl/intl.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//mensuration cycle page for females
class MensurationCycleScreen extends StatefulWidget {
  const MensurationCycleScreen({super.key});

  @override
  State<MensurationCycleScreen> createState() => _MensurationCycleScreenState();
}

class _MensurationCycleScreenState extends State<MensurationCycleScreen> {
  final UserProfileController _controller = UserProfileController();
  MenstrualCycle MenstrualCycleData = MenstrualCycle(
      calculatedDate: [0, 0, 0],
      lastPeriodStartDate: [0, 0, 0],
      averageCycleLength: 0);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  String SlectedDate = DateFormat('dd MMM yyyy').format(DateTime.now());
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          //  MenstrualCycleData.lastPeriodStartDate != null
          //     ? DateTime(
          //         MenstrualCycleData.lastPeriodStartDate[0],
          //         MenstrualCycleData.lastPeriodStartDate[1],
          //         MenstrualCycleData.lastPeriodStartDate[2],
          //       )
          //     :
          DateTime.now(),
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

    if (picked != null && picked != MenstrualCycleData.lastPeriodStartDate) {
      setState(() {
        // int day = picked.day;
        // String dayString = day
        //     .toString()
        //     .replaceAll(" ", "")
        //     .trim(); // Add leading zero if needed
        // if (dayString.length == 1) {
        //   dayString = '0' + dayString;
        // }
        // debugPrint('lected dat${int.parse(dayString)} lenth ${dayString.length}');
        MenstrualCycleData.lastPeriodStartDate = [
          picked.year,
          picked.month,
          picked.day
          // int.parse(dayString), // Convert back to integer
        ];
        SlectedDate = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  Future<void> loadData() async {
    try {
      final data = await _controller.FetchMensuration();
      setState(() {
        MenstrualCycleData = data;
        debugPrint('dsfvh data is ${MenstrualCycleData.averageCycleLength}');
      });
        } catch (e) {}
  }

  void updateData(MenstrualCycle newData) async {
    // Call the API function to update the data with newData
    final updatedData = await _controller.UpdateMensuration(newData);
    setState(() {
      MenstrualCycleData = updatedData;
      loadData();
    });
    Navigator.of(context).pop(); // Close the update modal
    }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> jsonData = {
      "calculatedDate": [2023, 10, 31],
      "lastPeriodStartDate": [2023, 10, 31],
      "averageCycleLength": 0,
    };
    var media = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
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
                width: 15,
                height: 15,
                color: ThemeManager.themeText,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(
            Languages.of(context)!.labelMensurationStatus,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust border radius as needed
                        color: const Color(0xFF007BC1), // Grey background color
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Languages.of(context)!.labelMensurationCycle,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: AppFontSizes.extraLargeDefault,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    // sizedBox12(),
                    // ShaderMask(
                    //   blendMode: BlendMode.srcIn,
                    //   shaderCallback: (bounds) {
                    //     return LinearGradient(
                    //             colors: TColor.primaryG,
                    //             begin: Alignment.centerLeft,
                    //             end: Alignment.centerRight)
                    //         .createShader(Rect.fromLTRB(
                    //             0, 0, bounds.width, bounds.height));
                    //   },
                    //   child: Text(
                    //     "${MenstrualCycleData.averageCycleLength.toString()} ${Languages.of(context)!.labelDaysLength}",
                    //     style: TextStyle(
                    //         color: ThemeManager.themeColor.withOpacity(0.7),
                    //         fontWeight: FontWeight.w700,
                    //         fontSize: AppFontSizes.mediumDefault),
                    //   ),
                    // ),
                    // sizedBox30(),
                    // Container(
                    //   alignment: Alignment.center,
                    //   child: SizedBox(
                    //     // width: media.width * 0.,
                    //     // height: media.width * 0.4,
                    //     child: Stack(
                    //       alignment: Alignment.center,
                    //       children: [
                    //         Container(
                    //           width: media.width * 0.40,
                    //           height: media.width * 0.40,
                    //           alignment: Alignment.center,
                    //           decoration: BoxDecoration(
                    //             gradient:
                    //                 LinearGradient(colors: TColor.primaryG),
                    //             borderRadius:
                    //                 BorderRadius.circular(media.width * 0.75),
                    //           ),
                    //           child: FittedBox(
                    //             child: Text(
                    //               "${Languages.of(context)!.labelDay} 2",
                    //               textAlign: TextAlign.center,
                    //               style: TextStyle(
                    //                   color: ThemeManager.themeColor,
                    //                   fontSize: AppFontSizes.mediumDefault),
                    //             ),
                    //           ),
                    //         ),
                    //         SimpleCircularProgressBar(
                    //           size: 200,
                    //           progressStrokeWidth: 29,
                    //           backStrokeWidth: 29,
                    //           progressColors: TColor.primaryG,
                    //           backColor: Colors.grey.shade100,
                    //           valueNotifier: ValueNotifier(50),
                    //           startAngle: -180,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    sizedBox30(),
                    _buildInfoBox(
                      title: Languages.of(context)!.labelNextDate,
                      data: DateFormatter.convertDate(
                          '${MenstrualCycleData.calculatedDate[0]}-${MenstrualCycleData.calculatedDate[1]}-${MenstrualCycleData.calculatedDate[2]}'),
                      icon: Icons.date_range,
                    ),
                    _buildInfoBox(
                      title: Languages.of(context)!.labelLastPeriodStartDate,
                      data: DateFormatter.convertDate(
                          '${MenstrualCycleData.lastPeriodStartDate[0]}-${MenstrualCycleData.lastPeriodStartDate[1]}-${MenstrualCycleData.lastPeriodStartDate[2]}'),
                      icon: Icons.access_time,
                    ),
                    _buildInfoBox(
                      title: Languages.of(context)!.labelAverageCycleLength,
                      data:
                          MenstrualCycleData.averageCycleLength.toString(),
                      icon: Icons.timeline,
                    ),
                  ],
                ),
                sizedBox30(),
                // ElevatedButton(
                //   onPressed: () {
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         String newAverageCycleLength =
                //             MenstrualCycleData.averageCycleLength.toString();
                //         return AlertDialog(
                //           title: Text("Update Data"),
                //           content: Column(
                //             mainAxisSize: MainAxisSize.min,
                //             children: <Widget>[
                //               TextButton(
                //                 onPressed: _selectDate,
                //                 child: Text("Select Last Period Start Date"),
                //               ),
                //               TextField(
                //                 controller: TextEditingController(
                //                     text: newAverageCycleLength),
                //                 keyboardType: TextInputType.number,
                //                 onChanged: (newValue) {
                //                   newAverageCycleLength = newValue;
                //                   // debugPrint('lected dat $newAverageCycleLength');
                //                 },
                //               ),
                //             ],
                //           ),
                //           actions: <Widget>[
                //             ElevatedButton(
                //               onPressed: () {
                //                 // if (MenstrualCycleData.lastPeriodStartDate !=
                //                 //         null &&
                //                 //     MenstrualCycleData.averageCycleLength !=
                //                 //         null) {
                //                 MenstrualCycleData.averageCycleLength =
                //                     int.parse(newAverageCycleLength);
                //                 updateData(MenstrualCycleData);
                //               },
                //               child: Text("Update"),
                //             )
                //           ],
                //         );
                //       },
                //     );
                //   },
                //   child: Text("Update"),
                // ),
                GestureDetector(
                  onTap: () {
                    // _openModal(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String newAverageCycleLength =
                            MenstrualCycleData.averageCycleLength.toString();
                        return AlertDialog(
                          backgroundColor: ThemeManager.themelightColor,
                          title: Text(
                            Languages.of(context)!.updateData,
                            style: TextStyle(color: ThemeManager.themeText),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: media.width * 0.6,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Adjust border radius as needed
                                  color: const Color.fromARGB(255, 189, 20,
                                      124), // Grey background color
                                ),
                                child: const Center(
                                    child: Text(
                                  "Set Your Cycle",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Adjust border radius as needed
                                  color: const Color.fromARGB(255, 199, 197,
                                      197), // Grey background color
                                ),
                                child: TextButton(
                                  onPressed: _selectDate,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.date_range),
                                      Text(
                                        Languages.of(context)!
                                            .selectLastPeriodStartDate,
                                        style: TextStyle(
                                          color: ThemeManager.themeText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Enter Average Cycle Length',
                                    style: TextStyle(
                                        color: ThemeManager.themeText,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Adjust border radius as needed
                                  color: const Color.fromARGB(255, 199, 197,
                                      197), // Grey background color
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      // labelText:
                                      //     'Enter New Average Cycle Length',
                                      // labelStyle: TextStyle(
                                      //   color: ThemeManager.themeText,
                                      // ),
                                      border: InputBorder
                                          .none, // Remove bottom line
                                    ),
                                    controller: TextEditingController(
                                        text: newAverageCycleLength),
                                    keyboardType: TextInputType.number,
                                    onChanged: (newValue) {
                                      setState(() {
                                        newAverageCycleLength = newValue;
                                      });
                                    },
                                    style: TextStyle(
                                      color: ThemeManager.themeText,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            Center(
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Adjust border radius as needed
                                    color: const Color.fromARGB(255, 189, 20,
                                        124) // Grey background color
                                    ),
                                child: InkWell(
                                  onTap: () {
                                    // if (MenstrualCycleData.lastPeriodStartDate != null && MenstrualCycleData.averageCycleLength != null) {
                                    MenstrualCycleData.averageCycleLength =
                                        int.parse(newAverageCycleLength);
                                    updateData(MenstrualCycleData);
                                    // Navigator.of(context).pop();
                                  },
                                  child: Center(
                                    child: Text(
                                      Languages.of(context)!.update,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: media.width * 0.30,
                    height: media.width * 0.14,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 189, 20, 124),
                      // gradient: LinearGradient(colors: TColor.primaryG),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: FittedBox(
                      child: Text(
                        "Edit",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ThemeManager.themeColor,
                            fontSize: AppFontSizes.mediumDefault),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoBox(
    {required String title, required String data, required IconData icon}) {
  return Container(
    // decoration: BoxDecoration(
    //   // border: Border.all(
    //   //   color: Colors.grey,
    //   //   width: 1.0,
    //   // ),
    //   borderRadius: BorderRadius.circular(10.0),
    // ),
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    decoration: BoxDecoration(
      color: ThemeManager.themelightColor.withOpacity(0.7),
      borderRadius: BorderRadius.circular(15),
    ),

    margin: const EdgeInsets.all(8.0),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color.fromARGB(255, 189, 20, 124)),
        const SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: TColor.gray,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              data,
              style: TextStyle(
                  color: TColor.primaryColor2,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.w700),
            ),
            // Text(
            //   title,
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(data),
          ],
        ),
      ],
    ),
  );
}
