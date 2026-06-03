import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//SLeep screen
class SleepDataPage extends StatefulWidget {
  const SleepDataPage({super.key});

  @override
  _SleepDataPageState createState() => _SleepDataPageState();
}

class _SleepDataPageState extends State<SleepDataPage> {
  Map<String, double> daywiseSleepData = {};
  final UserProfileController _controller = UserProfileController();
  int touchedIndex = -1;
  @override
  void initState() {
    super.initState();
    // Call the function to get daywise sleep data when the page is created
    fetchDaywiseSleepData();
  }

  Future<void> fetchDaywiseSleepData() async {
    try {
      // Assuming you have a function named getDaywiseSleepData that fetches data
      final data = await _controller.getDaywiseSleepData();
      // Map<String, double> data = await getDaywiseSleepData();
      setState(() {
        daywiseSleepData = data;
      });
    } catch (e) {
      // Handle errors, such as displaying an error message to the user
      debugPrint('Error fetching daywise sleep data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Data'),
      ),
      body: Center(
        child: daywiseSleepData.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Daywise Sleep Data:'),
                  // Display the data in a ListView or any other widget based on your UI design
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: daywiseSleepData.length,
                    itemBuilder: (context, index) {
                      String day = daywiseSleepData.keys.elementAt(index);
                      double hours = daywiseSleepData[day] ?? 0.0;
                      return ListTile(
                        title: Text('$day: $hours hours'),
                      );
                    },
                  ),
                  Container(
                    height: media.width * 0.5,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                    decoration: BoxDecoration(
                        color: ThemeManager.themeColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 3)
                        ]),
                    child: BarChart(BarChartData(
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.grey,
                          tooltipHorizontalAlignment:
                              FLHorizontalAlignment.right,
                          tooltipMargin: 10,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            String weekDay;
                            switch (group.x) {
                              case 0:
                                weekDay = 'Monday';
                                break;
                              case 1:
                                weekDay = 'Tuesday';
                                break;
                              case 2:
                                weekDay = 'Wednesday';
                                break;
                              case 3:
                                weekDay = 'Thursday';
                                break;
                              case 4:
                                weekDay = 'Friday';
                                break;
                              case 5:
                                weekDay = 'Saturday';
                                break;
                              case 6:
                                weekDay = 'Sunday';
                                break;
                              default:
                                throw Error();
                            }
                            return BarTooltipItem(
                              '$weekDay\n',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSizes.mediumDefault,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: (rod.toY - 1).toString(),
                                  style: TextStyle(
                                    color: ThemeManager.themeColor,
                                    fontSize: AppFontSizes.mediumDefault,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        touchCallback: (FlTouchEvent event, barTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                barTouchResponse == null ||
                                barTouchResponse.spot == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex =
                                barTouchResponse.spot!.touchedBarGroupIndex;
                          });
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
                            getTitlesWidget: getTitles,
                            reservedSize: 38,
                          ),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: showingGroups(),
                      gridData: const FlGridData(show: false),
                    )),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    var style = TextStyle(
      color: TColor.gray,
      fontWeight: FontWeight.w500,
      fontSize: AppFontSizes.smallDefault,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Sun', style: style);
        break;
      case 1:
        text = Text('Mon', style: style);
        break;
      case 2:
        text = Text('Tue', style: style);
        break;
      case 3:
        text = Text('Wed', style: style);
        break;
      case 4:
        text = Text('Thu', style: style);
        break;
      case 5:
        text = Text('Fri', style: style);
        break;
      case 6:
        text = Text('Sat', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        debugPrint("data is here $daywiseSleepData ${daywiseSleepData['TUESDAY']}");
        switch (i) {
          case 0:
            return makeGroupData(
                0, daywiseSleepData['MONDAY'] ?? 0, TColor.primaryG,
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1,
                daywiseSleepData['TUESDAY']?.toDouble() ?? 0, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(
                2, daywiseSleepData['WEDNESDAY'] ?? 0, TColor.primaryG,
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(
                3, daywiseSleepData['THURSDAY'] ?? 0, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(
                4, daywiseSleepData['FRIDAY'] ?? 0, TColor.primaryG,
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(
                5, daywiseSleepData['SATURDAY'] ?? 0, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(
                6, daywiseSleepData['SUNDAY'] ?? 0, TColor.primaryG,
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });
  BarChartGroupData makeGroupData(
    int x,
    double y,
    List<Color> barColor, {
    bool isTouched = false,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          gradient: LinearGradient(
              colors: barColor,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          width: width,
          borderSide: isTouched
              ? const BorderSide(color: Colors.green)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: ThemeManager.themelightColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
}

// Include the getDaywiseSleepData function here or import it from where it's defined
