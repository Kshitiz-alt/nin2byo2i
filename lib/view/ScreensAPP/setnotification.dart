import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'dart:convert';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//set reminder page
class SetReminder extends StatefulWidget {
  const SetReminder({super.key});

  @override
  _SetReminderState createState() => _SetReminderState();
}

class _SetReminderState extends State<SetReminder> {
  final UserProfileController _controller = UserProfileController();
  List<Map<String, dynamic>> apiData = [];
  void loaddata() async {
    final data = await _controller.getNotificationSheduledData();
    debugPrint("data is hehgfjgjgre $data");
    setState(() {
      apiData = data;
    });
  }

  late TimeOfDay startTime;
  late TimeOfDay endTime;
  String selectedReminderType = 'Breakfast'; // Default value

  @override
  void initState() {
    super.initState();
    startTime = TimeOfDay.now();
    endTime = TimeOfDay.now();
    loaddata();
  }

  // void _toggleNotification(bool value) async {
  //   try {
  //     await UserProfileController.OnOffNotificationForReminders(
  //         value, 'Snacks');
  //     setState(() {
  //       // isNotificationOn = value;
  //     });
  //   } catch (error) {
  //     // Handle error
  //     debugPrint('Error: $error');
  //   }
  // }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: startTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: TColor.primaryColor1,
            colorScheme: ColorScheme.dark(
              primary: TColor.primaryColor1, // Background color of the calendar
              onPrimary: ThemeManager.themeText, // Text color of the calendar
              surface: TColor.primaryColor1, // Background color of the modal
              onSurface: ThemeManager.themeText, // Text color of the modal
            ),
            // colorScheme: ColorScheme.light(primary: Colors.green),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: ThemeManager
                  .themelightColor, // Set the background color for the time picker
              hourMinuteTextColor: ThemeManager
                  .themeText, // Set the text color for hours and minutes
              dayPeriodTextColor:
                  ThemeManager.themeText, // Set the text color for AM/PM
              //  dayPeriodTextFontWeight: FontWeight.bold, // Set the font weight for AM/PM
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != startTime) {
      setState(() {
        startTime = pickedTime;
        endTime = TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute);
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: endTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: TColor.primaryColor1,
            colorScheme: ColorScheme.dark(
              primary: TColor.primaryColor1, // Background color of the calendar
              onPrimary: ThemeManager.themeText, // Text color of the calendar
              surface: TColor.primaryColor1, // Background color of the modal
              onSurface: ThemeManager.themeText, // Text color of the modal
            ),
            // colorScheme: ColorScheme.light(primary: Colors.green),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: ThemeManager
                  .themelightColor, // Set the background color for the time picker
              hourMinuteTextColor: ThemeManager
                  .themeText, // Set the text color for hours and minutes
              dayPeriodTextColor:
                  ThemeManager.themeText, // Set the text color for AM/PM
              //  dayPeriodTextFontWeight: FontWeight.bold, // Set the font weight for AM/PM
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != endTime) {
      // Check if the picked time is more than the start time and less than 1 hour from the start time
      if ((pickedTime.hour > startTime.hour ||
              (pickedTime.hour == startTime.hour &&
                  pickedTime.minute > startTime.minute)) &&
          (pickedTime.hour < startTime.hour + 1 ||
              (pickedTime.hour == startTime.hour + 1 &&
                  pickedTime.minute <= startTime.minute))) {
        setState(() {
          endTime = pickedTime;
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: ThemeManager.themelightColor,
              title: Text(
                Languages.of(context)!.invalidEndTime,
                style: TextStyle(color: ThemeManager.themeText),
              ),
              content: Text(
                Languages.of(context)!.chooseTimeWithin1Hour,
                style: TextStyle(color: ThemeManager.themeText),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    Languages.of(context)!.ok,
                    style: TextStyle(color: ThemeManager.themeText),
                  ),
                ),
              ],
            );
          },
        );
        // Show an error or handle the case where the selected time is not within the desired range
        debugPrint(
            "Invalid end time. Please choose a time within 1 hour of the start time.");
      }
    }
  }

  Future<void> _sendDataToServer() async {
    // Format the time to HH:mm:ss in 24-hour format
    String formattedStartTime =
        '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}:00';
    String formattedEndTime =
        '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}:00';

    // Create the data in the required format
    Map<String, dynamic> data = {
      "startTime": formattedStartTime,
      "lastTime": formattedEndTime,
      "notificationType": selectedReminderType, // Use selected reminder type
    };
    final bool success = await _controller.postNotificationTimingStartEnd(data);
    debugPrint('bool data is $success');
    if (success == true) {
      // ... your existing success dialog code
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ThemeManager.themelightColor,
            title: Text(
              Languages.of(context)!.notificationSaved,
              style: TextStyle(color: ThemeManager.themeText),
            ),
            content: Text(
              Languages.of(context)!.notificationSetSuccessfully,
              style: const TextStyle(color: Colors.green),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Navigator.of(context).pop();
                  // Navigator.of(context).pop();
                },
                child: Text(
                  Languages.of(context)!.ok,
                  style: TextStyle(color: ThemeManager.themeText),
                ),
              ),
            ],
          );
        },
      );
      loaddata();
    } else {
      // ... your existing error dialog code
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ThemeManager.themelightColor,
            title: Text(
              Languages.of(context)!.thereIsSomeError,
              style: const TextStyle(color: Colors.red),
            ),
            content: Text(
              Languages.of(context)!.thereIsSomeError,
              style: const TextStyle(color: Color.fromARGB(255, 175, 120, 76)),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Navigator.of(context).pop();
                  // Navigator.of(context).pop();
                },
                child: Text(
                  Languages.of(context)!.ok,
                  style: TextStyle(color: ThemeManager.themeText),
                ),
              ),
            ],
          );
        },
      );
    }

    debugPrint('notification send is $success');

    // Convert the data to JSON
    String jsonData = json.encode(data);

    // Send jsonData to the server (you would replace this with your server logic)
    debugPrint(jsonData);
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
          Languages.of(context)!.labelSetNotification,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  // gradient: LinearGradient(colors: TColor.primaryG),
                  color: const Color.fromARGB(255, 189, 20, 124),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    style: const TextStyle(color: Colors.white),
                    dropdownColor: const Color.fromARGB(255, 189, 20, 124),
                    icon: const Icon(Icons.expand_more, color: Colors.white),
                    underline: Container(),
                    items: [
                      'Breakfast',
                      'Lunch',
                      'Snacks',
                      'Dinner',
                      'Drinking Water',
                      // 'Calorie Target',
                      // 'Weight',
                      'Sleep',
                    ]
                        .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: AppFontSizes.mediumDefault),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedReminderType = newValue!;
                      });
                    },
                    hint: Text(
                      selectedReminderType,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ThemeManager.themeColor,
                          fontSize: AppFontSizes.smallDefault),
                    ),
                  ),
                )),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text('Start Time: ${startTime.format(context)}'),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SizedBox(
                    child: Text(
                      '${Languages.of(context)!.labelStartTime}: ${startTime.format(context)}',
                      style: TextStyle(
                        fontSize: AppFontSizes.mediumDefault,
                        fontWeight: FontWeight.bold,
                        color: ThemeManager.themeText,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  // height: 30,
                  child: RoundButton(
                      title: Languages.of(context)!.labelSelect,
                      type: RoundButtonType.bgGradient,
                      // fontSize: AppFontSizes

                      fontWeight: FontWeight.w400,
                      onPressed: () => _selectStartTime(context)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Text('End Time: ${endTime.format(context)}'),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SizedBox(
                    // width: media.width * 0.3,
                    child: Text(
                      '${Languages.of(context)!.labelEndTime}: ${endTime.format(context)}',
                      style: TextStyle(
                        fontSize: AppFontSizes.mediumDefault,
                        fontWeight: FontWeight.bold,
                        color: ThemeManager.themeText,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  // height: 30,
                  child: RoundButton(
                      title: Languages.of(context)!.labelSelect,
                      type: RoundButtonType.bgGradient,
                      // fontSize: AppFontSizes

                      fontWeight: FontWeight.w400,
                      onPressed: () => _selectEndTime(context)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: 100,
                // height: 55,
                child: RoundButton(
                  title: Languages.of(context)!.labelSave,
                  type: RoundButtonType.bgGradient,
                  // fontSize: AppFontSizes

                  fontWeight: FontWeight.w400,
                  onPressed: _sendDataToServer,
                ),
              ),
            ),
            sizedBox12(),
            Expanded(
              child: ListView.builder(
                itemCount: apiData.length,
                itemBuilder: (context, index) {
                  bool toggle = apiData[index]["notificationOn"] ?? false;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: media.width * 0.6,
                                      child: Text(
                                        '${Languages.of(context)!.labelStart} : ${convertTo12HourFormat(apiData[index]["startTime"])} - ${Languages.of(context)!.labelEnd} : ${convertTo12HourFormat(apiData[index]["lastTime"])}',
                                        style: TextStyle(
                                            color: ThemeManager.themeText),
                                      ),
                                    ),
                                    // Text(
                                    //   'Start : ${apiData[index]["notificationOn"]}',
                                    //   style: TextStyle(
                                    //       color: ThemeManager.themeText),
                                    // ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              // IconButton(
                              //   icon: Icon(
                              //     Icons.edit,
                              //     color: Colors.blue,
                              //   ),
                              //   onPressed: () {},
                              // ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(Languages.of(context)!
                                            .ninTextDeleteNotification),
                                        content: Text(Languages.of(context)!
                                            .ninTextConfirmDeleteNotification),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close dialog
                                            },
                                            child: Text(
                                                Languages.of(context)!.cancel),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              // Perform delete operation here
                                              await UserProfileController
                                                  .DleteNotification(
                                                      apiData[index]["id"]);
                                              setState(() {
                                                apiData.removeAt(index);
                                              });
                                              Navigator.of(context)
                                                  .pop(); // Close dialog
                                            },
                                            child: Text(Languages.of(context)!
                                                .ninTextDelete),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: media.width * 0.6,
                                  child: Text(
                                    '${Languages.of(context)!.labelType}: ${apiData[index]["notificationType"]}',
                                    style: TextStyle(
                                        color: ThemeManager.themeText),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              CustomAnimatedToggleSwitch<bool>(
                                current: toggle,
                                values: const [false, true],
                                dif: 0.0,
                                indicatorSize: const Size.square(30.0),
                                animationDuration:
                                    const Duration(milliseconds: 100),
                                animationCurve: Curves.linear,
                                onChanged: (newValue) {},
                                iconBuilder: (context, local, global) {
                                  return const SizedBox();
                                },
                                defaultCursor: SystemMouseCursors.click,
                                onTap: () async {
                                  toggle = !toggle;
                                  await UserProfileController
                                      .OnOffNotificationForReminders(toggle,
                                          '${apiData[index]["notificationType"]}');

                                  // Update the toggle status in the data
                                  setState(() {
                                    apiData[index]["notificationOn"] = toggle;
                                  });
                                  // debugPrint('Toggle switch onChanged: ');

                                  // bool newPositive = await updateNotification(
                                  //     MensurationToggle);
                                  // debugPrint('new flag is here $newPositive');
                                  // setState(
                                  //     () => MensurationToggle = newPositive);
                                },
                                iconsTappable: false,
                                wrapperBuilder: (context, global, child) {
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                          left: 10.0,
                                          right: 10.0,
                                          height: 10.0,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: toggle
                                                      ? [
                                                          const Color(0xFF007BC1),
                                                          const Color(0xFF007BC1)
                                                        ]
                                                      : TColor.secondaryG),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(50.0)),
                                            ),
                                          )),
                                      child,
                                    ],
                                  );
                                },
                                foregroundIndicatorBuilder: (context, global) {
                                  return SizedBox.fromSize(
                                    size: const Size(10, 10),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: ThemeManager.themeColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50.0)),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black,
                                              spreadRadius: 0.05,
                                              blurRadius: 1.1,
                                              offset: Offset(0.0, 0.8))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                width: 5,
                              )
                              // Switch(
                              //   value: toggle,
                              //   onChanged: (value) async {
                              //     // Call the method to handle notification changes
                              //     await UserProfileController
                              //         .OnOffNotificationForReminders(value,
                              //             '${apiData[index]["notificationType"]}');

                              //     // Update the toggle status in the data
                              //     setState(() {
                              //       apiData[index]["notificationOn"] = value;
                              //     });
                              //   },
                              //   activeColor: toggle
                              //       ? Color(0xFF007BC1)
                              //       : TColor.secondaryColor1,
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomShowFieldLink extends StatelessWidget {
  final String svgIconPath; // Path to your SVG file
  final String labelText;

  const CustomShowFieldLink({
    Key? key,
    required this.svgIconPath,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            // Use SvgPicture.asset to load the SVG icon
            SvgPicture.asset(
              svgIconPath,
              color: const Color(0xFFACA3A5),
              width: 24, // Adjust the width as needed
              height: 24, // Adjust the height as needed
            ),
            const SizedBox(width: 12.0),
            Text(
              labelText,
              style: const TextStyle(
                color: Color(0xFFACA3A5),
                fontSize: AppFontSizes.smallDefault,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            const Text(
              "values",
              style: TextStyle(
                color: Color(0xFFACA3A5),
                fontSize: AppFontSizes.smallDefault,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            const Icon(Icons.next_plan)
          ],
        ),
      ),
    );
  }
}
