import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

//custom piechar page
class PieChartPage extends StatefulWidget {
  const PieChartPage({super.key});

  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  TextEditingController activityController = TextEditingController();
  TextEditingController othersController = TextEditingController();

  Map<String, double> dataMap = {
    'Activity': 14,
    'Others': 10,
  };

  List<Color> colorList = [
    Colors.blue,
    Colors.green,
  ];

  void updateDataMap() {
    setState(() {
      double activityHours = double.tryParse(activityController.text) ?? 0;
      double othersHours = double.tryParse(othersController.text) ?? 0;

      dataMap['Activity'] = activityHours;
      dataMap['Others'] = othersHours;
    });
  }

  @override
  void dispose() {
    activityController.dispose();
    othersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circular Graph Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                controller: activityController,
                decoration: const InputDecoration(labelText: 'Activity (hours)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => updateDataMap(),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                controller: othersController,
                decoration: const InputDecoration(labelText: 'Others (hours)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => updateDataMap(),
              ),
            ),
            const SizedBox(height: 20),
            PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width / 2.7,
              colorList: colorList,
              initialAngleInDegree: 0,
              chartType: ChartType.disc,
              ringStrokeWidth: 32,
              centerText:
                  "Total\n${(dataMap['Activity']! + dataMap['Others']!).toStringAsFixed(1)} hours",
              legendOptions: const LegendOptions(
                showLegendsInRow: true,
                legendPosition: LegendPosition.bottom,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
