import 'package:flutter/material.dart';

enum RoundButtonType { bgGradient, bgSGradient, textGradient }

class RoundButton extends StatelessWidget {
  final String title;
  final RoundButtonType type;
  final VoidCallback onPressed;
  final double fontSize;
  final double elevation;
  final FontWeight fontWeight;

  const RoundButton(
      {super.key,
      required this.title,
      this.type = RoundButtonType.bgGradient,
      this.fontSize = 16,
      this.elevation = 1,
      this.fontWeight = FontWeight.w700,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: type == RoundButtonType.bgSGradient
                    // ? TColor.secondaryG
                    ? [
                        const Color.fromARGB(255, 189, 20, 124),
                        const Color.fromARGB(255, 189, 20, 124)
                      ]
                    // [Color(0xFFDC1439), Color(0xFFDC1439)]
                    : [
                        const Color.fromARGB(255, 189, 20, 124),
                        const Color.fromARGB(255, 189, 20, 124)
                      ],
                // : [const Color(0xaa15b8ff), const Color(0xaa15b8ff)],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: type == RoundButtonType.bgGradient ||
                      type == RoundButtonType.bgSGradient
                  ? const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 0.5,
                          offset: Offset(0, 0.5))
                    ]
                  : null),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: fontWeight)),
            ),
          )
          //  MaterialButton(
          //   onPressed: onPressed,
          //   // height: 50,
          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          //   textColor: TColor.primaryColor1,
          //   minWidth: double.maxFinite,
          //   elevation: type == RoundButtonType.bgGradient ||
          //           type == RoundButtonType.bgSGradient
          //       ? 0
          //       : elevation,
          //   color: type == RoundButtonType.bgGradient ||
          //           type == RoundButtonType.bgSGradient
          //       ? Colors.transparent
          //       : ThemeManager.themeColor,
          //   child: type == RoundButtonType.bgGradient ||
          //           type == RoundButtonType.bgSGradient
          //       ? Text(title,
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontSize: AppFontSizes.mediumDefault,
          //               fontWeight: fontWeight))
          //       : ShaderMask(
          //           blendMode: BlendMode.srcIn,
          //           shaderCallback: (bounds) {
          //             return LinearGradient(
          //                     colors: TColor.primaryG,
          //                     begin: Alignment.centerLeft,
          //                     end: Alignment.centerRight)
          //                 .createShader(
          //                     Rect.fromLTRB(0, 0, bounds.width, bounds.height));
          //           },
          //           child: Text(title,
          //               style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: fontSize,
          //                   fontWeight: fontWeight)),
          //         ),
          // ),
          ),
    );
  }
}
