import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

//custoim pie chart here
class PieChartSample2 extends StatefulWidget {
  final double value1;
  final double value2;
  final double value3;

  const PieChartSample2(
      {Key? key,
      required this.value1,
      required this.value2,
      required this.value3})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State(value1, value2, value3);
}

class PieChart2State extends State<PieChartSample2> {
  double value1;
  double value2;
  double value3;
  int touchedIndex = -1;

  PieChart2State(this.value1, this.value2, this.value3);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.7,
          child: Row(
            children: <Widget>[
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(value1, value2, value3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections(
      double value1, double value2, double value3) {
    double total = value1 + value2 + value3;
    double percent1 = (value1 / total) * 100;
    double percent2 = (value2 / total) * 100;
    double percent3 = (value3 / total) * 100;

    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xffdd123d),
            value: percent1,
            title: '${percent1.toStringAsFixed(1)}%',
            radius: radius + 15,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
              decoration: TextDecoration.none,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color.fromARGB(255, 34, 104, 161),
            value: percent2,
            title: '${percent2.toStringAsFixed(1)}%',
            radius: radius + 5,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
              decoration: TextDecoration.none,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFFFF9900),
            value: percent3,
            title: '${percent3.toStringAsFixed(1)}%',
            radius: radius + 10,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
              decoration: TextDecoration.none,
            ),
          );

        default:
          throw Error();
      }
    });
  }
}
