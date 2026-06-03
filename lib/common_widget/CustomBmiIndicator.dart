import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CustomBmiIndicator extends StatelessWidget {
  const CustomBmiIndicator({
    Key? key,
    required this.bmiValue,
  }) : super(key: key);

  final double bmiValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120, // Adjust the width of the gauge
      height: 120, // Adjust the height of the gauge
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 50,
            ranges: <GaugeRange>[
              GaugeRange(startValue: 0, endValue: 18.5, color: Colors.green),
              GaugeRange(
                  startValue: 18.5, endValue: 24.9, color: Colors.yellow),
              GaugeRange(
                  startValue: 24.9, endValue: 29.9, color: Colors.orange),
              GaugeRange(startValue: 29.9, endValue: 50, color: Colors.red),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: bmiValue,
                enableAnimation: true,
                needleLength: 0.3, // Adjust needle length (0.0 to 1.0)
              )
            ],
          )
        ],
      ),
    );
  }
}
