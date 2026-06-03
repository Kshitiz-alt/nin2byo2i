import '../../Common/colo_extension.dart';
import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class WorkoutRow extends StatelessWidget {
  final Map wObj;
  const WorkoutRow({super.key, required this.wObj});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            color: ThemeManager.themeColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 0.1)]),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                wObj["image"].toString(),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wObj["name"].toString(),
                  style: const TextStyle(
                      color: Colors.black, fontSize: AppFontSizes.smallDefault),
                ),
                Text(
                  "${wObj["kcal"].toString()} Calories Burn | ${wObj["time"].toString()}minutes",
                  style: TextStyle(
                    color: TColor.gray,
                    fontSize: AppFontSizes.smallDefault,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SimpleAnimationProgressBar(
                  height: 15,
                  width: media.width * 0.5,
                  backgroundColor: Colors.grey.shade100,
                  foregrondColor: Colors.purple,
                  ratio: wObj["progress"] as double? ?? 0.0,
                  direction: Axis.horizontal,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(seconds: 3),
                  borderRadius: BorderRadius.circular(7.5),
                  gradientColor: LinearGradient(
                      colors: TColor.primaryG,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                ),
              ],
            )),
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/img/next_icon.png",
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ))
          ],
        ));
  }
}
