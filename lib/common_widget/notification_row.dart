import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class NotificationRow extends StatelessWidget {
  final Map nObj;
  const NotificationRow({super.key, required this.nObj});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              nObj["image"].toString(),
              width: 40,
              height: 40,
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
                nObj["title"].toString(),
                style: TextStyle(
                    color: ThemeManager.themeText,
                    fontWeight: FontWeight.w500,
                    fontSize: AppFontSizes.smallDefault),
              ),
              Text(
                nObj["time"].toString(),
                style: TextStyle(
                  color: ThemeManager.themeText.withOpacity(0.8),
                  fontSize: AppFontSizes.smallDefault,
                ),
              ),
            ],
          )),
          // IconButton(
          //     onPressed: () {},
          //     icon: Image.asset(
          //       "assets/img/sub_menu.png",
          //       width: 15,
          //       height: 15,
          //       fit: BoxFit.contain,
          //     ))
        ],
      ),
    );
  }
}
