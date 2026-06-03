import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';

import 'package:nin2byo2i/view/HealthTrends/BloodStatusBottom.dart';
import 'package:nin2byo2i/view/HealthTrends/HeartLevelScreen.dart';
import 'package:nin2byo2i/view/HealthTrends/OxygenLevelScreen.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  int _currentIndex = 0;
  // List<String> _healthData = ["Oxygen", "Blood", "Heart"];

  @override
  Widget build(BuildContext context) {
    List<String> healthData = [
      Languages.of(context)!.TextAppOxygen,
      Languages.of(context)!.TextAppBlood
    ];
    return Scaffold(
      backgroundColor: ThemeManager.themeColor,
      body: _getHealthPage(_currentIndex),
      // body: Column(
      //   children: <Widget>[
      //     CarouselSlider(
      //       options: CarouselOptions(
      //         height: 40.0,
      //         initialPage: _currentIndex,
      //         enlargeCenterPage: true,
      //         onPageChanged: (index, reason) {
      //           setState(() {
      //             _currentIndex = index;
      //           });
      //         },
      //       ),
      //       items: _healthData.map((item) {
      //         return Builder(
      //           builder: (BuildContext context) {
      //             return Container(
      //               width: MediaQuery.of(context).size.width,
      //               child: Center(
      //                 child: Text(
      //                   item,
      //                   style: TextStyle(fontSize: AppFontSizes.largeDefault.0),
      //                 ),
      //               ),
      //             );
      //           },
      //         );
      //       }).toList(),
      //     ),
      //     Expanded(
      //       child: Center(
      //         child: _getHealthPage(_currentIndex),
      //       ),
      //     ),
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: ThemeManager.themeColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        //selectedItemColor: Colors.pink, // Set the color for the selected item
        unselectedItemColor: ThemeManager.themeText,
        items: healthData.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: TColor.primaryColor1,
            ),
            label: item,
          );
        }).toList(),
      ),
    );
  }

  Widget _getHealthPage(int index) {
    switch (index) {
      case 0:
        return OxygenLevelScreen();
      case 1:
        return BloodStatusBottom();
      // case 2:
      //   return heratrate();
      default:
        return Container();
    }
  }
}
