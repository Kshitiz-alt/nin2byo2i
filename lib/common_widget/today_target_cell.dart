import '../../Common/colo_extension.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class TodayTargetCell extends StatelessWidget {
  final String icon;
  final String value;
  final String title;
  const TodayTargetCell(
      {super.key,
      required this.icon,
      required this.value,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ThemeManager.themeColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) {
                  return LinearGradient(
                          colors: TColor.primaryG,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)
                      .createShader(
                          Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                },
                child: Text(
                  value,
                  style: TextStyle(
                      color: ThemeManager.themeColor.withOpacity(0.7),
                      fontWeight: FontWeight.w700,
                      fontSize: AppFontSizes.mediumDefault),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.smallDefault,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
