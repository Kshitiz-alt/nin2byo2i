import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/view/HealthTrends/BLoodPressurediastolic.dart';
import 'package:nin2byo2i/view/HealthTrends/BloodGlucosSatus.dart';
import 'package:nin2byo2i/view/HealthTrends/BloodPressureScreen.dart';
import 'package:nin2byo2i/view/HealthTrends/SysTolicAndDiastolicBloodpressure.dart';

class BloodStatusBottom extends StatefulWidget {
  const BloodStatusBottom({super.key});

  @override
  _BloodStatusBottomState createState() => _BloodStatusBottomState();
}

class _BloodStatusBottomState extends State<BloodStatusBottom> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> healthData = [
      // Languages.of(context)!.mainlabelSystolicBloodPressure,
      // Languages.of(context)!.mainlabelDiastolicBloodPressure,
      Languages.of(context)!.mainlabelBloodPressure,
      Languages.of(context)!.mainlabelBloodGlucose,
    ];
    return Scaffold(
      backgroundColor: ThemeManager.themeColor,
      body: _getHealthPage(_currentIndex),
      bottomNavigationBar: BottomAppBar(
        color: ThemeManager.themeColor, // Change color as needed
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: healthData.asMap().entries.map((entry) {
              final int index = entry.key;
              final String item = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? Colors.purple
                            : const Color.fromARGB(255, 235, 230, 230),
                        // Change colors as needed
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        item,
                        style: TextStyle(
                          color: _currentIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _getHealthPage(int index) {
    switch (index) {
      case 0:
        return BloodPressurePage();
      // case 1:
      //   return BLoodPressurediastolic();
      case 1:
        return BloodGlucosLevel();

      default:
        return Container();
    }
  }
}
