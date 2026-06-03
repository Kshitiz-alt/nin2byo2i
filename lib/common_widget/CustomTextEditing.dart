//common texfield
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType; // New property for keyboard type

  const CustomTextField({
    Key? key,
    required this.icon,
    required this.labelText,
    required this.controller,
    required this.keyboardType, // Initialize keyboard type
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType, // Set keyboard type here
        decoration: InputDecoration(
          filled: true,
          fillColor: ThemeManager.themelightColor,
          labelText: labelText,
          hintStyle: TextStyle(
            color: ThemeManager.themeText,
          ),
          labelStyle: TextStyle(
            color: ThemeManager.themeText,
            fontSize: AppFontSizes.smallDefault,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            icon,
            color: ThemeManager.themeText,
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: ThemeManager.themeText,
        ),
      ),
    );
  }
}
