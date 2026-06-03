import 'package:health/health.dart';
import 'package:nin2byo2i/Repository/TokenManagerforWatch.dart';
import 'package:nin2byo2i/view/google%20Fit/models/blood_glucose.dart';

class HealthRepository {
  final Health health = Health();
  bool requested = false;
  makeAccess() async {
    requested = await health.requestAuthorization(
      [
        HealthDataType.HEART_RATE,
        HealthDataType.BLOOD_GLUCOSE,
        HealthDataType.STEPS,
        HealthDataType.BODY_TEMPERATURE,
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataType.SLEEP_AWAKE,
        HealthDataType.SLEEP_ASLEEP,
      ],
      permissions: [
        HealthDataAccess.READ,
        HealthDataAccess.READ,
        HealthDataAccess.READ,
        HealthDataAccess.READ,
        HealthDataAccess.READ,
        HealthDataAccess.READ,
        HealthDataAccess.READ,
      ],
    );
    if (!requested) {
      throw Exception;
    }
  }

  Future<List<BloodGlucose>> getBloodGlucose() async {
    if (requested) {
      // getCurrentDateSteps();
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          types: [HealthDataType.BLOOD_GLUCOSE],
          startTime: DateTime.now().subtract(const Duration(days: 7)),
          endTime: DateTime.now());

      return healthData.map((e) {
        var b = e;
        print(b.value);
        return BloodGlucose(
          double.parse(b.value.toString()),
          b.unitString,
          b.dateFrom,
          b.dateTo,
        );
      }).toList();
    }
    return [];
  }

  Future<int?> getCurrentDateSteps() async {
    if (requested) {
      var now = DateTime.now();
      var midnight = DateTime(now.year, now.month, now.day);

      int? steps = await health.getTotalStepsInInterval(midnight, now);
      print("total steps is:$steps");
      return steps;
    }

    return null;
  }

  // Future<List<int>> get7DaysSteps() async {
  //   if (requested) {
  //     var now = DateTime.now();
  //     var midnight = DateTime(now.year, now.month, now.day);

  //     // Calculate start date 7 days ago
  //     var startDate = midnight.subtract(const Duration(days: 7));

  //     // Get steps data for the last 7 days
  //     List<int> stepsData = [];
  //     for (var i = 0; i < 7; i++) {
  //       // Calculate end date for each day
  //       var endDate = midnight.add(Duration(days: i));

  //       // Get total steps for each day
  //       int? steps = await health.getTotalStepsInInterval(startDate, endDate);
  //       stepsData.add(steps ?? 0); // If steps are null, add 0
  //     }

  //     print("Steps for last 7 days: $stepsData");
  //     return stepsData;
  //   }

  //   return [];
  // }

  Future<double?> getTodayCaloriesBurn() async {
    if (requested) {
      var now = DateTime.now();
      var midnight = DateTime(now.year, now.month, now.day);

      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        types: [HealthDataType.ACTIVE_ENERGY_BURNED],
        startTime: midnight,
        endTime: now,
      );

      double totalActiveEnergy = healthData
          .map((data) => double.parse(data.value.toString()))
          .fold(0.0, (prev, value) => prev + value);

      print("Total Active Energy Burned: $totalActiveEnergy");
      return totalActiveEnergy;
    }

    return null;
  }

  Future<double?> getBodyTemperature() async {
    if (requested) {
      var now = DateTime.now();
      var midnight = DateTime(now.year, now.month, now.day);

      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        types: [HealthDataType.BODY_TEMPERATURE],
        startTime: midnight,
        endTime: now,
      );

      double? bodyTemperature = healthData.isNotEmpty
          ? double.parse(healthData.first.value.toString())
          : null;

      print("Body Temperature: $bodyTemperature");
      return bodyTemperature;
    }

    return null;
  }

  Future<int?> getHeartRate() async {
    if (requested) {
      var now = DateTime.now();
      var midnight = DateTime(now.year, now.month, now.day);

      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        types: [HealthDataType.HEART_RATE],
        startTime: midnight,
        endTime: now,
      );

      int? heartRate = healthData.isNotEmpty
          ? int.parse(healthData.first.value.toString())
          : null;

      print("Heart Rate: $heartRate $healthData");
      return heartRate;
    }

    return null;
  }

  Future<Map<String, int>> get7DaysSleepData() async {
    Map<String, int> sleepMap = {};

    if (requested) {
      var now = DateTime.now();
      var midnight = DateTime(now.year, now.month, now.day);

      // Calculate start date 7 days ago
      var startDate = midnight.subtract(
          const Duration(days: 6)); // Adjusted to 6 days ago for 7-day data

      // Iterate through each day for the last 7 days
      for (var i = 0; i < 7; i++) {
        // Calculate the date for the current iteration
        var currentDate = startDate.add(Duration(days: i));

        // Get sleep data for the current day
        List<HealthDataPoint> sleepData = await health.getHealthDataFromTypes(
          types: [
            HealthDataType.SLEEP_AWAKE,
            HealthDataType.SLEEP_ASLEEP,
            // Add other sleep data types if needed
          ],
          startTime: currentDate,
          endTime: currentDate.add(const Duration(days: 1)),
        );

        // Calculate total sleep duration for the day
        double totalSleep = 0;
        for (var data in sleepData) {
          totalSleep += double.parse(data.value.toString());
        }

        // Format the date as yyyy-MM-dd
        String formattedDate =
            "${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";

        // Add sleep data to the map
        sleepMap[formattedDate] = totalSleep.toInt();
      }

      print("Sleep data for last 7 days: $sleepMap");
    }

    return sleepMap;
  }

  // Future<List<HealthDataPoint>> getSleepData() async {
  //   if (requested) {
  //     List<HealthDataPoint> sleepData = await health.getHealthDataFromTypes(
  //       DateTime.now().subtract(const Duration(days: 7)),
  //       DateTime.now(),
  //       [
  //         HealthDataType.SLEEP_AWAKE,
  //         HealthDataType.SLEEP_ASLEEP,
  //         // HealthDataType.SLEEP_LIGHT,
  //         // HealthDataType.SLEEP_DEEP,
  //         // HealthDataType.SLEEP_REM,
  //         // HealthDataType.SLEEP_SESSION,
  //       ],
  //     );

  //     // You can print or process sleep data as needed
  //     print(" nbm,j..m/m/.$sleepData");
  //     sleepData.forEach((data) {
  //       print(" nbm,j..m/m/.${data.type} - ${data.value} - ${data.dateFrom}");
  //     });

  //     return sleepData;
  //   }
  //   return [];
  // }

  Future<String> get7DaysStepsAsString() async {
    String stepsString = "";

    if (requested) {
      var now = DateTime.now();
      var midnight = DateTime(now.year, now.month, now.day);

      // Calculate start date 7 days ago
      var startDate = midnight.subtract(
          const Duration(days: 6)); // Adjusted to 6 days ago for 7-day data

      // Iterate through each day for the last 7 days
      for (var i = 0; i < 7; i++) {
        // Calculate the date for the current iteration
        var currentDate = startDate.add(Duration(days: i));

        // Get steps data for the current day
        int? steps = await health.getTotalStepsInInterval(
            currentDate, currentDate.add(const Duration(days: 1)));

        // Add steps data to the string with comma separation
        stepsString += "${steps ?? 0},";
      }

      // Remove the trailing comma
      stepsString = stepsString.isNotEmpty
          ? stepsString.substring(0, stepsString.length - 1)
          : stepsString;

      print("Steps for last 7 days: $stepsString");
    }

    return stepsString;
  }

  // Future<List<int>> get7DaysSteps() async {
  //   if (requested) {
  //     var now = DateTime.now();
  //     var midnight = DateTime(now.year, now.month, now.day);

  //     // Calculate start date 7 days ago
  //     var startDate = midnight.subtract(const Duration(days: 7));

  //     // Get steps data for the last 7 days
  //     List<int> stepsData = [];
  //     for (var i = 0; i < 7; i++) {
  //       // Calculate end date for each day
  //       var endDate = midnight.add(Duration(days: i));

  //       // Get total steps for each day
  //       int? steps = await health.getTotalStepsInInterval(startDate, endDate);
  //       stepsData.add(steps ?? 0); // If steps are null, add 0
  //     }

  //     print("Steps for last 7 days: $stepsData");
  //     return stepsData;
  //   }

  //   return [];
  // }

  // Future<List<double>> get7DaysCaloriesBurn() async {
  //   if (requested) {
  //     var now = DateTime.now();
  //     var midnight = DateTime(now.year, now.month, now.day);

  //     // Calculate start date 7 days ago
  //     var startDate = midnight.subtract(const Duration(days: 7));

  //     // Get calories burned data for the last 7 days
  //     List<double> caloriesData = [];
  //     for (var i = 0; i < 7; i++) {
  //       // Calculate end date for each day
  //       var endDate = midnight.add(Duration(days: i));

  //       // Get active energy burned for each day
  //       List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
  //         startDate,
  //         endDate,
  //         [HealthDataType.ACTIVE_ENERGY_BURNED],
  //       );

  //       double totalActiveEnergy = healthData
  //           .map((data) => double.parse(data.value.toString()))
  //           .fold(0.0, (prev, value) => prev + value);

  //       caloriesData.add(totalActiveEnergy);
  //     }

  //     print("Calories burned for last 7 days: $caloriesData");
  //     return caloriesData;
  //   }

  //   return [];
  // }
  Future<String> get7DaysCaloriesBurnAsString() async {
    String caloriesString = "";

    if (requested) {
      var now = DateTime.now();
      var midnight = DateTime(now.year, now.month, now.day);

      // Calculate start date 7 days ago, adjusted to start from 12 AM
      var startDate = midnight.subtract(const Duration(days: 6)).subtract(
          Duration(
              hours: midnight.hour,
              minutes: midnight.minute,
              seconds: midnight.second,
              milliseconds: midnight.millisecond,
              microseconds: midnight.microsecond));

      // Iterate through each day for the last 7 days
      for (var i = 0; i < 7; i++) {
        // Calculate the start and end dates for the current iteration
        var currentDateStart = startDate.add(Duration(days: i));
        var currentDateEnd = currentDateStart.add(const Duration(days: 1));

        // Get calories burned data for the current day
        List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          types: [HealthDataType.ACTIVE_ENERGY_BURNED],
          startTime: currentDateStart,
          endTime: currentDateEnd,
        );

        // Calculate total active energy burned for the day
        double totalActiveEnergy = 0;
        for (var dataPoint in healthData) {
          totalActiveEnergy += double.parse(dataPoint.value.toString());
        }

        // Add calories burned data to the string with comma separation
        caloriesString +=
            "${totalActiveEnergy.toInt()},"; // Assuming you want total active energy burned
      }

      // Remove the trailing comma
      caloriesString = caloriesString.isNotEmpty
          ? caloriesString.substring(0, caloriesString.length - 1)
          : caloriesString;

      print(
          "Calories burned for last 7 days starting from 12 AM: $caloriesString");
    }

    return caloriesString;
  }

  Future<Map<String, int>> get7DaysHeartRate() async {
    Map<String, int> heartRateMap = {};

    if (requested) {
      var now = DateTime.now();
      var midnight = DateTime(now.year, now.month, now.day);

      // Calculate start date 7 days ago
      var startDate = midnight.subtract(
          const Duration(days: 6)); // Adjusted to 6 days ago for 7-day data

      // Iterate through each day for the last 7 days
      for (var i = 0; i < 7; i++) {
        // Calculate the date for the current iteration
        var currentDate = startDate.add(Duration(days: i));

        // Get heart rate data for the current day
        List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          types: [HealthDataType.HEART_RATE],
          startTime: currentDate,
          endTime: currentDate.add(const Duration(days: 1)),
        );

        // Extract heart rate value from the data points
        // int heartRate = healthData.isNotEmpty
        //     ? int.parse(healthData.first.value.toString())
        //     : 0;
        int heartRate = healthData.isNotEmpty
            ? double.parse(healthData.first.value.toString()).toInt()
            : 0; // or any default value you prefe

        // Format the date as yyyy-MM-dd
        String formattedDate =
            "${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";

        // Add heart rate data to the map
        heartRateMap[formattedDate] = heartRate;
      }

      print("Heart rate for last 7 days: $heartRateMap");
    }

    return heartRateMap;
  }

  // Future<HealthDataPoint?> getLastSleepDataPoint() async {
  Future<String> getLast24HoursSleepData() async {
    if (requested) {
      // Get the current time
      var now = DateTime.now();

      // Set the start time to 12:00 PM of the previous day
      var startDateTime = DateTime(now.year, now.month, now.day - 1, 12, 0, 0);

      // Set the end time to 12:00 PM of the current day
      var endDateTime = DateTime(now.year, now.month, now.day, 12, 0, 0);

      List<HealthDataPoint> sleepData = await health.getHealthDataFromTypes(
        types: [
          HealthDataType.SLEEP_AWAKE,
          HealthDataType.SLEEP_ASLEEP,
          // HealthDataType.SLEEP_LIGHT,
          // HealthDataType.SLEEP_DEEP,
          // HealthDataType.SLEEP_REM,
          // HealthDataType.SLEEP_SESSION,
        ],
        startTime: startDateTime,
        endTime: endDateTime,
      );
      double totalSleep = 0;
      // You can print or process sleep data as needed
      // print(" nbm,j..m/m/.$sleepData");
      for (var data in sleepData) {
        totalSleep = double.parse(data.value.toString()) + totalSleep;
        print(" nbm,j..m/m/.${data.type} - ${data.value} - ${data.dateFrom}");
      }
      int hours = (totalSleep / 60).floor();
      int remainingMinutes = (totalSleep % 60).round();

      return "$hours h $remainingMinutes min";
      // return sleepData;
    }
    return "0";
  }

  // Future<List<HealthDataPoint>> getLast24HoursSleepData() async {
  //   if (requested) {
  //     // Get the current time
  //     var now = DateTime.now();

  //     // Set the start time to 12:00 PM of the previous day
  //     var startDateTime = DateTime(now.year, now.month, now.day - 1, 12, 0, 0);

  //     // Set the end time to 12:00 PM of the current day
  //     var endDateTime = DateTime(now.year, now.month, now.day, 12, 0, 0);

  //     List<HealthDataPoint> sleepData = await health.getHealthDataFromTypes(
  //       startDateTime,
  //       endDateTime,
  //       [
  //         HealthDataType.SLEEP_AWAKE,
  //         HealthDataType.SLEEP_ASLEEP,
  //         // HealthDataType.SLEEP_LIGHT,
  //         // HealthDataType.SLEEP_DEEP,
  //         // HealthDataType.SLEEP_REM,
  //         // HealthDataType.SLEEP_SESSION,
  //       ],
  //     );

  //     // You can print or process sleep data as needed
  //     print(" nbm,j..m/m/.$sleepData");
  //     sleepData.forEach((data) {
  //       print(" nbm,j..m/m/.${data.type} - ${data.value} - ${data.dateFrom}");
  //     });

  //     return sleepData;
  //   }
  //   return [];
  // }

  // Future<List<HealthDataPoint>> getTodaySleepData() async {
  //   if (requested) {
  //     // Get the start and end of the current day
  //     var now = DateTime.now();
  //     var startOfDay = DateTime(now.year, now.month, now.day);
  //     var endOfDay = startOfDay.add(Duration(days: 1));

  //     List<HealthDataPoint> sleepData = await health.getHealthDataFromTypes(
  //       startOfDay,
  //       endOfDay,
  //       [
  //         HealthDataType.SLEEP_AWAKE,
  //         HealthDataType.SLEEP_ASLEEP,
  //         // HealthDataType.SLEEP_LIGHT,
  //         // HealthDataType.SLEEP_DEEP,
  //         // HealthDataType.SLEEP_REM,
  //         // HealthDataType.SLEEP_SESSION,
  //       ],
  //     );

  //     // You can print or process sleep data as needed
  //     print(" nbm,j..m/m/.$sleepData");
  //     sleepData.forEach((data) {
  //       print(" nbm,j..m/m/.${data.type} - ${data.value} - ${data.dateFrom}");
  //     });

  //     return sleepData;
  //   }
  //   return [];
  // }
}


/*
/ create a HealthFactory for use in the app
    final health = HealthFactory(useHealthConnectIfAvailable: false);

    // define the types to get
    var types = [
      HealthDataType.WEIGHT,
      HealthDataType.STEPS,
      HealthDataType.HEIGHT,
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.WORKOUT,
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    ];

    // requesting access to the data types before reading them
    bool requested = await health.requestAuthorization(types);

    var now = DateTime.now();

    // fetch health data from the last 24 hours
    List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        now.subtract(const Duration(days: 1)), now, types);

    // request permissions to write steps and blood glucose
    var permissions = types.map((e) => HealthDataAccess.READ_WRITE).toList();

    await health.requestAuthorization(types, permissions: permissions);

    // write steps and blood glucose
    bool success =
        await health.writeHealthData(10, HealthDataType.BLOOD_OXYGEN, now, now);
    success = await health.writeHealthData(
        3.1, HealthDataType.BLOOD_GLUCOSE, now, now);

    // get the number of steps for today
    var midnight = DateTime(now.year, now.month, now.day);
    int? steps = await health.getTotalStepsInInterval(midnight, now);
    print(healthData);
*/