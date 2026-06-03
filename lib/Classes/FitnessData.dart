import 'package:flutter/foundation.dart';

//class for fitness data that is used on many screen
class FitnessData extends ChangeNotifier {
  static FitnessData? _instance;

  factory FitnessData() {
    _instance ??= FitnessData._internal();
    return _instance!;
  }

  FitnessData._internal();

  String _sleepTime = "0 hrs";
  String _sleepTimeFromeWatch = "0 hrs";
  String _sleepGoal = "0";
  String _heartRate = "0";
  String _caloriesBurned = "0";
  String _caloriesBurnedfromwatch = "0";
  String _caloriesBurnedTime = "0";
  String _caloriesLeft = "0";
  String _steps = "0";
  String _totalFoodCalories = "0";
  String _leftFoodCalories = "0";
  String _waterIntakeToday = "0";
  String _waterGoal = "0";
  double __percentage = 0;
  List waterArr = [
    // {"title": "0am", "subtitle": "0 L"},
    // {"title": "0am ", "subtitle": "0 L"},
    // {"title": "0am", "subtitle": "0 L"},
    // {"title": "0am", "subtitle": "0 L"},
    // {"title": "2pm - 4pm", "subtitle": "700ml"},
    // {"title": "4pm - now", "subtitle": "900ml"},
  ];
  String get sleepTime => _sleepTime;
  String get sleepTimeFromeWatch => _sleepTimeFromeWatch;
  String get sleepGoal => _sleepGoal;
  String get heartRate => _heartRate;
  String get caloriesBurned => _caloriesBurned;
  String get caloriesBurnedTime => _caloriesBurnedTime;
  String get caloriesBurnedfromwatch => _caloriesBurnedfromwatch;
  String get caloriesLeft => _caloriesLeft;
  double get caloriesProgressBar {
    double caloriesBurned = double.tryParse(_caloriesBurned) ?? 0;
    double caloriesLeft = double.tryParse(_caloriesLeft) ?? 0;

    if (caloriesLeft == 0) {
      // debugPrint(
      //     "fdsgdfgdfg ${double.parse(_caloriesBurned) / double.parse(_caloriesLeft)}");
      return 100;
    } else {
      // debugPrint("fdsgdfgdfg gfhffgh");
      double progressBarValue =
          caloriesBurned / (caloriesBurned + caloriesLeft);
      return progressBarValue.isNaN ? 100 : progressBarValue * 100;
    }
  }

  String get steps => _steps;
  String get totalFoodCalories => _totalFoodCalories;
  String get leftFoodCalories => _leftFoodCalories;
  String get waterIntakeToday => _waterIntakeToday;
  String get waterGoal => _waterGoal;
  double get percentage => __percentage;
  Map<String, double> data = {
    'Breakfast': 0,
    'Dinner': 0,
    'Lunch': 0,
    'Early Morning': 0,
    'Mid Morning': 0,
    'Evening': 0,
    'Bed Time': 0,
  };

  set percentage(double value) {
    if (value.isNaN) {
      value = 0.0;
      debugPrint('data is respuyjyujyhujonse fdddddddg$value');
    }
    debugPrint('data is respuyjyujyhujonse fdcccccccccccccccccccccccccg$value');

    if ((double.parse(_waterIntakeToday) /
            double.parse(_waterGoal == 0 ? "1" : _waterGoal))
        .isNaN) {
      __percentage = 0;
    } else {
      __percentage = double.parse(_waterIntakeToday) /
          ((double.parse(_waterGoal)) == 0 ? 1 : (double.parse(_waterGoal)));
    }

    debugPrint(
        'data is respuyjyujyhujonse fdcccccccccccccccccccccccccg$__percentage');
    notifyListeners();
  }

  set waterGoal(String value) {
    _waterGoal = value;
    notifyListeners();
  }

  set sleepGoal(String value) {
    _sleepGoal = value;
    notifyListeners();
  }

  set waterIntakeToday(String value) {
    _waterIntakeToday = value;
    notifyListeners();
  }

  set sleepTime(String value) {
    _sleepTime = value;
    notifyListeners();
  }

  set sleepTimeFromeWatch(String value) {
    _sleepTimeFromeWatch = value;
    notifyListeners();
  }

  set heartRate(String value) {
    _heartRate = value;
    notifyListeners();
  }

  set caloriesBurned(String value) {
    _caloriesBurned = value;
    notifyListeners();
  }

  set caloriesBurnedfromwatch(String value) {
    _caloriesBurnedfromwatch = value;
    notifyListeners();
  }

  set caloriesBurnedTime(String value) {
    _caloriesBurnedTime = value;
    notifyListeners();
  }

  set caloriesLeft(String value) {
    _caloriesLeft = value;
    notifyListeners();
  }

  set steps(String value) {
    _steps = value;
    notifyListeners();
  }

  set totalFoodCalories(String value) {
    _totalFoodCalories = value;
    notifyListeners();
  }

  set leftFoodCalories(String value) {
    _leftFoodCalories = value;
    notifyListeners();
  }

  static FitnessData get instance {
    return FitnessData();
  }
}
