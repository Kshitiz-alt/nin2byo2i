import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class CustomAlertWidget extends StatelessWidget {
  final String title;
  final String description;
  final Color? color;

  const CustomAlertWidget({super.key, 
    required this.title,
    required this.description,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeManager.themelightColor,
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppFontSizes.mediumDefault,
          fontWeight: FontWeight.bold,
          color: ThemeManager.themeText, // Customize text color
        ),
      ),
      content: Text(
        description,
        style: TextStyle(
            fontSize: AppFontSizes.mediumDefault,
            color:
                color ?? ThemeManager.themeText // Use provided color or default
            ),
      ),
      // Set the background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            Languages.of(context)!.ok,
            style: TextStyle(
              color: TColor.primaryColor1, // Customize button text color
            ),
          ),
        ),
      ],
    );
  }
}
