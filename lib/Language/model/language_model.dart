/*
Title:LanguageModel
Purpose:LanguageModel
Created By:Kalpesh Khandla
*/

class LanguageModel {
  final String flag;
  final String name;
  final String languageCode;

  LanguageModel(
    this.flag,
    this.name,
    this.languageCode,
  );

  static List<LanguageModel> languageList() {
    return <LanguageModel>[
      LanguageModel("🇺🇸", "English", 'en'),
      LanguageModel("🇮🇳", "Hindi", 'hi'),
      LanguageModel("🇮🇳", "Malayalam", 'ml'), // Malayalam
      LanguageModel("🇮🇳", "Marathi", 'mr'), // Marathi
      LanguageModel("🇮🇳", "Telugu", 'te'), // Telugu
      LanguageModel("🇮🇳", "Bengali", 'bn'), // Bengali
      LanguageModel("🇮🇳", "Tamil", 'ta'), // Tamil
      LanguageModel("🇮🇳", "Urdu", 'ur'), // Urdu
      LanguageModel("🇮🇳", "Gujarati", 'gu'), // Gujarati
      LanguageModel("🇮🇳", "Kannada", 'kn'), // Kannada
      LanguageModel("🇮🇳", "Panjabi", 'pa'), // Panjabi Punjabi
      LanguageModel("🇮🇳", "Oriya", 'or'), // Oriya

      // LanguageModel("🇺🇸", "English", 'en'),
      // LanguageModel("🇮🇳", "हिंदी", 'hi'),

      // LanguageModel("🇮🇳", "മലയാളം", 'ml'), // Malayalam

      // LanguageModel("🇮🇳", "मराठी", 'mr'), // Marathi
      // LanguageModel("🇮🇳", "తెలుగు", 'te'), // Telugu
      // LanguageModel("🇮🇳", "বাংলা", 'bn'), // Bengali
      // LanguageModel("🇮🇳", "தமிழ்", 'ta'), // Tamil
      // LanguageModel("🇮🇳", "اردو", 'ur'), // Urdu
      // LanguageModel("🇮🇳", "ગુજરાતી", 'gu'), // Gujarati
      // LanguageModel("🇮🇳", "ಕನ್ನಡ", 'kn'), // Kannada
      // LanguageModel("🇮🇳", "ਪੰਜਾਬੀ", 'pa'), // Panjabi Punjabi
      // LanguageModel("🇮🇳", "ଓଡ଼ିଆ", 'or'), // Oriya
    ];
  }
}
