import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';

//custom graph page
class LineChartSample2 extends StatefulWidget {
  final List<FlSpot> allSpots;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  final String valuetype;
  final Map<int, String> keyValuePairs;

  const LineChartSample2({super.key, 
    required this.allSpots,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required this.valuetype,
    required this.keyValuePairs,
  });

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Colors.red,
    Colors.blue,
  ];

  bool showAvg = false;
  // Map<int, String> keyValuePairs = {
  //   1: 'value1',
  //   10: 'value2',
  //   4: 'value3',
  // };
  int casevalue = 10;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.valuetype == "KG") {
      casevalue = 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 0,
            ),
            child: LineChart(
              // showAvg ? avgData() : mainData(),
              mainData(),
            ),
          ),
        ),
        // SizedBox(
        //   width: 60,
        //   height: 34,
        //   child: TextButton(
        //     onPressed: () {
        //       setState(() {
        //         showAvg = !showAvg;
        //       });
        //     },
        //     child: Text(
        //       'avg',
        //       style: TextStyle(
        //         fontSize: AppFontSizes

        //         color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: AppFontSizes.mediumDefault,
    );
    Widget text;
    if (widget.valuetype == "KG ") {
      switch (value.toInt()) {
        case 122:
          text = Text(Languages.of(context)!.ninTextYearly, style: style);
          break;
        // case 20:
        //   text = const Text('JUN', style: style);
        //   break;
        // case 30:
        //   text = const Text('SEP', style: style);
        //   break;
        default:
          text = const Text('', style: style);
          break;
      }
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: text,
      );
    }
    switch (value.toInt()) {
      case 10:
        //  text =
        //     Text('${Languages.of(context)!.ninTextPreviousdays}', style: style);
        text = const Text('', style: style);
        break;
      // case 20:
      //   text = const Text('JUN', style: style);
      //   break;
      // case 30:
      //   text = const Text('SEP', style: style);
      //   break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: AppFontSizes.mediumDefault,
    );
    String? text = widget.keyValuePairs[value.toInt()];

    if (text == null) {
      return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  String convertMinutesToHoursMinutes(double minutes) {
    if (widget.valuetype != "minutes") {
      return '$minutes ${widget.valuetype}';
    }
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes.toInt() % 60;
    String hoursString = (hours > 0) ? '${hours}h ' : '';
    String minutesString = '${remainingMinutes}m';
    return '$hoursString$minutesString';
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.grey,
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              final flSpot = touchedSpot;

              // Formatting the value to end with minutes
              final formattedValue =
                  '${convertMinutesToHoursMinutes(flSpot.y.toDouble())} ';

              return LineTooltipItem(
                formattedValue,
                const TextStyle(color: Colors.white),
              );
            }).toList();
          },
        ),
        // touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        //   show: true,
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white12,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          // top: BorderSide(color: const Color(0xff37434d)),
          left: BorderSide(width: 3.0, color: Color(0xff37434d)),
          bottom: BorderSide(width: 3.0, color: Color(0xff37434d)),
          // right: BorderSide(width: 3.0, color: const Color(0xff37434d)),
          // top: BorderSide(width: 3.0, color: const Color(0xff37434d)),
        ),
      ),
      minX: widget.minX,
      maxX: widget.maxX,
      minY: widget.minY,
      maxY: widget.maxY,
      //    minX: -1,
      // maxX: 30,
      // minY: -1,
      // maxY: 11,
      lineBarsData: [
        LineChartBarData(
          spots: widget.allSpots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
