import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isColored;
  const CustomButton({super.key, required this.text, this.isColored = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 60,
      decoration: ShapeDecoration(
        color: isColored ? null : Colors.white,
        gradient: isColored
            ? LinearGradient(
                begin: const Alignment(-1.00, 0.08),
                end: const Alignment(1, -0.08),
                colors: [
                  TColor.secondaryColor1,
                  TColor.secondaryColor1,
                ],
              )
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isColored ? Colors.white : const Color(0xFF92A3FD),
            fontSize: AppFontSizes.mediumDefault,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
      ),
    );
  }
}
