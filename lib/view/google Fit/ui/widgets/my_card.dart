import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/view/google%20Fit/models/blood_glucose.dart';

class MyCard extends StatelessWidget {
  final BloodGlucose bloodGlucose;

  const MyCard({super.key, required this.bloodGlucose});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              bloodGlucose.value
                  .toStringAsFixed(bloodGlucose.value >= 99 ? 0 : 2),
              style: const TextStyle(fontSize: AppFontSizes.largeDefault)),
          Text(bloodGlucose.unit),
          Text(bloodGlucose.dateFrom.toString()),
        ],
      ),
    );
  }
}
