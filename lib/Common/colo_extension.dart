import 'package:flutter/material.dart';

//common  color
class TColor {
  static Color get primaryColor1 => const Color(0xaa15b8ff);
  static Color get primaryColor2 => const Color(0xff9DCEFF);

  // static Color get secondaryColor1 => const Color(0xffff1515);
  static Color get secondaryColor1 => const Color.fromARGB(255, 189, 20, 124);
  //  static Color get secondaryColor1 => const Color(0xFFDC1439);
  static Color get secondaryColor2 => const Color.fromARGB(255, 236, 160, 160);

  static List<Color> get primaryG => [primaryColor1, primaryColor1];
  static List<Color> get secondaryG => [secondaryColor1, secondaryColor1];

  static Color get black => const Color(0xff1D1617);
  static Color get gray => const Color(0xff786F72);

  static Color get white => Colors.white;
  static Color get lightGray => const Color(0xFFF7F8F8);
  static Color get lightYellow => const Color.fromARGB(255, 163, 168, 102);

  //
}
