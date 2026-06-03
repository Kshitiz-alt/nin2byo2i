import 'package:shared_preferences/shared_preferences.dart';

class AppFontSizes {
  static const String smallKey = 'smallFontSize';
  static const String mediumKey = 'mediumFontSize';
  static const String largeKey = 'largeFontSize';
  static const String extraLargeKey = 'extraLargeFontSize';

  static const double smallDefault = 12.0;
  static const double mediumDefault = 14.0;
  static const double largeDefault = 19.0;
  static const double extraLargeDefault = 26.0;

  static Future<void> saveFontSizesToPreferences({
    required double smallSize,
    required double mediumSize,
    required double largeSize,
    required double extraLargeSize,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(smallKey, smallSize);
    await prefs.setDouble(mediumKey, mediumSize);
    await prefs.setDouble(largeKey, largeSize);
    await prefs.setDouble(extraLargeKey, extraLargeSize);
  }

  static Future<double> getFontSizeFromPreferences(
      String key, double defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? storedValue = prefs.getDouble(key);
    return storedValue ?? defaultValue;
  }

  static Future<double> getSmallFontSize() async {
    return getFontSizeFromPreferences(smallKey, smallDefault);
  }

  static Future<double> getMediumFontSize() async {
    return getFontSizeFromPreferences(mediumKey, mediumDefault);
  }

  static Future<double> getLargeFontSize() async {
    return getFontSizeFromPreferences(largeKey, largeDefault);
  }

  static Future<double> getExtraLargeFontSize() async {
    return getFontSizeFromPreferences(extraLargeKey, extraLargeDefault);
  }
}
