import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isobscureText;
  final TextInputType keyboardType;
  final Function(String) onProgress;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.keyboardType,
    this.isobscureText = false,
    required this.onProgress,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: TextFormField(
        decoration: InputDecoration(
            filled: true,
            fillColor: ThemeManager.themelightColor,
            labelText: label,
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
            border: InputBorder.none),
        style: TextStyle(color: ThemeManager.themeText),
        onChanged: (newValue) {
          onProgress(newValue);
        },
        keyboardType: keyboardType,
        obscureText: isobscureText,
        validator: validator,
      ),
    );
  }
}
