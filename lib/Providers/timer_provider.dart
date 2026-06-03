import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerProvider extends ChangeNotifier {
  int _timerDuration = 60;
  Timer? _timer;
  // Duration _remainingTime = const Duration();
  int get timerDuration => _timerDuration;

  // Duration get remainingTime => _remainingTime;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerDuration > 0) {
        _timerDuration--;

        notifyListeners();
      } else {
        stopTimer();
        // _timerDuration = 30;
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    // _remainingTime = const Duration();
    notifyListeners();
  }
}
