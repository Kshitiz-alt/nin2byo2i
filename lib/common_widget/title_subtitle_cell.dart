import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class TitleSubtitleCell extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleSubtitleCell(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
          color: ThemeManager.themelightColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: ThemeManager.themeText, blurRadius: 0.1)
          ]),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Color(0xFF007BC1),
                fontWeight: FontWeight.w500,
                fontSize: AppFontSizes.mediumDefault),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.smallDefault,
            ),
          ),
        ],
      ),
    );
  }
}
