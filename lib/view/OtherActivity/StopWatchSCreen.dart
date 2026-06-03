import 'dart:async';
import 'dart:convert'; // Add this line for JSON encoding
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nin2byo2i/Common/DateFormatter.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart'; // Add this line for HTTP requests
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:intl/intl.dart';

//this page is stop watch for activity page
class StopwatchScreen extends StatefulWidget {
  final String activityType;
  // final DateTime selectedDate;

  const StopwatchScreen({super.key, required this.activityType});
  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  final UserProfileController _controller = UserProfileController();
  late Stopwatch stopwatch;
  late Timer t;
  late DateTime startTime, endTime;
  bool flag = true;
  void handlestartstop(String type) {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    if (type == "stop") {
      stopwatch.stop();
      endTime = DateTime.now();
    } else if (type == "start") {
      stopwatch.start();
      if (flag) {
        startTime = DateTime.now();
        flag = false;
      }
    }
  }

  String selectedDate2 = "";
  final DateTime _selectedDate = DateTime.now();
//  void handlestartstop() {
//     setState(() {
//       _isPlaying = !_isPlaying;
//     });
//     if (stopwatch.isRunning) {
//       stopwatch.stop();
//       endTime = DateTime.now();
//     } else {
//       stopwatch.start();
//       if (flag) {
//         startTime = DateTime.now();
//         flag = false;
//       }
//     }
//   }
  String formattedtextreturn() {
    var milli = stopwatch.elapsed.inMilliseconds;
    String milliseconds = (milli % 1000).toString().padLeft(3, "0");
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0");
    return "$minutes:$seconds:$milliseconds";
  }

  // Function to submit duration to API
  Future<void> submitDuration() async {
    if (stopwatch.isRunning) {
      // Timer is still running, show a message or take appropriate action

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(Languages.of(context)!.NINTextTimerRunning),
            content: Text(Languages.of(context)!
                .NINTextPleaseStopTheTimerBeforeSubmitting),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(Languages.of(context)!.ok),
              ),
            ],
          );
        },
      );
    } else {
      String formattedStartTime =
          startTime.toLocal().toIso8601String().split('T')[1].substring(0, 8);
      String formattedEndTime =
          endTime.toLocal().toIso8601String().split('T')[1].substring(0, 8);

      try {
        final data = await _controller.addExercise(
          widget.activityType,
          formattedStartTime,
          formattedEndTime,
          (stopwatch.elapsed.inMilliseconds / (1000 * 60)),
          selectedDate2,
          // context
        );
        debugPrint('Error fetchigfb ng exerc a');
      } catch (error) {
        debugPrint('Error fetching exercise data: $error');
        // Handle error as needed
      }

      String s = (stopwatch.elapsed.inMilliseconds / 1000).toString();
      // Timer has stopped, proceed to submit the duration to API
      debugPrint(
          'data  is here ${(stopwatch.elapsed.inMilliseconds / 1000).toString()} $startTime $endTime');
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text(Languages.of(context)!.NINTextSubmittedSuccessfully1),
      //       content: Text(
      //           ' ${Languages.of(context)!.NINTextTotalDuration} $s ${Languages.of(context)!.NINTextSec}'),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             Navigator.pop(context);
      //           },
      //           child: Text(Languages.of(context)!.ok),
      //         ),
      //       ],
      //     );
      //   },
      // );
      stopwatch.reset();

      flag = true;
      // Add your API submission logic here
    }
  }

  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    t.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedDate2 = DateFormat("yyyy-MM-dd").format(_selectedDate);
    stopwatch = Stopwatch();

    t = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
              widget.activityType,
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
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   'Activity Type: ${widget.activityType}',
                    //   style: TextStyle(fontSize: AppFontSizes.mediumDefault),
                    // ),
                    const SizedBox(height: 20),

                    Text(
                      Languages.of(context)!.NINTextStartYourActivity,
                      style: TextStyle(
                          fontSize: AppFontSizes.mediumDefault,
                          fontWeight: FontWeight.bold,
                          color: ThemeManager.themeText),
                    ),
                    const SizedBox(height: 20),
                    // Add your stopwatch widget or other components here
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 4,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formattedtextreturn(),
                          style: TextStyle(
                            color: ThemeManager.themeText,
                            fontWeight: FontWeight.bold,
                            fontSize: AppFontSizes.extraLargeDefault,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                sizedBox12(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        handlestartstop("start");
                      },
                      child: Container(
                        width: 120, // Adjust width as needed
                        height: 50, // Adjust height as needed
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xaa15b8ff),
                              Color(0xaa15b8ff)
                            ],
                          ), // Change the color as needed
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the border radius as needed
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Languages.of(context)!.labelStart,
                              style: const TextStyle(
                                fontSize: AppFontSizes
                                    .mediumDefault, // Adjust the font size as needed
                                color: Colors
                                    .black, // Change the text color as needed
                              ),
                            ),
                            // Adjust the icon color as needed
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        handlestartstop("stop");
                      },
                      child: Container(
                        width: 120, // Adjust width as needed
                        height: 50, // Adjust height as needed
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFFDC1439), // Change the color as needed
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the border radius as needed
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Languages.of(context)!.NINTextPause,
                              style: const TextStyle(
                                fontSize: AppFontSizes
                                    .mediumDefault, // Adjust the font size as needed
                                color: Colors
                                    .white, // Change the text color as needed
                              ),
                            ),
                            // Adjust the icon color as needed
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 250,
                  height: 45,
                  child: RoundButton(
                    title: Languages.of(context)!.submit,
                    type: RoundButtonType.bgGradient,
                    fontSize: AppFontSizes.mediumDefault,
                    fontWeight: FontWeight.w400,
                    onPressed: () {
                      // Call the function to submit duration to API
                      submitDuration();
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 150,
                  // height: 45,
                  child: RoundButton(
                    title: Languages.of(context)!.NINTextReset,
                    type: RoundButtonType.bgSGradient,
                    fontSize: AppFontSizes.mediumDefault,
                    fontWeight: FontWeight.w400,
                    onPressed: () {
                      stopwatch.reset();
                      flag = true;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // SizedBox(
                //   width: 250,
                //   // height: 45,
                //   child: RoundButton(
                //     title: Languages.of(context)!.submit,
                //     type: RoundButtonType.bgGradient,
                //     fontSize: AppFontSizes.mediumDefault,
                //     fontWeight: FontWeight.w400,
                //     onPressed: () {
                //       // Call the function to submit duration to API
                //       submitDuration();
                //     },
                //   ),
                // ),
                const SizedBox(height: 130),
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
    );
  }
}
