import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/DateFormatter.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/view/OtherActivity/StopWatchSCreen.dart';
import 'package:intl/intl.dart';

//this page is hsow individual activity
class ShowIndividualActivityData extends StatefulWidget {
  final String activity;

  const ShowIndividualActivityData(this.activity, {super.key});

  @override
  _ShowIndividualActivityDataState createState() =>
      _ShowIndividualActivityDataState();
}

class _ShowIndividualActivityDataState
    extends State<ShowIndividualActivityData> {
  List<Map<String, dynamic>> exerciseData = [];

  DateTime selectedDate = DateTime.now();
  String SelectedDateIs = "";
  final UserProfileController _controller = UserProfileController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
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
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      await fetchData();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    selectedDate2 = DateFormat("yyyy-MM-dd").format(_selectedDate);
    // setStartTimeEnd();
    getStartTime();
  }

  Future<void> fetchData() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    SelectedDateIs = formattedDate;
    try {
      final data = await _controller.getExerciseByDateAndActivityType(
          formattedDate, widget.activity);
      debugPrint('Error fetchigfb ng exerc $data');
      setState(() {
        exerciseData = data;
      });
    } catch (error) {
      debugPrint('Error fetching exercise data: $error');
      // Handle error as needed
    }
  }

  Future<void> _refresh() async {
    fetchData();
  }

  String timeString = "12:00:12";
  // void setStartTimeEnd() async {
  //   debugPrint("gfhfhjnghmhmh $timeString");
  //   timeString = await _controller.fetchEndTimeByDate(
  //       DateFormat("yyyy-MM-dd").format(DateTime.now())) as String;
  //   debugPrint("gfhfhjnghmhmh $timeString");
  //   setState(() {});
  // }

  TextEditingController activityController = TextEditingController();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  Future<void> getStartTime() async {
    // Move the parseTimeOfDay function declaration before its usage
    debugPrint("fdgfhghg $selectedDate");
    timeString = await _controller
        .fetchEndTimeByDate(selectedDate2.split(' ')[0]);
    TimeOfDay parseTimeOfDay(String time) {
      final parts = time.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        return TimeOfDay(hour: hour, minute: minute);
      } else {
        throw const FormatException("Invalid time format");
      }
    }

    TimeOfDay addMinutes(TimeOfDay time, int minutesToAdd) {
      final int totalMinutes = time.hour * 60 + time.minute + minutesToAdd;
      final int endHour = totalMinutes ~/ 60;
      final int endMinute = totalMinutes % 60;
      return TimeOfDay(
          hour: endHour % 24,
          minute: endMinute); // Adjust for overflow if necessary
    }

    // TimeOfDay startTime = parseTimeOfDay(timeString);
    // TimeOfDay endTime = addMinutes(startTime, 60);
    //   TimeOfDay startTime = parseTimeOfDay(timeString);
    setState(() {
      startTime = parseTimeOfDay(timeString);
      endTime = addMinutes(startTime, 60);
      debugPrint("Fvdbgfbhghngnghn $startTime $endTime");
    });
  }

  String selectedDate2 = "";
  DateTime _selectedDate = DateTime.now();
  // final UserProfileController _controller = UserProfileController();

  void _showActivityTimerDialog(BuildContext context, String activityType) {
    TextEditingController activityController = TextEditingController();

    // TimeOfDay startTime = TimeOfDay.now();
    // TimeOfDay endTime = TimeOfDay.now();
    // DateTime? _selectedDate;
    // String selectedDate2 = DateFormat("yyyy-MM-dd").format(DateTime.now());

    String convertMinutesToHoursAndMinutes(int minutes) {
      int hours = minutes ~/ 60;
      int remainingMinutes = minutes % 60;
      return '${hours}h ${remainingMinutes}m';
    }

    int calculateDurationInMinutes(TimeOfDay startTime, TimeOfDay endTime) {
      final now = DateTime.now();
      final startDateTime = DateTime(
          now.year, now.month, now.day, startTime.hour, startTime.minute);
      final endDateTime =
          DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);

      final duration = endDateTime.difference(startDateTime);
      int timeDuration = duration.inMinutes;
      if (timeDuration < 0) {
        timeDuration += 1440;
      }
      return timeDuration;
    }

    int durationInMinutes = calculateDurationInMinutes(startTime, endTime);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        var media = MediaQuery.of(context).size;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                  '${Languages.of(context)!.NINTextEnterDurationFor} $activityType'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: media.width * 0.5,
                        child: Text(
                            "${Languages.of(context)!.TextAppSelectDate} : ${DateFormatter.convertDate(selectedDate2)}"),
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
                            lastDate: now,
                            selectableDayPredicate: (DateTime date) {
                              return date.isAfter(lastAllowedDate) ||
                                  date.isAtSameMomentAs(lastAllowedDate) &&
                                      date.isBefore(now);
                            },
                          );

                          if (picked != null && picked != _selectedDate) {
                            setState(() async {
                              _selectedDate = picked;
                              selectedDate2 =
                                  DateFormat("yyyy-MM-dd").format(picked);
                              debugPrint("fdgfhghg $selectedDate");
                              timeString = await _controller.fetchEndTimeByDate(
                                  selectedDate2.split(' ')[0]);
                              TimeOfDay parseTimeOfDay(String time) {
                                final parts = time.split(':');
                                if (parts.length >= 2) {
                                  final hour = int.parse(parts[0]);
                                  final minute = int.parse(parts[1]);
                                  return TimeOfDay(hour: hour, minute: minute);
                                } else {
                                  throw const FormatException("Invalid time format");
                                }
                              }

                              TimeOfDay addMinutes(
                                  TimeOfDay time, int minutesToAdd) {
                                final int totalMinutes =
                                    time.hour * 60 + time.minute + minutesToAdd;
                                final int endHour = totalMinutes ~/ 60;
                                final int endMinute = totalMinutes % 60;
                                return TimeOfDay(
                                    hour: endHour % 24,
                                    minute:
                                        endMinute); // Adjust for overflow if necessary
                              }

                              // TimeOfDay startTime = parseTimeOfDay(timeString);
                              // TimeOfDay endTime = addMinutes(startTime, 60);
                              //   TimeOfDay startTime = parseTimeOfDay(timeString);
                              setState(() {
                                startTime = parseTimeOfDay(timeString);
                                endTime = addMinutes(startTime, 60);

                                debugPrint("Fvdbgfbhghngnghn $startTime $endTime");
                              });
                              // await getStartTime2();
                            });
                          }
                        },
                        icon: const Icon(Icons.date_range),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  ListTile(
                    title: Text(
                        '${Languages.of(context)!.labelStartTime}: ${startTime.format(context)}'),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: startTime,
                      );
                      if (pickedTime != null && pickedTime != startTime) {
                        setState(() {
                          startTime = pickedTime;
                          durationInMinutes =
                              calculateDurationInMinutes(startTime, endTime);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ListTile(
                    title: Text(
                        '${Languages.of(context)!.labelEndTime}: ${endTime.format(context)}'),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: endTime,
                      );
                      if (pickedTime != null && pickedTime != endTime) {
                        setState(() {
                          endTime = pickedTime;
                          durationInMinutes =
                              calculateDurationInMinutes(startTime, endTime);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "${Languages.of(context)!.NINTextTotalDuration} = ${convertMinutesToHoursAndMinutes(durationInMinutes)}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      //   _controller.setLoading(true);
                      Navigator.of(context).pop();
                      String startTimeString =
                          '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}:00';
                      String endTimeString =
                          '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}:00';

                      // final data =
                      await _controller.addExercise(
                        activityType,
                        startTimeString,
                        endTimeString,
                        durationInMinutes.toDouble(),
                        selectedDate2,
                        // context,
                      );
                      if (mounted) {
                        _controller.fetchStepsOfToday();
                        fetchData();
                        getStartTime();
                      }

                      //  Navigator.pop(context); // Close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColor.secondaryColor1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: Text('Save'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
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

  String formatMinutes(double minutes) {
    if (minutes < 0) {
      throw ArgumentError('Minutes should be a non-negative number.');
    }

    int hours = minutes ~/ 60;
    int remainingMinutes = (minutes % 60).floor();
    int seconds = ((minutes * 60) % 60).floor();

    return '${hours}h ${remainingMinutes}m ${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return RefreshIndicator(
      color: TColor.secondaryColor1, // Set the color of the refresh indicator
      backgroundColor: TColor.primaryColor1,
      onRefresh: _refresh,
      child: Stack(
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
                widget.activity,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _showActivityTimerDialog(context, widget.activity);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColor
                            .secondaryColor1, // Set the background color to light blue
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              25.0), // Set the border radius
                        ),
                      ),
                      child: Text(
                        Languages.of(context)!.TextAppAddDurationManually,
                        style: const TextStyle(
                          fontSize: AppFontSizes.mediumDefault,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: TColor.primaryColor1.withOpacity(0.2)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              // width: screenWidth * 0.65,
                              width: 200,
                              child: Text(
                                Languages.of(context)!
                                    .TextAppClickStartToStartActivity,
                                style: TextStyle(
                                  color: ThemeManager.themeText,
                                  fontSize: AppFontSizes.extraLargeDefault,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 1.2, // Increase the line height
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                // Add your logic to handle the start button click
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StopwatchScreen(
                                        activityType: widget.activity),
                                  ),
                                );
                                fetchData();
                              },
                              child: Container(
                                width: media.width * 0.20,
                                height: media.width * 0.20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  gradient:
                                      LinearGradient(colors: TColor.primaryG),
                                  borderRadius:
                                      BorderRadius.circular(media.width * 0.75),
                                ),
                                child: FittedBox(
                                  child: Text(
                                    Languages.of(context)!.labelStart,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: AppFontSizes.mediumDefault),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  sizedBox12(),
                  Container(
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(14),
                    //     color: Color.fromARGB(255, 198, 223, 223)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          DateFormatter.convertDate(SelectedDateIs),
                          style: TextStyle(
                            color: ThemeManager.themeText,
                            fontSize: AppFontSizes.extraLargeDefault,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 1.2, // Increase the line height
                          ),
                        ),
                        // ElevatedButton(
                        //   onPressed: () => _selectDate(context),
                        //   child: Text('Select Date'),
                        // ),
                        SizedBox(
                          width: 150,
                          // height: 35,
                          child: RoundButton(
                            title: Languages.of(context)!.labelSelectDate,
                            type: RoundButtonType.bgGradient,
                            fontSize: AppFontSizes.smallDefault,
                            fontWeight: FontWeight.w400,
                            onPressed: () => _selectDate(context),
                          ),
                        )
                      ],
                    ),
                  ),
                  sizedBox12(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Divider(
                      color: ThemeManager.themeText,
                      height: 10, // You can adjust the height of the line
                      thickness: 1, // You can adjust the thickness of the line
                    ),
                  ),
                  const SizedBox(height: 20),
                  exerciseData.isNotEmpty
                      ? Column(
                          children: [
                            // for (var exercise in exerciseData)
                            for (int i = exerciseData.length - 1; i >= 0; i--)
                              // ListTile(
                              //   title: Text('Date: ${(exercise['date'])}'),
                              //   subtitle: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text('Start Time: ${exercise['startTime']}'),
                              //       Text('End Time: ${exercise['endTime']}'),
                              //       Text('Duration: ${exercise['duration']} minutes'),
                              //       Text(
                              //           'calories: ${exercise['caloriesBurned']} kcal'),
                              //     ],
                              //   ),
                              // ),
                              IndividualdataWidget(
                                fObj: {
                                  "name":
                                      '${convertTo12HourFormat(exerciseData[i]['startTime'])} to ${convertTo12HourFormat(exerciseData[i]['endTime'])} for ${formatMinutes(exerciseData[i]['duration'])}',
                                  "image": 'assets/img/burn.png',
                                  "discription":
                                      'Calories Burnt : ${tryConvertToString(exerciseData[i]['caloriesBurned'])} Kcal',
                                  "id": " ${exerciseData[i]['id']}",
                                },
                              ),
                          ],
                        )
                      : Text(
                          Languages.of(context)!.TextAppNoRecord,
                          style: TextStyle(color: ThemeManager.themeText),
                        )
                ],
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

  String formattedDate(List<int> dateList) {
    final date = DateTime(dateList[0], dateList[1], dateList[2]);
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Widget IndividualdataWidget({required Map<String, dynamic> fObj}) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 12),
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
                          // title: Text("Success"),
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
                      fetchData();
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

class IndividualdataWidget extends StatelessWidget {
  final Map fObj;
  const IndividualdataWidget({super.key, required this.fObj});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 12),
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
                  final UserProfileController controller =
                      UserProfileController();
                  debugPrint("asdfdgftjgfkh ${fObj["id"]}");
                  await controller.deleteExercise(fObj["id"]);

                  // Show success alert box
                  showDialog(
                    context:
                        context, // Make sure to have access to the BuildContext
                    builder: (BuildContext context) {
                      return AlertDialog(
                        // title: Text("Success"),
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
