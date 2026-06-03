import 'package:flutter/material.dart';
import 'package:nin2byo2i/Language/localization/Language/Language_bn.dart';
import 'package:nin2byo2i/Language/localization/Language/Language_gu.dart';
import 'package:nin2byo2i/Language/localization/Language/Language_kn.dart';
import 'package:nin2byo2i/Language/localization/Language/Language_mr.dart';
import 'package:nin2byo2i/Language/localization/Language/Language_or.dart';
import 'package:nin2byo2i/Language/localization/Language/Language_pa.dart';
import 'package:nin2byo2i/Language/localization/Language/Language_ta.dart';
import 'package:nin2byo2i/Language/localization/Language/Language_te.dart';
import 'package:nin2byo2i/Language/localization/Language/Language_ur.dart';
import 'package:nin2byo2i/Language/localization/Language/language_en.dart';
import 'package:nin2byo2i/Language/localization/Language/language_hi.dart';
import 'package:nin2byo2i/Language/localization/Language/language_ml.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
// AppLocalizationsDelegate.dart

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        'en',
        'hi',
        'bn',
        'te',
        'mr',
        'ta',
        'ur',
        'gu',
        'kn',
        'ml',
        'pa',
        'or',
      ].contains(locale.languageCode); // Add 'ml' for Malayalam

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'hi':
        return LanguageHi();
      case 'bn':
        return LanguageBn();
      case 'te':
        return LanguageTe();
      case 'mr':
        return LanguageMr();
      case 'ta':
        return LanguageTa();
      case 'ur':
        return LanguageUr();
      case 'gu':
        return LanguageGu();
      case 'kn':
        return LanguageKn();
      case 'ml':
        return LanguageMl();
      case 'pa':
        return LanguagePa();
      case 'or':
        return LanguageOr();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
