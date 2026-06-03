class MenstrualCycle {
  List<int> calculatedDate;
  List<int> lastPeriodStartDate;
  int averageCycleLength;

  MenstrualCycle({
    required this.calculatedDate,
    required this.lastPeriodStartDate,
    required this.averageCycleLength,
  });

  factory MenstrualCycle.fromJson(Map<String, dynamic> json) {
    return MenstrualCycle(
      calculatedDate: List<int>.from(json['calculatedDate']),
      lastPeriodStartDate: List<int>.from(json['lastPeriodStartDate']),
      averageCycleLength: json['averageCycleLength'],
    );
  }
}
