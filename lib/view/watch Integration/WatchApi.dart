import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:intl/intl.dart';
import 'package:nin2byo2i/Classes/FitnessData.dart';

import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Repository/TokenManagerforWatch.dart';

import 'package:nin2byo2i/Repository/auth_repo.dart';
import 'package:nin2byo2i/view/google%20Fit/infra/health_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//from here you can access all watch api
class WatchApiDataProvider extends ChangeNotifier {
  final UserProfileController _controller = UserProfileController();
  FitnessData fitnessData = FitnessData.instance;

  Future<void> makeApiCalls() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? watchType = await TokenManager.getWatchType();
    if (watchType?.toLowerCase() == 'google fit') {
      // Run your code here if the comparison is true
      debugPrint('Watch type matches "Google Fit"');
      final HealthRepository healthRepository = HealthRepository();
      await healthRepository.makeAccess();
      // int? steps = await healthRepository.getCurrentDateSteps();
      // debugPrint("fdhbdhnfgnhg $steps ");
      // final data =
      //     await _controller.PostStepsDataOfUser(steps == null ? 0 : steps);

      double? CaloriesBurn = await healthRepository.getTodayCaloriesBurn();
      await _controller.PostCalorieDataOfUser(
          CaloriesBurn ?? 0);

      debugPrint("fdhbdhnfgdffdgnhg $CaloriesBurn ");

      fitnessData.caloriesBurned = CaloriesBurn == null
          ? '0'
          : CaloriesBurn.toStringAsFixed(CaloriesBurn >= 99 ? 0 : 2).toString();
      // await healthRepository.getBodyTemperature();
      // await healthRepository.getHeartRate();
      String steps7dayts = await healthRepository.get7DaysStepsAsString();
      Map<String, int> sleep7dayts = await healthRepository.get7DaysSleepData();
      // List<double> caloriesBurnedData =
      // String caloriesburn7dayts =
      //     await healthRepository.get7DaysCaloriesBurnAsString();
      Map<String, int> heartRate7dayts =
          await healthRepository.get7DaysHeartRate();
      // await healthRepository.getLast24HoursSleepData();

      // await _controller.PostCaloriesBurn7daysDataOfUser(caloriesburn7dayts);
      await _controller.PostSteps7daysDataOfUser(steps7dayts);
      await _controller.PostSleep7daysDataOfUserGoogleFit(sleep7dayts);
      await _controller.PostRestingHeartRate7daysDataOfUser(heartRate7dayts);
      await _controller.fetchStepsOfToday();
      await fetchsleepTargetAndDuration();
      await _controller.fetchStepsOfToday();

      // fitnessData.sleepTimeFromeWatch =
      //     (await healthRepository.getLast24HoursSleepData()).toString();

      // debugPrint("fdhbdhnfgnhg $steps $CaloriesBurn");
      return;
    }
    // debugPrint("watch APi call Successfully$watch_type");
    if (watchType?.toLowerCase() == 'fitbit') {
      debugPrint("watch APi call Successfully");
      bool isExpired = await TokenManager.isTokenExpired();
      debugPrint("toke expired fitbit is $isExpired");
      if (isExpired) {
        await refreshToken();
        debugPrint('token has expired $isExpired');
        // Token has expired, handle accordingly (e.g., refresh token or reauthenticate)
      } else {
        // Token is still valid
        debugPrint('token has not expired ');
        //fitbit

        fetchStepsData();
        fetch7daysCaloriesBurnData();
        fetch7daysStepsData();
        fetchSleepData();
        fetch7daysSleepData();
        HeartRate();
        fetch7daysHeartRateData();
        SpO2();
      }
    }
    // await refreshToken();

    //from server
    fetchsleepTargetAndDuration();
    // //after fetch data from watch api get data from backenede and set in flutter pages
    // DateTime now = DateTime.now();
    // String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    // Map<String, dynamic> sleepData =
    //     await _controller.fetchSleepData(formattedDate);

    // if (sleepData.isNotEmpty) {
    //   // Code to execute if the map is empty
    //   int durationInSeconds = ((sleepData['duration'] / 1000000000).round() +
    //           (sleepData['manualDuration'] * 60))
    //       .toInt();

    //   Duration duration = Duration(seconds: durationInSeconds);
    //   int hours = duration.inHours;
    //   int minutes = (duration.inMinutes % 60);

    //   fitnessData.sleepTime = '$hours h $minutes m';
    //   debugPrint('The map is empty.');
    // }
    // int sleeptarget0 = await _controller.getSleepTarget();
    // double sleeptarget = sleeptarget0 / 60;
    // fitnessData.sleepGoal = sleeptarget.toString();
    // debugPrint("sleepData kjkunjkn $sleeptarget    ${fitnessData.sleepGoal}");
  }

  Future<void> fetchsleepTargetAndDuration() async {
    //after fetch data from watch api get data from backenede and set in flutter pages
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    Map<String, dynamic> sleepData =
        await _controller.fetchSleepData(formattedDate);

    if (sleepData.isNotEmpty) {
      // Code to execute if the map is empty
      int durationInSeconds = ((sleepData['duration'] * 60).round() +
              (sleepData['manualDuration'] * 60))
          .toInt();

      Duration duration = Duration(seconds: durationInSeconds);
      int hours = duration.inHours;
      int minutes = (duration.inMinutes % 60);

      fitnessData.sleepTime = '$hours h $minutes m';
      debugPrint('The map is empty.');
    }
    int sleeptarget0 = await _controller.getSleepTarget();
    double sleeptarget = sleeptarget0 / 60;
    fitnessData.sleepGoal = sleeptarget.toString();
    debugPrint(
        "sleepData kjkunjkn $sleepData  $sleeptarget ${fitnessData.sleepTime}   ${fitnessData.sleepGoal}");
  }

//refresh token
  Future<void> refreshToken() async {
    String refreshToken = await TokenManager.getRefreshToken() ?? "";
    String? tokenfit = await TokenManager.getToken();
    String? userIdfit = await TokenManager.getId();
    const String apiUrl = 'https://api.fitbit.com/oauth2/token';
    // final String basicToken
    debugPrint('response data is here refresh: $tokenfit');
    debugPrint('response data is here refresh: $refreshToken');
    final Map<String, String> headers = {
      'accept': 'application/json',
      'authorization':
          'Basic MjNSR1BDOmEwMjY1OTE1YjRkZmM5YTcyM2VmOGI1NmMxNTIyMzgw',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final Map<String, String> body = {
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      debugPrint('response data is here refresh: ${response.statusCode}');

      debugPrint('Access Token: ${data['access_token']}');
      await TokenManager.saveToken(data['access_token']);
      await TokenManager.saveRefreshToken(data['refresh_token']);
      debugPrint('Refresh Token: ${data['refresh_token']}');
    } else {
      debugPrint('Error response data is here refresh: ${response.statusCode}');
      debugPrint('Body: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> fetchStepsData() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    // Retrieve token, ID, and refresh token

    String? refreshToken = await TokenManager.getRefreshToken();
    String? tokenfit = await TokenManager.getToken();
    String? userIdfit = await TokenManager.getId();

    debugPrint('token and user id is $tokenfit $userIdfit');
    final response = await http.get(
        Uri.parse(
            'https://api.fitbit.com/1/user/$userIdfit/activities/date/$formattedDate.json'),
        headers: {
          'Authorization': 'Bearer $tokenfit',
        });

    if (response.statusCode == 200) {
      debugPrint('responsefsf $userIdfit fat $tokenfit ${response.body}');

      Map<String, dynamic> responseData1 = json.decode(response.body);
      int stepup = responseData1['summary']['steps'];
      // fitnessData.steps = stepup.toString();
      fitnessData.caloriesBurned =
          responseData1['summary']['caloriesOut'].toString();
      fitnessData.caloriesLeft =
          responseData1['goals']['caloriesOut'].toString();
      final data = await _controller.PostStepsDataOfUser(stepup);
      _controller.fetchStepsOfToday();
      //  caloriesburn= responseData1['goals']['steps'];
      debugPrint('step dat upload $data ${fitnessData.caloriesBurned}');
      // if (mounted) {
      //   setState(() {
      //     _steps2 = responseData1['summary']['steps'].toString();
      //     caloriesburn = responseData1['summary']['caloriesOut'];
      //     caloriesburnleft = responseData1['goals']['caloriesOut'];
      //     caloriesburnleft = caloriesburnleft - caloriesburn;
      //   });
      // }

      debugPrint('steps is here ');

      return json.decode(response.body);
    } else {
      debugPrint('response fat ${response.body}');
      throw Exception('Failed to load data');
    }
  }
  //updtae last 7days steps

  Future<Map<String, dynamic>> fetch7daysStepsData() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    // Retrieve token, ID, and refresh token

    String? refreshToken = await TokenManager.getRefreshToken();
    String? tokenfit = await TokenManager.getToken();
    String? userIdfit = await TokenManager.getId();

    debugPrint('token and user id is $tokenfit $userIdfit');
    final response = await http.get(
        Uri.parse(
            'https://api.fitbit.com/1/user/-/activities/steps/date/$formattedDate/7d.json'),
        headers: {
          'Authorization': 'Bearer $tokenfit',
        });

    if (response.statusCode == 200) {
      debugPrint('respohgjggjgjnsefsf $userIdfit fat $tokenfit ${response.body}');
      List<Map<String, dynamic>> stepsData = List<Map<String, dynamic>>.from(
          json.decode(response.body)['activities-steps']);

      // Sort the stepsData based on dateTime
      stepsData.sort((a, b) => a['dateTime'].compareTo(b['dateTime']));

      // Generate separate strings for dates and values
      // String datesString = stepsData.map((step) => step['dateTime']).join(',');
      String valuesString = stepsData.map((step) => step['value']).join(',');

      // debugPrint('Dates String: $datesString');
      debugPrint('Values String: $valuesString');

      // return {'dates': datesString, 'values': valuesString};

      // Map<String, dynamic> responseData1 = json.decode(response.body);
      // int stepup = responseData1['summary']['steps'];
      // // fitnessData.steps = stepup.toString();
      // fitnessData.caloriesBurned =
      //     responseData1['summary']['caloriesOut'].toString();
      // fitnessData.caloriesLeft =
      //     responseData1['goals']['caloriesOut'].toString();
      final data = await _controller.PostSteps7daysDataOfUser(valuesString);
      _controller.fetchStepsOfToday();
      // //  caloriesburn= responseData1['goals']['steps'];
      // debugPrint('step dat upload $data');
      // if (mounted) {
      //   setState(() {
      //     _steps2 = responseData1['summary']['steps'].toString();
      //     caloriesburn = responseData1['summary']['caloriesOut'];
      //     caloriesburnleft = responseData1['goals']['caloriesOut'];
      //     caloriesburnleft = caloriesburnleft - caloriesburn;
      //   });
      // }

      debugPrint('steps is here ');

      return json.decode(response.body);
    } else {
      debugPrint('response fat ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  //updtae last 7days caloriesburn

  Future<Map<String, dynamic>> fetch7daysCaloriesBurnData() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    // Retrieve token, ID, and refresh token

    String? refreshToken = await TokenManager.getRefreshToken();
    String? tokenfit = await TokenManager.getToken();
    String? userIdfit = await TokenManager.getId();

    debugPrint('token and user id is $tokenfit $userIdfit');
    final response = await http.get(
        Uri.parse(
            'https://api.fitbit.com/1/user/-/activities/calories/date/$formattedDate/7d.json'),
        headers: {
          'Authorization': 'Bearer $tokenfit',
        });

    if (response.statusCode == 200) {
      debugPrint(
          'respohgjggjgjnsefsfgffhfh $userIdfit fat $tokenfit ${response.body}');
      List<Map<String, dynamic>> stepsData = List<Map<String, dynamic>>.from(
          json.decode(response.body)['activities-calories']);

      // Sort the stepsData based on dateTime
      stepsData.sort((a, b) => a['dateTime'].compareTo(b['dateTime']));

      // Generate separate strings for dates and values
      // String datesString = stepsData.map((step) => step['dateTime']).join(',');
      String valuesString = stepsData.map((step) => step['value']).join(',');

      // debugPrint('Dates String: $datesString');
      debugPrint('Values String: $valuesString');

      // return {'dates': datesString, 'values': valuesString};

      // Map<String, dynamic> responseData1 = json.decode(response.body);
      // int stepup = responseData1['summary']['steps'];
      // // fitnessData.steps = stepup.toString();
      // fitnessData.caloriesBurned =
      //     responseData1['summary']['caloriesOut'].toString();
      // fitnessData.caloriesLeft =
      //     responseData1['goals']['caloriesOut'].toString();
      final data =
          await _controller.PostCaloriesBurn7daysDataOfUser(valuesString);
      // _controller.fetchStepsOfToday();
      // //  caloriesburn= responseData1['goals']['steps'];
      // debugPrint('step dat upload $data');
      // if (mounted) {
      //   setState(() {
      //     _steps2 = responseData1['summary']['steps'].toString();
      //     caloriesburn = responseData1['summary']['caloriesOut'];
      //     caloriesburnleft = responseData1['goals']['caloriesOut'];
      //     caloriesburnleft = caloriesburnleft - caloriesburn;
      //   });
      // }

      debugPrint('steps is here ');

      return json.decode(response.body);
    } else {
      debugPrint('response fat ${response.body}');
      throw Exception('Failed to load data');
    }
  }
//update sleep

  Future<Map<String, dynamic>> fetchSleepData() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    String? tokenfit = await TokenManager.getToken();
    String? userIdfit = await TokenManager.getId();

    debugPrint('token and user id is $tokenfit $userIdfit');
    final response = await http.get(
        Uri.parse(
            'https://api.fitbit.com/1.2/user/$userIdfit/sleep/date/$formattedDate.json'),
        headers: {
          'Authorization': 'Bearer $tokenfit',
        });

    if (response.statusCode == 200) {
      debugPrint('response sleep ${response.body}');

      Map<String, dynamic> responseData1 = json.decode(response.body);

      debugPrint(
          'sleep dgggat ${responseData1['summary']['totalMinutesAsleep']} sleepg $responseData1');
      int minutes = responseData1['summary']['totalMinutesAsleep'];

      if (responseData1["sleep"].isNotEmpty) {
        Map<String, dynamic> sleepData = {
          // "id": 2,
          "dateOfSleep": formattedDate,
          "duration": minutes,
          "manualDuration": 0,
          "efficiency": responseData1["sleep"][0]["efficiency"],
          "endTime": responseData1["sleep"][0]["endTime"]
        };
        await _controller.UpdateSleepData(sleepData);
      }

      debugPrint('steps is here ');

      return json.decode(response.body);
    } else {
      debugPrint('response fat ${response.body}');
      throw Exception('Failed to load data');
    }
  }
//7days sleep

  Future<Map<String, dynamic>> fetch7daysSleepData() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');

    // Current date
    var currentDate = formatter.format(now);
    debugPrint('Current Date: $currentDate');

    // Date 7 days ago
    var sevenDaysAgo = now.subtract(const Duration(days: 6));
    var sevenDaysAgoFormatted = formatter.format(sevenDaysAgo);
    debugPrint('Date 7 days ago: $sevenDaysAgoFormatted');
    String? tokenfit = await TokenManager.getToken();
    String? userIdfit = await TokenManager.getId();

    debugPrint('token and user id is $tokenfit $userIdfit');
    final response = await http.get(
        Uri.parse(
            'https://api.fitbit.com/1.2/user/$userIdfit/sleep/date/$sevenDaysAgoFormatted/$currentDate.json'),
        headers: {
          'Authorization': 'Bearer $tokenfit',
        });

    if (response.statusCode == 200) {
      debugPrint(
          'response -$sevenDaysAgo- -$currentDate- dgd7days sleeep $sevenDaysAgo sleep ${response.body}');

      Map<String, dynamic> responseData1 = json.decode(response.body);
      List<dynamic> sleepData = responseData1['sleep'];

      Map<String, dynamic> sleepMap = {};

      for (var entry in sleepData) {
        String dateOfSleep = entry['dateOfSleep'];
        int duration = entry['duration'];
        int efficiency = entry['efficiency'];
        int minutesAsleep = entry['minutesAsleep'];

        if (sleepMap.containsKey(dateOfSleep)) {
          // If the date already exists in the map, update the values
          // sleepMap[dateOfSleep]['totalSleep'] += duration;
          sleepMap[dateOfSleep]['totalEfficiency'] += efficiency;
          sleepMap[dateOfSleep]['totalMinutesAsleep'] += minutesAsleep;
          // sleepMap[dateOfSleep]['count'] += 1;
        } else {
          // If the date doesn't exist, create a new entry in the map
          sleepMap[dateOfSleep] = {
            // 'totalSleep': duration,
            'totalEfficiency': efficiency,
            'totalMinutesAsleep': minutesAsleep,
            // 'count': 1,
          };
        }
      }

      debugPrint('sleep data  mfgf  $sleepMap');
      await _controller.PostSleep7daysDataOfUser(sleepMap);
      return json.decode(response.body);
    } else {
      debugPrint('response fat ${response.body}');
      debugPrint(
          'response -$sevenDaysAgo- -$currentDate- dgd7days sleeep $sevenDaysAgo sleep ${response.body}');
      throw Exception('Failed to load data');
    }
  }
//7days sleep

  Future<Map<String, dynamic>> fetch7daysHeartRateData() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');

    // Current date
    var currentDate = formatter.format(now);
    debugPrint('Current Date: $currentDate');

    // Date 7 days ago
    var sevenDaysAgo = now.subtract(const Duration(days: 6));
    var sevenDaysAgoFormatted = formatter.format(sevenDaysAgo);
    debugPrint('Date 7 days ago: $sevenDaysAgoFormatted');
    String? tokenfit = await TokenManager.getToken();
    String? userIdfit = await TokenManager.getId();

    debugPrint('token and user id is $tokenfit $userIdfit');
    final response = await http.get(
        Uri.parse(
            'https://api.fitbit.com/1/user/$userIdfit/activities/heart/date/$sevenDaysAgoFormatted/$currentDate.json'),
        headers: {
          'Authorization': 'Bearer $tokenfit',
        });

    if (response.statusCode == 200) {
      debugPrint(
          'response -$sevenDaysAgo- -$currentDate- dgd7days sleeep $sevenDaysAgo sleep ${response.body}');

      Map<String, dynamic> responseData1 = json.decode(response.body);
      List<dynamic> heartRateData = responseData1['activities-heart'];

      Map<String, dynamic> restingHeartRateMap = {};

      for (var entry in heartRateData) {
        String dateTime = entry['dateTime'];
        int restingHeartRate = entry['value']['restingHeartRate'] ?? 0;

        // Only add to the map if restingHeartRate is not null
        restingHeartRateMap[dateTime] = restingHeartRate;
            }

      debugPrint('sleep data  mfggf  $restingHeartRateMap');
      await _controller.PostRestingHeartRate7daysDataOfUser(
          restingHeartRateMap);
      return json.decode(response.body);
    } else {
      debugPrint('response fat ${response.body}');
      debugPrint(
          'response -$sevenDaysAgo- -$currentDate- dgd7days sleeep $sevenDaysAgo sleep ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  //herat rate

  Future<Map<String, dynamic>> HeartRate() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    String? tokenfit = await TokenManager.getToken();
    String? userIdfit = await TokenManager.getId();
    debugPrint('token and user id is $tokenfit $userIdfit');
    final response = await http.get(
        Uri.parse(
            'https://api.fitbit.com/1/user/$userIdfit/activities/heart/date/today/1d.json'),
        headers: {
          'Authorization': 'Bearer $tokenfit',
        });

    if (response.statusCode == 200) {
      debugPrint('resgfggponse fat ${response.body}');

      Map<String, dynamic> responseData1 = json.decode(response.body);

      debugPrint('sleep dat upload $responseData1');

      if (responseData1["activities-heart"][0]["value"]["restingHeartRate"] !=
          null) {
        String HeartRateData = responseData1["activities-heart"][0]["value"]
                ["restingHeartRate"]
            .toString();
        fitnessData.heartRate = HeartRateData;
        debugPrint('Heart Rate is here $responseData1   $HeartRateData');
      }

      return json.decode(response.body);
    } else {
      debugPrint('respogfhfjhfjhnse fat ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> SpO2() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    String? tokenfit = await TokenManager.getToken();
    String? userIdfit = await TokenManager.getId();
    debugPrint('token and user id is $tokenfit $userIdfit');
    final response = await http.get(
        Uri.parse(
            'https://api.fitbit.com/1/user/$userIdfit/spo2/date/today.json'),
        headers: {
          'Authorization': 'Bearer $tokenfit',
        });
//   /1/user/$userIdfit/spo2/date/today/all.json
    if (response.statusCode == 200) {
      debugPrint('resgfggpfnjhfgjhnfjfgjgfjfgjonse fat ${response.body}');

      // Map<String, dynamic> responseData1 = json.decode(response.body);

      // debugPrint('sleep dat upload $responseData1');

      // if (responseData1["activities-heart"][0]["value"]["restingHeartRate"] !=
      //     null) {
      //   String HeartRateData = responseData1["activities-heart"][0]["value"]
      //           ["restingHeartRate"]
      //       .toString();
      //   debugPrint('Heart Rate is here $responseData1   $HeartRateData');
      // }

      return json.decode(response.body);
    } else {
      debugPrint('respogfhfjhfjhnse fat ${response.body}');
      throw Exception('Failed to load data');
    }
  }
}
