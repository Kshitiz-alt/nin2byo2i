import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nin2byo2i/Classes/FitnessData.dart';
import 'package:nin2byo2i/Classes/Food%20Classes/foodtableingredient.dart';
import 'package:nin2byo2i/Classes/WaterClass.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nin2byo2i/Classes/earclassforuser.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Controller/temp.dart';
import 'package:nin2byo2i/Help%20Supports/BMICalculator.dart';
import 'package:nin2byo2i/Help%20Supports/BMRCalculator.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/NotificationServices/NotificationServices.dart';
import 'package:nin2byo2i/Repository/TokenManagerforWatch.dart';
import 'package:nin2byo2i/Repository/auth_repo.dart';
import 'package:nin2byo2i/common_widget/CommonLoadingSCreen.dart';
import 'package:nin2byo2i/common_widget/CustomBmiIndicator.dart';
import 'package:nin2byo2i/screens/SignIn/InstructionScreen.dart';

import 'package:nin2byo2i/screens/SignIn/complete_profile.dart';
import 'package:nin2byo2i/screens/SignIn/login.dart';
import 'package:nin2byo2i/screens/SignIn/otp.dart';

import 'package:nin2byo2i/view/Food/FoodAnalyse.dart';
import 'package:nin2byo2i/view/Food/Top10FoodList.dart';
import 'package:nin2byo2i/view/Food/customtablerowforfat.dart';
import 'package:nin2byo2i/view/Food/temp.dart';
import 'package:nin2byo2i/view/HealthTrends/SysTolicAndDiastolicBloodpressure.dart';
import 'package:nin2byo2i/view/HealthTrends/mainpageOfPdf.dart';
import 'package:nin2byo2i/view/HealthTrends/pdfviewer.dart';
import 'package:nin2byo2i/view/OtherActivity/ActitivityDiary.dart';
import 'package:nin2byo2i/view/Food/NutrientInMyFood.dart';
import 'package:nin2byo2i/view/Food/SearchRawFood.dart';
import 'package:nin2byo2i/view/OtherActivity/ActivityTracker.dart';
import 'package:nin2byo2i/view/OtherActivity/TESTFCM.dart';
import 'package:nin2byo2i/view/OtherActivity/TodayActivity.dart';
import 'package:nin2byo2i/view/OtherActivity/hbdcfdijdkng.dart';
import 'package:nin2byo2i/view/OtherActivity/testing.dart';
import 'package:nin2byo2i/view/SuggestionComponents/CarbIntakeResultContainer.dart';
import 'package:nin2byo2i/view/SuggestionComponents/DDSResultContainer.dart';
import 'package:nin2byo2i/view/SuggestionComponents/FatIntakeResultContainer.dart';
import 'package:nin2byo2i/view/SuggestionComponents/ProteinIntakeResultContainer%20.dart';
import 'package:nin2byo2i/view/SuggestionComponents/RefinedSugarIntakeResultContainer.dart';
import 'package:nin2byo2i/view/SuggestionComponents/SaltIntakeResultContainer.dart';
import 'package:nin2byo2i/view/home/BmiScreen.dart';

import 'package:nin2byo2i/view/Food/AddOrEditDishRecipy.dart';
import 'package:nin2byo2i/view/Food/DishSelectionOptions.dart';
import 'package:nin2byo2i/view/Food/AddDishScreen.dart';
import 'package:nin2byo2i/view/Food/NutrientsGoalAccordingRda.dart';
import 'package:nin2byo2i/view/Food/SearchCookedFood.dart';
import 'package:nin2byo2i/view/Food/dietaryDiary.dart';

import 'package:nin2byo2i/view/Food/showListOfUserFoodTable.dart';
import 'package:nin2byo2i/view/HealthTrends/HealthTrendBottomNav.dart';

import 'package:nin2byo2i/common_widget/round_button.dart';

import 'package:nin2byo2i/common_widget/workout_row.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/common_widget/workout_row.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';

import 'package:nin2byo2i/view/MensurationData/MensurationCycle.dart';
import 'package:nin2byo2i/view/ScreensAPP/CartForOrder.dart';
import 'package:nin2byo2i/view/ScreensAPP/OrderHistory.dart';
import 'package:nin2byo2i/view/ScreensAPP/setnotification.dart';
import 'package:nin2byo2i/view/home/RecompleteProfile.dart';
import 'package:nin2byo2i/view/home/facebook.dart';
import 'package:nin2byo2i/view/home/fdfiujrgihigkh.dart';
import 'package:nin2byo2i/view/home/fontsizestest.dart';
import 'package:nin2byo2i/view/home/occupation.dart';
import 'package:nin2byo2i/view/home/spinanimation.dart';
import 'package:nin2byo2i/view/home/tegd.dart';
import 'package:nin2byo2i/view/home/PieChartSample2.dart';
import 'package:nin2byo2i/view/home/testingphomne.dart';
import 'package:nin2byo2i/view/home/testting.dart';

import 'package:nin2byo2i/view/main_tab/AllCalculator.dart';
import 'package:nin2byo2i/view/main_tab/HipWaistTrackerPage.dart';

import 'package:nin2byo2i/view/watch%20Integration/WatchApi.dart';
import 'package:nin2byo2i/view/watch%20Integration/WatchOptionScreen.dart';
import 'package:nin2byo2i/view/OtherActivity/AllActivityTrackers.dart';
import 'package:nin2byo2i/view/workout_tracker/ShowWeeklyCaloriesBurn.dart';
import 'package:nin2byo2i/view/workout_tracker/SleepTrackerSCreen.dart';
import 'package:nin2byo2i/view/OtherActivity/StopWatchSCreen.dart';
import 'package:nin2byo2i/view/workout_tracker/WeeklyHeartRate.dart';
import 'package:nin2byo2i/view/workout_tracker/activitydata.dart';
import 'package:nin2byo2i/view/workout_tracker/weeklySteps.dart';
import 'package:nin2byo2i/view/workout_tracker/weightManager.dart';

import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../../common/colo_extension.dart';
import '../workout_tracker/activity_tracker_view.dart';

import 'notification_view.dart';

//home page view
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List lastWorkoutArr = [
    {
      "name": "Full Body Workout",
      "image": "assets/img/Workout1.png",
      "kcal": "180",
      "time": "20",
      "progress": 0.3
    },
    {
      "name": "Lower Body Workout",
      "image": "assets/img/Workout2.png",
      "kcal": "200",
      "time": "30",
      "progress": 0.4
    },
    {
      "name": "Ab Workout",
      "image": "assets/img/Workout3.png",
      "kcal": "300",
      "time": "40",
      "progress": 0.7
    },
  ];
  List<int> showingTooltipOnSpots = [21];

  List<FlSpot> get allSpots => const [
        FlSpot(0, 20),
        FlSpot(1, 25),
        FlSpot(2, 40),
        FlSpot(3, 50),
        FlSpot(4, 35),
        FlSpot(5, 40),
        FlSpot(6, 30),
        FlSpot(7, 20),
        FlSpot(8, 25),
        FlSpot(9, 40),
        FlSpot(10, 50),
        FlSpot(11, 35),
        FlSpot(12, 50),
        FlSpot(13, 60),
        FlSpot(14, 40),
        FlSpot(15, 50),
        FlSpot(16, 20),
        FlSpot(17, 25),
        FlSpot(18, 40),
        FlSpot(19, 50),
        FlSpot(20, 35),
        FlSpot(21, 80),
        FlSpot(22, 30),
        FlSpot(23, 20),
        FlSpot(24, 25),
        FlSpot(25, 40),
        FlSpot(26, 50),
        FlSpot(27, 35),
        FlSpot(28, 50),
        FlSpot(29, 60),
        FlSpot(30, 40)
      ];
  int calculateSum() {
    debugPrint("fgdhfgjgfjfj ${fitnessData.data}");
    int sum = 0;
    sum += (fitnessData.data["Early Morning"]?.toInt() ?? 0);
    sum += (fitnessData.data["Breakfast"]?.toInt() ?? 0);
    sum += (fitnessData.data["Mid Morning"]?.toInt() ?? 0);

    sum += (fitnessData.data["Dinner"]?.toInt() ?? 0);
    sum += (fitnessData.data["Evening"]?.toInt() ?? 0);
    sum += (fitnessData.data["Bed Time"]?.toInt() ?? 0);
    sum += (fitnessData.data["Lunch"]?.toInt() ?? 0);

    // Add more data keys to sum if needed
    return sum;
  }

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '0', _steps2 = '0', sleeep = '0';
  int caloriesburn = 0, caloriesburnleft = 0;
  NotificationServices notificationServices = NotificationServices();
  FlutterTts flutterTts = FlutterTts();
  // String ConectedWatch = '';
  late List<Meal> mealsFood = [];
  @override
  void dispose() {
    flutterTts.stop();
    subscription.cancel(); // Cancel the subscription to avoid memory leaks
    // super.dispose();
    super.dispose();
  }

  Future<void> _speak(String text) async {
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setLanguage("hi-IN");

    if (text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  String HeartRateData = '0';
  String FcmToken = '';

  var connectivityResult;
  bool isInternetAvailable = false;
  late StreamSubscription<List<ConnectivityResult>> subscription;
  Future<void> checkInternetConnection() async {
    connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isInternetAvailable =
          !connectivityResult.contains(ConnectivityResult.none);
    });
  }

  String formattedDateforcalories = "";

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    var formatter = DateFormat('dd MMMM, EEE');
    formattedDateforcalories = formatter.format(now);
    checkInternetConnection();
    // Listen for connectivity changes
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      setState(() {
        connectivityResult = result;
        isInternetAvailable = !result.contains(ConnectivityResult.none);
      });
    });
    final userProfileController =
        Provider.of<UserProfileController>(context, listen: false);
    //get fcm token and send to server
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      debugPrint('device token');
      debugPrint("device token is heer--- $value");
      FcmToken = value;
      //sending to server
      userProfileController.SendNotificationToken(FcmToken);
    });

    // Trigger the initial API call when the widget is created

    // debugPrint("user profile not found $profile");
    // if (profile == false) {
    //   debugPrint("user profile not found $profile");
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, CompleteProfile.routeName, (route) => false);
    // }

    // fetchStepsData();
    // fetchSleepData();
    // HeartRate();
    //notification
    CheckALlAPiHeleAndChangeLodingStatus();
    currentDate = getCurrentDate();
    currentDate2 = getCurrentDate();
    fetchMeals();
    loadSugarSalt();
    fetchData0();
  }

  String Selecteddateforsugar = DateFormat('yyyy-MM-dd').format(DateTime.now());
  double salt = 0, sugar = 0;
  Future<void> loadSugarSalt() async {
    final data = await UserProfileController.fetchSaltAndSugarData2(
        Selecteddateforsugar);
    debugPrint("sdfgfdhfghjgfjf ${data?['Salt']}  ${data?['Sugar']}");
    setState(() {
      salt = data!['Salt']!;
      sugar = data['Sugar']!;
    });
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.year}-${_formatNumber(now.month)}-${_formatNumber(now.day)}";
    return formattedDate;
  }

  String convertDateFormat(String date) {
    List<String> parts = date.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);

    String monthName = DateFormat('MMMM').format(DateTime(year, month, day));
    String formattedDate = "$day $monthName $year";
    debugPrint("Fdsgdsgfdhdh $formattedDate");
    return formattedDate;
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  late String currentDate;
  late String currentDate2;
  Future<List<Meal>> fetchMeals() async {
    setState(() {
      isLoadingScreenCheck = true;
    });
    mealsFood = [];
    try {
      List<Meal> meals =
          await _controller.festchmealtabelCustom(currentDate, currentDate2);
      setState(() {
        isLoadingScreenCheck = false;
        mealsFood = meals;
      });
      return meals;
    } catch (e) {
      debugPrint("gfdhfgjfgjghjkghkghk");
      // _scaffoldKey.currentState?.showSnackBar(SnackBar(
      //     duration: Duration(milliseconds: 1500),
      //     content: Text('Error fetching meals: $e')));
      rethrow;
    }
  }

  bool showContent = false;
  bool isLoadingScreen = true;
  Future<void> CheckALlAPiHeleAndChangeLodingStatus() async {
    LoadInitialData();

    await getUserProfileData();
    setState(() {
      isLoadingScreen = false;
    });
    // LoadInitialData();
    GetAlltTypeOFMealCalories();
    checkMensurationEnable();
    _controller.fetchStepsOfToday();
    loadEarValues();
  }

  double totalDuration = 0;
  String totalCaloriesExpenditure = '';
  String totalCaloriesBurned = '';
  String energyBalance = '';
  String restIntakeCalories = '';
  String totalEnergyIntakeDate = '';
  String totalEnergyIntakeMeal = '';

  Future<void> fetchData0() async {
    DateTime today = DateTime.now();
    // DateTime yesterday =
    //     today.subtract(Duration(days: 1)); // Subtract 1 day from today

    // Format yesterday's date in "yyyy-MM-dd" format
    String formattedDate = DateFormat('yyyy-MM-dd').format(today);

    String date = formattedDate; // Specify the date here
    final data =
        await UserProfileController.fetchCaloriesBurnedAndEnergyIntake(date);
    if (data != null) {
      // Define the _formatNumericValue function first
      String formatNumericValue(dynamic value) {
        if (value is num) {
          if (value >= 100) {
            // If greater than or equal to 100, show no decimal places
            return value.toStringAsFixed(0);
          } else {
            // If less than 100, show two decimal places
            return value.toStringAsFixed(2);
          }
        }
        return value.toString(); // Fallback if not a number
      }

// Now use the _formatNumericValue function inside your widget or wherever needed
      setState(() {
        totalDuration =
            double.tryParse(formatNumericValue(data['totalDuration']))!;
        debugPrint("dfvdgbfghnjghm $totalDuration $data");
        totalCaloriesExpenditure =
            formatNumericValue(data['totalCaloriesExpenditure']);
        totalCaloriesBurned = formatNumericValue(data['totalCaloriesBurned']);
        energyBalance = formatNumericValue(data['energyBalance']);
        restIntakeCalories = formatNumericValue(data['restIntakeCalories']);
        debugPrint(
            "dfvggjhfkhfjkhbgfghfn $totalDuration $totalCaloriesExpenditure ");

        List<dynamic> totalEnergyIntake = data['totalEnergyIntake'];
        if (totalEnergyIntake.isNotEmpty) {
          totalEnergyIntakeDate = totalEnergyIntake[0]['date'];
          totalEnergyIntakeMeal =
              formatNumericValue(totalEnergyIntake[0]['mealEnergy']);
        }
      });
    }
  }

  late EarForUser _profileFuture = EarForUser(
    gender: "waiting",
    age: "waiting",
    group: "waiting",
    workLevel: "waiting",
    energy: 0.0,
    protein: 0.0,
    fatsOilsVisible: 0.0,
    fiber: 0.0,
    calcium: 0.0,
    magnesium: 0.0,
    iron: 0.0,
    zinc: 0.0,
    thiamine: 0.0,
    riboflavin: 0.0,
    niacin: 0.0,
    folate: 0.0,
    vitA: 0.0,
    iodine: 0.0,
    vitB12: 0.0,
    vitC: 0.0,
    carbohydrate: 0.0,
  );
  Future<void> loadEarValues() async {
    _profileFuture = (await _controller.getProfileEar());
    setState(() {});
  }

  FitnessData fitnessData = FitnessData.instance;
  final UserProfileController _controller = UserProfileController();
  // late Map<String, dynamic> data = {
  //   'Breakfast': 0,
  //   'Dinner': 0,
  //   'Snacks': 0,
  //   'Lunch': 0
  // };
  Future<void> GetAlltTypeOFMealCalories() async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      final data1 = await _controller.GetCaloriesEarned(formattedDate);
      // fitnessData.data['Dinner'] =
      //     (data1['Dinner'] == null) ? 0.0 : data1['Dinner'].toStringAsFixed(2);
      // ;
      // fitnessData.data['Breakfast'] = (data1['Breakfast'] == null)
      //     ? 0.0
      //     : data1['Breakfast'].toStringAsFixed(2);
      // ;
      // fitnessData.data['Snacks'] =
      //     (data1['Snacks'] == null) ? 0.0 : data1['Snacks'].toStringAsFixed(2);
      // ;
      // fitnessData.data['Lunch'] =
      //     (data1['Lunch'] == null) ? 0.0 : data1['Lunch'].toStringAsFixed(2);
      // ;

      // debugPrint('Snacks: ${data1["Snacks"]} $data1');

      // // Map<String, dynamic> data = {
      // //   'Breakfast': 0,
      // //   'Dinner': 0,
      // //   'Snacks': 0,
      // //   'Lunch': 0
      // // };
      // debugPrint("datddkmlmlkfmdl $data");

      // // Check and update values to 0 if null
      // for (var key in data1.keys) {
      //   if (data[key] == null) {
      //     data[key] = 0;
      //   }

      //   // debugPrint the updated map
      //   debugPrint("datddkmlmlkfmdl $data");
      // }
    } catch (e) {
      debugPrint('Error: $e');
    }
    if (mounted) {
      setState(() {});
    }
    // Trigger a rebuild after data is fetched
  }

  // Future<void> getUserProfileData() async {
  //   final userProfileController =
  //       Provider.of<UserProfileController>(context, listen: false);
  //   final profile = await userProfileController.fetchUserProfileFromAPI();
  //   String? token = await AuthRepo.getToken();
  //   if (JwtDecoder.isExpired(token!)) {
  //     debugPrint("user profile not found $profile");
  //     if (profile == false) {
  //       debugPrint("user profile not found $profile");
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, CompleteProfile.routeName, (route) => false);
  //     }
  //   }
  // }
  double bmi = 0;
  Future<void> getUserProfileData() async {
    final userProfileController =
        Provider.of<UserProfileController>(context, listen: false);
    final profile = await userProfileController.fetchUserProfileFromAPI();
    // debugPrint("jnvdfkvdknvfd $profile");
    if (profile == false) {
      debugPrint("jnvdfkvdknvfd $profile");
      final AuthRepo authRepo = AuthRepo();
      if (authRepo.User_id == "") {
        debugPrint("sdfgdsggdg $profile");
        try {
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('token'); // Remove the token from storage
          //  await AuthRepo.clearToken();
          await FirebaseAuth.instance.signOut();

          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.routeName,
            (route) => false,
          );
        } catch (e) {
          debugPrint('Error during logout: $e');
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RecompleteProfile()),
        );
      }
      // Navigate to another page when the button is clicked
    }

    String? token = await AuthRepo.getToken();
    bmi = userProfileController.userProfile?.bmi ?? 0;
    // if (token != null) {
    //   try {
    //     // Decode the token
    //     Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    //     // Get the expiration time from the decoded token
    //     int expirationTime = decodedToken['exp'];

    //     // Check if the token has expired
    //     if (JwtDecoder.isExpired(expirationTime.toString())) {
    //       debugPrint("Token has expired");
    //       if (profile == false) {
    //         debugPrint("User profile not found $profile");
    //         Navigator.pushNamedAndRemoveUntil(
    //             context, CompleteProfile.routeName, (route) => false);
    //       }
    //     } else {
    //       debugPrint("Token is not expired");
    //       // Continue with your logic if the token is not expired
    //     }
    //   } catch (e) {
    //     // Handle decoding errors or invalid tokens
    //     debugPrint('Error decoding or validating JWT token: $e');
    //   }
    // }
  }

  bool MensurationToggle = false;
  Future<void> checkMensurationEnable() async {
    final bool mensurationOnOffBool = await _controller.MensurationOnOffBool();
    MensurationToggle = mensurationOnOffBool;
    if (mounted) {
      setState(() {
        MensurationToggle = mensurationOnOffBool;
      });
    }
  }

  Future<void> _refresh() async {
    // Add your refresh logic here
    // await Future.delayed(Duration(seconds: 2));
    final userProfileController =
        Provider.of<UserProfileController>(context, listen: false);

    // Trigger the initial API call when the widget is created
    final apiDataProvider =
        Provider.of<WatchApiDataProvider>(context, listen: false);

    // Call the API function during app startup
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    apiDataProvider.makeApiCalls();
    // });
    userProfileController.fetchUserProfileFromAPI();
    LoadInitialData();
    // fetchStepsData();
    // fetchSleepData();
    //notification
    // notificationServices.requestNotificationPermission();
    // notificationServices.forgroundMessage();
    // notificationServices.firebaseInit(context);
    // notificationServices.setupInteractMessage(context);
    // notificationServices.isTokenRefresh();

    // notificationServices.getDeviceToken().then((value) {
    //   if (kDebugMode) {
    //     debugPrint('device token');
    //     debugPrint(value);
    //   }
    // });
    // setState(() {
    //   // items = List.generate(20, (index) => 'Refreshed Item $index');
    // });
  }

  // Future<Map<String, dynamic>> fetchStepsData() async {
  //   // String tokenfit = "";
  //   // String userIdfit = '';
  //   // _loadData() async {
  //   //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //   setState(() async {
  //   //     tokenfit = await prefs.getString('tokenfit') ?? "";
  //   //     userIdfit = await prefs.getString('userIdfit') ?? '';
  //   //   });
  //   // }

  //   // _loadData();
  //   var now = DateTime.now();
  //   var formatter = DateFormat('yyyy-MM-dd');
  //   String formattedDate = formatter.format(now);
  //   String? tokenfit = await TokenManager.getToken();
  //   String? userIdfit = await TokenManager.getId();

  //   debugPrint('token and user id is $tokenfit $userIdfit');
  //   final response = await http.get(
  //       Uri.parse(
  //           'https://api.fitbit.com/1/user/$userIdfit/activities/date/$formattedDate.json'),
  //       headers: {
  //         'Authorization': 'Bearer $tokenfit',
  //       });

  //   if (response.statusCode == 200) {
  //     debugPrint('response fat ${response.body}');

  //     Map<String, dynamic> responseData1 = json.decode(response.body);
  //     int stepup = responseData1['summary']['steps'];
  //     final data = await _controller.PostStepsDataOfUser(stepup);
  //     //  caloriesburn= responseData1['goals']['steps'];
  //     debugPrint('step dat upload $data');
  //     if (mounted) {
  //       setState(() {
  //         _steps2 = responseData1['summary']['steps'].toString();
  //         caloriesburn = responseData1['summary']['caloriesOut'];
  //         caloriesburnleft = responseData1['goals']['caloriesOut'];
  //         caloriesburnleft = caloriesburnleft - caloriesburn;
  //       });
  //     }

  //     debugPrint('steps is here $_steps2');
  //     // userId = responseData['user_id'];
  //     // await Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) => DisplayDataPage(
  //     //         responseData: responseData1),
  //     //   ),
  //     // );
  //     return json.decode(response.body);
  //   } else {
  //     debugPrint('response fat ${response.body}');
  //     throw Exception('Failed to load data');
  //   }
  // }

  // Future<Map<String, dynamic>> fetchSleepData() async {
  //   // String tokenfit = "";
  //   // String userIdfit = '';
  //   // _loadData() async {
  //   //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //   setState(() async {
  //   //     tokenfit = await prefs.getString('tokenfit') ?? "";
  //   //     userIdfit = await prefs.getString('userIdfit') ?? '';
  //   //   });
  //   // }

  //   // _loadData();
  //   var now = DateTime.now();
  //   var formatter = DateFormat('yyyy-MM-dd');
  //   String formattedDate = formatter.format(now);
  //   String? tokenfit = await TokenManager.getToken();
  //   String? userIdfit = await TokenManager.getId();
  //   debugPrint('token and user id is $tokenfit $userIdfit');
  //   final response = await http.get(
  //       Uri.parse(
  //           'https://api.fitbit.com/1.2/user/$userIdfit/sleep/date/$formattedDate.json'),
  //       headers: {
  //         'Authorization': 'Bearer $tokenfit',
  //       });

  //   if (response.statusCode == 200) {
  //     debugPrint('response fat ${response.body}');

  //     Map<String, dynamic> responseData1 = json.decode(response.body);
  //     // int stepup = responseData1['summary']['steps'];
  //     // final data = await _controller.PostStepsDataOfUser(stepup);
  //     //  caloriesburn= responseData1['goals']['steps'];
  //     debugPrint('sleep dat sleepg $responseData1');
  //     int minutes = responseData1['summary']['totalMinutesAsleep'];
  //     int hours = (minutes / 60).floor();
  //     int remainingMinutes = minutes % 60;
  //     // int hours = (milliseconds / (1000 * 3600)).floor();
  //     // int minutes = ((milliseconds % (1000 * 3600)) / (1000 * 60)).floor();
  //     if (responseData1["sleep"].isNotEmpty) {
  //       Map<String, dynamic> sleepData = {
  //         // "id": 2,
  //         "dateOfSleep": formattedDate,
  //         "duration": minutes,
  //         "manualDuration": 0,
  //         "efficiency": responseData1["sleep"][0]["efficiency"] ?? null,
  //         "endTime": responseData1["sleep"][0]["endTime"] ?? null
  //       };
  //       await _controller.UpdateSleepData(sleepData);
  //     }

  //     if (mounted) {
  //       setState(() {
  //         //sleeep = responseData1['summary']['totalMinutesAsleep'].toString();
  //         sleeep =
  //             hours.toString() + ' h ' + remainingMinutes.toString() + ' m ';
  //         debugPrint('sleep dat upload $sleeep');
  //       });
  //     }

  //     debugPrint('steps is here $_steps2');
  //     // userId = responseData['user_id'];
  //     // await Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) => DisplayDataPage(
  //     //         responseData: responseData1),
  //     //   ),
  //     // );
  //     return json.decode(response.body);
  //   } else {
  //     debugPrint('response fat ${response.body}');
  //     throw Exception('Failed to load data');
  //   }
  // }

  // Future<Map<String, dynamic>> HeartRate() async {
  //   // String tokenfit = "";
  //   // String userIdfit = '';
  //   // _loadData() async {
  //   //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //   setState(() async {
  //   //     tokenfit = await prefs.getString('tokenfit') ?? "";
  //   //     userIdfit = await prefs.getString('userIdfit') ?? '';
  //   //   });
  //   // }

  //   // _loadData();
  //   var now = DateTime.now();
  //   var formatter = DateFormat('yyyy-MM-dd');
  //   String formattedDate = formatter.format(now);
  //   String? tokenfit = await TokenManager.getToken();
  //   String? userIdfit = await TokenManager.getId();
  //   debugPrint('token and user id is $tokenfit $userIdfit');
  //   final response = await http.get(
  //       Uri.parse(
  //           'https://api.fitbit.com/1/user/$userIdfit/activities/heart/date/today/1d.json'),
  //       headers: {
  //         'Authorization': 'Bearer $tokenfit',
  //       });

  //   if (response.statusCode == 200) {
  //     debugPrint('response fat ${response.body}');

  //     Map<String, dynamic> responseData1 = json.decode(response.body);
  //     // int stepup = responseData1['summary']['steps'];
  //     // final data = await _controller.PostStepsDataOfUser(stepup);
  //     //  caloriesburn= responseData1['goals']['steps'];
  //     debugPrint('sleep dat upload $responseData1');

  //     // int hours = (minutes / 60).floor();
  //     // int remainingMinutes = minutes % 60;
  //     // int hours = (milliseconds / (1000 * 3600)).floor();
  //     // int minutes = ((milliseconds % (1000 * 3600)) / (1000 * 60)).floor();

  //     if (mounted) {
  //       setState(() {
  //         //sleeep = responseData1['summary']['totalMinutesAsleep'].toString();
  //         if (responseData1["activities-heart"][0]["value"]
  //                 ["restingHeartRate"] !=
  //             null) {
  //           HeartRateData = responseData1["activities-heart"][0]["value"]
  //                   ["restingHeartRate"]
  //               .toString();
  //         }

  //         debugPrint('sleep datfhjfjff upload $responseData1   $HeartRateData');
  //       });
  //     }

  //     // debugPrint('steps is here $_steps2');
  //     // userId = responseData['user_id'];
  //     // await Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) => DisplayDataPage(
  //     //         responseData: responseData1),
  //     //   ),
  //     // );
  //     return json.decode(response.body);
  //   } else {
  //     debugPrint('response fat ${response.body}');
  //     throw Exception('Failed to load data');
  //   }
  // }

  late WaterData waterData;
  bool success = false;
  double percentage = 0;
  Future<void> LoadInitialData() async {
    try {
      final data = await _controller.GetWaterDataOfUser();
      await Permission.activityRecognition.request();
      initPlatformState();
      await Permission.location.request();
      // await Permission.storage.request();
      // if (data != null) {
      //   if (mounted) {
      //     setState(() {
      //       waterData = data;
      //       double waterGoal = waterData.waterGoal;
      //       double waterIntake = waterData.waterIntake;
      //       percentage = (waterIntake / waterGoal);
      //       debugPrint('Water Goal: $waterGoal');
      //       debugPrint('Water Intake: $waterIntake');
      //       debugPrint('Percentage of water completed: $percentage%');
      //       success = true;
      //     });
      //   }
      // }
    } catch (e) {}
    try {
      final data = await _controller.getWaterIntake();
      setState(() {
        if (data.isNotEmpty) {
          fitnessData.waterArr = data.reversed.toList().take(3).toList();
        }
      });
    } catch (e) {}

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
    String? data = await TokenManager.getWatchType();
    if (mounted) {
      if (data != null) {
        setState(() {
          TokenManager.ConnectedWatch = data;
        });
      }
    }
  }

  void onStepCount(StepCount event) {
    debugPrint(event.toString());
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    debugPrint(event.toString());
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    debugPrint('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    debugPrint(_status);
  }

  void onStepCountError(error) {
    debugPrint('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  // Future<void> handlePermission() async {
  //   bool granted = await PermissionManager.hasSensiorPermission();

  //   if (granted) {
  //     // Storage permissions are granted; you can proceed to pick an image.
  //     initPlatformState();
  //   } else {
  //     // Permissions were not granted; ask the user for permission.
  //     await PermissionManager.requstSensiorPermission();

  //     // After requesting permissions, you can check again or handle it further as needed.
  //     bool rechecked = await PermissionManager.hasSensiorPermission();

  //     if (rechecked) {
  //       // Permissions were granted after requesting.
  //       initPlatformState();
  //     } else {
  //       // Handle the case where permissions were not granted even after requesting.
  //       // You can show a message or take appropriate action.
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final userProfileController = Provider.of<UserProfileController>(context);
    var fitnessData = Provider.of<FitnessData>(context);
    var media = MediaQuery.of(context).size;
    String message = '';
    // double bmi = (userProfileController.userProfile!.bmi == null)
    //     ? 0
    //     : userProfileController.userProfile!.bmi;
    if (bmi < 18.5) {
      message = Languages.of(context)!.labelUnderweight;
    } else if (bmi < 25) {
      message = Languages.of(context)!.labelNormalWeight;
    } else if (bmi < 30) {
      message = Languages.of(context)!.labelOverweight;
    } else {
      message = Languages.of(context)!.labelObese;
    }
    // bmivalue = userProfileController.userProfile!.bmi??0;
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots,
        isCurved: false,
        barWidth: 3,
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(colors: [
            TColor.primaryColor2.withOpacity(0.4),
            TColor.primaryColor1.withOpacity(0.1),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        dotData: const FlDotData(show: false),
        gradient: LinearGradient(
          colors: TColor.primaryG,
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     "djfdfdkj",
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   backgroundColor: ThemeManager.themeColor,
        // ),height:
        backgroundColor: ThemeManager.themeColor,
        body: isInternetAvailable
            ? isLoadingScreen
                ? const CommonDataLoadingScreen()
                : RefreshIndicator(
                    color: TColor
                        .secondaryColor1, // Set the color of the refresh indicator
                    backgroundColor: TColor.primaryColor1,
                    onRefresh: _refresh,
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                        // "Welcome Back,",
                                        Languages.of(context)!.labelWelcomeBack,
                                        style: TextStyle(
                                            color:
                                                //  TColor.gray,
                                                ThemeManager.themeText,
                                            fontSize:
                                                AppFontSizes.smallDefault),
                                      ),
                                      Text(
                                        " ${userProfileController.userProfile?.firstName} ${userProfileController.userProfile?.lastName}",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: ThemeManager.themeText,
                                            fontSize: AppFontSizes.largeDefault,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    //
                                                    SetReminder()),
                                            // AddDishEdit()),
                                          );
                                        },
                                        icon: Image.asset(
                                          "assets/img/HoursTime.png",
                                          width: 24.0, // Set the desired width
                                          // height: 24.0,
                                          color: ThemeManager.themeText,
                                          fit: BoxFit.cover,
                                        ),
                                        // Image.asset(
                                        //   "assets/img/notification_active.png",
                                        //   width: 25,
                                        //   height: 25,
                                        //   color: Colors.black,
                                        //   fit: BoxFit.fitHeight,
                                        // )
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const NotificationView(),
                                              ),
                                            );
                                          },
                                          icon: Image.asset(
                                            "assets/img/notification_active.png",
                                            width: 25,
                                            height: 25,
                                            color: ThemeManager.themeText,
                                            fit: BoxFit.fitHeight,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: media.width * 0.05,
                              ),

                              // Center(
                              //   child: Container(
                              //     height: 40,
                              //     width: media.width * 0.9,
                              //     decoration: BoxDecoration(
                              //       color: TColor.primaryColor1,
                              //       borderRadius: BorderRadius.circular(
                              //           10.0), // Adjust the value as needed
                              //     ),
                              //     child: Center(
                              //       child: Text(
                              //         'My Health status',
                              //         style: TextStyle(
                              //             color: ThemeManager.themeText,
                              //             fontSize: 19,
                              //             fontWeight: FontWeight.w700),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              GestureDetector(
                                // onLongPress: () => _speak(
                                //     'Yorur BMI is ${userProfileController.userProfile?.bmi.toString().substring(0, 5)} and $message'),
                                child: Container(
                                  // height: media.width * 0.62,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: TColor.primaryG),
                                      borderRadius: BorderRadius.circular(
                                          media.width * 0.075)),
                                  child: Column(
                                    children: [
                                      sizedBox12(),
                                      Center(
                                        child: Container(
                                          // height: 40,
                                          width: media.width * 0.80,
                                          decoration: BoxDecoration(
                                            color: TColor.primaryColor1,
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Adjust the value as needed
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                Languages.of(context)!
                                                    .ninTextMyHealthStatus,
                                                style: TextStyle(
                                                    color:
                                                        ThemeManager.themeText,
                                                    fontSize: AppFontSizes
                                                        .largeDefault,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/img/bg_dots.png",
                                              height: media.width * 0.4,
                                              width: double.maxFinite,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 25,
                                                      horizontal: 25),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // SizedBox(
                                                      //   width: media.width * 0.4,
                                                      //   child: Text(
                                                      //     'My nutrition status',
                                                      //     style: TextStyle(
                                                      //         color: ThemeManager
                                                      //             .themeText,
                                                      //         fontSize: AppFontSizes.mediumDefault,
                                                      //         fontWeight:
                                                      //             FontWeight.w700),
                                                      //   ),
                                                      // ),
                                                      // SizedBox(
                                                      //   height: 5,
                                                      // ),
                                                      SizedBox(
                                                        width:
                                                            media.width * 0.4,
                                                        child: Text(
                                                          '${Languages.of(context)!.labelBMI} : ${userProfileController.userProfile?.bmi.toStringAsFixed(2)} kg/m²',
                                                          style: TextStyle(
                                                              color: ThemeManager
                                                                  .themeText,
                                                              fontSize: AppFontSizes
                                                                  .mediumDefault,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            media.width * 0.45,
                                                        child: Text(
                                                          '${Languages.of(context)!.labelBMR} : ${userProfileController.userProfile?.bmr != null ? userProfileController.userProfile!.bmr.toStringAsFixed(userProfileController.userProfile!.bmr >= 99 ? 0 : 2) : 'N/A'} ${Languages.of(context)!.ninTextKcalPerDay}',
                                                          style: TextStyle(
                                                              color: ThemeManager
                                                                  .themeText,
                                                              fontSize: AppFontSizes
                                                                  .mediumDefault,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            media.width * 0.45,
                                                        child: Text(
                                                          // Languages.of(context)!.labelNormalWeight,

                                                          message,
                                                          style: TextStyle(
                                                              color: ThemeManager
                                                                  .themeText
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontSize: AppFontSizes
                                                                  .smallDefault),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            media.width * 0.05,
                                                      ),
                                                      if (TokenManager
                                                          .ConnectedWatch
                                                          .isNotEmpty)
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                                width: 130,
                                                                // height: 35,
                                                                child:
                                                                    RoundButton(
                                                                        title:
                                                                            '${TokenManager.ConnectedWatch} ${Languages.of(context)!.labelIsConnected}',
                                                                        type: RoundButtonType
                                                                            .bgSGradient,
                                                                        fontSize:
                                                                            AppFontSizes
                                                                                .mediumDefault,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        onPressed:
                                                                            () async {
                                                                          await Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => const WatchOptions()),
                                                                          );
                                                                          setState(
                                                                              () {});
                                                                        })),
                                                            // Image.asset(
                                                            //   'assets/fitbit.png', // Replace with your asset path
                                                            //   width:
                                                            //       40.0, // Adjust the width as needed
                                                            //   height:
                                                            //       40.0, // Adjust the height as needed
                                                            //   fit: BoxFit.cover,
                                                            // ),
                                                          ],
                                                        )
                                                      else
                                                        SizedBox(
                                                            width: 130,
                                                            // height: 35,
                                                            child: RoundButton(
                                                                title: Languages
                                                                        .of(
                                                                            context)!
                                                                    .labelconectWatch,
                                                                type: RoundButtonType
                                                                    .bgSGradient,
                                                                fontSize:
                                                                    AppFontSizes
                                                                        .smallDefault,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                onPressed:
                                                                    () async {
                                                                  await Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const WatchOptions()),
                                                                  );
                                                                  setState(
                                                                      () {});
                                                                })),
                                                    ],
                                                  ),
                                                  // AspectRatio(
                                                  //   aspectRatio: 1,
                                                  //   child: PieChart(
                                                  //     PieChartData(
                                                  //       pieTouchData: PieTouchData(
                                                  //         touchCallback: (FlTouchEvent event,
                                                  //             pieTouchResponse) {},
                                                  //       ),
                                                  //       startDegreeOffset: 250,
                                                  //       borderData: FlBorderData(
                                                  //         show: false,
                                                  //       ),
                                                  //       sectionsSpace: 1,
                                                  //       centerSpaceRadius: 0,
                                                  //       sections: showingSections(),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  Column(
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            // final AuthRepo _authRepo = AuthRepo();
                                                            // AuthRepo.checkTokenExpired();

                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      // BMIClockIndicator(
                                                                      //   bmiValue: 121,
                                                                      // ),
                                                                      //
                                                                      BMIPage(bmiValue: bmi)
                                                                  // CloudinaryImageUploader()
                                                                  // AddDishEdit()
                                                                  ),
                                                            );
                                                          },
                                                          child:
                                                              CustomBmiIndicator(
                                                                  bmiValue:
                                                                      bmi)),
                                                      Text(
                                                        Languages.of(context)!
                                                            .labelBMI,
                                                      )
                                                    ],
                                                  ),
                                                  // ClipOval(
                                                  //   child: Container(
                                                  //     width: 90,
                                                  //     //  height: 41,
                                                  //     // decoration: BoxDecoration(
                                                  //     //   shape: BoxShape.circle,
                                                  //     //   color: ThemeManager
                                                  //     //       .themelightColor, // Set the background color for the circular container
                                                  //     // ),
                                                  //     child: Center(
                                                  //       child: Image.asset(
                                                  //         "assets/images/bmilogo.png",
                                                  //         // width: 2100, // Adjust the width of the image
                                                  //         // height: 24, // Adjust the height of the image
                                                  //         // color: ThemeManager.themeText,
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            )
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                              sizedBox12(),

                              GestureDetector(
                                // onLongPress: () => _speak(
                                //     'Yorur BMI is ${userProfileController.userProfile?.bmi.toString().substring(0, 5)} and $message'),
                                child: Container(
                                  // height: media.width * 0.62,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: TColor.primaryG),
                                      borderRadius: BorderRadius.circular(
                                          media.width * 0.075)),
                                  child: Column(
                                    children: [
                                      sizedBox12(),
                                      Center(
                                        child: Container(
                                          // height: 40,
                                          width: media.width * 0.80,
                                          decoration: BoxDecoration(
                                            color: TColor.primaryColor1,
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Adjust the value as needed
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                Languages.of(context)!
                                                    .myEnergyBalanceYesterday,
                                                style: TextStyle(
                                                    color:
                                                        ThemeManager.themeText,
                                                    fontSize: AppFontSizes
                                                        .largeDefault,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/img/bg_dots.png",
                                              height: media.width * 0.4,
                                              width: double.maxFinite,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 25,
                                                      horizontal: 25),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // SizedBox(
                                                      //   width: media.width * 0.4,
                                                      //   child: Text(
                                                      //     'My nutrition status',
                                                      //     style: TextStyle(
                                                      //         color: ThemeManager
                                                      //             .themeText,
                                                      //         fontSize: AppFontSizes.mediumDefault,
                                                      //         fontWeight:
                                                      //             FontWeight.w700),
                                                      //   ),
                                                      // ),
                                                      // SizedBox(
                                                      //   height: 5,
                                                      // ),

                                                      if (totalDuration < 24)
                                                        Center(
                                                          child: Container(
                                                            // padding:
                                                            //     EdgeInsets.all(
                                                            //         16.0),
                                                            // margin:
                                                            //     EdgeInsets.all(
                                                            //         20.0),
                                                            // decoration:
                                                            //     BoxDecoration(
                                                            //   border: Border.all(
                                                            //       color: Colors
                                                            //           .blueAccent),
                                                            //   borderRadius:
                                                            //       BorderRadius
                                                            //           .circular(
                                                            //               10.0),
                                                            // ),
                                                            child: SizedBox(
                                                              width:
                                                                  media.width *
                                                                      0.8,
                                                              child: Text(
                                                                Languages.of(
                                                                        context)!
                                                                    .inputActivityDataPrompt,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        AppFontSizes
                                                                            .mediumDefault),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      if (totalDuration >= 24)
                                                        for (int i = 0;
                                                            i <
                                                                mealsFood
                                                                    .length;
                                                            i++)
                                                          SizedBox(
                                                            width: media.width *
                                                                0.8,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                Text(
                                                                  '${Languages.of(context)!.totalEnergyConsumption} : $totalEnergyIntakeMeal Kcal',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          AppFontSizes
                                                                              .mediumDefault,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  '${Languages.of(context)!.totalEnergyExpenditure} : $totalCaloriesExpenditure Kcal',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          AppFontSizes
                                                                              .mediumDefault,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  '${Languages.of(context)!.energybalance}: $energyBalance Kcal',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          AppFontSizes
                                                                              .mediumDefault,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  Languages.of(
                                                                          context)!
                                                                      .indicatorhealth,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          AppFontSizes
                                                                              .mediumDefault,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),

                                                            //  Text(
                                                            //   'Total Energy Expenditure : ${mealsFood[0].totalmealCalories-userProfileController.userProfile!.bmr + double.parse(fitnessData.caloriesBurned)} ${(userProfileController.userProfile!.bmr + double.parse(fitnessData.caloriesBurned)).toStringAsFixed((userProfileController.userProfile!.bmr + double.parse(fitnessData.caloriesBurned)) >= 99 ? 0 : 2)} Kcal',
                                                            //   style: TextStyle(
                                                            //       color: ThemeManager
                                                            //           .themeText,
                                                            //       fontSize: AppFontSizes
                                                            //           .mediumDefault,
                                                            //       fontWeight:
                                                            //           FontWeight
                                                            //               .w700),
                                                            // ),
                                                          ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                    ],
                                                  ),
                                                  // AspectRatio(
                                                  //   aspectRatio: 1,
                                                  //   child: PieChart(
                                                  //     PieChartData(
                                                  //       pieTouchData: PieTouchData(
                                                  //         touchCallback: (FlTouchEvent event,
                                                  //             pieTouchResponse) {},
                                                  //       ),
                                                  //       startDegreeOffset: 250,
                                                  //       borderData: FlBorderData(
                                                  //         show: false,
                                                  //       ),
                                                  //       sectionsSpace: 1,
                                                  //       centerSpaceRadius: 0,
                                                  //       sections: showingSections(),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // ClipOval(
                                                  //   child: Container(
                                                  //     width: 90,
                                                  //     //  height: 41,
                                                  //     // decoration: BoxDecoration(
                                                  //     //   shape: BoxShape.circle,
                                                  //     //   color: ThemeManager
                                                  //     //       .themelightColor, // Set the background color for the circular container
                                                  //     // ),
                                                  //     child: Center(
                                                  //       child: Image.asset(
                                                  //         "assets/images/bmilogo.png",
                                                  //         // width: 2100, // Adjust the width of the image
                                                  //         // height: 24, // Adjust the height of the image
                                                  //         // color: ThemeManager.themeText,
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            )
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                              sizedBox12(),
                              Container(
                                decoration: BoxDecoration(
                                  color: TColor.primaryColor2.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         NutrientInMyFood(),
                                            //     // ActivityTrackerScreen(),
                                            //     // LocationMarker(),
                                            //   ),
                                            // );
                                          },
                                          // onLongPress: () => _speak(
                                          //     'check your time and calories burn you spent on different activivties'),
                                          child: Container(
                                            width: media.width * 0.95,
                                            // height: media.width * 0.15,
                                            // height: media.width * 0.40,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 15),
                                            // decoration: BoxDecoration(
                                            //   color: TColor.primaryColor2
                                            //       .withOpacity(0.3),
                                            //   borderRadius:
                                            //       BorderRadius.circular(15),
                                            // ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    ClipOval(
                                                      child: SizedBox(
                                                        width: 50,
                                                        //  height: 41,
                                                        // decoration:
                                                        //     BoxDecoration(
                                                        //   shape:
                                                        //       BoxShape.circle,
                                                        //   // color: ThemeManager
                                                        //   //     .themelightColor, // Set the background color for the circular container
                                                        // ),
                                                        child: Center(
                                                          child: Image.asset(
                                                            "assets/img/lunch.jpg",
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: SizedBox(
                                                        width:
                                                            media.width * 0.7,
                                                        child: Text(
                                                          Languages.of(context)!
                                                              .TextAppNutrientsInMyFood,
                                                          textAlign:
                                                              TextAlign.center,
                                                          // $_steps2
                                                          style: TextStyle(
                                                              color: ThemeManager
                                                                  .themeText,
                                                              fontSize: AppFontSizes
                                                                  .largeDefault,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Spacer(),

                                                // SizedBox(
                                                //   width: 70,
                                                //   height: 35,
                                                //   child: RoundButton(
                                                //     title: Languages.of(context)!
                                                //         .labelCheck,
                                                //     type: RoundButtonType.bgGradient,
                                                //     fontSize: AppFontSizes.smallDefault,,
                                                //     fontWeight: FontWeight.w400,
                                                //     onPressed: () {
                                                //       // Navigator.push(
                                                //       //   context,
                                                //       //   MaterialPageRoute(s
                                                //       //     builder: (context) =>
                                                //       //         const ActivityTrackerView(),
                                                //       //   ),
                                                //       // );
                                                //       Navigator.push(
                                                //         context,
                                                //         MaterialPageRoute(
                                                //           builder: (context) =>
                                                //               NutrientInMyFood(),
                                                //         ),
                                                //       );
                                                //     },
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ),
                                        ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               ToadyActivity()),
                                        //     );
                                        //   },
                                        //   onLongPress: () => _speak(
                                        //       'check your time and calories burn you spent on different activivties'),
                                        //   child: Container(
                                        //     width: media.width * 0.41,
                                        //     height: media.width * 0.28,
                                        //     // height: media.width * 0.40,
                                        //     padding: const EdgeInsets.symmetric(
                                        //         vertical: 15, horizontal: 15),
                                        //     decoration: BoxDecoration(
                                        //       color: TColor.primaryColor2
                                        //           .withOpacity(0.3),
                                        //       borderRadius: BorderRadius.circular(15),
                                        //     ),
                                        //     child: Column(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.start,
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.center,
                                        //       children: [
                                        //         ClipOval(
                                        //           child: Container(
                                        //             width: 50,
                                        //             //  height: 41,
                                        //             decoration: BoxDecoration(
                                        //               shape: BoxShape.circle,
                                        //               color: ThemeManager
                                        //                   .themelightColor, // Set the background color for the circular container
                                        //             ),
                                        //             child: Center(
                                        //               child: Image.asset(
                                        //                 "assets/images/exercise.png",
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //         // Spacer(),
                                        //         Center(
                                        //           child: Text(
                                        //             Languages.of(context)!
                                        //                 .TextApp1MyActivity,
                                        //             textAlign: TextAlign.center,
                                        //             // $_steps2
                                        //             style: TextStyle(
                                        //                 color: ThemeManager.themeText,
                                        //                 fontSize: AppFontSizes.mediumDefault,
                                        //                 fontWeight: FontWeight.w700),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          // sizedBox30(),
                                          // sizedBox30(),
                                          // Create a reusable ContainerCard for the first action
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchRawFood()),
                                              );
                                            },
                                            child: Container(
                                              //  height: media.width * 0.38,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  color: TColor.primaryColor1
                                                      .withOpacity(0.2)),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 80,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/img/raw food.jpeg.png',
                                                        height: 60,
                                                        // height: 50,
                                                        // width: 100,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  // Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SizedBox(
                                                      width: 90,
                                                      child: Text(
                                                        Languages.of(context)!
                                                            .ninTextNutrientsInRawFoods,
                                                        style: TextStyle(
                                                            color: ThemeManager
                                                                .themeText,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: AppFontSizes
                                                                .mediumDefault),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchCookedFood()),
                                              );
                                            },
                                            child: Container(
                                              //   height: media.width * 0.38,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  color: TColor.primaryColor1
                                                      .withOpacity(0.2)),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 80,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/img/cooked recipy.png',
                                                        height: 60,
                                                        // width: 100,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  // Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SizedBox(
                                                      width: 90,
                                                      child: Text(
                                                        Languages.of(context)!
                                                            .ninTextNutrientsInRecipes,
                                                        style: TextStyle(
                                                            color: ThemeManager
                                                                .themeText,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: AppFontSizes
                                                                .mediumDefault),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Top10Foods()),
                                              );
                                            },
                                            child: Container(
                                              //    height: media.width * 0.38,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  color: TColor.primaryColor1
                                                      .withOpacity(0.2)),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 80,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/img/top 10 food.png',
                                                        height: 60,
                                                        //  height: 80,
                                                        // width: 100,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  // Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SizedBox(
                                                      width: 90,
                                                      child: Text(
                                                        Languages.of(context)!
                                                            .mainlabelExploreTop10Foods,
                                                        style: TextStyle(
                                                            color: ThemeManager
                                                                .themeText,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: AppFontSizes
                                                                .mediumDefault),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // ContainerCard(
                                          //   imagePath: 'assets/img/top10food.png',
                                          //   text: 'Explore Top 10 Foods',
                                          //   onTap: () {
                                          //     Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(builder: (context) => Top10Foods()),
                                          //     );
                                          //   },
                                          // ),
                                          // // Create another ContainerCard for the second action
                                          // ContainerCard(
                                          //   imagePath: 'assets/img/foodsafe (2).png',
                                          //   text: 'Search Cooked Food',
                                          //   onTap: () {
                                          //     Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(builder: (context) => SearchCookedFood()),
                                          //     );
                                          //   },
                                          // ),
                                        ],
                                      ),
                                    ),
                                    sizedBox12(),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              sizedBox12(),
                              Container(
                                width: media.width * 0.95,
                                decoration: BoxDecoration(
                                  color: TColor.primaryColor2.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: ShapeDecoration(
                                          color: ThemeManager.themelightColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(36),
                                          ),
                                          shadows: const [
                                            BoxShadow(
                                              color: Color(0x3F000000),
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                              spreadRadius: 0,
                                            ),
                                          ],
                                        ),
                                        child: ClipOval(
                                          child: Container(
                                            width: 42,
                                            // height: 41,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ThemeManager
                                                  .themelightColor, // Set the background color for the circular container
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/fork 2.png",
                                                width:
                                                    24, // Adjust the width of the image
                                                // height:
                                                //     24, // Adjust the height of the image
                                                color: ThemeManager.themeText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // ClipOval(
                                      //   child: Container(
                                      //     width: 50,
                                      //     //  height: 41,
                                      //     // decoration: BoxDecoration(
                                      //     //   shape: BoxShape.circle,
                                      //     //   color: ThemeManager
                                      //     //       .themelightColor, // Set the background color for the circular container
                                      //     // ),
                                      //     child: Center(
                                      //       child: Image.asset(
                                      //         "assets/images/fork 2.png",
                                      //         //    "assets/img/running.png",
                                      //         width:
                                      //             38, // Adjust the width of the image
                                      //         // height: 24, // Adjust the height of the image
                                      //         // color: ThemeManager.themeText,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width: media.width * 0.5,
                                        child: Text(
                                          // Languages.of(context)!
                                          //     .ninTextMyHeartRate,
                                          Languages.of(context)!.recordMyDiet,
                                          style: TextStyle(
                                              color: ThemeManager.themeText,
                                              fontSize:
                                                  AppFontSizes.largeDefault,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: 80,
                                        // height: 35,
                                        child: RoundButton(
                                          title: Languages.of(context)!
                                              .labelAddDish,
                                          type: RoundButtonType.bgGradient,
                                          fontSize: AppFontSizes.smallDefault,
                                          fontWeight: FontWeight.w400,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddDishScreen(),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              sizedBox12(),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PDFScreen2(
                                                  lablename:
                                                      "MY PLATE FOR THE DAY",
                                                  pdfAssetPath:
                                                      "assets/img/myplate.pdf",
                                                )),
                                      );
                                    },
                                    // onLongPress: () => _speak(
                                    //     'check your time and calories burn you spent on different activivties'),
                                    child: Container(
                                      width: media.width * 0.95,

                                      // height: media.width * 0.40,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: TColor.primaryColor2
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              ClipOval(
                                                child: Container(
                                                  width: 45,
                                                  //  height: 41,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ThemeManager
                                                        .themelightColor, // Set the background color for the circular container
                                                  ),
                                                  child: Center(
                                                    child: Image.asset(
                                                      'assets/img/diary.png',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Center(
                                                child: SizedBox(
                                                  width: media.width * 0.7,
                                                  child: Text(
                                                    Languages.of(context)!
                                                        .ninTextIcmrNinMyPlateForTheDay,
                                                    textAlign: TextAlign.start,
                                                    // $_steps2
                                                    style: TextStyle(
                                                        color: ThemeManager
                                                            .themeText,
                                                        fontSize: AppFontSizes
                                                            .largeDefault,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          // Spacer(),

                                          // SizedBox(
                                          //   width: 70,
                                          //   height: 35,
                                          //   child: RoundButton(
                                          //     title: Languages.of(context)!
                                          //         .labelCheck,
                                          //     type: RoundButtonType.bgGradient,
                                          //     fontSize: AppFontSizes.smallDefault,,
                                          //     fontWeight: FontWeight.w400,
                                          //     onPressed: () {
                                          //       // Navigator.push(
                                          //       //   context,
                                          //       //   MaterialPageRoute(s
                                          //       //     builder: (context) =>
                                          //       //         const ActivityTrackerView(),
                                          //       //   ),
                                          //       // );
                                          //       Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) =>
                                          //                 PDFScreen2(
                                          //                   lablename:
                                          //                       "MY PLATE FOR THE DAY",
                                          //                   pdfAssetPath:
                                          //                       "assets/img/myplate.pdf",
                                          //                 )),
                                          //       );
                                          //     },
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // sizedBox30(),
                              const SizedBox(
                                height: 5,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     Container(
                              //       width: 50,
                              //       child: Image.asset(
                              //         'assets/img/glassrotate.png',
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 50,
                              //     )
                              //   ],
                              // ),
                              sizedBox12(),
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    child: Image.asset(
                                      'assets/img/glassrotate.png',
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PDFScreen2(
                                                    lablename:
                                                        "MY PLATE FOR THE DAY",
                                                    pdfAssetPath:
                                                        "assets/img/myplate.pdf",
                                                  )),
                                        );
                                      },
                                      child: SpinImageOnNavigate()),
                                ],
                              ),

                              // InkWell(
                              //     onTap: () {
                              //       Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => PDFScreen2(
                              //                   lablename:
                              //                       "MY PLATE FOR THE DAY",
                              //                   pdfAssetPath:
                              //                       "assets/img/myplate.pdf",
                              //                 )),
                              //       );
                              //     },
                              //     child: SpinImageOnNavigate()),
                              sizedBox12(),

                              SizedBox(
                                height: media.width * 0.05,
                              ),

                              Container(
                                width: media.width * 0.95,
                                // height: media.width * 0.15,
                                // height: media.width * 0.40,

                                decoration: BoxDecoration(
                                  color: TColor.primaryColor2.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ExpansionTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 13.0, right: 13),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          // width: media.width * 0.6,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: media.width * 0.6,
                                                child: Text(
                                                  // "${Languages.of(context)!.labelCaloriesEarned} today($formattedDateforcalories)",
                                                  "${Languages.of(context)!.labelCaloriesEarned} ${Languages.of(context)!.ninTextToday} ",
                                                  style: TextStyle(
                                                      color: ThemeManager
                                                          .themeText,
                                                      fontSize: AppFontSizes
                                                          .largeDefault,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              SizedBox(
                                                width: media.width * 0.6,
                                                child: Text(
                                                  // "${Languages.of(context)!.labelCaloriesEarned} today($formattedDateforcalories)",
                                                  "(${calculateSum()} Kcal)",
                                                  style: TextStyle(
                                                      color: ThemeManager
                                                          .themeText,
                                                      fontSize: AppFontSizes
                                                          .largeDefault,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 70,
                                        //   height: 25,
                                        //   child: RoundButton(
                                        //     title: Languages.of(context)!.add,
                                        //     type: RoundButtonType.bgGradient,
                                        //     fontSize: AppFontSizes.smallDefault,,
                                        //     fontWeight: FontWeight.w400,
                                        //     onPressed: () {
                                        //       Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               AddDishScreen(),
                                        //         ),
                                        //       );
                                        //     },
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                  //heretyy.l
                                  children: [
                                    Container(
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(15.0),
                                      //   color: TColor.primaryColor1,
                                      // ),
                                      child: Column(
                                        children: [
                                          _buildCalorieRow(
                                              Languages.of(context)!
                                                  .mainlabelEarlyMorning,
                                              fitnessData.data["Early Morning"]
                                                  .toString(),
                                              1000),
                                          _buildCalorieRow(
                                              Languages.of(context)!
                                                  .labelBreakfast,
                                              fitnessData.data["Breakfast"]
                                                  .toString(),
                                              500),
                                          _buildCalorieRow(
                                              Languages.of(context)!
                                                  .mainlabelMidMorning,
                                              fitnessData.data["Mid Morning"]
                                                  .toString(),
                                              800),
                                          _buildCalorieRow(
                                              Languages.of(context)!.labelLunch,
                                              fitnessData.data["Lunch"]
                                                  .toString(),
                                              1500),
                                          _buildCalorieRow(
                                              Languages.of(context)!
                                                  .mainlabelEvening,
                                              fitnessData.data["Evening"]
                                                  .toString(),
                                              1000),
                                          _buildCalorieRow(
                                              Languages.of(context)!
                                                  .labelDinner,
                                              fitnessData.data["Dinner"]
                                                  .toString(),
                                              1000),
                                          _buildCalorieRow(
                                              Languages.of(context)!
                                                  .mainlabelBedtime,
                                              fitnessData.data["Bed Time"]
                                                  .toString(),
                                              1000),
                                        ],
                                      ),
                                    ),
                                    sizedBox12(),
                                  ],
                                  onExpansionChanged: (expanded) {
                                    if (expanded) {
                                      // Calculate total calories earned
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                              sizedBox12(),
                              for (int i = 0; i < mealsFood.length; i++)
                                Container(
                                  width: media.width * 0.95,

                                  // height: media.width * 0.40,

                                  decoration: BoxDecoration(
                                    color:
                                        TColor.primaryColor2.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15),
                                  ),

                                  child: ExpansionTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 13.0, right: 13),
                                      child: Text(
                                        Languages.of(context)!
                                            .TextAppTotalNutrientTaken,
                                        style: TextStyle(
                                            color: ThemeManager.themeText,
                                            fontSize: AppFontSizes.largeDefault,
                                            fontWeight: FontWeight.w700
                                            // Set the title color
                                            ),
                                      ),
                                    ),
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                // border: Border.all(
                                                //   color: TColor.primaryColor1,
                                                //   width: 2,
                                                // ),
                                                border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255,
                                                      34,
                                                      104,
                                                      161), // Assuming TColor.primaryColor1 is defined somewhere
                                                  width: 2,
                                                ),
                                                color: const Color.fromARGB(
                                                    255, 34, 104, 161),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    width: 110,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0),
                                                      child: Text(
                                                        Languages.of(context)!
                                                            .NINTextNutrient,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 60,
                                                    child: Text(
                                                        Languages.of(context)!
                                                            .NINTextValue,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                  SizedBox(
                                                    width: 80,
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                            // Languages.of(
                                                            //         context)!
                                                            //     .NINTextEAR,
                                                            "EAR",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        Tooltip(
                                                          message:
                                                              'EAR Information',
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons.info,
                                                              color:
                                                                  Colors.white,
                                                              size: 20,
                                                            ),
                                                            onPressed: () {
                                                              // Show BMR information here
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder: (_) =>
                                                                    AlertDialog(
                                                                  title:
                                                                      const Text(
                                                                          'EAR'),
                                                                  content:
                                                                      const Text(
                                                                    'Estimated Average Requirement (EAR): Average daily level of intake estimated to meet the requirements of 50% of healthy individuals',
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          'Close'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                        Languages.of(context)!
                                                            .NINTextPercentage,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Add some spacing between header and data
                                            Column(
                                              children: [
                                                customtablerow(
                                                  color: Colors.white,
                                                  percentageNotAvailable:
                                                      _profileFuture.energy ==
                                                          0,
                                                  ingredientName:
                                                      Languages.of(context)!
                                                          .NINTextEnergyKcal,
                                                  ingredientValue: mealsFood[0]
                                                      .totalmealCalories
                                                      .toStringAsFixed(mealsFood[
                                                                      0]
                                                                  .totalmealCalories >=
                                                              99
                                                          ? 0
                                                          : 2),
                                                  earValue: _profileFuture
                                                      .energy
                                                      .toStringAsFixed(
                                                          _profileFuture
                                                                      .energy >=
                                                                  99
                                                              ? 0
                                                              : 2),
                                                  percentage: mealsFood[0]
                                                          .totalmealCalories *
                                                      100 /
                                                      (_profileFuture.energy ==
                                                              0
                                                          ? 1
                                                          : _profileFuture
                                                              .energy),
                                                ),
                                                customtablerow(
                                                  color: TColor.primaryColor1
                                                      .withOpacity(0.2),
                                                  percentageNotAvailable:
                                                      _profileFuture.protein ==
                                                          0,
                                                  ingredientName:
                                                      Languages.of(context)!
                                                          .NINTextProteinG,
                                                  ingredientValue: mealsFood[0]
                                                      .mealProteins
                                                      .toStringAsFixed(mealsFood[
                                                                      0]
                                                                  .mealProteins >=
                                                              99
                                                          ? 0
                                                          : 2),
                                                  earValue: _profileFuture
                                                      .protein
                                                      .toStringAsFixed(
                                                          _profileFuture
                                                                      .protein >=
                                                                  99
                                                              ? 0
                                                              : 2),
                                                  percentage: mealsFood[0]
                                                          .mealProteins *
                                                      100 /
                                                      (_profileFuture.protein ==
                                                              0
                                                          ? 1
                                                          : _profileFuture
                                                              .protein),
                                                ),
                                                customtablerowforfat(
                                                  color: Colors.white,
                                                  percentageNotAvailable:
                                                      _profileFuture
                                                              .fatsOilsVisible ==
                                                          0,
                                                  ingredientName:
                                                      Languages.of(context)!
                                                          .NINTextFatG,
                                                  ingredientValue: mealsFood[0]
                                                      .mealFats
                                                      .toStringAsFixed(mealsFood[
                                                                      0]
                                                                  .mealFats >=
                                                              99
                                                          ? 0
                                                          : 2),
                                                  earValue: 'N/A',
                                                  percentage: mealsFood[0]
                                                          .mealFats *
                                                      100 /
                                                      (_profileFuture
                                                                  .fatsOilsVisible ==
                                                              0
                                                          ? 1
                                                          : _profileFuture
                                                              .fatsOilsVisible),
                                                ),
                                                customtablerow(
                                                  color: TColor.primaryColor1
                                                      .withOpacity(0.2),
                                                  percentageNotAvailable:
                                                      _profileFuture
                                                              .carbohydrate ==
                                                          0,
                                                  ingredientName: Languages.of(
                                                          context)!
                                                      .NINTextCarbohydratesG,
                                                  ingredientValue: mealsFood[0]
                                                      .mealCarbs
                                                      .toStringAsFixed(mealsFood[
                                                                      0]
                                                                  .mealCarbs >=
                                                              99
                                                          ? 0
                                                          : 2),
                                                  earValue: 'N/A  *',
                                                  percentage: mealsFood[0]
                                                          .mealCarbs *
                                                      100 /
                                                      (_profileFuture
                                                                  .carbohydrate ==
                                                              0
                                                          ? 1
                                                          : _profileFuture
                                                              .carbohydrate),
                                                ),
                                                customtablerow(
                                                  color: Colors.white,
                                                  percentageNotAvailable:
                                                      _profileFuture.calcium ==
                                                          0,
                                                  ingredientName:
                                                      Languages.of(context)!
                                                          .NINTextCalciumMg,
                                                  ingredientValue: mealsFood[0]
                                                      .mealCalcium
                                                      .toStringAsFixed(mealsFood[
                                                                      0]
                                                                  .mealCalcium >=
                                                              99
                                                          ? 0
                                                          : 2),
                                                  earValue: _profileFuture
                                                      .calcium
                                                      .toStringAsFixed(
                                                          _profileFuture
                                                                      .calcium >=
                                                                  99
                                                              ? 0
                                                              : 2),
                                                  percentage: mealsFood[0]
                                                          .mealCalcium *
                                                      100 /
                                                      (_profileFuture.calcium ==
                                                              0
                                                          ? 1
                                                          : _profileFuture
                                                              .calcium),
                                                ),
                                                customtablerow(
                                                  color: TColor.primaryColor1
                                                      .withOpacity(0.2),
                                                  percentageNotAvailable:
                                                      _profileFuture.fiber == 0,
                                                  ingredientName:
                                                      Languages.of(context)!
                                                          .NINTextFiberG,
                                                  ingredientValue: mealsFood[0]
                                                      .mealFibers
                                                      .toStringAsFixed(mealsFood[
                                                                      0]
                                                                  .mealFibers >=
                                                              99
                                                          ? 0
                                                          : 2),
                                                  earValue: 'N/A  **',
                                                  percentage: mealsFood[0]
                                                          .mealFibers *
                                                      100 /
                                                      (_profileFuture.fiber == 0
                                                          ? 1
                                                          : _profileFuture
                                                              .fiber),
                                                ),
                                                customtablerow(
                                                  color: Colors.white,
                                                  percentageNotAvailable:
                                                      _profileFuture.iron == 0,
                                                  ingredientName:
                                                      Languages.of(context)!
                                                          .NINTextIronMg,
                                                  ingredientValue: mealsFood[0]
                                                      .mealIron
                                                      .toStringAsFixed(mealsFood[
                                                                      0]
                                                                  .mealIron >=
                                                              99
                                                          ? 0
                                                          : 2),
                                                  earValue: _profileFuture.iron
                                                      .toStringAsFixed(
                                                          _profileFuture.iron >=
                                                                  99
                                                              ? 0
                                                              : 2),
                                                  percentage: mealsFood[0]
                                                          .mealIron *
                                                      100 /
                                                      (_profileFuture.iron == 0
                                                          ? 1
                                                          : _profileFuture
                                                              .iron),
                                                ),
                                                customtablerow(
                                                  color: TColor.primaryColor1
                                                      .withOpacity(0.2),
                                                  percentageNotAvailable:
                                                      _profileFuture.zinc == 0,
                                                  ingredientName:
                                                      Languages.of(context)!
                                                          .NINTextZincMg,
                                                  ingredientValue: mealsFood[0]
                                                      .mealZinc
                                                      .toStringAsFixed(mealsFood[
                                                                      0]
                                                                  .mealZinc >=
                                                              99
                                                          ? 0
                                                          : 2),
                                                  earValue: _profileFuture.zinc
                                                      .toStringAsFixed(
                                                          _profileFuture.zinc >=
                                                                  99
                                                              ? 0
                                                              : 2),
                                                  percentage: mealsFood[0]
                                                          .mealZinc *
                                                      100 /
                                                      (_profileFuture.zinc == 0
                                                          ? 1
                                                          : _profileFuture
                                                              .zinc),
                                                ),
                                                customtablerow(
                                                  color: Colors.white,
                                                  percentageNotAvailable:
                                                      _profileFuture
                                                              .magnesium ==
                                                          0,
                                                  ingredientName:
                                                      Languages.of(context)!
                                                          .NINTextMagnesiumMg,
                                                  ingredientValue: mealsFood[0]
                                                      .mealMagnesium
                                                      .toStringAsFixed(mealsFood[
                                                                      0]
                                                                  .mealMagnesium >=
                                                              99
                                                          ? 0
                                                          : 2),
                                                  earValue: _profileFuture
                                                      .magnesium
                                                      .toStringAsFixed(
                                                          _profileFuture
                                                                      .magnesium >=
                                                                  99
                                                              ? 0
                                                              : 2),
                                                  percentage: mealsFood[0]
                                                          .mealMagnesium *
                                                      100 /
                                                      (_profileFuture
                                                                  .magnesium ==
                                                              0
                                                          ? 1
                                                          : _profileFuture
                                                              .magnesium),
                                                ),
                                                customtablerow(
                                                  color: TColor.primaryColor1
                                                      .withOpacity(0.2),
                                                  percentageNotAvailable:
                                                      _profileFuture.thiamine ==
                                                          0,
                                                  ingredientName:
                                                      Languages.of(context)!
                                                          .NINTextThiamineB1Mg,
                                                  ingredientValue: mealsFood[0]
                                                      .mealThiamineB1
                                                      .toStringAsFixed(mealsFood[
                                                                      0]
                                                                  .mealThiamineB1 >=
                                                              99
                                                          ? 0
                                                          : 2),
                                                  earValue: _profileFuture
                                                      .thiamine
                                                      .toStringAsFixed(
                                                          _profileFuture
                                                                      .thiamine >=
                                                                  99
                                                              ? 0
                                                              : 2),
                                                  percentage: mealsFood[0]
                                                          .mealThiamineB1 *
                                                      100 /
                                                      (_profileFuture
                                                                  .thiamine ==
                                                              0
                                                          ? 1
                                                          : _profileFuture
                                                              .thiamine),
                                                ),
                                                customtablerow(
                                                  color: Colors.white,
                                                  percentageNotAvailable:
                                                      _profileFuture
                                                              .riboflavin ==
                                                          0,
                                                  ingredientName: Languages.of(
                                                          context)!
                                                      .NINTextRiboflavinB2Mg,
                                                  ingredientValue: mealsFood[0]
                                                      .mealRiboflavinB2
                                                      .toStringAsFixed(mealsFood[
                                                                      0]
                                                                  .mealRiboflavinB2 >=
                                                              99
                                                          ? 0
                                                          : 2),
                                                  earValue: _profileFuture
                                                      .riboflavin
                                                      .toStringAsFixed(
                                                          _profileFuture
                                                                      .riboflavin >=
                                                                  99
                                                              ? 0
                                                              : 2),
                                                  percentage: mealsFood[0]
                                                          .mealRiboflavinB2 *
                                                      100 /
                                                      (_profileFuture
                                                                  .riboflavin ==
                                                              0
                                                          ? 1
                                                          : _profileFuture
                                                              .riboflavin),
                                                ),
                                                customtablerow(
                                                  color: TColor.primaryColor1
                                                      .withOpacity(0.2),
                                                  percentageNotAvailable:
                                                      _profileFuture.niacin ==
                                                          0,
                                                  ingredientName:
                                                      Languages.of(context)!
                                                          .NINTextNiacinB3Mg,
                                                  ingredientValue: mealsFood[0]
                                                      .mealNiacinB3
                                                      .toStringAsFixed(mealsFood[
                                                                      0]
                                                                  .mealNiacinB3 >=
                                                              99
                                                          ? 0
                                                          : 2),
                                                  earValue: _profileFuture
                                                      .niacin
                                                      .toStringAsFixed(
                                                          _profileFuture
                                                                      .niacin >=
                                                                  99
                                                              ? 0
                                                              : 2),
                                                  percentage: mealsFood[0]
                                                          .mealNiacinB3 *
                                                      100 /
                                                      (_profileFuture.niacin ==
                                                              0
                                                          ? 1
                                                          : _profileFuture
                                                              .niacin),
                                                ),
                                                customtablerow(
                                                  color: Colors.white,
                                                  percentageNotAvailable:
                                                      _profileFuture.folate ==
                                                          0,
                                                  ingredientName:
                                                      Languages.of(context)!
                                                          .NINTextFolatesB9Mcg,
                                                  ingredientValue: mealsFood[0]
                                                      .mealFolatesB9
                                                      .toStringAsFixed(mealsFood[
                                                                      0]
                                                                  .mealFolatesB9 >=
                                                              99
                                                          ? 0
                                                          : 2),
                                                  earValue: _profileFuture
                                                      .folate
                                                      .toStringAsFixed(
                                                          _profileFuture
                                                                      .folate >=
                                                                  99
                                                              ? 0
                                                              : 2),
                                                  percentage: mealsFood[0]
                                                          .mealFolatesB9 *
                                                      100 /
                                                      (_profileFuture.folate ==
                                                              0
                                                          ? 1
                                                          : _profileFuture
                                                              .folate),
                                                ),
                                                customtablerow(
                                                  color: TColor.primaryColor1
                                                      .withOpacity(0.2),
                                                  percentageNotAvailable:
                                                      _profileFuture.vitA == 0,
                                                  ingredientName: Languages.of(
                                                          context)!
                                                      .NINTextRetinolVitAMcg,
                                                  ingredientValue: mealsFood[0]
                                                      .mealRetinolVitA
                                                      .toStringAsFixed(mealsFood[
                                                                      0]
                                                                  .mealRetinolVitA >=
                                                              99
                                                          ? 0
                                                          : 2),
                                                  earValue: _profileFuture.vitA
                                                      .toStringAsFixed(
                                                          _profileFuture.vitA >=
                                                                  99
                                                              ? 0
                                                              : 2),
                                                  percentage: mealsFood[0]
                                                          .mealRetinolVitA *
                                                      100 /
                                                      (_profileFuture.vitA == 0
                                                          ? 1
                                                          : _profileFuture
                                                              .vitA),
                                                ),
                                                // SizedBox(
                                                //   height: 4,
                                                // ),
                                                Container(
                                                  width: media.width * 0.85,
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    // color: TColor
                                                    //     .primaryColor1
                                                    //     .withOpacity(0.2),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          Languages.of(context)!
                                                              .ninTextAdequateIntakeCarbs // style:
                                                          // style: TextStyle(
                                                          //   fontWeight:
                                                          //       FontWeight.bold,
                                                          //   fontSize: AppFontSizes.mediumDefault.0,
                                                          // ),
                                                          ),
                                                      const SizedBox(
                                                          height: 8.0),
                                                      Text(
                                                          Languages.of(context)!
                                                              .ninTextAdequateIntakeFiber // style: TextStyle(
                                                          //   fontWeight:
                                                          //       FontWeight.bold,
                                                          //   fontSize: AppFontSizes.mediumDefault.0,
                                                          // ),
                                                          ),
                                                    ],
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                if (mealsFood[i]
                                                        .totalmealCalories >
                                                    0)
                                                  Column(
                                                    children: [
                                                      const Center(
                                                          child: Text(
                                                        "Nutrient intake based on AMDR",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: AppFontSizes
                                                              .mediumDefault,
                                                        ),
                                                      )),
                                                      SizedBox(
                                                        width:
                                                            media.width * 0.85,
                                                        child: CarbIntakeResultContainer(
                                                            carbIntake: (mealsFood[
                                                                            i]
                                                                        .mealCarbs *
                                                                    4 *
                                                                    100) /
                                                                (mealsFood[i]
                                                                    .totalmealCalories)),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            media.width * 0.85,
                                                        child:
                                                            FatIntakeResultContainerI(
                                                          fatIntake: (mealsFood[
                                                                          i]
                                                                      .mealFats *
                                                                  9 *
                                                                  100) /
                                                              (mealsFood[i]
                                                                  .totalmealCalories),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            media.width * 0.85,
                                                        child:
                                                            ProteinIntakeResultContainer(
                                                          proteinIntake: (mealsFood[
                                                                          i]
                                                                      .mealProteins *
                                                                  4 *
                                                                  100) /
                                                              (mealsFood[i]
                                                                  .totalmealCalories),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            media.width * 0.85,
                                                        child:
                                                            RefinedSugarIntakeResultContainer(
                                                          sugarIntake: sugar,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            media.width * 0.85,
                                                        child:
                                                            SaltIntakeResultContainer(
                                                          saltIntake: salt,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            media.width * 0.85,
                                                        child:
                                                            DDSResultContainer(),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                SizedBox(
                                                  width: media.width * 0.82,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            media.width * 0.5,
                                                        height: 35,
                                                        child: RoundButton(
                                                          title:
                                                              "View previous diaries",
                                                          type: RoundButtonType
                                                              .bgGradient,
                                                          fontSize: AppFontSizes
                                                              .mediumDefault,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        DietryDiary(),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              sizedBox12(),

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //   children: [
                              //     Container(
                              //       alignment: Alignment.center,
                              //       child: SizedBox(
                              //         // width: media.width * 0.,
                              //         // height: media.width * 0.4,
                              //         child: Stack(
                              //           alignment: Alignment.center,
                              //           children: [
                              //             Container(
                              //               width: media.width * 0.20,
                              //               height: media.width * 0.20,
                              //               alignment: Alignment.center,
                              //               decoration: BoxDecoration(
                              //                 gradient:
                              //                     LinearGradient(colors: TColor.primaryG),
                              //                 borderRadius: BorderRadius.circular(
                              //                     media.width * 0.75),
                              //               ),
                              //               child: FittedBox(
                              //                 child: Text(
                              //                   "${fitnessData.steps}",
                              //                   textAlign: TextAlign.center,
                              //                   style: TextStyle(
                              //                       color: ThemeManager.themeColor,
                              //                       fontSize: AppFontSizes.mediumDefault),
                              //                 ),
                              //               ),
                              //             ),
                              //             SimpleCircularProgressBar(
                              //               size: 100,
                              //               progressStrokeWidth: 10,
                              //               backStrokeWidth: 12,
                              //               progressColors: TColor.primaryG,
                              //               backColor: Colors.grey.shade100,
                              //               valueNotifier: ValueNotifier(50),
                              //               startAngle: -180,
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     ClipOval(
                              //       child: Container(
                              //         width: 80,
                              //         //  height: 41,
                              //         decoration: BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           color: ThemeManager
                              //               .themelightColor, // Set the background color for the circular container
                              //         ),
                              //         child: Center(
                              //           child: Image.asset(
                              //             "assets/images/steps.png",
                              //             // width: 2100, // Adjust the width of the image
                              //             // height: 24, // Adjust the height of the image
                              //             color: ThemeManager.themeText,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         NutrientInMyFood(),
                                      //     // ActivityTrackerScreen(),
                                      //     // LocationMarker(),
                                      //   ),
                                      // );
                                    },
                                    // onLongPress: () => _speak(
                                    //     'check your time and calories burn you spent on different activivties'),
                                    child: Container(
                                      width: media.width * 0.95,
                                      // height: media.width * 0.15,
                                      // height: media.width * 0.40,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: TColor.primaryColor2
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ClipOval(
                                                child: Container(
                                                  width: 45,
                                                  //  height: 41,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ThemeManager
                                                        .themelightColor, // Set the background color for the circular container
                                                  ),
                                                  child: Center(
                                                    child: Image.asset(
                                                      'assets/img/my diet plan.png',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: media.width * 0.5,
                                                child: Text(
                                                  Languages.of(context)!
                                                      .TextAppMyDietDiary,
                                                  textAlign: TextAlign.start,
                                                  // $_steps2
                                                  style: TextStyle(
                                                      color: ThemeManager
                                                          .themeText,
                                                      fontSize: AppFontSizes
                                                          .largeDefault,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: 80,
                                            // height: 35,
                                            child: RoundButton(
                                              title: Languages.of(context)!
                                                  .labelCheck,
                                              type: RoundButtonType.bgGradient,
                                              fontSize:
                                                  AppFontSizes.smallDefault,
                                              fontWeight: FontWeight.w400,
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DietryDiary(),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sizedBox12(),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    // onTap: () {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => ToadyActivity(),
                                    //       // ActivityTrackerScreen(),
                                    //       // LocationMarker(),
                                    //     ),
                                    //   );
                                    // },
                                    // onLongPress: () => _speak(
                                    //     'check your time and calories burn you spent on different activivties'),
                                    child: Container(
                                      width: media.width * 0.95,
                                      // height: media.width * 0.15,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 13, horizontal: 13),
                                      decoration: BoxDecoration(
                                        color: TColor.primaryColor2
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ClipOval(
                                                child: Container(
                                                  width: 50,
                                                  //  height: 41,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ThemeManager
                                                        .themelightColor, // Set the background color for the circular container
                                                  ),
                                                  child: Center(
                                                    child: Image.asset(
                                                      "assets/img/running.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: media.width * 0.5,
                                                child: Text(
                                                  Languages.of(context)!
                                                      .TextApp1MyActivity,
                                                  textAlign: TextAlign.start,
                                                  // $_steps2
                                                  style: TextStyle(
                                                      color: ThemeManager
                                                          .themeText,
                                                      fontSize: AppFontSizes
                                                          .largeDefault,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Spacer(),

                                          const Spacer(),
                                          SizedBox(
                                            width: 80,
                                            // height: 35,
                                            child: RoundButton(
                                              title: Languages.of(context)!
                                                  .labelCheck,
                                              type: RoundButtonType.bgGradient,
                                              fontSize:
                                                  AppFontSizes.smallDefault,
                                              fontWeight: FontWeight.w400,
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ToadyActivity(),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // sizedBox12(),

                              // Container(
                              //   width: media.width * 0.95,
                              //   decoration: BoxDecoration(
                              //     color: TColor.primaryColor2.withOpacity(0.3),
                              //     borderRadius: BorderRadius.circular(15),
                              //   ),
                              //   child: ExpansionTile(
                              //     title: Row(
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       children: [
                              //         ClipOval(
                              //           child: Container(
                              //             width: 45,
                              //             //  height: 41,
                              //             // decoration: BoxDecoration(
                              //             //   shape: BoxShape.circle,
                              //             //   color: ThemeManager
                              //             //       .themelightColor, // Set the background color for the circular container
                              //             // ),
                              //             child: Center(
                              //               child: Image.asset(
                              //                 "assets/img/activity tracker.jpeg",
                              //                 //    "assets/img/running.png",
                              //                 // width: 2100, // Adjust the width of the image
                              //                 // height: 24, // Adjust the height of the image
                              //                 // color: ThemeManager.themeText,
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //         // Spacer(),
                              //         SizedBox(width: 5),
                              //         SizedBox(
                              //           // width: media.width * 0.60,
                              //           child: Text(
                              //             "Track my activity",
                              //             // $_steps2
                              //             style: TextStyle(
                              //                 color: ThemeManager.themeText,
                              //                 fontSize: 19,
                              //                 fontWeight: FontWeight.w700),
                              //           ),
                              //         ),
                              //         // Text(
                              //         //   " ${fitnessData.steps} ",
                              //         //   // $_steps2
                              //         //   style: TextStyle(
                              //         //       color: ThemeManager.themeText,
                              //         //       fontSize:AppFontSizes.extraLargeDefault,
                              //         //       fontWeight: FontWeight.w700),
                              //         // ),
                              //         // SizedBox(
                              //         //   width: 70,
                              //         //   height: 25,
                              //         //   child: RoundButton(
                              //         //     title: Languages.of(context)!.labelCheck,
                              //         //     type: RoundButtonType.bgGradient,
                              //         //     fontSize: AppFontSizes.smallDefault,,
                              //         //     fontWeight: FontWeight.w400,
                              //         //     onPressed: () {
                              //         //       Navigator.push(
                              //         //         context,
                              //         //         MaterialPageRoute(
                              //         //           builder: (context) => stepsWeekly(),
                              //         //           // ActivityTrackerScreen(),
                              //         //           // LocationMarker(),
                              //         //         ),
                              //         //       );
                              //         //       // Navigator.push(
                              //         //       //   context,
                              //         //       //   MaterialPageRoute(
                              //         //       //       builder: (context) => BMRCalculator()),
                              //         //       // );
                              //         //     },
                              //         //   ),
                              //         // )
                              //       ],
                              //     ),
                              //     children: [
                              //       Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Column(
                              //           children: [
                              //             sizedBox12(),
                              //             GestureDetector(
                              //               onTap: () {
                              //                 Navigator.push(
                              //                   context,
                              //                   MaterialPageRoute(
                              //                       builder: (context) =>
                              //                           stepsWeekly()
                              //                       //  AllActivityScreen(),
                              //                       //  AllActivityScreen(),
                              //                       // ActivityTrackerScreen(),
                              //                       // LocationMarker(),
                              //                       ),
                              //                 );
                              //                 // Navigator.push(
                              //                 //   context,
                              //                 //   MaterialPageRoute(
                              //                 //       builder: (context) => BMRCalculator()),
                              //                 // );
                              //               },
                              //               child: Container(
                              //                 height: media.width * 0.3,
                              //                 padding:
                              //                     const EdgeInsets.symmetric(
                              //                         vertical: 15,
                              //                         horizontal: 15),
                              //                 decoration: BoxDecoration(
                              //                   color: TColor.primaryColor2
                              //                       .withOpacity(0.3),
                              //                   borderRadius:
                              //                       BorderRadius.circular(15),
                              //                 ),
                              //                 child: Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.start,
                              //                   children: [
                              //                     ClipOval(
                              //                       child: Container(
                              //                         width: 80,
                              //                         //  height: 41,
                              //                         // decoration: BoxDecoration(
                              //                         //   shape: BoxShape.circle,
                              //                         //   color: ThemeManager
                              //                         //       .themelightColor, // Set the background color for the circular container
                              //                         // ),
                              //                         child: Center(
                              //                           child: Image.asset(
                              //                             "assets/images/shoes.png",
                              //                             //    "assets/img/running.png",
                              //                             // width: 2100, // Adjust the width of the image
                              //                             // height: 24, // Adjust the height of the image
                              //                             // color: ThemeManager.themeText,
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                     Spacer(),
                              //                     Column(
                              //                       crossAxisAlignment:
                              //                           CrossAxisAlignment
                              //                               .center,
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .center,
                              //                       children: [
                              //                         SizedBox(
                              //                           // width: media.width * 0.60,
                              //                           child: Text(
                              //                             "${Languages.of(context)!.labelTodaySteps}  ",
                              //                             //
                              //                             // $_steps2
                              //                             style: TextStyle(
                              //                                 color: ThemeManager
                              //                                     .themeText,
                              //                                 fontSize: 19,
                              //                                 fontWeight:
                              //                                     FontWeight
                              //                                         .w700),
                              //                           ),
                              //                         ),
                              //                         SizedBox(
                              //                           // width: media.width * 0.60,
                              //                           child: Text(
                              //                             "${fitnessData!.steps}",
                              //                             //
                              //                             // $_steps2
                              //                             style: TextStyle(
                              //                                 color: ThemeManager
                              //                                     .themeText,
                              //                                 fontSize: 19,
                              //                                 fontWeight:
                              //                                     FontWeight
                              //                                         .w700),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                     SizedBox(
                              //                       width: 50,
                              //                     )
                              //                   ],
                              //                 ),
                              //               ),
                              //             ),
                              //             sizedBox12(),
                              //             GestureDetector(
                              //               onTap: () {
                              //                 Navigator.push(
                              //                   context,
                              //                   MaterialPageRoute(
                              //                     builder: (context) =>
                              //                         ShowWeeklyCaloriesBurn(),
                              //                   ),
                              //                 );
                              //               },
                              //               child: Container(
                              //                 padding:
                              //                     const EdgeInsets.symmetric(
                              //                         vertical: 15,
                              //                         horizontal: 15),
                              //                 decoration: BoxDecoration(
                              //                   color: TColor.primaryColor2
                              //                       .withOpacity(0.3),
                              //                   borderRadius:
                              //                       BorderRadius.circular(15),
                              //                 ),
                              //                 height: media.width * 0.3,
                              //                 child: Row(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.start,
                              //                     children: [
                              //                       SizedBox(
                              //                         width: 5,
                              //                       ),
                              //                       Container(
                              //                         alignment:
                              //                             Alignment.center,
                              //                         child: SizedBox(
                              //                           width:
                              //                               media.width * 0.2,
                              //                           height:
                              //                               media.width * 0.2,
                              //                           child: Stack(
                              //                             alignment:
                              //                                 Alignment.center,
                              //                             children: [
                              //                               Container(
                              //                                 width:
                              //                                     media.width *
                              //                                         0.15,
                              //                                 height:
                              //                                     media.width *
                              //                                         0.15,
                              //                                 alignment:
                              //                                     Alignment
                              //                                         .center,
                              //                                 decoration:
                              //                                     BoxDecoration(
                              //                                   gradient: LinearGradient(
                              //                                       colors: TColor
                              //                                           .primaryG),
                              //                                   borderRadius: BorderRadius
                              //                                       .circular(media
                              //                                               .width *
                              //                                           0.075),
                              //                                 ),
                              //                                 child: FittedBox(
                              //                                   child: Text(
                              //                                     // "$caloriesburnleft kCal\nleft",
                              //                                     "${fitnessData.caloriesLeft} kCal\nleft",
                              //                                     textAlign:
                              //                                         TextAlign
                              //                                             .center,
                              //                                     style: TextStyle(
                              //                                         color: ThemeManager
                              //                                             .themeColor,
                              //                                         fontSize:
                              //                                             12),
                              //                                   ),
                              //                                 ),
                              //                               ),
                              //                               // ClipOval(
                              //                               //   child: Container(
                              //                               //     width: 50,
                              //                               //     child: Center(
                              //                               //       child: Image.asset(
                              //                               //         "assets/images/calories.png",
                              //                               //       ),
                              //                               //     ),
                              //                               //   ),
                              //                               // ),
                              //                               SimpleCircularProgressBar(
                              //                                 progressStrokeWidth:
                              //                                     10,
                              //                                 backStrokeWidth:
                              //                                     10,
                              //                                 progressColors:
                              //                                     TColor
                              //                                         .primaryG,
                              //                                 backColor: Colors
                              //                                     .grey
                              //                                     .shade100,
                              //                                 valueNotifier:
                              //                                     ValueNotifier(
                              //                                         fitnessData
                              //                                             .caloriesProgressBar),
                              //                                 startAngle: -180,
                              //                               ),
                              //                             ],
                              //                           ),
                              //                         ),
                              //                       ),
                              //                       const Spacer(),
                              //                       Column(
                              //                         mainAxisAlignment:
                              //                             MainAxisAlignment
                              //                                 .center,
                              //                         children: [
                              //                           Text(
                              //                             Languages.of(context)!
                              //                                 .labelCalories,
                              //                             style: TextStyle(
                              //                                 color: ThemeManager
                              //                                     .themeText,
                              //                                 fontSize: 19,
                              //                                 fontWeight:
                              //                                     FontWeight
                              //                                         .w700),
                              //                           ),
                              //                           sizedBox12(),
                              //                           SizedBox(
                              //                             // width: media.width * 0.60,
                              //                             child: Text(
                              //                               "${double.parse(fitnessData.caloriesBurned).toStringAsFixed(1)} kCal",
                              //                               //
                              //                               // $_steps2
                              //                               style: TextStyle(
                              //                                   color: ThemeManager
                              //                                       .themeText,
                              //                                   fontSize: 19,
                              //                                   fontWeight:
                              //                                       FontWeight
                              //                                           .w700),
                              //                             ),
                              //                           ),
                              //                           // Text(
                              //                           //   // "$caloriesburn kCal",
                              //                           //   "${double.parse(fitnessData.caloriesBurned).toStringAsFixed(1)} kCal",
                              //                           //   style: TextStyle(
                              //                           //       color: ThemeManager.themeText, fontSize: AppFontSizes.mediumDefault),
                              //                           // ),
                              //                         ],
                              //                       ),
                              //                       SizedBox(
                              //                         width: 50,
                              //                       )
                              //                     ]),
                              //               ),
                              //             ),
                              //             sizedBox12(),
                              //             GestureDetector(
                              //               onTap: () {
                              //                 Navigator.push(
                              //                   context,
                              //                   MaterialPageRoute(
                              //                     builder: (context) =>
                              //                         AllActivityScreen(),
                              //                     // ActivityTrackerScreen(),
                              //                     // LocationMarker(),
                              //                   ),
                              //                 );
                              //               },
                              //               child: Container(
                              //                 // width: media.width * 0.28,
                              //                 height: media.width * 0.3,
                              //                 padding:
                              //                     const EdgeInsets.symmetric(
                              //                         vertical: 15,
                              //                         horizontal: 15),
                              //                 decoration: BoxDecoration(
                              //                   color: TColor.primaryColor2
                              //                       .withOpacity(0.3),
                              //                   borderRadius:
                              //                       BorderRadius.circular(15),
                              //                 ),
                              //                 child: Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment
                              //                           .spaceAround,
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.center,
                              //                   children: [
                              //                     ClipOval(
                              //                       child: Container(
                              //                         width: 80,
                              //                         //  height: 41,
                              //                         decoration: BoxDecoration(
                              //                           shape: BoxShape.circle,
                              //                           color: ThemeManager
                              //                               .themelightColor, // Set the background color for the circular container
                              //                         ),
                              //                         child: Center(
                              //                           child: Image.asset(
                              //                             "assets/images/exercise.png",
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     ),
                              //                     Spacer(),
                              //                     SizedBox(
                              //                       width: media.width * 0.50,
                              //                       child: Text(
                              //                         Languages.of(context)!
                              //                             .mainlabelTimeSpentOn,
                              //                         textAlign:
                              //                             TextAlign.center,
                              //                         // $_steps2
                              //                         style: TextStyle(
                              //                             color: ThemeManager
                              //                                 .themeText,
                              //                             fontSize: 19,
                              //                             fontWeight:
                              //                                 FontWeight.w700),
                              //                       ),
                              //                     ),
                              //                     SizedBox(
                              //                       width: 35,
                              //                     )
                              //                   ],
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       )
                              //     ],
                              //     onExpansionChanged: (expanded) {
                              //       if (expanded) {
                              //         // Calculate total calories earned
                              //         setState(() {});
                              //       }
                              //     },
                              //   ),
                              // ),
                              sizedBox12(),
                              //currently i am here

                              // InkWell(
                              //   onTap: () {
                              //     // Navigator.push(
                              //     //   context,
                              //     //   MaterialPageRoute(s
                              //     //     builder: (context) =>
                              //     //         const ActivityTrackerView(),
                              //     //   ),
                              //     // );
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) =>
                              //             SleepTrackerSCreen(),
                              //       ),
                              //     );
                              //   },
                              //   child: Container(
                              //     width: double.maxFinite,
                              //     height: media.width * 0.45,
                              //     padding: const EdgeInsets.symmetric(
                              //         vertical: 25, horizontal: 20),
                              //     decoration: BoxDecoration(
                              //         color: ThemeManager.themeColor,
                              //         borderRadius: BorderRadius.circular(25),
                              //         boxShadow: [
                              //           BoxShadow(
                              //               color: ThemeManager.themeText,
                              //               blurRadius: 0.1)
                              //         ]),
                              //     child: Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Row(
                              //             children: [
                              //               Text(
                              //                 Languages.of(context)!.labelSleep,
                              //                 style: TextStyle(
                              //                     color: ThemeManager.themeText,
                              //                     fontSize: AppFontSizes.smallDefault,,
                              //                     fontWeight: FontWeight.w700),
                              //               ),
                              //               SizedBox(
                              //                 width: 10,
                              //               ),
                              //               // SizedBox(
                              //               //   width: 70,
                              //               //   height: 20,
                              //               //   child: RoundButton(
                              //               //     title: Languages.of(
                              //               //             context)!
                              //               //         .labelCheck,
                              //               //     type: RoundButtonType
                              //               //         .bgGradient,
                              //               //     fontSize: AppFontSizes.smallDefault,,
                              //               //     fontWeight:
                              //               //         FontWeight.w400,
                              //               //     onPressed: () {
                              //               //       // Navigator.push(
                              //               //       //   context,
                              //               //       //   MaterialPageRoute(s
                              //               //       //     builder: (context) =>
                              //               //       //         const ActivityTrackerView(),
                              //               //       //   ),
                              //               //       // );
                              //               //       Navigator.push(
                              //               //         context,
                              //               //         MaterialPageRoute(
                              //               //           builder: (context) =>
                              //               //               SleepTrackerSCreen(),
                              //               //         ),
                              //               //       );
                              //               //     },
                              //               //   ),
                              //               // )
                              //             ],
                              //           ),
                              //           ShaderMask(
                              //             blendMode: BlendMode.srcIn,
                              //             shaderCallback: (bounds) {
                              //               return LinearGradient(
                              //                       colors: TColor.primaryG,
                              //                       begin: Alignment.centerLeft,
                              //                       end: Alignment.centerRight)
                              //                   .createShader(Rect.fromLTRB(
                              //                       0,
                              //                       0,
                              //                       bounds.width,
                              //                       bounds.height));
                              //             },
                              //             child: Text(
                              //               "${fitnessData.sleepTime}",
                              //               style: TextStyle(
                              //                   color: ThemeManager.themeColor
                              //                       .withOpacity(0.7),
                              //                   fontWeight: FontWeight.w700,
                              //                   fontSize: AppFontSizes.mediumDefault),
                              //             ),
                              //           ),
                              //           const Spacer(),
                              //           SizedBox(
                              //             width: 100,
                              //             child: Image.asset(
                              //                 "assets/img/sleep_grap.png",
                              //                 width: double.maxFinite,
                              //                 fit: BoxFit.fitWidth),
                              //           )
                              //         ]),
                              //   ),
                              // ),
                              // sizedBox12(),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BMICalculator(),
                                          // ActivityTrackerScreen(),
                                          // LocationMarker(),
                                        ),
                                      );
                                    },
                                    // onLongPress: () => _speak(
                                    //     'Your ${Languages.of(context)!.labelTodaySteps} is $_steps2  steps'),
                                    child: Container(
                                      width: media.width * 0.47,
                                      height: media.width * 0.45,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: TColor.primaryColor2
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipOval(
                                            child: SizedBox(
                                              width: 60,
                                              height: 60,
                                              //  height: 41,
                                              // decoration: BoxDecoration(
                                              //   shape: BoxShape.circle,
                                              //   color: ThemeManager
                                              //       .themelightColor, // Set the background color for the circular container
                                              // ),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/images/bmi.png",
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Spacer(),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Center(
                                            child: Text(
                                              Languages.of(context)!
                                                  .mainlabelBMICalculator,
                                              textAlign: TextAlign.center,
                                              // $_steps2
                                              style: TextStyle(
                                                  color: ThemeManager.themeText,
                                                  fontSize:
                                                      AppFontSizes.largeDefault,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BMRCalculator(),
                                          // ActivityTrackerScreen(),
                                          // LocationMarker(),
                                        ),
                                      );
                                    },
                                    // onLongPress: () => _speak(
                                    //     'Your ${Languages.of(context)!.labelTodaySteps} is $_steps2  steps'),
                                    child: Container(
                                      width: media.width * 0.47,
                                      height: media.width * 0.45,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: TColor.primaryColor2
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipOval(
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ThemeManager
                                                    .themelightColor, // Set the background color for the circular container
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/images/calculator.png",
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Spacer(),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Center(
                                            child: Text(
                                              Languages.of(context)!
                                                  .mainlabelBMRCalculator,
                                              textAlign: TextAlign.center,
                                              // $_steps2
                                              style: TextStyle(
                                                  color: ThemeManager.themeText,
                                                  fontSize:
                                                      AppFontSizes.largeDefault,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sizedBox12(),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const WeightManager(),
                                          // ActivityTrackerScreen(),
                                          // LocationMarker(),
                                        ),
                                      );
                                    },
                                    // onLongPress: () => _speak(
                                    //     'Your ${Languages.of(context)!.labelTodaySteps} is $_steps2  steps'),
                                    child: Container(
                                      width: media.width * 0.47,
                                      height: media.width * 0.45,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: TColor.primaryColor2
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipOval(
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ThemeManager
                                                    .themelightColor, // Set the background color for the circular container
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/img/body weight.png",
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Spacer(),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Center(
                                            child: Text(
                                              Languages.of(context)!
                                                  .TextAppWeightManager,
                                              textAlign: TextAlign.center,
                                              // $_steps2
                                              style: TextStyle(
                                                  color: ThemeManager.themeText,
                                                  fontSize:
                                                      AppFontSizes.largeDefault,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ActivityTrackerPage(),
                                          // ActivityTrackerScreen(),
                                          // LocationMarker(),
                                        ),
                                      );
                                      setState(() {
                                        fetchData0();
                                      });
                                    },
                                    // onLongPress: () => _speak(
                                    //     'Your ${Languages.of(context)!.labelTodaySteps} is $_steps2  steps'),
                                    child: Container(
                                      width: media.width * 0.47,
                                      height: media.width * 0.45,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: TColor.primaryColor2
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipOval(
                                            child: SizedBox(
                                              width: 60,
                                              height: 60,
                                              // decoration: BoxDecoration(
                                              //   shape: BoxShape.circle,
                                              //   color: ThemeManager
                                              //       .themelightColor, // Set the background color for the circular container
                                              // ),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/img/activity tracker.jpeg",
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Spacer(),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Center(
                                            child: Text(
                                              Languages.of(context)!
                                                  .ninTextTrackMyActivity,
                                              textAlign: TextAlign.center,
                                              // $_steps2
                                              style: TextStyle(
                                                  color: ThemeManager.themeText,
                                                  fontSize:
                                                      AppFontSizes.largeDefault,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              sizedBox12(),
                              Container(
                                width: media.width * 0.95,
                                decoration: BoxDecoration(
                                  color: TColor.primaryColor2.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipOval(
                                        child: SizedBox(
                                          width: 50,
                                          //  height: 41,
                                          // decoration: BoxDecoration(
                                          //   shape: BoxShape.circle,
                                          //   color: ThemeManager
                                          //       .themelightColor, // Set the background color for the circular container
                                          // ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/pulse.png",
                                              //    "assets/img/running.png",
                                              width:
                                                  38, // Adjust the width of the image
                                              // height: 24, // Adjust the height of the image
                                              // color: ThemeManager.themeText,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width: media.width * 0.5,
                                        child: Text(
                                          Languages.of(context)!
                                              .ninTextMyHeartRate,
                                          style: TextStyle(
                                              color: ThemeManager.themeText,
                                              fontSize:
                                                  AppFontSizes.largeDefault,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: 80,
                                        // height: 35,
                                        child: RoundButton(
                                          title:
                                              Languages.of(context)!.labelCheck,
                                          type: RoundButtonType.bgGradient,
                                          fontSize: AppFontSizes.smallDefault,
                                          fontWeight: FontWeight.w400,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ShowWeeklyHeartRate(),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // sizedBox12(),
                              // GestureDetector(
                              //   onLongPress: () => _speak(
                              //       'Your ${Languages.of(context)!.labelHeartRate} $HeartRateData BPM'),
                              //   child: ClipRRect(
                              //     borderRadius: BorderRadius.circular(25),
                              //     child: Container(
                              //       height: media.width * 0.4,
                              //       width: double.maxFinite,
                              //       decoration: BoxDecoration(
                              //         color:
                              //             TColor.primaryColor2.withOpacity(0.3),
                              //         borderRadius: BorderRadius.circular(25),
                              //       ),
                              //       child: Stack(
                              //         alignment: Alignment.topLeft,
                              //         children: [
                              //           Padding(
                              //             padding: const EdgeInsets.symmetric(
                              //                 vertical: 20, horizontal: 20),
                              //             child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.start,
                              //               mainAxisSize: MainAxisSize.min,
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: [
                              //                 Text(
                              //                   Languages.of(context)!
                              //                       .labelHeartRate,
                              //                   style: TextStyle(
                              //                       color:
                              //                           ThemeManager.themeText,
                              //                       fontSize: AppFontSizes.mediumDefault,
                              //                       fontWeight:
                              //                           FontWeight.w700),
                              //                 ),
                              //                 ShaderMask(
                              //                   blendMode: BlendMode.srcIn,
                              //                   shaderCallback: (bounds) {
                              //                     return LinearGradient(
                              //                             colors:
                              //                                 TColor.primaryG,
                              //                             begin: Alignment
                              //                                 .centerLeft,
                              //                             end: Alignment
                              //                                 .centerRight)
                              //                         .createShader(
                              //                             Rect.fromLTRB(
                              //                                 0,
                              //                                 0,
                              //                                 bounds.width,
                              //                                 bounds.height));
                              //                   },
                              //                   child: Text(
                              //                     "${fitnessData.heartRate} BPM",
                              //                     style: TextStyle(
                              //                         color: ThemeManager
                              //                             .themeColor
                              //                             .withOpacity(0.7),
                              //                         fontWeight:
                              //                             FontWeight.w700,
                              //                         fontSize: AppFontSizes.mediumDefault),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //           LineChart(
                              //             LineChartData(
                              //               showingTooltipIndicators:
                              //                   showingTooltipOnSpots
                              //                       .map((index) {
                              //                 return ShowingTooltipIndicators([
                              //                   LineBarSpot(
                              //                     tooltipsOnBar,
                              //                     lineBarsData
                              //                         .indexOf(tooltipsOnBar),
                              //                     tooltipsOnBar.spots[index],
                              //                   ),
                              //                 ]);
                              //               }).toList(),
                              //               lineTouchData: LineTouchData(
                              //                 enabled: true,
                              //                 handleBuiltInTouches: false,
                              //                 touchCallback: (FlTouchEvent
                              //                         event,
                              //                     LineTouchResponse? response) {
                              //                   if (response == null ||
                              //                       response.lineBarSpots ==
                              //                           null) {
                              //                     return;
                              //                   }
                              //                   if (event is FlTapUpEvent) {
                              //                     final spotIndex = response
                              //                         .lineBarSpots!
                              //                         .first
                              //                         .spotIndex;
                              //                     showingTooltipOnSpots.clear();
                              //                     setState(() {
                              //                       showingTooltipOnSpots
                              //                           .add(spotIndex);
                              //                     });
                              //                   }
                              //                 },
                              //                 mouseCursorResolver: (FlTouchEvent
                              //                         event,
                              //                     LineTouchResponse? response) {
                              //                   if (response == null ||
                              //                       response.lineBarSpots ==
                              //                           null) {
                              //                     return SystemMouseCursors
                              //                         .basic;
                              //                   }
                              //                   return SystemMouseCursors.click;
                              //                 },
                              //                 getTouchedSpotIndicator:
                              //                     (LineChartBarData barData,
                              //                         List<int> spotIndexes) {
                              //                   return spotIndexes.map((index) {
                              //                     return TouchedSpotIndicatorData(
                              //                       FlLine(
                              //                         color: Colors.red,
                              //                       ),
                              //                       FlDotData(
                              //                         show: true,
                              //                         getDotPainter: (spot,
                              //                                 percent,
                              //                                 barData,
                              //                                 index) =>
                              //                             FlDotCirclePainter(
                              //                           radius: 3,
                              //                           color: Colors.white,
                              //                           strokeWidth: 3,
                              //                           strokeColor: TColor
                              //                               .secondaryColor1,
                              //                         ),
                              //                       ),
                              //                     );
                              //                   }).toList();
                              //                 },
                              //                 touchTooltipData:
                              //                     LineTouchTooltipData(
                              //                   tooltipBgColor:
                              //                       TColor.secondaryColor1,
                              //                   tooltipRoundedRadius: 20,
                              //                   getTooltipItems:
                              //                       (List<LineBarSpot>
                              //                           lineBarsSpot) {
                              //                     return lineBarsSpot
                              //                         .map((lineBarSpot) {
                              //                       return LineTooltipItem(
                              //                         "${lineBarSpot.x.toInt()} ${Languages.of(context)!.labelMinutesAgo}",
                              //                         const TextStyle(
                              //                           color: Colors.white,
                              //                           fontSize: AppFontSizes.smallDefault,
                              //                           fontWeight:
                              //                               FontWeight.bold,
                              //                         ),
                              //                       );
                              //                     }).toList();
                              //                   },
                              //                 ),
                              //               ),
                              //               lineBarsData: lineBarsData,
                              //               minY: 0,
                              //               maxY: 130,
                              //               titlesData: FlTitlesData(
                              //                 show: false,
                              //               ),
                              //               gridData: FlGridData(show: false),
                              //               borderData: FlBorderData(
                              //                 show: true,
                              //                 border: Border.all(
                              //                   color: Colors.transparent,
                              //                 ),
                              //               ),
                              //             ),
                              //           )
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // // sizedBox12(),
                              // GestureDetector(
                              //   onLongPress: () => _speak(
                              //       'click on right check button to check your ${Languages.of(context)!.labelHealthData}'),
                              //   child: Container(
                              //     padding: const EdgeInsets.symmetric(
                              //         vertical: 15, horizontal: 15),
                              //     decoration: BoxDecoration(
                              //       color:
                              //           TColor.primaryColor2.withOpacity(0.3),
                              //       borderRadius: BorderRadius.circular(15),
                              //     ),
                              //     child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         SizedBox(
                              //           width: media.width * 0.60,
                              //           child: Text(
                              //             Languages.of(context)!
                              //                 .labelHealthData,
                              //             style: TextStyle(
                              //               color: ThemeManager.themeText,
                              //               fontSize: 19,
                              //               fontWeight: FontWeight.w700,
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           width: 70,
                              //           height: 35,
                              //           child: RoundButton(
                              //             title:
                              //                 Languages.of(context)!.labelCheck,
                              //             type: RoundButtonType.bgGradient,
                              //             fontSize: AppFontSizes.smallDefault,,
                              //             fontWeight: FontWeight.w400,
                              //             onPressed: () {
                              //               // Navigator.push(
                              //               //   context,
                              //               //   MaterialPageRoute(s
                              //               //     builder: (context) =>
                              //               //         const ActivityTrackerView(),
                              //               //   ),
                              //               // );
                              //               Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                   builder: (context) =>
                              //                       HealthScreen(),
                              //                 ),
                              //               );
                              //             },
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              sizedBox12(),
                              Container(
                                width: media.width * 0.95,
                                decoration: BoxDecoration(
                                  color: TColor.primaryColor2.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ExpansionTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 13.0, right: 13),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          // width: media.width * 0.6,
                                          child: SizedBox(
                                            width: media.width * 0.6,
                                            child: Text(
                                              // "${Languages.of(context)!.labelCaloriesEarned} today($formattedDateforcalories)",
                                              "${Languages.of(context)!.ninTextMyWaterIntake} : ${fitnessData.waterIntakeToday} ${Languages.of(context)!.ninTextLit}",
                                              style: TextStyle(
                                                  color: ThemeManager.themeText,
                                                  fontSize:
                                                      AppFontSizes.largeDefault,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 70,
                                      ],
                                    ),
                                  ),
                                  //heretyy.l
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const WaterTrackerView(),
                                            // SearchCookedFood(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        // decoration: BoxDecoration(
                                        //   borderRadius: BorderRadius.circular(15.0),
                                        //   color: TColor.primaryColor1,
                                        // ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: media.width * 0.85,
                                              width: media.width * 0.7,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 25,
                                                      horizontal: 20),
                                              decoration: BoxDecoration(
                                                  color:
                                                      ThemeManager.themeColor,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: ThemeManager
                                                            .themeText,
                                                        blurRadius: 0.1)
                                                  ]),
                                              child: Row(
                                                children: [
                                                  SimpleAnimationProgressBar(
                                                    height: media.width * 0.85,
                                                    width: media.width * 0.07,
                                                    backgroundColor:
                                                        Colors.grey.shade100,
                                                    foregrondColor:
                                                        Colors.purple,
                                                    ratio:
                                                        fitnessData.percentage,
                                                    direction: Axis.vertical,
                                                    curve: Curves
                                                        .fastLinearToSlowEaseIn,
                                                    duration: const Duration(
                                                        seconds: 3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    gradientColor:
                                                        LinearGradient(
                                                            colors:
                                                                TColor.primaryG,
                                                            begin: Alignment
                                                                .bottomCenter,
                                                            end: Alignment
                                                                .topCenter),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        Languages.of(context)!
                                                            .labelWaterIntake,
                                                        style: TextStyle(
                                                            color: ThemeManager
                                                                .themeText,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: AppFontSizes
                                                                .mediumDefault),
                                                      ),
                                                      ShaderMask(
                                                          blendMode:
                                                              BlendMode.srcIn,
                                                          shaderCallback:
                                                              (bounds) {
                                                            return LinearGradient(
                                                                    colors: TColor
                                                                        .primaryG,
                                                                    begin: Alignment
                                                                        .centerLeft,
                                                                    end: Alignment
                                                                        .centerRight)
                                                                .createShader(
                                                                    Rect.fromLTRB(
                                                                        0,
                                                                        0,
                                                                        bounds
                                                                            .width,
                                                                        bounds
                                                                            .height));
                                                          },
                                                          child: Text(
                                                            // "${waterData.waterIntake} ${Languages.of(context)!.labelLiters}",
                                                            "${fitnessData.waterIntakeToday} ${Languages.of(context)!.labelLiters}",
                                                            style: TextStyle(
                                                                color: ThemeManager
                                                                    .themeColor
                                                                    .withOpacity(
                                                                        0.7),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    AppFontSizes
                                                                        .mediumDefault),
                                                          )
                                                          // : Center(
                                                          //     child: Text(
                                                          //         '0  ${Languages.of(context)!.labelLiters}')),
                                                          ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "${Languages.of(context)!.labelRealTimeGoal} ${fitnessData.waterGoal} ${Languages.of(context)!.labelLiters}",
                                                        style: TextStyle(
                                                            color: TColor.gray,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: AppFontSizes
                                                                .smallDefault),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: fitnessData
                                                            .waterArr
                                                            .map((wObj) {
                                                          var isLast = wObj ==
                                                              fitnessData
                                                                  .waterArr
                                                                  .last;
                                                          return Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            4),
                                                                    width: 10,
                                                                    height: 10,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: TColor
                                                                          .secondaryColor1
                                                                          .withOpacity(
                                                                              0.5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                    ),
                                                                  ),
                                                                  if (!isLast)
                                                                    DottedDashedLine(
                                                                        height: media.width *
                                                                            0.078,
                                                                        width:
                                                                            0,
                                                                        dashColor: TColor
                                                                            .secondaryColor1
                                                                            .withOpacity(
                                                                                0.5),
                                                                        axis: Axis
                                                                            .vertical)
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    wObj["title"]
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: TColor
                                                                          .gray,
                                                                      fontSize:
                                                                          AppFontSizes
                                                                              .smallDefault,
                                                                    ),
                                                                  ),
                                                                  ShaderMask(
                                                                    blendMode:
                                                                        BlendMode
                                                                            .srcIn,
                                                                    shaderCallback:
                                                                        (bounds) {
                                                                      return LinearGradient(colors: TColor.secondaryG, begin: Alignment.centerLeft, end: Alignment.centerRight).createShader(Rect.fromLTRB(
                                                                          0,
                                                                          0,
                                                                          bounds
                                                                              .width,
                                                                          bounds
                                                                              .height));
                                                                    },
                                                                    child: Text(
                                                                      wObj["subtitle"]
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: ThemeManager.themeColor.withOpacity(
                                                                              0.7),
                                                                          fontSize:
                                                                              AppFontSizes.smallDefault),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          );
                                                        }).toList(),
                                                      ),
                                                      const Spacer(),
                                                      Center(
                                                        child: Image.asset(
                                                          "assets/img/glass (1).png",
                                                          width: 60,
                                                          height: 60,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.all(2.0),
                                                      //   child: SizedBox(
                                                      //     width: 70,
                                                      //     height: 25,
                                                      //     child: RoundButton(
                                                      //       title:
                                                      //           Languages.of(context)!
                                                      //               .labelCheck,
                                                      //       type: RoundButtonType
                                                      //           .bgGradient,
                                                      //       fontSize: AppFontSizes.smallDefault,,
                                                      //       fontWeight:
                                                      //           FontWeight.w400,
                                                      //       onPressed: () {
                                                      //         // Navigator.push(
                                                      //         //   context,
                                                      //         //   MaterialPageRoute(s
                                                      //         //     builder: (context) =>
                                                      //         //         const ActivityTrackerView(),
                                                      //         //   ),
                                                      //         // );
                                                      //         Navigator.push(
                                                      //           context,
                                                      //           MaterialPageRoute(
                                                      //             builder: (context) =>
                                                      //                 WaterTrackerView(),
                                                      //             // SearchCookedFood(),
                                                      //           ),
                                                      //         );
                                                      //       },
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    sizedBox12(),
                                  ],
                                  onExpansionChanged: (expanded) {
                                    if (expanded) {
                                      // Calculate total calories earned
                                      setState(() {});
                                    }
                                  },
                                ),
                              ),
                              sizedBox12(),
                              // Container(
                              //   width: media.width * 0.95,
                              //   decoration: BoxDecoration(
                              //     color: TColor.primaryColor2.withOpacity(0.3),
                              //     borderRadius: BorderRadius.circular(15),
                              //   ),
                              //   child: ExpansionTile(
                              //     title: Padding(
                              //       padding: const EdgeInsets.only(
                              //           left: 13.0, right: 13),
                              //       child: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           SizedBox(
                              //             // width: media.width * 0.6,
                              //             child: SizedBox(
                              //               width: media.width * 0.6,
                              //               child: Text(
                              //                 // "${Languages.of(context)!.labelCaloriesEarned} today($formattedDateforcalories)",
                              //                 Languages.of(context)!
                              //                     .ninTextSleepTracker,
                              //                 style: TextStyle(
                              //                     color: ThemeManager.themeText,
                              //                     fontSize:
                              //                         AppFontSizes.largeDefault,
                              //                     fontWeight: FontWeight.w700),
                              //               ),
                              //             ),
                              //           ),
                              //           // SizedBox(
                              //           //   width: 70,
                              //         ],
                              //       ),
                              //     ),
                              //     //heretyy.l
                              //     children: [
                              //       sizedBox12(),
                              //       Container(
                              //         width: media.width * 0.7,
                              //         // decoration: BoxDecoration(
                              //         //   borderRadius: BorderRadius.circular(15.0),
                              //         //   color: TColor.primaryColor1,
                              //         // ),
                              //         child: Column(
                              //           children: [
                              //             InkWell(
                              //               onTap: () {
                              //                 // Navigator.push(
                              //                 //   context,
                              //                 //   MaterialPageRoute(s
                              //                 //     builder: (context) =>
                              //                 //         const ActivityTrackerView(),
                              //                 //   ),
                              //                 // );
                              //                 Navigator.push(
                              //                   context,
                              //                   MaterialPageRoute(
                              //                     builder: (context) =>
                              //                         SleepTrackerSCreen(),
                              //                   ),
                              //                 );
                              //               },
                              //               child: Container(
                              //                 width: double.maxFinite,
                              //                 // height: media.width * 0.47,
                              //                 padding:
                              //                     const EdgeInsets.symmetric(
                              //                         vertical: 25,
                              //                         horizontal: 20),
                              //                 decoration: BoxDecoration(
                              //                     color:
                              //                         ThemeManager.themeColor,
                              //                     borderRadius:
                              //                         BorderRadius.circular(25),
                              //                     boxShadow: [
                              //                       BoxShadow(
                              //                           color: ThemeManager
                              //                               .themeText,
                              //                           blurRadius: 0.1)
                              //                     ]),
                              //                 child: Row(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.start,
                              //                     children: [
                              //                       Column(
                              //                         crossAxisAlignment:
                              //                             CrossAxisAlignment
                              //                                 .start,
                              //                         children: [
                              //                           SizedBox(
                              //                             width:
                              //                                 media.width * 0.4,
                              //                             child: Text(
                              //                               Languages.of(
                              //                                       context)!
                              //                                   .ninTextRecordReviewSleep,
                              //                               style: TextStyle(
                              //                                   color: ThemeManager
                              //                                       .themeText,
                              //                                   fontWeight:
                              //                                       FontWeight
                              //                                           .bold,
                              //                                   fontSize:
                              //                                       AppFontSizes
                              //                                           .mediumDefault),
                              //                             ),
                              //                           ),
                              //                           SizedBox(
                              //                             width: 10,
                              //                           ),
                              //                           // SizedBox(
                              //                           //   width: 70,
                              //                           //   height: 20,
                              //                           //   child: RoundButton(
                              //                           //     title: Languages.of(
                              //                           //             context)!
                              //                           //         .labelCheck,
                              //                           //     type: RoundButtonType
                              //                           //         .bgGradient,
                              //                           //     fontSize: AppFontSizes.smallDefault,,
                              //                           //     fontWeight:
                              //                           //         FontWeight.w400,
                              //                           //     onPressed: () {
                              //                           //       // Navigator.push(
                              //                           //       //   context,
                              //                           //       //   MaterialPageRoute(s
                              //                           //       //     builder: (context) =>
                              //                           //       //         const ActivityTrackerView(),
                              //                           //       //   ),
                              //                           //       // );
                              //                           //       Navigator.push(
                              //                           //         context,
                              //                           //         MaterialPageRoute(
                              //                           //           builder: (context) =>
                              //                           //               SleepTrackerSCreen(),
                              //                           //         ),
                              //                           //       );
                              //                           //     },
                              //                           //   ),
                              //                           // )
                              //                           ShaderMask(
                              //                             blendMode:
                              //                                 BlendMode.srcIn,
                              //                             shaderCallback:
                              //                                 (bounds) {
                              //                               return LinearGradient(
                              //                                       colors: TColor
                              //                                           .primaryG,
                              //                                       begin: Alignment
                              //                                           .centerLeft,
                              //                                       end: Alignment
                              //                                           .centerRight)
                              //                                   .createShader(
                              //                                       Rect.fromLTRB(
                              //                                           0,
                              //                                           0,
                              //                                           bounds
                              //                                               .width,
                              //                                           bounds
                              //                                               .height));
                              //                             },
                              //                             child: Text(
                              //                               "${fitnessData.sleepTime} ${(fitnessData.sleepTime) == "0" ? "hrs" : ""}",
                              //                               style: TextStyle(
                              //                                   color: ThemeManager
                              //                                       .themeColor
                              //                                       .withOpacity(
                              //                                           0.7),
                              //                                   fontWeight:
                              //                                       FontWeight
                              //                                           .w700,
                              //                                   fontSize:
                              //                                       AppFontSizes
                              //                                           .mediumDefault),
                              //                             ),
                              //                           ),
                              //                         ],
                              //                       ),

                              //                       // const Spacer(),
                              //                       Center(
                              //                         child: Image.asset(
                              //                           "assets/img/sleep12.png",
                              //                           width: 80,
                              //                           // height: 80,
                              //                           fit: BoxFit.contain,
                              //                         ),
                              //                       ),
                              //                       // Image.asset(
                              //                       //     "assets/img/sleep12.png",
                              //                       //     width: double.maxFinite,
                              //                       //     fit: BoxFit.fitWidth)
                              //                     ]),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //       sizedBox12(),
                              //     ],
                              //     onExpansionChanged: (expanded) {
                              //       if (expanded) {
                              //         // Calculate total calories earned
                              //         setState(() {});
                              //       }
                              //     },
                              //   ),
                              // ),
                              // sizedBox12(),
                              Container(
                                width: media.width * 0.95,
                                decoration: BoxDecoration(
                                  color: TColor.primaryColor2.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipOval(
                                        child: SizedBox(
                                          width: 50,
                                          //  height: 41,
                                          // decoration: BoxDecoration(
                                          //   shape: BoxShape.circle,
                                          //   color: ThemeManager
                                          //       .themelightColor, // Set the background color for the circular container
                                          // ),
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/pulse.png",
                                              //    "assets/img/running.png",
                                              width:
                                                  38, // Adjust the width of the image
                                              // height: 24, // Adjust the height of the image
                                              // color: ThemeManager.themeText,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width: media.width * 0.5,
                                        child: Text(
                                          Languages.of(context)!
                                              .ninTextRecordMyBloodPressure,
                                          style: TextStyle(
                                            color: ThemeManager.themeText,
                                            fontSize: AppFontSizes.largeDefault,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: 80,
                                        // height: 35,
                                        child: RoundButton(
                                          title:
                                              Languages.of(context)!.labelCheck,
                                          type: RoundButtonType.bgGradient,
                                          fontSize: AppFontSizes.smallDefault,
                                          fontWeight: FontWeight.w400,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HealthScreen(),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // Container(
                              //   width: media.width * 0.95,
                              //   decoration: BoxDecoration(
                              //     color: TColor.primaryColor2.withOpacity(0.3),
                              //     borderRadius: BorderRadius.circular(15),
                              //   ),
                              //   child: ExpansionTile(
                              //     title: Padding(
                              //       padding: const EdgeInsets.only(
                              //           left: 13.0, right: 13),
                              //       child: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           SizedBox(
                              //             // width: media.width * 0.6,
                              //             child: SizedBox(
                              //               width: media.width * 0.6,
                              //               child: Text(
                              //                 // "${Languages.of(context)!.labelCaloriesEarned} today($formattedDateforcalories)",
                              //                 "Record my Blood Pressure /Blood glucose/ SPO2",
                              //                 style: TextStyle(
                              //                     color: ThemeManager.themeText,
                              //                     fontSize: 19,
                              //                     fontWeight: FontWeight.w700),
                              //               ),
                              //             ),
                              //           ),
                              //           // SizedBox(
                              //           //   width: 70,
                              //         ],
                              //       ),
                              //     ),
                              //     //heretyy.l
                              //     children: [
                              //       Container(
                              //         child: Column(
                              //           children: [
                              //             sizedBox12(),
                              //             GestureDetector(
                              //               onTap: () {
                              //                 Navigator.push(
                              //                   context,
                              //                   MaterialPageRoute(
                              //                     builder: (context) =>
                              //                         HealthScreen(),
                              //                   ),
                              //                 );
                              //               },
                              //               child: Container(
                              //                 height: media.width * 0.85,
                              //                 width: media.width * 0.7,
                              //                 padding:
                              //                     const EdgeInsets.symmetric(
                              //                         vertical: 25,
                              //                         horizontal: 20),
                              //                 decoration: BoxDecoration(
                              //                     color:
                              //                         ThemeManager.themeColor,
                              //                     borderRadius:
                              //                         BorderRadius.circular(25),
                              //                     boxShadow: [
                              //                       BoxShadow(
                              //                           color: ThemeManager
                              //                               .themeText,
                              //                           blurRadius: 0.1)
                              //                     ]),
                              //                 child: Column(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.start,
                              //                     children: [
                              //                       Text(
                              //                         Languages.of(context)!
                              //                             .labelHealthData,
                              //                         style: TextStyle(
                              //                             color: ThemeManager
                              //                                 .themeText,
                              //                             fontWeight:
                              //                                 FontWeight.w700,
                              //                             fontSize: AppFontSizes.mediumDefault),
                              //                       ),
                              //                       // ShaderMask(
                              //                       //   blendMode: BlendMode.srcIn,
                              //                       //   shaderCallback: (bounds) {
                              //                       //     return LinearGradient(
                              //                       //             colors: TColor
                              //                       //                 .primaryG,
                              //                       //             begin: Alignment
                              //                       //                 .centerLeft,
                              //                       //             end: Alignment
                              //                       //                 .centerRight)
                              //                       //         .createShader(
                              //                       //             Rect.fromLTRB(
                              //                       //                 0,
                              //                       //                 0,
                              //                       //                 bounds.width,
                              //                       //                 bounds
                              //                       //                     .height));
                              //                       //   },
                              //                       //   child: Text(
                              //                       //     // "$caloriesburn kCal",
                              //                       //     Languages.of(context)!
                              //                       //         .labelHealthData,
                              //                       //     style: TextStyle(
                              //                       //         color: ThemeManager
                              //                       //             .themeText,
                              //                       //         fontWeight:
                              //                       //             FontWeight.w700,
                              //                       //         fontSize: AppFontSizes.mediumDefault),
                              //                       //   ),
                              //                       // ),
                              //                       const Spacer(),

                              //                       Image.asset(
                              //                           "assets/img/spo and blood pressure.png",
                              //                           width: double.maxFinite,
                              //                           fit: BoxFit.fitWidth)
                              //                       // Container(
                              //                       //   alignment: Alignment.center,
                              //                       //   child: SizedBox(
                              //                       //     width: media.width * 0.2,
                              //                       //     height: media.width * 0.2,
                              //                       //     child: Stack(
                              //                       //       alignment:
                              //                       //           Alignment.center,
                              //                       //       children: [
                              //                       //         Container(
                              //                       //           width: media.width *
                              //                       //               0.15,
                              //                       //           height:
                              //                       //               media.width *
                              //                       //                   0.15,
                              //                       //           alignment: Alignment
                              //                       //               .center,
                              //                       //           decoration:
                              //                       //               BoxDecoration(
                              //                       //             gradient: LinearGradient(
                              //                       //                 colors: TColor
                              //                       //                     .primaryG),
                              //                       //             borderRadius: BorderRadius
                              //                       //                 .circular(media
                              //                       //                         .width *
                              //                       //                     0.075),
                              //                       //           ),
                              //                       //           child: FittedBox(
                              //                       //             child: Text(
                              //                       //               // "$caloriesburnleft kCal\nleft",
                              //                       //               Languages.of(
                              //                       //                       context)!
                              //                       //                   .labelHealthData,
                              //                       //               textAlign:
                              //                       //                   TextAlign
                              //                       //                       .center,
                              //                       //               style: TextStyle(
                              //                       //                   color: ThemeManager
                              //                       //                       .themeColor,
                              //                       //                   fontSize:
                              //                       //                       11),
                              //                       //             ),
                              //                       //           ),
                              //                       //         ),
                              //                       //         // ClipOval(
                              //                       //         //   child: Container(
                              //                       //         //     width: 50,
                              //                       //         //     child: Center(
                              //                       //         //       child: Image.asset(
                              //                       //         //         "assets/images/calories.png",
                              //                       //         //       ),
                              //                       //         //     ),
                              //                       //         //   ),
                              //                       //         // ),
                              //                       //         // SimpleCircularProgressBar(
                              //                       //         //   progressStrokeWidth:
                              //                       //         //       10,
                              //                       //         //   backStrokeWidth: 10,
                              //                       //         //   progressColors:
                              //                       //         //       TColor.primaryG,
                              //                       //         //   backColor: Colors
                              //                       //         //       .grey.shade100,
                              //                       //         //   valueNotifier:
                              //                       //         //       ValueNotifier(
                              //                       //         //           fitnessData
                              //                       //         //               .caloriesProgressBar),
                              //                       //         //   startAngle: -180,
                              //                       //         // ),
                              //                       //       ],
                              //                       //     ),
                              //                       //   ),
                              //                       // )
                              //                     ]),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //       sizedBox12(),
                              //     ],
                              //     onExpansionChanged: (expanded) {
                              //       if (expanded) {
                              //         // Calculate total calories earned
                              //         setState(() {});
                              //       }
                              //     },
                              //   ),
                              // ),
                              // // GestureDetector(
                              //   onTap: () {
                              //     // Navigator.push(
                              //     //   context,
                              //     //   MaterialPageRoute(s
                              //     //     builder: (context) =>
                              //     //         const ActivityTrackerView(),
                              //     //   ),
                              //     // );
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => WaterTrackerView(),
                              //         // SearchCookedFood(),
                              //       ),
                              //     );
                              //   },
                              //   onLongPress: () => _speak(
                              //       'your today ${Languages.of(context)!.labelWaterIntake} is ${waterData.waterIntake} ${Languages.of(context)!.labelLiters} sour total sleep timing is $sleeep your today ${Languages.of(context)!.labelCalories} is $caloriesburn kCal and left calories is $caloriesburnleft kCal'),
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //         child: Container(
                              //           height: media.width * 0.95,
                              //           padding: const EdgeInsets.symmetric(
                              //               vertical: 25, horizontal: 20),
                              //           decoration: BoxDecoration(
                              //               color: ThemeManager.themeColor,
                              //               borderRadius:
                              //                   BorderRadius.circular(25),
                              //               boxShadow: [
                              //                 BoxShadow(
                              //                     color: ThemeManager.themeText,
                              //                     blurRadius: 0.1)
                              //               ]),
                              //           child: Row(
                              //             children: [
                              //               SimpleAnimationProgressBar(
                              //                 height: media.width * 0.85,
                              //                 width: media.width * 0.07,
                              //                 backgroundColor:
                              //                     Colors.grey.shade100,
                              //                 foregrondColor: Colors.purple,
                              //                 ratio: fitnessData.percentage,
                              //                 direction: Axis.vertical,
                              //                 curve:
                              //                     Curves.fastLinearToSlowEaseIn,
                              //                 duration:
                              //                     const Duration(seconds: 3),
                              //                 borderRadius:
                              //                     BorderRadius.circular(15),
                              //                 gradientColor: LinearGradient(
                              //                     colors: TColor.primaryG,
                              //                     begin: Alignment.bottomCenter,
                              //                     end: Alignment.topCenter),
                              //               ),
                              //               const SizedBox(
                              //                 width: 10,
                              //               ),
                              //               Expanded(
                              //                   child: Column(
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   Text(
                              //                     Languages.of(context)!
                              //                         .labelWaterIntake,
                              //                     style: TextStyle(
                              //                         color: ThemeManager
                              //                             .themeText,
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                         fontSize: AppFontSizes.mediumDefault),
                              //                   ),
                              //                   ShaderMask(
                              //                       blendMode: BlendMode.srcIn,
                              //                       shaderCallback: (bounds) {
                              //                         return LinearGradient(
                              //                                 colors: TColor
                              //                                     .primaryG,
                              //                                 begin: Alignment
                              //                                     .centerLeft,
                              //                                 end: Alignment
                              //                                     .centerRight)
                              //                             .createShader(
                              //                                 Rect.fromLTRB(
                              //                                     0,
                              //                                     0,
                              //                                     bounds.width,
                              //                                     bounds
                              //                                         .height));
                              //                       },
                              //                       child: Text(
                              //                         // "${waterData.waterIntake} ${Languages.of(context)!.labelLiters}",
                              //                         "${fitnessData.waterIntakeToday} ${Languages.of(context)!.labelLiters}",
                              //                         style: TextStyle(
                              //                             color: ThemeManager
                              //                                 .themeColor
                              //                                 .withOpacity(0.7),
                              //                             fontWeight:
                              //                                 FontWeight.w700,
                              //                             fontSize: AppFontSizes.mediumDefault),
                              //                       )
                              //                       // : Center(
                              //                       //     child: Text(
                              //                       //         '0  ${Languages.of(context)!.labelLiters}')),
                              //                       ),
                              //                   const SizedBox(
                              //                     height: 10,
                              //                   ),
                              //                   Text(
                              //                     "${Languages.of(context)!.labelRealTimeGoal} ${fitnessData.waterGoal} ${Languages.of(context)!.labelLiters}",
                              //                     style: TextStyle(
                              //                         color: TColor.gray,
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                         fontSize: AppFontSizes.smallDefault,),
                              //                   ),
                              //                   Column(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.start,
                              //                     children: fitnessData.waterArr
                              //                         .map((wObj) {
                              //                       var isLast = wObj ==
                              //                           fitnessData
                              //                               .waterArr.last;
                              //                       return Row(
                              //                         crossAxisAlignment:
                              //                             CrossAxisAlignment
                              //                                 .start,
                              //                         children: [
                              //                           Column(
                              //                             mainAxisAlignment:
                              //                                 MainAxisAlignment
                              //                                     .start,
                              //                             crossAxisAlignment:
                              //                                 CrossAxisAlignment
                              //                                     .center,
                              //                             children: [
                              //                               Container(
                              //                                 margin:
                              //                                     const EdgeInsets
                              //                                         .symmetric(
                              //                                         vertical:
                              //                                             4),
                              //                                 width: 10,
                              //                                 height: 10,
                              //                                 decoration:
                              //                                     BoxDecoration(
                              //                                   color: TColor
                              //                                       .secondaryColor1
                              //                                       .withOpacity(
                              //                                           0.5),
                              //                                   borderRadius:
                              //                                       BorderRadius
                              //                                           .circular(
                              //                                               5),
                              //                                 ),
                              //                               ),
                              //                               if (!isLast)
                              //                                 DottedDashedLine(
                              //                                     height: media
                              //                                             .width *
                              //                                         0.078,
                              //                                     width: 0,
                              //                                     dashColor: TColor
                              //                                         .secondaryColor1
                              //                                         .withOpacity(
                              //                                             0.5),
                              //                                     axis: Axis
                              //                                         .vertical)
                              //                             ],
                              //                           ),
                              //                           const SizedBox(
                              //                             width: 10,
                              //                           ),
                              //                           Column(
                              //                             mainAxisAlignment:
                              //                                 MainAxisAlignment
                              //                                     .start,
                              //                             crossAxisAlignment:
                              //                                 CrossAxisAlignment
                              //                                     .start,
                              //                             children: [
                              //                               Text(
                              //                                 wObj["title"]
                              //                                     .toString(),
                              //                                 style: TextStyle(
                              //                                   color:
                              //                                       TColor.gray,
                              //                                   fontSize: AppFontSizes.smallDefault,
                              //                                 ),
                              //                               ),
                              //                               ShaderMask(
                              //                                 blendMode:
                              //                                     BlendMode
                              //                                         .srcIn,
                              //                                 shaderCallback:
                              //                                     (bounds) {
                              //                                   return LinearGradient(
                              //                                           colors: TColor
                              //                                               .secondaryG,
                              //                                           begin: Alignment
                              //                                               .centerLeft,
                              //                                           end: Alignment
                              //                                               .centerRight)
                              //                                       .createShader(Rect.fromLTRB(
                              //                                           0,
                              //                                           0,
                              //                                           bounds
                              //                                               .width,
                              //                                           bounds
                              //                                               .height));
                              //                                 },
                              //                                 child: Text(
                              //                                   wObj["subtitle"]
                              //                                       .toString(),
                              //                                   style: TextStyle(
                              //                                       color: ThemeManager
                              //                                           .themeColor
                              //                                           .withOpacity(
                              //                                               0.7),
                              //                                       fontSize:
                              //                                           12),
                              //                                 ),
                              //                               ),
                              //                             ],
                              //                           )
                              //                         ],
                              //                       );
                              //                     }).toList(),
                              //                   ),
                              //                   Spacer(),
                              //                   Center(
                              //                     child: Image.asset(
                              //                       "assets/img/glass (1).png",
                              //                       width: 60,
                              //                       height: 60,
                              //                       fit: BoxFit.contain,
                              //                     ),
                              //                   ),
                              //                   // Padding(
                              //                   //   padding:
                              //                   //       const EdgeInsets.all(2.0),
                              //                   //   child: SizedBox(
                              //                   //     width: 70,
                              //                   //     height: 25,
                              //                   //     child: RoundButton(
                              //                   //       title:
                              //                   //           Languages.of(context)!
                              //                   //               .labelCheck,
                              //                   //       type: RoundButtonType
                              //                   //           .bgGradient,
                              //                   //       fontSize: AppFontSizes.smallDefault,,
                              //                   //       fontWeight:
                              //                   //           FontWeight.w400,
                              //                   //       onPressed: () {
                              //                   //         // Navigator.push(
                              //                   //         //   context,
                              //                   //         //   MaterialPageRoute(s
                              //                   //         //     builder: (context) =>
                              //                   //         //         const ActivityTrackerView(),
                              //                   //         //   ),
                              //                   //         // );
                              //                   //         Navigator.push(
                              //                   //           context,
                              //                   //           MaterialPageRoute(
                              //                   //             builder: (context) =>
                              //                   //                 WaterTrackerView(),
                              //                   //             // SearchCookedFood(),
                              //                   //           ),
                              //                   //         );
                              //                   //       },
                              //                   //     ),
                              //                   //   ),
                              //                   // ),
                              //                   SizedBox(
                              //                     height: 8,
                              //                   ),
                              //                 ],
                              //               ))
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         width: media.width * 0.05,
                              //       ),
                              //       Expanded(
                              //           child: Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.start,
                              //         mainAxisSize: MainAxisSize.min,
                              //         children: [
                              //           InkWell(
                              //             onTap: () {
                              //               // Navigator.push(
                              //               //   context,
                              //               //   MaterialPageRoute(s
                              //               //     builder: (context) =>
                              //               //         const ActivityTrackerView(),
                              //               //   ),
                              //               // );
                              //               Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                   builder: (context) =>
                              //                       SleepTrackerSCreen(),
                              //                 ),
                              //               );
                              //             },
                              //             child: Container(
                              //               width: double.maxFinite,
                              //               height: media.width * 0.45,
                              //               padding: const EdgeInsets.symmetric(
                              //                   vertical: 25, horizontal: 20),
                              //               decoration: BoxDecoration(
                              //                   color: ThemeManager.themeColor,
                              //                   borderRadius:
                              //                       BorderRadius.circular(25),
                              //                   boxShadow: [
                              //                     BoxShadow(
                              //                         color: ThemeManager
                              //                             .themeText,
                              //                         blurRadius: 0.1)
                              //                   ]),
                              //               child: Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   children: [
                              //                     Row(
                              //                       children: [
                              //                         Text(
                              //                           "Record my sleep",
                              //                           style: TextStyle(
                              //                               color: ThemeManager
                              //                                   .themeText,
                              //                               fontWeight:
                              //                                   FontWeight.bold,
                              //                               fontSize: AppFontSizes.mediumDefault),
                              //                         ),
                              //                         SizedBox(
                              //                           width: 10,
                              //                         ),
                              //                         // SizedBox(
                              //                         //   width: 70,
                              //                         //   height: 20,
                              //                         //   child: RoundButton(
                              //                         //     title: Languages.of(
                              //                         //             context)!
                              //                         //         .labelCheck,
                              //                         //     type: RoundButtonType
                              //                         //         .bgGradient,
                              //                         //     fontSize: AppFontSizes.smallDefault,,
                              //                         //     fontWeight:
                              //                         //         FontWeight.w400,
                              //                         //     onPressed: () {
                              //                         //       // Navigator.push(
                              //                         //       //   context,
                              //                         //       //   MaterialPageRoute(s
                              //                         //       //     builder: (context) =>
                              //                         //       //         const ActivityTrackerView(),
                              //                         //       //   ),
                              //                         //       // );
                              //                         //       Navigator.push(
                              //                         //         context,
                              //                         //         MaterialPageRoute(
                              //                         //           builder: (context) =>
                              //                         //               SleepTrackerSCreen(),
                              //                         //         ),
                              //                         //       );
                              //                         //     },
                              //                         //   ),
                              //                         // )
                              //                       ],
                              //                     ),
                              //                     ShaderMask(
                              //                       blendMode: BlendMode.srcIn,
                              //                       shaderCallback: (bounds) {
                              //                         return LinearGradient(
                              //                                 colors: TColor
                              //                                     .primaryG,
                              //                                 begin: Alignment
                              //                                     .centerLeft,
                              //                                 end: Alignment
                              //                                     .centerRight)
                              //                             .createShader(
                              //                                 Rect.fromLTRB(
                              //                                     0,
                              //                                     0,
                              //                                     bounds.width,
                              //                                     bounds
                              //                                         .height));
                              //                       },
                              //                       child: Text(
                              //                         "${fitnessData.sleepTime}",
                              //                         style: TextStyle(
                              //                             color: ThemeManager
                              //                                 .themeColor
                              //                                 .withOpacity(0.7),
                              //                             fontWeight:
                              //                                 FontWeight.w700,
                              //                             fontSize: AppFontSizes.mediumDefault),
                              //                       ),
                              //                     ),
                              //                     const Spacer(),
                              //                     Center(
                              //                       child: Image.asset(
                              //                         "assets/img/sleep12.png",
                              //                         width: 80,
                              //                         height: 80,
                              //                         fit: BoxFit.contain,
                              //                       ),
                              //                     ),
                              //                     // Image.asset(
                              //                     //     "assets/img/sleep12.png",
                              //                     //     width: double.maxFinite,
                              //                     //     fit: BoxFit.fitWidth)
                              //                   ]),
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             height: media.width * 0.05,
                              //           ),
                              //           GestureDetector(
                              //             onTap: () {
                              //               Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                   builder: (context) =>
                              //                       HealthScreen(),
                              //                 ),
                              //               );
                              //             },
                              //             child: Container(
                              //               width: double.maxFinite,
                              //               height: media.width * 0.45,
                              //               padding: const EdgeInsets.symmetric(
                              //                   vertical: 25, horizontal: 20),
                              //               decoration: BoxDecoration(
                              //                   color: ThemeManager.themeColor,
                              //                   borderRadius:
                              //                       BorderRadius.circular(25),
                              //                   boxShadow: [
                              //                     BoxShadow(
                              //                         color: ThemeManager
                              //                             .themeText,
                              //                         blurRadius: 0.1)
                              //                   ]),
                              //               child: Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   children: [
                              //                     Text(
                              //                       Languages.of(context)!
                              //                           .labelHealthData,
                              //                       style: TextStyle(
                              //                           color: ThemeManager
                              //                               .themeText,
                              //                           fontWeight:
                              //                               FontWeight.w700,
                              //                           fontSize: AppFontSizes.mediumDefault),
                              //                     ),
                              //                     // ShaderMask(
                              //                     //   blendMode: BlendMode.srcIn,
                              //                     //   shaderCallback: (bounds) {
                              //                     //     return LinearGradient(
                              //                     //             colors: TColor
                              //                     //                 .primaryG,
                              //                     //             begin: Alignment
                              //                     //                 .centerLeft,
                              //                     //             end: Alignment
                              //                     //                 .centerRight)
                              //                     //         .createShader(
                              //                     //             Rect.fromLTRB(
                              //                     //                 0,
                              //                     //                 0,
                              //                     //                 bounds.width,
                              //                     //                 bounds
                              //                     //                     .height));
                              //                     //   },
                              //                     //   child: Text(
                              //                     //     // "$caloriesburn kCal",
                              //                     //     Languages.of(context)!
                              //                     //         .labelHealthData,
                              //                     //     style: TextStyle(
                              //                     //         color: ThemeManager
                              //                     //             .themeText,
                              //                     //         fontWeight:
                              //                     //             FontWeight.w700,
                              //                     //         fontSize: AppFontSizes.mediumDefault),
                              //                     //   ),
                              //                     // ),
                              //                     const Spacer(),

                              //                     Image.asset(
                              //                         "assets/img/spo and blood pressure.png",
                              //                         width: double.maxFinite,
                              //                         fit: BoxFit.fitWidth)
                              //                     // Container(
                              //                     //   alignment: Alignment.center,
                              //                     //   child: SizedBox(
                              //                     //     width: media.width * 0.2,
                              //                     //     height: media.width * 0.2,
                              //                     //     child: Stack(
                              //                     //       alignment:
                              //                     //           Alignment.center,
                              //                     //       children: [
                              //                     //         Container(
                              //                     //           width: media.width *
                              //                     //               0.15,
                              //                     //           height:
                              //                     //               media.width *
                              //                     //                   0.15,
                              //                     //           alignment: Alignment
                              //                     //               .center,
                              //                     //           decoration:
                              //                     //               BoxDecoration(
                              //                     //             gradient: LinearGradient(
                              //                     //                 colors: TColor
                              //                     //                     .primaryG),
                              //                     //             borderRadius: BorderRadius
                              //                     //                 .circular(media
                              //                     //                         .width *
                              //                     //                     0.075),
                              //                     //           ),
                              //                     //           child: FittedBox(
                              //                     //             child: Text(
                              //                     //               // "$caloriesburnleft kCal\nleft",
                              //                     //               Languages.of(
                              //                     //                       context)!
                              //                     //                   .labelHealthData,
                              //                     //               textAlign:
                              //                     //                   TextAlign
                              //                     //                       .center,
                              //                     //               style: TextStyle(
                              //                     //                   color: ThemeManager
                              //                     //                       .themeColor,
                              //                     //                   fontSize:
                              //                     //                       11),
                              //                     //             ),
                              //                     //           ),
                              //                     //         ),
                              //                     //         // ClipOval(
                              //                     //         //   child: Container(
                              //                     //         //     width: 50,
                              //                     //         //     child: Center(
                              //                     //         //       child: Image.asset(
                              //                     //         //         "assets/images/calories.png",
                              //                     //         //       ),
                              //                     //         //     ),
                              //                     //         //   ),
                              //                     //         // ),
                              //                     //         // SimpleCircularProgressBar(
                              //                     //         //   progressStrokeWidth:
                              //                     //         //       10,
                              //                     //         //   backStrokeWidth: 10,
                              //                     //         //   progressColors:
                              //                     //         //       TColor.primaryG,
                              //                     //         //   backColor: Colors
                              //                     //         //       .grey.shade100,
                              //                     //         //   valueNotifier:
                              //                     //         //       ValueNotifier(
                              //                     //         //           fitnessData
                              //                     //         //               .caloriesProgressBar),
                              //                     //         //   startAngle: -180,
                              //                     //         // ),
                              //                     //       ],
                              //                     //     ),
                              //                     //   ),
                              //                     // )
                              //                   ]),
                              //             ),
                              //           ),
                              //         ],
                              //       ))
                              //     ],
                              //   ),
                              // ),

                              // sizedBox12(),
                              // GestureDetector(
                              //   onLongPress: () => _speak(
                              //       'click on right check button to check your ${Languages.of(context)!.labelHealthData}'),
                              //   child: Container(
                              //     padding: const EdgeInsets.symmetric(
                              //         vertical: 15, horizontal: 15),
                              //     decoration: BoxDecoration(
                              //       color:
                              //           TColor.primaryColor2.withOpacity(0.3),
                              //       borderRadius: BorderRadius.circular(15),
                              //     ),
                              //     child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         SizedBox(
                              //           width: media.width * 0.60,
                              //           child: Text(
                              //             Languages.of(context)!
                              //                 .labelHealthData,
                              //             style: TextStyle(
                              //               color: ThemeManager.themeText,
                              //               fontSize: 19,
                              //               fontWeight: FontWeight.w700,
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           width: 70,
                              //           height: 35,
                              //           child: RoundButton(
                              //             title:
                              //                 Languages.of(context)!.labelCheck,
                              //             type: RoundButtonType.bgGradient,
                              //             fontSize: AppFontSizes.smallDefault,,
                              //             fontWeight: FontWeight.w400,
                              //             onPressed: () {
                              //               // Navigator.push(
                              //               //   context,
                              //               //   MaterialPageRoute(s
                              //               //     builder: (context) =>
                              //               //         const ActivityTrackerView(),
                              //               //   ),
                              //               // );
                              //               Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                   builder: (context) =>
                              //                       HealthScreen(),
                              //                 ),
                              //               );
                              //             },
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),

                              //dsvdfbgfhb
                              // sizedBox12(),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) =>
                              //             ShowWeeklyCaloriesBurn(),
                              //       ),
                              //     );
                              //   },
                              //   child: Container(
                              //     width: double.maxFinite,
                              //     height: media.width * 0.45,
                              //     padding: const EdgeInsets.symmetric(
                              //         vertical: 25, horizontal: 20),
                              //     decoration: BoxDecoration(
                              //         color: ThemeManager.themeColor,
                              //         borderRadius: BorderRadius.circular(25),
                              //         boxShadow: [
                              //           BoxShadow(
                              //               color: ThemeManager.themeText,
                              //               blurRadius: 0.1)
                              //         ]),
                              //     child: Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Text(
                              //             Languages.of(context)!.labelCalories,
                              //             style: TextStyle(
                              //                 color: ThemeManager.themeText,
                              //                 fontSize: AppFontSizes.smallDefault,,
                              //                 fontWeight: FontWeight.w700),
                              //           ),
                              //           ShaderMask(
                              //             blendMode: BlendMode.srcIn,
                              //             shaderCallback: (bounds) {
                              //               return LinearGradient(
                              //                       colors: TColor.primaryG,
                              //                       begin: Alignment.centerLeft,
                              //                       end: Alignment.centerRight)
                              //                   .createShader(Rect.fromLTRB(
                              //                       0,
                              //                       0,
                              //                       bounds.width,
                              //                       bounds.height));
                              //             },
                              //             child: Text(
                              //               // "$caloriesburn kCal",
                              //               "${double.parse(fitnessData.caloriesBurned).toStringAsFixed(1)} kCal",
                              //               style: TextStyle(
                              //                   color: ThemeManager.themeColor
                              //                       .withOpacity(0.7),
                              //                   fontWeight: FontWeight.w700,
                              //                   fontSize: AppFontSizes.mediumDefault),
                              //             ),
                              //           ),
                              //           const Spacer(),
                              //           Container(
                              //             alignment: Alignment.center,
                              //             child: SizedBox(
                              //               width: media.width * 0.2,
                              //               height: media.width * 0.2,
                              //               child: Stack(
                              //                 alignment: Alignment.center,
                              //                 children: [
                              //                   Container(
                              //                     width: media.width * 0.15,
                              //                     height: media.width * 0.15,
                              //                     alignment: Alignment.center,
                              //                     decoration: BoxDecoration(
                              //                       gradient: LinearGradient(
                              //                           colors:
                              //                               TColor.primaryG),
                              //                       borderRadius:
                              //                           BorderRadius.circular(
                              //                               media.width *
                              //                                   0.075),
                              //                     ),
                              //                     child: FittedBox(
                              //                       child: Text(
                              //                         // "$caloriesburnleft kCal\nleft",
                              //                         "${fitnessData.caloriesLeft} kCal\nleft",
                              //                         textAlign:
                              //                             TextAlign.center,
                              //                         style: TextStyle(
                              //                             color: ThemeManager
                              //                                 .themeColor,
                              //                             fontSize: AppFontSizes.smallDefault),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                   // ClipOval(
                              //                   //   child: Container(
                              //                   //     width: 50,
                              //                   //     child: Center(
                              //                   //       child: Image.asset(
                              //                   //         "assets/images/calories.png",
                              //                   //       ),
                              //                   //     ),
                              //                   //   ),
                              //                   // ),
                              //                   SimpleCircularProgressBar(
                              //                     progressStrokeWidth: 10,
                              //                     backStrokeWidth: 10,
                              //                     progressColors:
                              //                         TColor.primaryG,
                              //                     backColor:
                              //                         Colors.grey.shade100,
                              //                     valueNotifier: ValueNotifier(
                              //                         fitnessData
                              //                             .caloriesProgressBar),
                              //                     startAngle: -180,
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           )
                              //         ]),
                              //   ),
                              // ),
                              //todayssteps section
                              sizedBox12(),

                              // sizedBox12(),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => stepsWeekly()
                              //           //  AllActivityScreen(),
                              //           //  AllActivityScreen(),
                              //           // ActivityTrackerScreen(),
                              //           // LocationMarker(),
                              //           ),
                              //     );
                              //     // Navigator.push(
                              //     //   context,
                              //     //   MaterialPageRoute(
                              //     //       builder: (context) => BMRCalculator()),
                              //     // );
                              //   },
                              //   onLongPress: () => _speak(
                              //       'Your ${Languages.of(context)!.labelTodaySteps} is $_steps2  steps'),
                              //   child: Container(
                              //     padding: const EdgeInsets.symmetric(
                              //         vertical: 15, horizontal: 15),
                              //     decoration: BoxDecoration(
                              //       color:
                              //           TColor.primaryColor2.withOpacity(0.3),
                              //       borderRadius: BorderRadius.circular(15),
                              //     ),
                              //     child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         ClipOval(
                              //           child: Container(
                              //             width: 80,
                              //             //  height: 41,
                              //             // decoration: BoxDecoration(
                              //             //   shape: BoxShape.circle,
                              //             //   color: ThemeManager
                              //             //       .themelightColor, // Set the background color for the circular container
                              //             // ),
                              //             child: Center(
                              //               child: Image.asset(
                              //                 "assets/images/shoes.png",
                              //                 //    "assets/img/running.png",
                              //                 // width: 2100, // Adjust the width of the image
                              //                 // height: 24, // Adjust the height of the image
                              //                 // color: ThemeManager.themeText,
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //         // Spacer(),

                              //         SizedBox(
                              //           width: media.width * 0.60,
                              //           child: Text(
                              //             "${Languages.of(context)!.labelTodaySteps} ${fitnessData.steps} ",
                              //             // $_steps2
                              //             style: TextStyle(
                              //                 color: ThemeManager.themeText,
                              //                 fontSize:AppFontSizes.extraLargeDefault,
                              //                 fontWeight: FontWeight.w700),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),

                              //todays steps------
                              // SizedBox(
                              //   height: media.width * 0.05,
                              // ),
                              // Text(
                              //   Languages.of(context)!.labelActivityStatus,
                              //   style: TextStyle(
                              //       color: ThemeManager.themeText,
                              //       fontSize: AppFontSizes.mediumDefault,
                              //       fontWeight: FontWeight.w700),
                              // ),

                              // SizedBox(
                              //   height: media.width * 0.05,
                              // ),
                              // GestureDetector(
                              //   onTap: () {
                              //     // Navigator.push(
                              //     //   context,
                              //     //   MaterialPageRoute(s
                              //     //     builder: (context) =>
                              //     //         const ActivityTrackerView(),
                              //     //   ),
                              //     // );
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => WaterTrackerView(),
                              //         // SearchCookedFood(),
                              //       ),
                              //     );
                              //   },
                              //   onLongPress: () => _speak(
                              //       'your today ${Languages.of(context)!.labelWaterIntake} is ${waterData.waterIntake} ${Languages.of(context)!.labelLiters} sour total sleep timing is $sleeep your today ${Languages.of(context)!.labelCalories} is $caloriesburn kCal and left calories is $caloriesburnleft kCal'),
                              //   child: Row(
                              //     children: [
                              //       Expanded(
                              //         child: Container(
                              //           height: media.width * 0.95,
                              //           padding: const EdgeInsets.symmetric(
                              //               vertical: 25, horizontal: 20),
                              //           decoration: BoxDecoration(
                              //               color: ThemeManager.themeColor,
                              //               borderRadius:
                              //                   BorderRadius.circular(25),
                              //               boxShadow: [
                              //                 BoxShadow(
                              //                     color: ThemeManager.themeText,
                              //                     blurRadius: 0.1)
                              //               ]),
                              //           child: Row(
                              //             children: [
                              //               SimpleAnimationProgressBar(
                              //                 height: media.width * 0.85,
                              //                 width: media.width * 0.07,
                              //                 backgroundColor:
                              //                     Colors.grey.shade100,
                              //                 foregrondColor: Colors.purple,
                              //                 ratio: fitnessData.percentage,
                              //                 direction: Axis.vertical,
                              //                 curve:
                              //                     Curves.fastLinearToSlowEaseIn,
                              //                 duration:
                              //                     const Duration(seconds: 3),
                              //                 borderRadius:
                              //                     BorderRadius.circular(15),
                              //                 gradientColor: LinearGradient(
                              //                     colors: TColor.primaryG,
                              //                     begin: Alignment.bottomCenter,
                              //                     end: Alignment.topCenter),
                              //               ),
                              //               const SizedBox(
                              //                 width: 10,
                              //               ),
                              //               Expanded(
                              //                   child: Column(
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   Text(
                              //                     Languages.of(context)!
                              //                         .labelWaterIntake,
                              //                     style: TextStyle(
                              //                         color: ThemeManager
                              //                             .themeText,
                              //                         fontSize: AppFontSizes.smallDefault,,
                              //                         fontWeight:
                              //                             FontWeight.w700),
                              //                   ),
                              //                   ShaderMask(
                              //                       blendMode: BlendMode.srcIn,
                              //                       shaderCallback: (bounds) {
                              //                         return LinearGradient(
                              //                                 colors: TColor
                              //                                     .primaryG,
                              //                                 begin: Alignment
                              //                                     .centerLeft,
                              //                                 end: Alignment
                              //                                     .centerRight)
                              //                             .createShader(
                              //                                 Rect.fromLTRB(
                              //                                     0,
                              //                                     0,
                              //                                     bounds.width,
                              //                                     bounds
                              //                                         .height));
                              //                       },
                              //                       child: Text(
                              //                         // "${waterData.waterIntake} ${Languages.of(context)!.labelLiters}",
                              //                         "${fitnessData.waterIntakeToday} ${Languages.of(context)!.labelLiters}",
                              //                         style: TextStyle(
                              //                             color: ThemeManager
                              //                                 .themeColor
                              //                                 .withOpacity(0.7),
                              //                             fontWeight:
                              //                                 FontWeight.w700,
                              //                             fontSize: AppFontSizes.mediumDefault),
                              //                       )
                              //                       // : Center(
                              //                       //     child: Text(
                              //                       //         '0  ${Languages.of(context)!.labelLiters}')),
                              //                       ),
                              //                   const SizedBox(
                              //                     height: 10,
                              //                   ),
                              //                   Text(
                              //                     "${Languages.of(context)!.labelRealTimeGoal} ${fitnessData.waterGoal} ${Languages.of(context)!.labelLiters}",
                              //                     style: TextStyle(
                              //                       color: TColor.gray,
                              //                       fontSize: AppFontSizes.smallDefault,,
                              //                     ),
                              //                   ),
                              //                   Column(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.start,
                              //                     children: fitnessData.waterArr
                              //                         .map((wObj) {
                              //                       var isLast = wObj ==
                              //                           fitnessData
                              //                               .waterArr.last;
                              //                       return Row(
                              //                         crossAxisAlignment:
                              //                             CrossAxisAlignment
                              //                                 .start,
                              //                         children: [
                              //                           Column(
                              //                             mainAxisAlignment:
                              //                                 MainAxisAlignment
                              //                                     .start,
                              //                             crossAxisAlignment:
                              //                                 CrossAxisAlignment
                              //                                     .center,
                              //                             children: [
                              //                               Container(
                              //                                 margin:
                              //                                     const EdgeInsets
                              //                                         .symmetric(
                              //                                         vertical:
                              //                                             4),
                              //                                 width: 10,
                              //                                 height: 10,
                              //                                 decoration:
                              //                                     BoxDecoration(
                              //                                   color: TColor
                              //                                       .secondaryColor1
                              //                                       .withOpacity(
                              //                                           0.5),
                              //                                   borderRadius:
                              //                                       BorderRadius
                              //                                           .circular(
                              //                                               5),
                              //                                 ),
                              //                               ),
                              //                               if (!isLast)
                              //                                 DottedDashedLine(
                              //                                     height: media
                              //                                             .width *
                              //                                         0.078,
                              //                                     width: 0,
                              //                                     dashColor: TColor
                              //                                         .secondaryColor1
                              //                                         .withOpacity(
                              //                                             0.5),
                              //                                     axis: Axis
                              //                                         .vertical)
                              //                             ],
                              //                           ),
                              //                           const SizedBox(
                              //                             width: 10,
                              //                           ),
                              //                           Column(
                              //                             mainAxisAlignment:
                              //                                 MainAxisAlignment
                              //                                     .start,
                              //                             crossAxisAlignment:
                              //                                 CrossAxisAlignment
                              //                                     .start,
                              //                             children: [
                              //                               Text(
                              //                                 wObj["title"]
                              //                                     .toString(),
                              //                                 style: TextStyle(
                              //                                   color:
                              //                                       TColor.gray,
                              //                                   fontSize: AppFontSizes.smallDefault,
                              //                                 ),
                              //                               ),
                              //                               ShaderMask(
                              //                                 blendMode:
                              //                                     BlendMode
                              //                                         .srcIn,
                              //                                 shaderCallback:
                              //                                     (bounds) {
                              //                                   return LinearGradient(
                              //                                           colors: TColor
                              //                                               .secondaryG,
                              //                                           begin: Alignment
                              //                                               .centerLeft,
                              //                                           end: Alignment
                              //                                               .centerRight)
                              //                                       .createShader(Rect.fromLTRB(
                              //                                           0,
                              //                                           0,
                              //                                           bounds
                              //                                               .width,
                              //                                           bounds
                              //                                               .height));
                              //                                 },
                              //                                 child: Text(
                              //                                   wObj["subtitle"]
                              //                                       .toString(),
                              //                                   style: TextStyle(
                              //                                       color: ThemeManager
                              //                                           .themeColor
                              //                                           .withOpacity(
                              //                                               0.7),
                              //                                       fontSize:
                              //                                           12),
                              //                                 ),
                              //                               ),
                              //                             ],
                              //                           )
                              //                         ],
                              //                       );
                              //                     }).toList(),
                              //                   ),
                              //                   // Spacer(),
                              //                   // Padding(
                              //                   //   padding:
                              //                   //       const EdgeInsets.all(2.0),
                              //                   //   child: SizedBox(
                              //                   //     width: 70,
                              //                   //     height: 25,
                              //                   //     child: RoundButton(
                              //                   //       title:
                              //                   //           Languages.of(context)!
                              //                   //               .labelCheck,
                              //                   //       type: RoundButtonType
                              //                   //           .bgGradient,
                              //                   //       fontSize: AppFontSizes.smallDefault,,
                              //                   //       fontWeight:
                              //                   //           FontWeight.w400,
                              //                   //       onPressed: () {
                              //                   //         // Navigator.push(
                              //                   //         //   context,
                              //                   //         //   MaterialPageRoute(s
                              //                   //         //     builder: (context) =>
                              //                   //         //         const ActivityTrackerView(),
                              //                   //         //   ),
                              //                   //         // );
                              //                   //         Navigator.push(
                              //                   //           context,
                              //                   //           MaterialPageRoute(
                              //                   //             builder: (context) =>
                              //                   //                 WaterTrackerView(),
                              //                   //             // SearchCookedFood(),
                              //                   //           ),
                              //                   //         );
                              //                   //       },
                              //                   //     ),
                              //                   //   ),
                              //                   // ),
                              //                   SizedBox(
                              //                     height: 8,
                              //                   ),
                              //                 ],
                              //               ))
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         width: media.width * 0.05,
                              //       ),
                              //       Expanded(
                              //           child: Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.start,
                              //         mainAxisSize: MainAxisSize.min,
                              //         children: [
                              //           // InkWell(
                              //           //   onTap: () {
                              //           //     // Navigator.push(
                              //           //     //   context,
                              //           //     //   MaterialPageRoute(s
                              //           //     //     builder: (context) =>
                              //           //     //         const ActivityTrackerView(),
                              //           //     //   ),
                              //           //     // );
                              //           //     Navigator.push(
                              //           //       context,
                              //           //       MaterialPageRoute(
                              //           //         builder: (context) =>
                              //           //             SleepTrackerSCreen(),
                              //           //       ),
                              //           //     );
                              //           //   },
                              //           //   child: Container(
                              //           //     width: double.maxFinite,
                              //           //     height: media.width * 0.45,
                              //           //     padding: const EdgeInsets.symmetric(
                              //           //         vertical: 25, horizontal: 20),
                              //           //     decoration: BoxDecoration(
                              //           //         color: ThemeManager.themeColor,
                              //           //         borderRadius:
                              //           //             BorderRadius.circular(25),
                              //           //         boxShadow: [
                              //           //           BoxShadow(
                              //           //               color: ThemeManager
                              //           //                   .themeText,
                              //           //               blurRadius: 0.1)
                              //           //         ]),
                              //           //     child: Column(
                              //           //         crossAxisAlignment:
                              //           //             CrossAxisAlignment.start,
                              //           //         children: [
                              //           //           Row(
                              //           //             children: [
                              //           //               Text(
                              //           //                 Languages.of(context)!
                              //           //                     .labelSleep,
                              //           //                 style: TextStyle(
                              //           //                     color: ThemeManager
                              //           //                         .themeText,
                              //           //                     fontSize: AppFontSizes.smallDefault,,
                              //           //                     fontWeight:
                              //           //                         FontWeight
                              //           //                             .w700),
                              //           //               ),
                              //           //               SizedBox(
                              //           //                 width: 10,
                              //           //               ),
                              //           //               // SizedBox(
                              //           //               //   width: 70,
                              //           //               //   height: 20,
                              //           //               //   child: RoundButton(
                              //           //               //     title: Languages.of(
                              //           //               //             context)!
                              //           //               //         .labelCheck,
                              //           //               //     type: RoundButtonType
                              //           //               //         .bgGradient,
                              //           //               //     fontSize: AppFontSizes.smallDefault,,
                              //           //               //     fontWeight:
                              //           //               //         FontWeight.w400,
                              //           //               //     onPressed: () {
                              //           //               //       // Navigator.push(
                              //           //               //       //   context,
                              //           //               //       //   MaterialPageRoute(s
                              //           //               //       //     builder: (context) =>
                              //           //               //       //         const ActivityTrackerView(),
                              //           //               //       //   ),
                              //           //               //       // );
                              //           //               //       Navigator.push(
                              //           //               //         context,
                              //           //               //         MaterialPageRoute(
                              //           //               //           builder: (context) =>
                              //           //               //               SleepTrackerSCreen(),
                              //           //               //         ),
                              //           //               //       );
                              //           //               //     },
                              //           //               //   ),
                              //           //               // )
                              //           //             ],
                              //           //           ),
                              //           //           ShaderMask(
                              //           //             blendMode: BlendMode.srcIn,
                              //           //             shaderCallback: (bounds) {
                              //           //               return LinearGradient(
                              //           //                       colors: TColor
                              //           //                           .primaryG,
                              //           //                       begin: Alignment
                              //           //                           .centerLeft,
                              //           //                       end: Alignment
                              //           //                           .centerRight)
                              //           //                   .createShader(
                              //           //                       Rect.fromLTRB(
                              //           //                           0,
                              //           //                           0,
                              //           //                           bounds.width,
                              //           //                           bounds
                              //           //                               .height));
                              //           //             },
                              //           //             child: Text(
                              //           //               "${fitnessData.sleepTime}",
                              //           //               style: TextStyle(
                              //           //                   color: ThemeManager
                              //           //                       .themeColor
                              //           //                       .withOpacity(0.7),
                              //           //                   fontWeight:
                              //           //                       FontWeight.w700,
                              //           //                   fontSize: AppFontSizes.mediumDefault),
                              //           //             ),
                              //           //           ),
                              //           //           const Spacer(),
                              //           //           Image.asset(
                              //           //               "assets/img/sleep_grap.png",
                              //           //               width: double.maxFinite,
                              //           //               fit: BoxFit.fitWidth)
                              //           //         ]),
                              //           //   ),
                              //           // ),
                              //           SizedBox(
                              //             height: media.width * 0.05,
                              //           ),
                              //           GestureDetector(
                              //             onTap: () {
                              //               Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                   builder: (context) =>
                              //                       ShowWeeklyCaloriesBurn(),
                              //                 ),
                              //               );
                              //             },
                              //             child: Container(
                              //               width: double.maxFinite,
                              //               height: media.width * 0.45,
                              //               padding: const EdgeInsets.symmetric(
                              //                   vertical: 25, horizontal: 20),
                              //               decoration: BoxDecoration(
                              //                   color: ThemeManager.themeColor,
                              //                   borderRadius:
                              //                       BorderRadius.circular(25),
                              //                   boxShadow: [
                              //                     BoxShadow(
                              //                         color: ThemeManager
                              //                             .themeText,
                              //                         blurRadius: 0.1)
                              //                   ]),
                              //               child: Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   children: [
                              //                     Text(
                              //                       Languages.of(context)!
                              //                           .labelCalories,
                              //                       style: TextStyle(
                              //                           color: ThemeManager
                              //                               .themeText,
                              //                           fontSize: AppFontSizes.smallDefault,,
                              //                           fontWeight:
                              //                               FontWeight.w700),
                              //                     ),
                              //                     ShaderMask(
                              //                       blendMode: BlendMode.srcIn,
                              //                       shaderCallback: (bounds) {
                              //                         return LinearGradient(
                              //                                 colors: TColor
                              //                                     .primaryG,
                              //                                 begin: Alignment
                              //                                     .centerLeft,
                              //                                 end: Alignment
                              //                                     .centerRight)
                              //                             .createShader(
                              //                                 Rect.fromLTRB(
                              //                                     0,
                              //                                     0,
                              //                                     bounds.width,
                              //                                     bounds
                              //                                         .height));
                              //                       },
                              //                       child: Text(
                              //                         // "$caloriesburn kCal",
                              //                         "${double.parse(fitnessData.caloriesBurned).toStringAsFixed(1)} kCal",
                              //                         style: TextStyle(
                              //                             color: ThemeManager
                              //                                 .themeColor
                              //                                 .withOpacity(0.7),
                              //                             fontWeight:
                              //                                 FontWeight.w700,
                              //                             fontSize: AppFontSizes.mediumDefault),
                              //                       ),
                              //                     ),
                              //                     const Spacer(),
                              //                     Container(
                              //                       alignment: Alignment.center,
                              //                       child: SizedBox(
                              //                         width: media.width * 0.2,
                              //                         height: media.width * 0.2,
                              //                         child: Stack(
                              //                           alignment:
                              //                               Alignment.center,
                              //                           children: [
                              //                             Container(
                              //                               width: media.width *
                              //                                   0.15,
                              //                               height:
                              //                                   media.width *
                              //                                       0.15,
                              //                               alignment: Alignment
                              //                                   .center,
                              //                               decoration:
                              //                                   BoxDecoration(
                              //                                 gradient: LinearGradient(
                              //                                     colors: TColor
                              //                                         .primaryG),
                              //                                 borderRadius: BorderRadius
                              //                                     .circular(media
                              //                                             .width *
                              //                                         0.075),
                              //                               ),
                              //                               child: FittedBox(
                              //                                 child: Text(
                              //                                   // "$caloriesburnleft kCal\nleft",
                              //                                   "${fitnessData.caloriesLeft} kCal\nleft",
                              //                                   textAlign:
                              //                                       TextAlign
                              //                                           .center,
                              //                                   style: TextStyle(
                              //                                       color: ThemeManager
                              //                                           .themeColor,
                              //                                       fontSize:
                              //                                           11),
                              //                                 ),
                              //                               ),
                              //                             ),
                              //                             // ClipOval(
                              //                             //   child: Container(
                              //                             //     width: 50,
                              //                             //     child: Center(
                              //                             //       child: Image.asset(
                              //                             //         "assets/images/calories.png",
                              //                             //       ),
                              //                             //     ),
                              //                             //   ),
                              //                             // ),
                              //                             SimpleCircularProgressBar(
                              //                               progressStrokeWidth:
                              //                                   10,
                              //                               backStrokeWidth: 10,
                              //                               progressColors:
                              //                                   TColor.primaryG,
                              //                               backColor: Colors
                              //                                   .grey.shade100,
                              //                               valueNotifier:
                              //                                   ValueNotifier(
                              //                                       fitnessData
                              //                                           .caloriesProgressBar),
                              //                               startAngle: -180,
                              //                             ),
                              //                           ],
                              //                         ),
                              //                       ),
                              //                     )
                              //                   ]),
                              //             ),
                              //           ),
                              //         ],
                              //       ))
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: media.width * 0.05,
                              // ),

                              // SizedBox(
                              //   height: media.width * 0.05,
                              // ),
                              if (MensurationToggle)
                                Container(
                                  width: media.width * 0.95,
                                  decoration: BoxDecoration(
                                    color:
                                        TColor.primaryColor2.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ExpansionTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 13.0, right: 13),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            // width: media.width * 0.6,
                                            child: SizedBox(
                                              width: media.width * 0.6,
                                              child: Text(
                                                // "${Languages.of(context)!.labelCaloriesEarned} today($formattedDateforcalories)",
                                                Languages.of(context)!
                                                    .labelMensurationCycle,
                                                style: TextStyle(
                                                    color:
                                                        ThemeManager.themeText,
                                                    fontSize: AppFontSizes
                                                        .largeDefault,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: 70,
                                        ],
                                      ),
                                    ),
                                    //heretyy.l
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MensurationCycleScreen(),
                                              // SearchCookedFood(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          // decoration: BoxDecoration(
                                          //   borderRadius: BorderRadius.circular(15.0),
                                          //   color: TColor.primaryColor1,
                                          // ),c
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: media.width * 0.4,
                                                width: media.width * 0.7,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 25,
                                                        horizontal: 20),
                                                decoration: BoxDecoration(
                                                    color:
                                                        ThemeManager.themeColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: ThemeManager
                                                              .themeText,
                                                          blurRadius: 0.1)
                                                    ]),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  media.width *
                                                                      0.4,
                                                              child: Text(
                                                                Languages.of(
                                                                        context)!
                                                                    .labelMensurationCycle,
                                                                style: TextStyle(
                                                                    color: ThemeManager
                                                                        .themeText,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        AppFontSizes
                                                                            .mediumDefault),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  media.width *
                                                                      0.4,
                                                              child: Text(
                                                                Languages.of(
                                                                        context)!
                                                                    .labelTrackAndManage,
                                                                style: TextStyle(
                                                                    color: ThemeManager.themeText,
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .bold,
                                                                    fontSize: AppFontSizes.mediumDefault),
                                                              ),
                                                            ),

                                                            // const SizedBox(
                                                            //   height: 10,
                                                            // ),

                                                            // Padding(
                                                            //   padding:
                                                            //       const EdgeInsets.all(2.0),
                                                            //   child: SizedBox(
                                                            //     width: 70,
                                                            //     height: 25,
                                                            //     child: RoundButton(
                                                            //       title:
                                                            //           Languages.of(context)!
                                                            //               .labelCheck,
                                                            //       type: RoundButtonType
                                                            //           .bgGradient,
                                                            //       fontSize: AppFontSizes.smallDefault,,
                                                            //       fontWeight:
                                                            //           FontWeight.w400,
                                                            //       onPressed: () {
                                                            //         // Navigator.push(
                                                            //         //   context,
                                                            //         //   MaterialPageRoute(s
                                                            //         //     builder: (context) =>
                                                            //         //         const ActivityTrackerView(),
                                                            //         //   ),
                                                            //         // );
                                                            //         Navigator.push(
                                                            //           context,
                                                            //           MaterialPageRoute(
                                                            //             builder: (context) =>
                                                            //                 WaterTrackerView(),
                                                            //             // SearchCookedFood(),
                                                            //           ),
                                                            //         );
                                                            //       },
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        Center(
                                                          child: Image.asset(
                                                            "assets/img/period.png",
                                                            width: 60,
                                                            height: 60,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ],
                                                    ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      sizedBox12(),
                                    ],
                                    onExpansionChanged: (expanded) {
                                      if (expanded) {
                                        // Calculate total calories earned
                                        setState(() {});
                                      }
                                    },
                                  ),
                                ),
                              // ElevatedButton(
                              //     onPressed: () {
                              //       Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => OtpScreen(),
                              //           // SearchCookedFood(),
                              //         ),
                              //       );
                              //     },
                              //     child: Text("Testing 111")),
                              // // InkWell(
                              //   onTap: () {},
                              //   child: Container(
                              //     width: media.width * 0.95,
                              //     decoration: BoxDecoration(
                              //       color:
                              //           TColor.primaryColor2.withOpacity(0.3),
                              //       borderRadius: BorderRadius.circular(15),
                              //     ),
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: Center(
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.start,
                              //           children: [
                              //             SizedBox(width: 10),
                              //             // SizedBox(
                              //             //   width: 40,
                              //             //   height: 40,
                              //             //   child: Image.asset(
                              //             //     fObj["image"].toString(),
                              //             //     width: 40,
                              //             //     height: 40,
                              //             //     color: TColor.secondaryColor2,
                              //             //     fit: BoxFit.contain,
                              //             //   ),
                              //             // ),
                              //             SizedBox(width: 15),
                              //             Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.center,
                              //               crossAxisAlignment: CrossAxisAlignment
                              //                   .start, // Align text to the left
                              //               children: [
                              //                 Text(
                              //                   Languages.of(context)!
                              //                       .labelMensurationCycle,
                              //                   style: TextStyle(
                              //                     color: ThemeManager.themeText,
                              //                     fontSize:
                              //                         AppFontSizes.largeDefault,
                              //                     fontWeight: FontWeight.w700,
                              //                   ),
                              //                 ),
                              //                 SizedBox(
                              //                     height:
                              //                         4), // Add some vertical spacing
                              //                 SizedBox(
                              //                   width: media.width * 0.55,
                              //                   child: Center(
                              //                     child: Text(
                              //                       Languages.of(context)!
                              //                           .labelTrackAndManage,
                              //                       style: TextStyle(
                              //                         color: ThemeManager
                              //                             .themeText,
                              //                         fontSize: AppFontSizes
                              //                             .mediumDefault,
                              //                         fontFamily: 'Poppins',
                              //                         fontWeight:
                              //                             FontWeight.w400,
                              //                         height:
                              //                             1.5, // Increase the line height
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 )
                              //               ],
                              //             ),
                              //             Spacer(),
                              //             SizedBox(
                              //               width: 80,
                              //               height: 35,
                              //               child: RoundButton(
                              //                 title: Languages.of(context)!
                              //                     .labelCheck,
                              //                 type: RoundButtonType.bgGradient,
                              //                 fontSize:
                              //                     AppFontSizes.smallDefault,
                              //                 fontWeight: FontWeight.w400,
                              //                 onPressed: () {
                              //                   Navigator.push(
                              //                     context,
                              //                     MaterialPageRoute(
                              //                       builder: (context) =>
                              //                           MensurationCycleScreen(),
                              //                     ),
                              //                   );
                              //                 },
                              //               ),
                              //             )
                              //             // SizedBox(
                              //             //   width: 70,
                              //             //   height: 25,
                              //             //   child: RoundButton(
                              //             //     title: Languages.of(context)!
                              //             //         .labelCheck,
                              //             //     type: RoundButtonType.bgGradient,
                              //             //     fontSize: AppFontSizes.smallDefault,,
                              //             //     fontWeight: FontWeight.w400,
                              //             //     onPressed: () {
                              //             //       // Navigator.push(
                              //             //       //   context,
                              //             //       //   MaterialPageRoute(s
                              //             //       //     builder: (context) =>
                              //             //       //         const ActivityTrackerView(),
                              //             //       //   ),
                              //             //       // );
                              //             //       Navigator.push(
                              //             //         context,
                              //             //         MaterialPageRoute(
                              //             //             builder: (context) =>
                              //             //                 MensurationCycleScreen()),
                              //             //       );
                              //             //     },
                              //             //   ),
                              //             // ),
                              //             ,
                              //             SizedBox(
                              //               width: 5,
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // // SizedBox(
                              //   height: media.width * 0.03,
                              // ),
                              // SizedBox(
                              //   height: media.width * 0.05,
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 13.0, right: 13),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(
                              //         Languages.of(context)!.labelCaloriesEarned,
                              //         style: TextStyle(
                              //             color: ThemeManager.themeText,
                              //             fontSize: AppFontSizes.mediumDefault,
                              //             fontWeight: FontWeight.w700),
                              //       ),
                              //       SizedBox(
                              //         width: 70,
                              //         height: 25,
                              //         child: RoundButton(
                              //           title: Languages.of(context)!.add,
                              //           type: RoundButtonType.bgGradient,
                              //           fontSize: AppFontSizes.smallDefault,,
                              //           fontWeight: FontWeight.w400,
                              //           onPressed: () {
                              //             Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                 builder: (context) => AddDishScreen(),
                              //               ),
                              //             );
                              //           },
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // sizedBox12(),

                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceAround,
                              //   children: [
                              //     GestureDetector(
                              //       onTap: () {
                              //         // Navigator.push(
                              //         //   context,
                              //         //   MaterialPageRoute(
                              //         //     builder: (context) =>
                              //         //         NutrientInMyFood(),
                              //         //     // ActivityTrackerScreen(),
                              //         //     // LocationMarker(),
                              //         //   ),
                              //         // );
                              //       },
                              //       onLongPress: () => _speak(
                              //           'check your time and calories burn you spent on different activivties'),
                              //       child: Container(
                              //         width: media.width * 0.95,
                              //         height: media.width * 0.15,
                              //         // height: media.width * 0.40,
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 15, horizontal: 15),
                              //         decoration: BoxDecoration(
                              //           color: TColor.primaryColor2
                              //               .withOpacity(0.3),
                              //           borderRadius: BorderRadius.circular(15),
                              //         ),
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.center,
                              //           children: [
                              //             Row(
                              //               children: [
                              //                 ClipOval(
                              //                   child: Container(
                              //                     width: 50,
                              //                     //  height: 41,
                              //                     decoration: BoxDecoration(
                              //                       shape: BoxShape.circle,
                              //                       color: ThemeManager
                              //                           .themelightColor, // Set the background color for the circular container
                              //                     ),
                              //                     child: Center(
                              //                       child: Image.asset(
                              //                         "assets/img/lunch.jpg",
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //                 Center(
                              //                   child: Text(
                              //                     Languages.of(context)!
                              //                         .TextAppNutrientsInMyFood,
                              //                     textAlign: TextAlign.center,
                              //                     // $_steps2
                              //                     style: TextStyle(
                              //                         color: ThemeManager
                              //                             .themeText,
                              //                         fontSize: AppFontSizes.mediumDefault,
                              //                         fontWeight:
                              //                             FontWeight.w700),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //             // Spacer(),

                              //             SizedBox(
                              //               width: 70,
                              //               height: 35,
                              //               child: RoundButton(
                              //                 title: Languages.of(context)!
                              //                     .labelCheck,
                              //                 type: RoundButtonType.bgGradient,
                              //                 fontSize: AppFontSizes.smallDefault,,
                              //                 fontWeight: FontWeight.w400,
                              //                 onPressed: () {
                              //                   // Navigator.push(
                              //                   //   context,
                              //                   //   MaterialPageRoute(s
                              //                   //     builder: (context) =>
                              //                   //         const ActivityTrackerView(),
                              //                   //   ),
                              //                   // );
                              //                   Navigator.push(
                              //                     context,
                              //                     MaterialPageRoute(
                              //                       builder: (context) =>
                              //                           NutrientInMyFood(),
                              //                     ),
                              //                   );
                              //                 },
                              //               ),
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     // GestureDetector(
                              //     //   onTap: () {
                              //     //     Navigator.push(
                              //     //       context,
                              //     //       MaterialPageRoute(
                              //     //           builder: (context) =>
                              //     //               ToadyActivity()),
                              //     //     );
                              //     //   },
                              //     //   onLongPress: () => _speak(
                              //     //       'check your time and calories burn you spent on different activivties'),
                              //     //   child: Container(
                              //     //     width: media.width * 0.41,
                              //     //     height: media.width * 0.28,
                              //     //     // height: media.width * 0.40,
                              //     //     padding: const EdgeInsets.symmetric(
                              //     //         vertical: 15, horizontal: 15),
                              //     //     decoration: BoxDecoration(
                              //     //       color: TColor.primaryColor2
                              //     //           .withOpacity(0.3),
                              //     //       borderRadius: BorderRadius.circular(15),
                              //     //     ),
                              //     //     child: Column(
                              //     //       mainAxisAlignment:
                              //     //           MainAxisAlignment.start,
                              //     //       crossAxisAlignment:
                              //     //           CrossAxisAlignment.center,
                              //     //       children: [
                              //     //         ClipOval(
                              //     //           child: Container(
                              //     //             width: 50,
                              //     //             //  height: 41,
                              //     //             decoration: BoxDecoration(
                              //     //               shape: BoxShape.circle,
                              //     //               color: ThemeManager
                              //     //                   .themelightColor, // Set the background color for the circular container
                              //     //             ),
                              //     //             child: Center(
                              //     //               child: Image.asset(
                              //     //                 "assets/images/exercise.png",
                              //     //               ),
                              //     //             ),
                              //     //           ),
                              //     //         ),
                              //     //         // Spacer(),
                              //     //         Center(
                              //     //           child: Text(
                              //     //             Languages.of(context)!
                              //     //                 .TextApp1MyActivity,
                              //     //             textAlign: TextAlign.center,
                              //     //             // $_steps2
                              //     //             style: TextStyle(
                              //     //                 color: ThemeManager.themeText,
                              //     //                 fontSize: AppFontSizes.mediumDefault,
                              //     //                 fontWeight: FontWeight.w700),
                              //     //           ),
                              //     //         ),
                              //     //       ],
                              //     //     ),
                              //     //   ),
                              //     // ),
                              //   ],
                              // ),

                              sizedBox12(),

                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceAround,
                              //   children: [
                              //     GestureDetector(
                              //       onTap: () {
                              //         // Navigator.push(
                              //         //   context,
                              //         //   MaterialPageRoute(
                              //         //     builder: (context) =>
                              //         //         NutrientInMyFood(),
                              //         //     // ActivityTrackerScreen(),
                              //         //     // LocationMarker(),
                              //         //   ),
                              //         // );
                              //       },
                              //       onLongPress: () => _speak(
                              //           'check your time and calories burn you spent on different activivties'),
                              //       child: Container(
                              //         width: media.width * 0.95,
                              //         height: media.width * 0.15,
                              //         // height: media.width * 0.40,
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 15, horizontal: 15),
                              //         decoration: BoxDecoration(
                              //           color: TColor.primaryColor2
                              //               .withOpacity(0.3),
                              //           borderRadius: BorderRadius.circular(15),
                              //         ),
                              //         child: Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceBetween,
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.center,
                              //           children: [
                              //             Row(
                              //               children: [
                              //                 ClipOval(
                              //                   child: Container(
                              //                     width: 50,
                              //                     //  height: 41,
                              //                     decoration: BoxDecoration(
                              //                       shape: BoxShape.circle,
                              //                       color: ThemeManager
                              //                           .themelightColor, // Set the background color for the circular container
                              //                     ),
                              //                     child: Center(
                              //                       child: Image.asset(
                              //                         'assets/img/diary.png',
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //                 Center(
                              //                   child: Text(
                              //                     Languages.of(context)!
                              //                         .TextAppMyDietDiary,
                              //                     textAlign: TextAlign.center,
                              //                     // $_steps2
                              //                     style: TextStyle(
                              //                         color: ThemeManager
                              //                             .themeText,
                              //                         fontSize: AppFontSizes.mediumDefault,
                              //                         fontWeight:
                              //                             FontWeight.w700),
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //             // Spacer(),

                              //             SizedBox(
                              //               width: 70,
                              //               height: 35,
                              //               child: RoundButton(
                              //                 title: Languages.of(context)!
                              //                     .labelCheck,
                              //                 type: RoundButtonType.bgGradient,
                              //                 fontSize: AppFontSizes.smallDefault,,
                              //                 fontWeight: FontWeight.w400,
                              //                 onPressed: () {
                              //                   // Navigator.push(
                              //                   //   context,
                              //                   //   MaterialPageRoute(s
                              //                   //     builder: (context) =>
                              //                   //         const ActivityTrackerView(),
                              //                   //   ),
                              //                   // );
                              //                   Navigator.push(
                              //                     context,
                              //                     MaterialPageRoute(
                              //                       builder: (context) =>
                              //                           DietryDiary(),
                              //                     ),
                              //                   );
                              //                 },
                              //               ),
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // sizedBox12(),

                              // NotificationListener<ScrollNotification>(
                              //   onNotification: (scrollNotification) {
                              //     if (!showContent &&
                              //         scrollNotification.metrics.pixels >=
                              //             scrollNotification
                              //                 .metrics.maxScrollExtent) {
                              //       setState(() {
                              //         showContent = true;
                              //       });
                              //     }
                              //     return false;
                              //   },
                              //   child: SingleChildScrollView(
                              //     child: Column(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: <Widget>[
                              //         Text(
                              //           'Text Container',
                              //           style: TextStyle(
                              //               fontSize: AppFontSizes.largeDefault.0,
                              //               fontWeight: FontWeight.bold),
                              //         ),
                              //         SizedBox(height: 20.0),
                              //         Container(
                              //           padding: EdgeInsets.all(20.0),
                              //           decoration: BoxDecoration(
                              //             color: Colors.grey[200],
                              //             borderRadius:
                              //                 BorderRadius.circular(10.0),
                              //           ),
                              //           child: Text(
                              //             'This is a text container. It contains some text displayed in a visually distinct box.',
                              //             style: TextStyle(fontSize: AppFontSizes.mediumDefault.0),
                              //           ),
                              //         ),
                              //         SizedBox(height: 20.0),
                              //         showContent
                              //             ? Column(
                              //                 children: [
                              //                   Text(
                              //                     'Additional Text',
                              //                     style: TextStyle(
                              //                         fontSize: AppFontSizes.mediumDefault.0,
                              //                         fontWeight:
                              //                             FontWeight.bold),
                              //                   ),
                              //                   SizedBox(height: 10.0),
                              //                   Text(
                              //                     'This is some additional text added below the text container.',
                              //                     style:
                              //                         TextStyle(fontSize: AppFontSizes.mediumDefault.0),
                              //                   ),
                              //                 ],
                              //               )
                              //             : SizedBox(), // Show nothing initially
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: media.width * 0.05,
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       left: 13.0, right: 13),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       SizedBox(
                              //         width: media.width * 0.6,
                              //         child: Text(
                              //           // "${Languages.of(context)!.labelCaloriesEarned} today($formattedDateforcalories)",
                              //           "${Languages.of(context)!.labelCaloriesEarned} today",
                              //           style: TextStyle(
                              //               color: ThemeManager.themeText,
                              //               fontSize: AppFontSizes.mediumDefault,
                              //               fontWeight: FontWeight.w700),
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         width: 70,
                              //         height: 25,
                              //         child: RoundButton(
                              //           title: Languages.of(context)!.add,
                              //           type: RoundButtonType.bgGradient,
                              //           fontSize: AppFontSizes.smallDefault,,
                              //           fontWeight: FontWeight.w400,
                              //           onPressed: () {
                              //             Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                 builder: (context) =>
                              //                     AddDishScreen(),
                              //               ),
                              //             );
                              //           },
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // sizedBox12(),

                              // Container(
                              //   // decoration: BoxDecoration(
                              //   //   borderRadius: BorderRadius.circular(15.0),
                              //   //   color: TColor.primaryColor1,
                              //   // ),
                              //   child: Column(
                              //     children: [
                              //       _buildCalorieRow(
                              //           Languages.of(context)!
                              //               .mainlabelEarlyMorning,
                              //           fitnessData.data["Early Morning"]
                              //               .toString(),
                              //           1000),
                              //       _buildCalorieRow(
                              //           '${Languages.of(context)!.labelBreakfast}',
                              //           fitnessData.data["Breakfast"]
                              //               .toString(),
                              //           500),
                              //       _buildCalorieRow(
                              //           Languages.of(context)!
                              //               .mainlabelMidMorning,
                              //           fitnessData.data["Mid Morning"]
                              //               .toString(),
                              //           800),
                              //       _buildCalorieRow(
                              //           '${Languages.of(context)!.labelLunch}',
                              //           fitnessData.data["Lunch"].toString(),
                              //           1500),
                              //       _buildCalorieRow(
                              //           Languages.of(context)!.mainlabelEvening,
                              //           fitnessData.data["Evening"].toString(),
                              //           1000),
                              //       _buildCalorieRow(
                              //           '${Languages.of(context)!.labelDinner}',
                              //           fitnessData.data["Dinner"].toString(),
                              //           1000),
                              //       _buildCalorieRow(
                              //           Languages.of(context)!.mainlabelBedtime,
                              //           fitnessData.data["Bed Time"].toString(),
                              //           1000),
                              //     ],
                              //   ),
                              // ),
                              // sizedBox12(),
                              // SpinImageOnNavigate(),
                              // Container(
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(
                              //         10.0), // Adjust the radius as needed
                              //     gradient: LinearGradient(colors: [
                              //       TColor.primaryColor1.withOpacity(0.2),
                              //       TColor.secondaryColor1.withOpacity(0.2)
                              //     ]),
                              //     // gradient: LinearGradient(
                              //     //   begin: Alignment.topCenter,
                              //     //   end: Alignment.bottomCenter,
                              //     //   colors: [
                              //     //     TColor.primaryColor1,
                              //     //     ThemeManager.themelightColor
                              //     //   ], // Adjust colors as needed
                              //     // ),
                              //   ),
                              //   child: ExpansionTile(
                              //     title: Text(
                              //       Languages.of(context)!
                              //           .TextAppMyNutrientRequirements,
                              //       style: TextStyle(
                              //         color: ThemeManager.themeText,
                              //         fontSize: AppFontSizes.mediumDefault,
                              //       ),
                              //     ),
                              //     children: [
                              //       Padding(
                              //         padding: EdgeInsets.all(16.0),
                              //         child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             Padding(
                              //               padding: EdgeInsets.symmetric(
                              //                   vertical: 8.0),
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                 children: [
                              //                   Text(
                              //                     Languages.of(context)!
                              //                         .NINTextNutrient,
                              //                     style: TextStyle(
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                         fontSize: AppFontSizes.mediumDefault),
                              //                   ),
                              //                   Text(
                              //                     Languages.of(context)!
                              //                         .labelWeight,
                              //                     style: TextStyle(
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                         fontSize: AppFontSizes.mediumDefault),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //             // _buildDetailRow(
                              //             //     'Gender', _profileFuture.gender),
                              //             // _buildDetailRow(
                              //             //     'Age', _profileFuture.age),
                              //             // _buildDetailRow(
                              //             //     'Group', _profileFuture.group),
                              //             // _buildDetailRow('Work Level',
                              //             //     _profileFuture.workLevel),
                              //             _buildDetailRow(
                              //               Languages.of(context)!
                              //                   .NINTextEnergyKcal,
                              //               _profileFuture.energy
                              //                   .toStringAsFixed(
                              //                 _profileFuture.energy >= 99
                              //                     ? 0
                              //                     : 2,
                              //               ),
                              //             ),
                              //             _buildDetailRow(
                              //               Languages.of(context)!
                              //                   .NINTextProteinG,
                              //               _profileFuture.protein
                              //                   .toStringAsFixed(
                              //                 _profileFuture.protein >= 99
                              //                     ? 0
                              //                     : 2,
                              //               ),
                              //             ),
                              //             _buildDetailRow(
                              //               Languages.of(context)!.NINTextFatG,
                              //               _profileFuture.fatsOilsVisible
                              //                   .toStringAsFixed(
                              //                 _profileFuture.fatsOilsVisible >=
                              //                         99
                              //                     ? 0
                              //                     : 2,
                              //               ),
                              //             ),
                              //             _buildDetailRow(
                              //               Languages.of(context)!
                              //                   .NINTextFiberG,
                              //               _profileFuture.fiber
                              //                   .toStringAsFixed(
                              //                 _profileFuture.fiber >= 99
                              //                     ? 0
                              //                     : 2,
                              //               ),
                              //             ),
                              //             _buildDetailRow(
                              //               Languages.of(context)!
                              //                   .NINTextCalciumMg,
                              //               _profileFuture.calcium
                              //                   .toStringAsFixed(
                              //                 _profileFuture.calcium >= 99
                              //                     ? 0
                              //                     : 2,
                              //               ),
                              //             ),
                              //             _buildDetailRow(
                              //               Languages.of(context)!
                              //                   .NINTextMagnesiumMg,
                              //               _profileFuture.magnesium
                              //                   .toStringAsFixed(
                              //                 _profileFuture.magnesium >= 99
                              //                     ? 0
                              //                     : 2,
                              //               ),
                              //             ),
                              //             _buildDetailRow(
                              //               Languages.of(context)!
                              //                   .NINTextIronMg,
                              //               _profileFuture.iron.toStringAsFixed(
                              //                 _profileFuture.iron >= 99 ? 0 : 2,
                              //               ),
                              //             ),
                              //             _buildDetailRow(
                              //               Languages.of(context)!
                              //                   .NINTextZincMg,
                              //               _profileFuture.zinc.toStringAsFixed(
                              //                 _profileFuture.zinc >= 99 ? 0 : 2,
                              //               ),
                              //             ),
                              //             _buildDetailRow(
                              //               Languages.of(context)!
                              //                   .NINTextThiamineB1Mg,
                              //               _profileFuture.thiamine
                              //                   .toStringAsFixed(
                              //                 _profileFuture.thiamine >= 99
                              //                     ? 0
                              //                     : 2,
                              //               ),
                              //             ),
                              //             _buildDetailRow(
                              //               Languages.of(context)!
                              //                   .NINTextRiboflavinB2Mg,
                              //               _profileFuture.riboflavin
                              //                   .toStringAsFixed(
                              //                 _profileFuture.riboflavin >= 99
                              //                     ? 0
                              //                     : 2,
                              //               ),
                              //             ),
                              //             _buildDetailRow(
                              //               Languages.of(context)!
                              //                   .NINTextNiacinB3Mg,
                              //               _profileFuture.niacin
                              //                   .toStringAsFixed(
                              //                 _profileFuture.niacin >= 99
                              //                     ? 0
                              //                     : 2,
                              //               ),
                              //             ),
                              //             _buildDetailRow(
                              //               Languages.of(context)!
                              //                   .NINTextFolatesB9Mcg,
                              //               _profileFuture.folate
                              //                   .toStringAsFixed(
                              //                 _profileFuture.folate >= 99
                              //                     ? 0
                              //                     : 2,
                              //               ),
                              //             ),
                              //             _buildDetailRow(
                              //               Languages.of(context)!
                              //                   .NINTextRetinolVitAMcg,
                              //               _profileFuture.vitA.toStringAsFixed(
                              //                 _profileFuture.vitA >= 99 ? 0 : 2,
                              //               ),
                              //             ),
                              //             // _buildDetailRow(
                              //             //   Languages.of(context)!.Iodinemcg,
                              //             //   _profileFuture.iodine
                              //             //       .toStringAsFixed(
                              //             //     _profileFuture.iodine >= 99
                              //             //         ? 0
                              //             //         : 2,
                              //             //   ),
                              //             // ),
                              //             // _buildDetailRow(
                              //             //   'Vitamin B12',
                              //             //   _profileFuture.vitB12
                              //             //       .toStringAsFixed(
                              //             //     _profileFuture.vitB12 >= 99
                              //             //         ? 0
                              //             //         : 2,
                              //             //   ),
                              //             // ),
                              //             // _buildDetailRow(
                              //             //   Languages.of(context)!.VitaminCmg,
                              //             //   _profileFuture.vitC.toStringAsFixed(
                              //             //     _profileFuture.vitC >= 99 ? 0 : 2,
                              //             //   ),
                              //             // ),
                              //             _buildDetailRow(
                              //               Languages.of(context)!
                              //                   .NINTextCarbohydratesG,
                              //               _profileFuture.carbohydrate
                              //                   .toStringAsFixed(
                              //                 _profileFuture.carbohydrate >= 99
                              //                     ? 0
                              //                     : 2,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               NutrientInMyFood()),
                              //     );
                              //   },
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(14),
                              //           color:
                              //               Color.fromARGB(255, 152, 219, 219)),
                              //       child: Row(
                              //         children: [
                              //           Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: Image.asset(
                              //               'assets/img/top10food.png',
                              //               height: 100,
                              //               // width: 100,
                              //               fit: BoxFit.cover,
                              //             ),
                              //           ),
                              //           Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: SizedBox(
                              //               width: 120,
                              //               child: Text(
                              //                 Languages.of(context)!
                              //                     .mainlabelExploreTop10Foods,
                              //                 style: TextStyle(
                              //                     color: ThemeManager.themeText,
                              //                     fontSize:AppFontSizes.extraLargeDefault),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // _buildCalorieRow('${Languages.of(context)!.labelBreakfast}',
                              //     fitnessData.data["Breakfast"].toString(), 500),
                              // _buildCalorieRow('${Languages.of(context)!.labelLunch}',
                              //     fitnessData.data["Lunch"].toString(), 1500),
                              // _buildCalorieRow('${Languages.of(context)!.labelSnacks}',
                              //     fitnessData.data["Snacks"].toString(), 800),
                              // BMIClockIndicator(
                              //   bmiValue: 121,
                              // ),

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       Languages.of(context)!.labelFoodPlan,
                              //       style: TextStyle(
                              //           color: Colors.black,
                              //           fontSize: AppFontSizes.mediumDefault,
                              //           fontWeight: FontWeight.w700),
                              //     ),
                              //     SizedBox(
                              //       width: 70,
                              //       height: 25,
                              //       child: RoundButton(
                              //         title: Languages.of(context)!.labelCheck,
                              //         type: RoundButtonType.bgGradient,
                              //         fontSize: AppFontSizes.smallDefault,,
                              //         fontWeight: FontWeight.w400,
                              //         onPressed: () {
                              //           Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //               builder: (context) => FoodPlanAddDish(),
                              //             ),
                              //           );
                              //         },
                              //       ),
                              //     )
                              //   ],
                              // ),
                              // sizedBox12(),
                              // for (int i = 0; i < mealsFood.length; i++)
                              //   Container(
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(10),
                              //       // border: Border.all(
                              //       //   color: Colors.grey,
                              //       //   width: 2,
                              //       // ),
                              //       color: const Color.fromARGB(
                              //           255, 233, 231, 231),
                              //     ),
                              //     child: ExpansionTile(
                              //       title: Text(
                              //         Languages.of(context)!
                              //             .TextAppTotalNutrientTaken,
                              //         style: TextStyle(
                              //           color:
                              //               Colors.black, // Set the title color
                              //         ),
                              //       ),
                              //       children: [
                              //         SingleChildScrollView(
                              //           scrollDirection: Axis.horizontal,
                              //           child: Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               Padding(
                              //                 padding: const EdgeInsets.only(
                              //                     left: 8.0, right: 8.0),
                              //                 child: Container(
                              //                   height: 40,
                              //                   decoration: BoxDecoration(
                              //                     border: Border.all(
                              //                       color: Colors.grey,
                              //                       width: 2,
                              //                     ),
                              //                     color: TColor.primaryColor1,
                              //                   ),
                              //                   child: Row(
                              //                     mainAxisAlignment:
                              //                         MainAxisAlignment
                              //                             .spaceAround,
                              //                     children: [
                              //                       Container(
                              //                         width: 110,
                              //                         child: Text(
                              //                             Languages.of(context)!
                              //                                 .NINTextNutrient),
                              //                       ),
                              //                       Container(
                              //                         width: 60,
                              //                         child: Text(
                              //                             Languages.of(context)!
                              //                                 .NINTextValue),
                              //                       ),
                              //                       Container(
                              //                         width: 80,
                              //                         child: Row(
                              //                           children: [
                              //                             Text(Languages.of(
                              //                                     context)!
                              //                                 .NINTextEAR),
                              //                             Tooltip(
                              //                               message:
                              //                                   'BMR Information',
                              //                               child: IconButton(
                              //                                 icon: Icon(
                              //                                   Icons.info,
                              //                                   color: ThemeManager
                              //                                       .themeText,
                              //                                   size: 20,
                              //                                 ),
                              //                                 onPressed: () {
                              //                                   // Show BMR information here
                              //                                   showDialog(
                              //                                     context:
                              //                                         context,
                              //                                     builder: (_) =>
                              //                                         AlertDialog(
                              //                                       title: Text(
                              //                                           'EAR'),
                              //                                       content:
                              //                                           Text(
                              //                                         'Estimated Average Requirement (EAR): Average daily level of intake estimated to meet the requirements of 50% of healthy individuals',
                              //                                       ),
                              //                                       actions: [
                              //                                         TextButton(
                              //                                           onPressed:
                              //                                               () {
                              //                                             Navigator.pop(
                              //                                                 context);
                              //                                           },
                              //                                           child: Text(
                              //                                               'Close'),
                              //                                         ),
                              //                                       ],
                              //                                     ),
                              //                                   );
                              //                                 },
                              //                               ),
                              //                             ),
                              //                           ],
                              //                         ),
                              //                       ),
                              //                       Container(
                              //                         width: 100,
                              //                         child: Text(Languages.of(
                              //                                 context)!
                              //                             .NINTextPercentage),
                              //                       ),
                              //                     ],
                              //                   ),
                              //                 ),
                              //               ),
                              //               // Add some spacing between header and data
                              //               Padding(
                              //                 padding: const EdgeInsets.only(
                              //                     bottom: 8.0,
                              //                     left: 8.0,
                              //                     right: 8.0),
                              //                 child: Column(
                              //                   children: [
                              //                     customtablerow(
                              //                       percentageNotAvailable:
                              //                           _profileFuture.energy ==
                              //                               0,
                              //                       ingredientName:
                              //                           Languages.of(context)!
                              //                               .NINTextEnergyKcal,
                              //                       ingredientValue:
                              //                           '${mealsFood[0].totalmealCalories.toStringAsFixed(mealsFood[0].totalmealCalories >= 99 ? 0 : 2)}',
                              //                       earValue:
                              //                           '${_profileFuture.energy.toStringAsFixed(_profileFuture.energy >= 99 ? 0 : 2)}',
                              //                       percentage: mealsFood[0]
                              //                               .totalmealCalories *
                              //                           100 /
                              //                           (_profileFuture
                              //                                       .energy ==
                              //                                   0
                              //                               ? 1
                              //                               : _profileFuture
                              //                                   .energy),
                              //                     ),
                              //                     customtablerow(
                              //                       percentageNotAvailable:
                              //                           _profileFuture
                              //                                   .protein ==
                              //                               0,
                              //                       ingredientName:
                              //                           Languages.of(context)!
                              //                               .NINTextProteinG,
                              //                       ingredientValue:
                              //                           '${mealsFood[0].mealProteins.toStringAsFixed(mealsFood[0].mealProteins >= 99 ? 0 : 2)}',
                              //                       earValue:
                              //                           '${_profileFuture.protein.toStringAsFixed(_profileFuture.protein >= 99 ? 0 : 2)}',
                              //                       percentage: mealsFood[0]
                              //                               .mealProteins *
                              //                           100 /
                              //                           (_profileFuture
                              //                                       .protein ==
                              //                                   0
                              //                               ? 1
                              //                               : _profileFuture
                              //                                   .protein),
                              //                     ),
                              //                     customtablerow(
                              //                       percentageNotAvailable:
                              //                           _profileFuture
                              //                                   .fatsOilsVisible ==
                              //                               0,
                              //                       ingredientName:
                              //                           Languages.of(context)!
                              //                               .NINTextFatG,
                              //                       ingredientValue:
                              //                           '${mealsFood[0].mealFats.toStringAsFixed(mealsFood[0].mealFats >= 99 ? 0 : 2)}',
                              //                       earValue:
                              //                           '${_profileFuture.fatsOilsVisible.toStringAsFixed(_profileFuture.fatsOilsVisible >= 99 ? 0 : 2)}',
                              //                       percentage: mealsFood[0]
                              //                               .mealFats *
                              //                           100 /
                              //                           (_profileFuture
                              //                                       .fatsOilsVisible ==
                              //                                   0
                              //                               ? 1
                              //                               : _profileFuture
                              //                                   .fatsOilsVisible),
                              //                     ),
                              //                     customtablerow(
                              //                       percentageNotAvailable:
                              //                           _profileFuture
                              //                                   .carbohydrate ==
                              //                               0,
                              //                       ingredientName: Languages
                              //                               .of(context)!
                              //                           .NINTextCarbohydratesG,
                              //                       ingredientValue:
                              //                           '${mealsFood[0].mealCarbs.toStringAsFixed(mealsFood[0].mealCarbs >= 99 ? 0 : 2)}',
                              //                       earValue:
                              //                           '${_profileFuture.carbohydrate.toStringAsFixed(_profileFuture.carbohydrate >= 99 ? 0 : 2)}',
                              //                       percentage: mealsFood[0]
                              //                               .mealCarbs *
                              //                           100 /
                              //                           (_profileFuture
                              //                                       .carbohydrate ==
                              //                                   0
                              //                               ? 1
                              //                               : _profileFuture
                              //                                   .carbohydrate),
                              //                     ),
                              //                     customtablerow(
                              //                       percentageNotAvailable:
                              //                           _profileFuture
                              //                                   .calcium ==
                              //                               0,
                              //                       ingredientName:
                              //                           Languages.of(context)!
                              //                               .NINTextCalciumMg,
                              //                       ingredientValue:
                              //                           '${mealsFood[0].mealCalcium.toStringAsFixed(mealsFood[0].mealCalcium >= 99 ? 0 : 2)}',
                              //                       earValue:
                              //                           '${_profileFuture.calcium.toStringAsFixed(_profileFuture.calcium >= 99 ? 0 : 2)}',
                              //                       percentage: mealsFood[0]
                              //                               .mealCalcium *
                              //                           100 /
                              //                           (_profileFuture
                              //                                       .calcium ==
                              //                                   0
                              //                               ? 1
                              //                               : _profileFuture
                              //                                   .calcium),
                              //                     ),
                              //                     customtablerow(
                              //                       percentageNotAvailable:
                              //                           _profileFuture.fiber ==
                              //                               0,
                              //                       ingredientName:
                              //                           Languages.of(context)!
                              //                               .NINTextFiberG,
                              //                       ingredientValue:
                              //                           '${mealsFood[0].mealFibers.toStringAsFixed(mealsFood[0].mealFibers >= 99 ? 0 : 2)}',
                              //                       earValue:
                              //                           '${_profileFuture.fiber.toStringAsFixed(_profileFuture.fiber >= 99 ? 0 : 2)}',
                              //                       percentage: mealsFood[0]
                              //                               .mealFibers *
                              //                           100 /
                              //                           (_profileFuture.fiber ==
                              //                                   0
                              //                               ? 1
                              //                               : _profileFuture
                              //                                   .fiber),
                              //                     ),
                              //                     customtablerow(
                              //                       percentageNotAvailable:
                              //                           _profileFuture.iron ==
                              //                               0,
                              //                       ingredientName:
                              //                           Languages.of(context)!
                              //                               .NINTextIronMg,
                              //                       ingredientValue:
                              //                           '${mealsFood[0].mealIron.toStringAsFixed(mealsFood[0].mealIron >= 99 ? 0 : 2)}',
                              //                       earValue:
                              //                           '${_profileFuture.iron.toStringAsFixed(_profileFuture.iron >= 99 ? 0 : 2)}',
                              //                       percentage: mealsFood[0]
                              //                               .mealIron *
                              //                           100 /
                              //                           (_profileFuture.iron ==
                              //                                   0
                              //                               ? 1
                              //                               : _profileFuture
                              //                                   .iron),
                              //                     ),
                              //                     customtablerow(
                              //                       percentageNotAvailable:
                              //                           _profileFuture.zinc ==
                              //                               0,
                              //                       ingredientName:
                              //                           Languages.of(context)!
                              //                               .NINTextZincMg,
                              //                       ingredientValue:
                              //                           '${mealsFood[0].mealZinc.toStringAsFixed(mealsFood[0].mealZinc >= 99 ? 0 : 2)}',
                              //                       earValue:
                              //                           '${_profileFuture.zinc.toStringAsFixed(_profileFuture.zinc >= 99 ? 0 : 2)}',
                              //                       percentage: mealsFood[0]
                              //                               .mealZinc *
                              //                           100 /
                              //                           (_profileFuture.zinc ==
                              //                                   0
                              //                               ? 1
                              //                               : _profileFuture
                              //                                   .zinc),
                              //                     ),
                              //                     customtablerow(
                              //                       percentageNotAvailable:
                              //                           _profileFuture
                              //                                   .magnesium ==
                              //                               0,
                              //                       ingredientName:
                              //                           Languages.of(context)!
                              //                               .NINTextMagnesiumMg,
                              //                       ingredientValue:
                              //                           '${mealsFood[0].mealMagnesium.toStringAsFixed(mealsFood[0].mealMagnesium >= 99 ? 0 : 2)}',
                              //                       earValue:
                              //                           '${_profileFuture.magnesium.toStringAsFixed(_profileFuture.magnesium >= 99 ? 0 : 2)}',
                              //                       percentage: mealsFood[0]
                              //                               .mealMagnesium *
                              //                           100 /
                              //                           (_profileFuture
                              //                                       .magnesium ==
                              //                                   0
                              //                               ? 1
                              //                               : _profileFuture
                              //                                   .magnesium),
                              //                     ),
                              //                     customtablerow(
                              //                       percentageNotAvailable:
                              //                           _profileFuture
                              //                                   .thiamine ==
                              //                               0,
                              //                       ingredientName: Languages
                              //                               .of(context)!
                              //                           .NINTextThiamineB1Mg,
                              //                       ingredientValue:
                              //                           '${mealsFood[0].mealThiamineB1.toStringAsFixed(mealsFood[0].mealThiamineB1 >= 99 ? 0 : 2)}',
                              //                       earValue:
                              //                           '${_profileFuture.thiamine.toStringAsFixed(_profileFuture.thiamine >= 99 ? 0 : 2)}',
                              //                       percentage: mealsFood[0]
                              //                               .mealThiamineB1 *
                              //                           100 /
                              //                           (_profileFuture
                              //                                       .thiamine ==
                              //                                   0
                              //                               ? 1
                              //                               : _profileFuture
                              //                                   .thiamine),
                              //                     ),
                              //                     customtablerow(
                              //                       percentageNotAvailable:
                              //                           _profileFuture
                              //                                   .riboflavin ==
                              //                               0,
                              //                       ingredientName: Languages
                              //                               .of(context)!
                              //                           .NINTextRiboflavinB2Mg,
                              //                       ingredientValue:
                              //                           '${mealsFood[0].mealRiboflavinB2.toStringAsFixed(mealsFood[0].mealRiboflavinB2 >= 99 ? 0 : 2)}',
                              //                       earValue:
                              //                           '${_profileFuture.riboflavin.toStringAsFixed(_profileFuture.riboflavin >= 99 ? 0 : 2)}',
                              //                       percentage: mealsFood[0]
                              //                               .mealRiboflavinB2 *
                              //                           100 /
                              //                           (_profileFuture
                              //                                       .riboflavin ==
                              //                                   0
                              //                               ? 1
                              //                               : _profileFuture
                              //                                   .riboflavin),
                              //                     ),
                              //                     customtablerow(
                              //                       percentageNotAvailable:
                              //                           _profileFuture.niacin ==
                              //                               0,
                              //                       ingredientName:
                              //                           Languages.of(context)!
                              //                               .NINTextNiacinB3Mg,
                              //                       ingredientValue:
                              //                           '${mealsFood[0].mealNiacinB3.toStringAsFixed(mealsFood[0].mealNiacinB3 >= 99 ? 0 : 2)}',
                              //                       earValue:
                              //                           '${_profileFuture.niacin.toStringAsFixed(_profileFuture.niacin >= 99 ? 0 : 2)}',
                              //                       percentage: mealsFood[0]
                              //                               .mealNiacinB3 *
                              //                           100 /
                              //                           (_profileFuture
                              //                                       .niacin ==
                              //                                   0
                              //                               ? 1
                              //                               : _profileFuture
                              //                                   .niacin),
                              //                     ),
                              //                     customtablerow(
                              //                       percentageNotAvailable:
                              //                           _profileFuture.folate ==
                              //                               0,
                              //                       ingredientName: Languages
                              //                               .of(context)!
                              //                           .NINTextFolatesB9Mcg,
                              //                       ingredientValue:
                              //                           '${mealsFood[0].mealFolatesB9.toStringAsFixed(mealsFood[0].mealFolatesB9 >= 99 ? 0 : 2)}',
                              //                       earValue:
                              //                           '${_profileFuture.folate.toStringAsFixed(_profileFuture.folate >= 99 ? 0 : 2)}',
                              //                       percentage: mealsFood[0]
                              //                               .mealFolatesB9 *
                              //                           100 /
                              //                           (_profileFuture
                              //                                       .folate ==
                              //                                   0
                              //                               ? 1
                              //                               : _profileFuture
                              //                                   .folate),
                              //                     ),
                              //                     customtablerow(
                              //                       percentageNotAvailable:
                              //                           _profileFuture.vitA ==
                              //                               0,
                              //                       ingredientName: Languages
                              //                               .of(context)!
                              //                           .NINTextRetinolVitAMcg,
                              //                       ingredientValue:
                              //                           '${mealsFood[0].mealRetinolVitA.toStringAsFixed(mealsFood[0].mealRetinolVitA >= 99 ? 0 : 2)}',
                              //                       earValue:
                              //                           '${_profileFuture.vitA.toStringAsFixed(_profileFuture.vitA >= 99 ? 0 : 2)}',
                              //                       percentage: mealsFood[0]
                              //                               .mealRetinolVitA *
                              //                           100 /
                              //                           (_profileFuture.vitA ==
                              //                                   0
                              //                               ? 1
                              //                               : _profileFuture
                              //                                   .vitA),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // sizedBox12(),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               HealthDashboardPage()),
                              //     );
                              //   },
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(14),
                              //           color:
                              //               Color.fromARGB(255, 152, 219, 219)),
                              //       child: Row(
                              //         children: [
                              //           Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: Image.asset(
                              //               'assets/img/diary.png',
                              //               height: 50,
                              //               // width: 100,
                              //               fit: BoxFit.cover,
                              //             ),
                              //           ),
                              //           Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: SizedBox(
                              //               width: 120,
                              //               child: Text(
                              //                 "My activity",
                              //                 style: TextStyle(
                              //                     color: ThemeManager.themeText,
                              //                     fontSize:AppFontSizes.extraLargeDefault),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // InkWell(
                              //   onTap: () {
                              //     // final AuthRepo _authRepo = AuthRepo();
                              //     // AuthRepo.checkTokenExpired();

                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               //
                              //               //      RecompleteProfile()
                              //               // MvfdbfdbfgbyApp()
                              //               //SearchRawFood()
                              //               // BloodPressurePage()
                              //               // Tgfdiuewkj()
                              //               // fontsizeflutter()
                              //               // HipWaistTrackerPage()
                              //               // DropdownPage()
                              //               // fontsizeflutter()
                              //               // LoginPage()
                              //               //   PhoneSignInPage()
                              //               //    PieChartPage()
                              //               RecompleteProfile()
                              //           //  FcmTokenPage()
                              //           //  GoogleSignInPage()
                              //           // PdfViwerPage()
                              //           // PDFViewerPage(
                              //           //     pdfAssetPath:
                              //           //         "assets/img/sample.pdf"),
                              //           //  ToadyActivity()
                              //           //  WorkLevelPage()
                              //           // BMIClockIndicator(
                              //           //   bmiValue: 121,
                              //           // ),
                              //           //
                              //           // BMIPage(bmiValue: 20)
                              //           // CloudinaryImageUploader()
                              //           // AddDishEdit()
                              //           ),
                              //     );
                              //   },
                              //   child: SizedBox(
                              //     width: 230,
                              //     child: Text(
                              //       'testing version latest 55',
                              //       style: TextStyle(
                              //         color: TColor.primaryColor1,
                              //         fontSize: AppFontSizes.mediumDefault,
                              //         fontFamily: 'Poppins',
                              //         fontWeight: FontWeight.w400,
                              //         height: 1.5, // Increase the line height
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // // SizedBox(
                              //   height: media.width * 0.05,
                              // ),
                              // SizedBox(
                              //   height: media.width * 0.05,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       Languages.of(context)!.labelWorkoutProgress,
                              //       style: TextStyle(
                              //           color: Colors.black,
                              //           fontSize: AppFontSizes.mediumDefault,
                              //           fontWeight: FontWeight.w700),
                              //     ),
                              //     Container(
                              //         height: 30,
                              //         padding: const EdgeInsets.symmetric(horizontal: 8),
                              //         decoration: BoxDecoration(
                              //           gradient: LinearGradient(colors: TColor.primaryG),
                              //           borderRadius: BorderRadius.circular(15),
                              //         ),
                              //         child: DropdownButtonHideUnderline(
                              //           child: DropdownButton(
                              //             items: [
                              //               "${Languages.of(context)!.labelWeekly}",
                              //               "${Languages.of(context)!.labelMonthly}"
                              //             ]
                              //                 .map((name) => DropdownMenuItem(
                              //                       value: name,
                              //                       child: Text(
                              //                         name,
                              //                         style: TextStyle(
                              //                             color: TColor.gray,
                              //                             fontSize: AppFontSizes.mediumDefault),
                              //                       ),
                              //                     ))
                              //                 .toList(),
                              //             onChanged: (value) {},
                              //             icon: Icon(Icons.expand_more,
                              //                 color: ThemeManager.themeColor),
                              //             hint: Text(
                              //               Languages.of(context)!.labelWeekly,
                              //               textAlign: TextAlign.center,
                              //               style: TextStyle(
                              //                   color: ThemeManager.themeColor,
                              //                   fontSize: AppFontSizes.smallDefault,),
                              //             ),
                              //           ),
                              //         )),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: media.width * 0.05,
                              // ),
                              // Container(
                              //     padding: const EdgeInsets.only(left: 15),
                              //     height: media.width * 0.5,
                              //     width: double.maxFinite,
                              //     child: LineChart(
                              //       LineChartData(
                              //         showingTooltipIndicators:
                              //             showingTooltipOnSpots.map((index) {
                              //           return ShowingTooltipIndicators([
                              //             LineBarSpot(
                              //               tooltipsOnBar,
                              //               lineBarsData.indexOf(tooltipsOnBar),
                              //               tooltipsOnBar.spots[index],
                              //             ),
                              //           ]);
                              //         }).toList(),
                              //         lineTouchData: LineTouchData(
                              //           enabled: true,
                              //           handleBuiltInTouches: false,
                              //           touchCallback: (FlTouchEvent event,
                              //               LineTouchResponse? response) {
                              //             if (response == null ||
                              //                 response.lineBarSpots == null) {
                              //               return;
                              //             }
                              //             if (event is FlTapUpEvent) {
                              //               final spotIndex =
                              //                   response.lineBarSpots!.first.spotIndex;
                              //               showingTooltipOnSpots.clear();
                              //               setState(() {
                              //                 showingTooltipOnSpots.add(spotIndex);
                              //               });
                              //             }
                              //           },
                              //           mouseCursorResolver: (FlTouchEvent event,
                              //               LineTouchResponse? response) {
                              //             if (response == null ||
                              //                 response.lineBarSpots == null) {
                              //               return SystemMouseCursors.basic;
                              //             }
                              //             return SystemMouseCursors.click;
                              //           },
                              //           getTouchedSpotIndicator:
                              //               (LineChartBarData barData,
                              //                   List<int> spotIndexes) {
                              //             return spotIndexes.map((index) {
                              //               return TouchedSpotIndicatorData(
                              //                 FlLine(
                              //                   color: Colors.transparent,
                              //                 ),
                              //                 FlDotData(
                              //                   show: true,
                              //                   getDotPainter:
                              //                       (spot, percent, barData, index) =>
                              //                           FlDotCirclePainter(
                              //                     radius: 3,
                              //                     color: Colors.white,
                              //                     strokeWidth: 3,
                              //                     strokeColor: TColor.secondaryColor1,
                              //                   ),
                              //                 ),
                              //               );
                              //             }).toList();
                              //           },
                              //           touchTooltipData: LineTouchTooltipData(
                              //             tooltipBgColor: TColor.secondaryColor1,
                              //             tooltipRoundedRadius: 20,
                              //             getTooltipItems:
                              //                 (List<LineBarSpot> lineBarsSpot) {
                              //               return lineBarsSpot.map((lineBarSpot) {
                              //                 return LineTooltipItem(
                              //                   "${lineBarSpot.x.toInt()} ${Languages.of(context)!.labelMinutesAgo}",
                              //                   const TextStyle(
                              //                     color: Colors.white,
                              //                     fontSize: AppFontSizes.smallDefault,
                              //                     fontWeight: FontWeight.bold,
                              //                   ),
                              //                 );
                              //               }).toList();
                              //             },
                              //           ),
                              //         ),
                              //         lineBarsData: lineBarsData1,
                              //         minY: -0.5,
                              //         maxY: 110,
                              //         titlesData: FlTitlesData(
                              //             show: true,
                              //             leftTitles: AxisTitles(),
                              //             topTitles: AxisTitles(),
                              //             bottomTitles: AxisTitles(
                              //               sideTitles: bottomTitles,
                              //             ),
                              //             rightTitles: AxisTitles(
                              //               sideTitles: rightTitles,
                              //             )),
                              //         gridData: FlGridData(
                              //           show: true,
                              //           drawHorizontalLine: true,
                              //           horizontalInterval: 25,
                              //           drawVerticalLine: false,
                              //           getDrawingHorizontalLine: (value) {
                              //             return FlLine(
                              //               color: TColor.gray.withOpacity(0.15),
                              //               strokeWidth: 2,
                              //             );
                              //           },
                              //         ),
                              //         borderData: FlBorderData(
                              //           show: true,
                              //           border: Border.all(
                              //             color: Colors.transparent,
                              //           ),
                              //         ),
                              //       ),
                              //     )),
                              // SizedBox(
                              //   height: media.width * 0.05,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       Languages.of(context)!.labelLatestWorkout,
                              //       style: TextStyle(
                              //           color: Colors.black,
                              //           fontSize: AppFontSizes.mediumDefault,
                              //           fontWeight: FontWeight.w700),
                              //     ),
                              //     TextButton(
                              //       onPressed: () {},
                              //       child: Text(
                              //         Languages.of(context)!.labelSeeMore,
                              //         style: TextStyle(
                              //             color: Colors.black,
                              //             fontSize: AppFontSizes.mediumDefault,
                              //             fontWeight: FontWeight.w700),
                              //       ),
                              //     )
                              //   ],
                              // ),
                              // ListView.builder(
                              //     padding: EdgeInsets.zero,
                              //     physics: const NeverScrollableScrollPhysics(),
                              //     shrinkWrap: true,
                              //     itemCount: lastWorkoutArr.length,
                              //     itemBuilder: (context, index) {
                              //       var wObj = lastWorkoutArr[index] as Map? ?? {};
                              //       return InkWell(
                              //           onTap: () {
                              //             Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                 builder: (context) =>
                              //                     const FinishedWorkoutView(),
                              //               ),
                              //             );
                              //           },
                              //           child: WorkoutRow(wObj: wObj));
                              //     }),
                              // SizedBox(
                              //   height: media.width * 0.1,
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
            : const Center(
                child: SizedBox(
                  width: 250,
                  child: Text(
                    'No internet connection!.. Please Check Internet',
                    style: TextStyle(fontSize: AppFontSizes.largeDefault),
                  ),
                ),
              ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      2,
      (i) {
        var color0 = TColor.secondaryColor1;

        switch (i) {
          case 0:
            return PieChartSectionData(
                color: color0,
                value: 33,
                title: '',
                radius: 55,
                titlePositionPercentageOffset: 0.55,
                badgeWidget: const Text(
                  "20,1",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppFontSizes.smallDefault,
                      fontWeight: FontWeight.w700),
                ));
          case 1:
            return PieChartSectionData(
              color: Colors.white,
              value: 75,
              title: '',
              radius: 45,
              titlePositionPercentageOffset: 0.55,
            );

          default:
            throw Error();
        }
      },
    );
  }

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
      ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        gradient: LinearGradient(colors: [
          TColor.primaryColor2.withOpacity(0.5),
          TColor.primaryColor1.withOpacity(0.5),
        ]),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 35),
          FlSpot(2, 70),
          FlSpot(3, 40),
          FlSpot(4, 80),
          FlSpot(5, 25),
          FlSpot(6, 70),
          FlSpot(7, 35),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        gradient: LinearGradient(colors: [
          TColor.secondaryColor2.withOpacity(0.5),
          TColor.secondaryColor1.withOpacity(0.5),
        ]),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
        ),
        spots: const [
          FlSpot(1, 80),
          FlSpot(2, 50),
          FlSpot(3, 90),
          FlSpot(4, 40),
          FlSpot(5, 80),
          FlSpot(6, 35),
          FlSpot(7, 60),
        ],
      );

  SideTitles get rightTitles => SideTitles(
        getTitlesWidget: rightTitleWidgets,
        showTitles: true,
        interval: 20,
        reservedSize: 40,
      );

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0%';
        break;
      case 20:
        text = '20%';
        break;
      case 40:
        text = '40%';
        break;
      case 60:
        text = '60%';
        break;
      case 80:
        text = '80%';
        break;
      case 100:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text,
        style: TextStyle(
          color: TColor.gray,
          fontSize: AppFontSizes.smallDefault,
        ),
        textAlign: TextAlign.center);
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: TColor.gray,
      fontSize: AppFontSizes.smallDefault,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('Sun', style: style);
        break;
      case 2:
        text = Text('Mon', style: style);
        break;
      case 3:
        text = Text('Tue', style: style);
        break;
      case 4:
        text = Text('Wed', style: style);
        break;
      case 5:
        text = Text('Thu', style: style);
        break;
      case 6:
        text = Text('Fri', style: style);
        break;
      case 7:
        text = Text('Sat', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  Widget _buildCalorieRow(
      String meal, String caloriesTaken, int targetCalories) {
    return InkWell(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => AddDishScreen(),
      //     ),
      //   );
      // },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: TColor.primaryColor1.withOpacity(0.2),
          // gradient: LinearGradient(colors: [
          //   TColor.primaryColor1.withOpacity(0.2),
          //   TColor.secondaryColor1.withOpacity(0.2)
          // ]),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(FontAwesomeIcons.utensils,
                    size: 30, color: ThemeManager.themeText),
                const SizedBox(width: 5),
                Text(
                  meal,
                  style: TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.w400,
                      color: ThemeManager.themeText),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${double.parse(caloriesTaken).toStringAsFixed(double.parse(caloriesTaken) >= 99 ? 0 : 2)} Kcal',
                  style: TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      color: ThemeManager.themeText),
                ),
                // Text(
                //   '${Languages.of(context)!.labelTarget}: $targetCalories kcal',
                //   style: TextStyle(fontSize: AppFontSizes.smallDefault.0, color: Colors.red),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    ),
  );
}
