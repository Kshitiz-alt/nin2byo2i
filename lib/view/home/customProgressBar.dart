import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';

//custom progress bar
class MvfdbfdbfgbyApp extends StatelessWidget {
  const MvfdbfdbfgbyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrient Values',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Nutrient Values'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NutrientTable(),
        ),
      ),
    );
  }
}

class NutrientTable extends StatelessWidget {
  final List<Map<String, dynamic>> nutrients = const [
    {'Nutrient': 'Protein', 'Value': '20g', 'Percentage': 50.0, 'ear': '20g'},
    {
      'Nutrient': 'Carbohydrates',
      'Value': '30g',
      'Percentage': 75.0,
      'ear': '20g'
    },
    {'Nutrient': 'Fat', 'Value': '15g', 'Percentage': 120.0, 'ear': '20g'},
    // Add more nutrients here
  ];

  const NutrientTable({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];

    for (final nutrient in nutrients) {
      rows.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
              width: 2,
            ),
            color: Colors.grey.withOpacity(0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 80, // Adjust the width according to your needs
                child: Text(nutrient['Nutrient']),
              ),
              SizedBox(
                width: 40, // Adjust the width according to your needs
                child: Text(nutrient['Value']),
              ),
              SizedBox(
                width: 40, // Adjust the width according to your needs
                child: Text(nutrient['ear']),
              ),
              SizedBox(
                width: 150, // Adjust the width according to your needs
                child: Row(
                  children: [
                    MyHorizontalProgressBar(
                      percentage: nutrient['Percentage'],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            color: Colors.green,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 80,
                child: const Text('Nutrient'),
              ),
              SizedBox(
                width: 40,
                child: const Text('Value'),
              ),
              SizedBox(
                width: 40,
                child: const Text('Ear'),
              ),
              SizedBox(
                width: 150,
                child: const Text('Percentage'),
              ),
            ],
          ),
        ),
        // SizedBox(height: 10), // Add some spacing between header and data
        Column(
          children: rows,
        ),
      ],
    );
  }
}

class MyHorizontalProgressBar extends StatelessWidget {
  final double percentage;

  const MyHorizontalProgressBar({Key? key, required this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double blueWidth = percentage <= 100 ? percentage : 100;
    double orangeWidth =
        percentage > 100 ? ((percentage - 100) / 100) * 200 : 0;
    Color backColorIs = Colors.white;
    if (orangeWidth > 0) {
      backColorIs = Colors.orange;
    }
    if (orangeWidth > 100) {
      //   backColorIs = Colors.orange;
      orangeWidth = 100;
    }
    return Container(
      width: 104 / 2 +
          ((orangeWidth != 0
              ? (orangeWidth / 2) > 20
                  ? 24
                  : (orangeWidth / 2) + 8
              : 0)),
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        color: backColorIs,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: <Widget>[
              Container(
                width: blueWidth / 2,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 87, 171, 240),
                ),
              ),
              Center(
                child: Text(
                  '${percentage.toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: ThemeManager.themeText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (orangeWidth > 0)
            Container(
              width: (orangeWidth / 2) > 20
                  ? 20
                  : ((orangeWidth / 2) > 100 ? 100 : (orangeWidth / 2)),
              decoration: const BoxDecoration(
                color: Colors.orange,
              ),
            )
        ],
      ),
    );
  }
}
