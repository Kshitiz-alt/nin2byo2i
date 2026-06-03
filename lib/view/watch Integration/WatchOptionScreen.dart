import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Help%20Supports/BMICalculator.dart';
import 'package:nin2byo2i/Help%20Supports/BMRCalculator.dart';
import 'package:nin2byo2i/Help%20Supports/HelthRecommandation.dart';
import 'package:nin2byo2i/Help%20Supports/SuggestHealthyFood.dart';
import 'package:nin2byo2i/Help%20Supports/ShareAppAndBarcode.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Repository/TokenManagerforWatch.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/google%20Fit/infra/health_repository.dart';
import 'package:nin2byo2i/view/google%20Fit/models/blood_glucose.dart';
import 'package:nin2byo2i/view/main_tab/google%20signin.dart';
import 'package:nin2byo2i/view/watch%20Integration/WatchApi.dart';
import 'package:nin2byo2i/view/workout_tracker/activitydata.dart';
import 'package:nin2byo2i/common_widget/SelectViw.widget.dart';

import 'package:nin2byo2i/view/Food/AddDishScreen.dart';
import 'package:nin2byo2i/view/Food/Top10FoodList.dart';
import 'package:nin2byo2i/view/Food/showListOfUserFoodTable.dart';
import 'package:nin2byo2i/view/HealthTrends/HealthTrendBottomNav.dart';
import 'package:nin2byo2i/view/MensurationData/MensurationCycle.dart';
import 'package:nin2byo2i/view/ScreensAPP/CsvFileDownload.dart';
import 'package:nin2byo2i/view/ScreensAPP/ListOfAllBooks.dart';
import 'package:nin2byo2i/view/ScreensAPP/OrderHistory.dart';
import 'package:nin2byo2i/view/ScreensAPP/RozarPayPayment.dart';

import 'package:nin2byo2i/view/ScreensAPP/getweekwaterintake.dart';
import 'package:nin2byo2i/view/ScreensAPP/setnotification.dart';
import 'package:nin2byo2i/view/ScreensAPP/texttovoice.dart';
import 'package:nin2byo2i/view/workout_tracker/activity_tracker_view.dart';

import 'package:nin2byo2i/view/watch%20Integration/fitbitlogine.dart';
import 'package:provider/provider.dart';

//from this page user can select wich watch he want to integrate
class WatchOptions extends StatefulWidget {
  const WatchOptions({super.key});

  @override
  State<WatchOptions> createState() => _WatchOptionsState();
}

class _WatchOptionsState extends State<WatchOptions> {
  final HealthRepository healthRepository = HealthRepository();

  final UserProfileController _controller = UserProfileController();
  bool MensurationToggle = false;
  FlutterTts flutterTts = FlutterTts();

  // String ConectedWatch = '';
  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> disconnectWatch() async {
    await TokenManager.removeId();
    await TokenManager.removeRefreshToken();
    await TokenManager.removeToken();
    await TokenManager.removeWatchType();
    setState(() {
      TokenManager.ConnectedWatch = '';
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeManager.themelightColor,
          title: Text(
            Languages.of(context)!.watchDisconnected,
            style: TextStyle(
              color: ThemeManager.themeText,
            ),
          ),
          content: Text(
            Languages.of(context)!.watchDisconnectedSuccessfully,
            style: TextStyle(
              color: ThemeManager.themeText,
            ),
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
    // Add your logic here to disconnect the watch
    // For example, update the state or call an API to disconnect the watch
  }

  Future<void> _speak(String text) async {
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setLanguage("hi-IN");
    // await flutterTts.setVoice({"name": "hi-in-x-dhi#male_1-local"});

    if (text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  @override
  void initState() {
    super.initState();

    initializeData();
  }

  Future<void> initializeData() async {
    // String? data = await TokenManager.getWatchType();
    // if (data != null) {
    //   setState(() {
    //     ConectedWatch = data;
    //   });
    // }
  }

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ThemeManager.themeColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          Languages.of(context)!.TextAppConnectWatch,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
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
              color: ThemeManager.themeText,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: RefreshIndicator(
        color: Colors.purple, // Set the color of the refresh indicator
        backgroundColor: Colors.white,
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (TokenManager.ConnectedWatch.isNotEmpty)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Column(
                              children: [
                                Text(
                                  '${Languages.of(context)!.labelConnectedWatch} ${TokenManager.ConnectedWatch}',
                                  style: TextStyle(
                                    fontSize: AppFontSizes.largeDefault,
                                    color: ThemeManager.themeText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign:
                                      TextAlign.center, // Center-align the text
                                ),
                                SizedBox(
                                  width: 150,
                                  // height: 35,
                                  child: RoundButton(
                                    title:
                                        Languages.of(context)!.labelDisconnect,
                                    type: RoundButtonType.bgGradient,
                                    fontSize: AppFontSizes.smallDefault,
                                    fontWeight: FontWeight.w400,
                                    onPressed: () {
                                      disconnectWatch();
                                    },
                                  ),
                                )
                                // ElevatedButton(
                                //   onPressed: () {
                                //     // Add logic to disconnect the watch here
                                //     // For example, call a function to handle disconnection
                                //     disconnectWatch();
                                //   },
                                //   child: Text('Disconnect Watch'),
                                // ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16.0), // Adjust the spacing as needed
                          Image.asset(
                            'assets/fitbit.png', // Replace with your asset path
                            width: 150.0, // Adjust the width as needed
                            height: 150.0, // Adjust the height as needed
                            fit: BoxFit.cover,
                          ),
                          // Adjust the spacing as needed
                        ],
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  // onLongPress: () => _speak(
                  //     'click here to Fitbit Screen where you can connect your wtch with this app'),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FitbitAuthPage(),
                        ),
                      );
                    },
                    child: SizedBox(
                        height: media.width * 0.2,
                        child: WatchOptionsWidget(
                          fObj: {
                            "name":
                                "${Languages.of(context)!.labelFitbit} ${Languages.of(context)!.labelwatch} ",
                            "image": "assets/fitbit.png",
                          },
                          index: 8,
                        )),
                  ),
                ),
                GestureDetector(
                  // onLongPress: () => _speak(
                  //     'click here to Fitbit Screen where you can connect your wtch with this app'),
                  child: InkWell(
                    onTap: () async {
                      final GoogleSignIn googleSignIn = GoogleSignIn();
                      try {
                        await googleSignIn.signOut();
                        debugPrint("User signed out");
                      } catch (error) {
                        debugPrint("Error signing out: $error");
                      }
                      // Call the method to get blood glucose data when the button is clicked
                      try {
                        await healthRepository.makeAccess();

                        // Do something with the obtained data, such as displaying it or performing further actions.

                        await TokenManager.saveWatchType('Google Fit');
                        // You can also call the method to get current date steps if needed
                        // int? steps = await healthRepository.getCurrentDateSteps();
                        // debugPrint("Total steps for today: $steps");
                        TokenManager.ConnectedWatch =
                            await TokenManager.getWatchType() as String;
                        final apiDataProvider =
                            Provider.of<WatchApiDataProvider>(context,
                                listen: false);
                        _controller.PostProfileVariableTypeData("Google Fit");
                        apiDataProvider.makeApiCalls();
                        setState(() {});
                      } catch (e) {}

                      // _showModal(context, 'Hello, this is the passed string!');
                      // _reloadPage();
                    },
                    child: SizedBox(
                        height: media.width * 0.2,
                        child: WatchOptionsWidget(
                          fObj: {
                            "name":
                                "${Languages.of(context)!.labelGoogleFit} app ",
                            "image": "assets/fitbit.png",
                          },
                          index: 8,
                        )),
                  ),
                ),
                // GestureDetector(
                //   onLongPress: () => _speak(
                //       'click here to Fitbit Screen where you can connect your wtch with this app'),
                //   child: InkWell(
                //     onTap: () {},
                //     child: SizedBox(
                //         height: media.width * 0.2,
                //         child: WatchOptionsWidget(
                //           fObj: {
                //             "name":
                //                 "${Languages.of(context)!.labelAppleWatch}   ",
                //             "image": "assets/fitbit.png",
                //           },
                //           index: 8,
                //         )),
                //   ),
                // ),
                // GestureDetector(
                //   onLongPress: () => _speak(
                //       'click here to Fitbit Screen where you can connect your wtch with this app'),
                //   child: InkWell(
                //     onTap: () {},
                //     child: SizedBox(
                //         height: media.width * 0.2,
                //         child: WatchOptionsWidget(
                //           fObj: {
                //             "name":
                //                 "${Languages.of(context)!.labelSamsungSmartWatch}  ",
                //             "image": "assets/fitbit.png",
                //           },
                //           index: 8,
                //         )),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to show the modal
  void _showModal(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Languages.of(context)!.NINTextSuccess),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the modal
              },
              child: Text(Languages.of(context)!.NINTextClose),
            ),
          ],
        );
      },
    );
  }
}

class WatchOptionsWidget extends StatelessWidget {
  final Map fObj;
  final int index;
  const WatchOptionsWidget(
      {super.key, required this.index, required this.fObj});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    bool isEvent = index % 2 == 0;
    return Container(
      margin: const EdgeInsets.all(5),
      width: media.width * 0.9,
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
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          Image.asset(
            fObj["image"].toString(),
            width: media.width * 0.15,
            height: media.width * 0.10,
            fit: BoxFit.contain,
          ),
          // Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              fObj["name"],
              style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
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
