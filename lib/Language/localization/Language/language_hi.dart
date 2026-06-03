import 'languages.dart';

class LanguageHi extends Languages {
  @override
  String get inputActivityDataPrompt =>
      "अपनी ऊर्जा व्यय और संतुलन देखने के लिए, कृपया 24-घंटे की गतिविधि डेटा दर्ज करें।";
  @override
  String get myEnergyBalanceYesterday => "मेरा ऊर्जा संतुलन (कल)";
  @override
  String get caloriesBurnFromWatch => "घड़ी से जली हुई कैलोरी";
  @override
  String get activities => "गतिविधियाँ";
  @override
  String get searchActivityHere => "यहाँ गतिविधि खोजें";
  @override
  String get orSelectActivityFromBelow => "या नीचे से गतिविधि चुनें";
  @override
  String get tryLater => "बाद में प्रयास करें";
//   @override
//   String get appName => "नीना ०";

//   @override
//   String get labelWelcome => "स्वागत";

//   @override
//   String get labelSelectLanguage => "भाषा चुने";

//   @override
//   String get labelInfo => "यह मल्टी-लैंग्वेज डेमो एप्लिकेशन है";

//   @override
//   // TODO: implement labelChangeLanguage
//   String get labelChangeLanguage => "भाषा बदलें";
//   @override
//   String get labelWelcomeBack => "वापसी पर स्वागत है,";

//   @override
//   String get labelUnderweight => "आपके पास एक कम वजन है";

//   @override
//   String get labelNormalWeight => "आपका एक सामान्य वजन है";

//   @override
//   String get labelOverweight => "आपके पास अधिक वजन है";

//   @override
//   String get labelObese => "आपके पास एक मोटापे है";

//   @override
//   String get labelViewMore => "और देखें";

//   @override
//   String get labelTodaySteps => "आज कदम";

//   @override
//   String get labelCheck => "जाँच करना";

//   @override
//   String get labelHealthData => "रक्तचाप /SPO2";

//   @override
//   String get labelActivityStatus => "गतिविधि की स्थिति";

//   @override
//   String get labelHeartRate => "हृदय दर";

//   @override
//   String get labelHeartRateValue => "78 बीपीएम";

//   @override
//   String get labelMinutesAgo => "पहले से ही";

//   @override
//   String get labelWaterIntake => "पानी सेवन";

//   @override
//   String get labelLiters => "लीटर";

//   @override
//   String get labelZeroLiters => "0 लीटर";

//   @override
//   String get labelRealTimeGoal => "वास्तविक समय, लक्ष्य";

//   @override
//   String get labelCalories => "कैलोरी बर्न";

//   @override
//   String get labelCaloriesEarned => "कैलोरी अर्जित";

//   @override
//   String get labelFoodPlan => "खाद्य योजना";

//   @override
//   String get labelWorkoutProgress => "कसरत प्रगति";

//   @override
//   String get labelWeekly => "साप्ताहिक";

//   @override
//   String get labelMonthly => "महीने के";

//   @override
//   String get labelLatestWorkout => "नवीनतम कसरत";

//   @override
//   String get labelSeeMore => "और देखें";
//   String get labelBreakfast => "नाश्ता";
//   String get labelLunch => "दिन का खाना";
//   String get labelDinner => "रात का खाना";
//   String get labelSnacks => "नाश्ता";
//   String get labelTaken => "लिया";
//   String get labelTarget => "लक्ष्य";

//   //profile

//   String get labelProfile => "प्रोफ़ाइल";
//   String get labelEdit => "संपादन करना";
//   String get labelUser => "उपयोगकर्ता";
//   String get labelProgram => "एक वसा कार्यक्रम खो दें";
//   String get labelHeight => "ऊंचाई";
//   String get labelWeight => "वज़न";
//   String get labelAge => "आयु";
//   String get labelAccount => "खाता";
//   String get labelPersonalData => "व्यक्तिगत डेटा";
//   String get labelAchievement => "उपलब्धि";
//   String get labelActivityHistory => "गतिविधि इतिहास";
// //String get labelWorkoutProgress => "कसरत प्रगति";
//   String get labelNotification => "अधिसूचना";
//   String get labelPopupNotification => "पापुलेशन इन्वर्शन";
//   String get labelMensurationCycle => "चक्र माहवारी";
//   String get labelOther => "अन्य";
//   String get labelContactUs => "संपर्क करें";
//   String get labelPrivacyPolicy => "गोपनीयता नीति";
//   String get labelSetting => "सेटिंग";
//   String get labelFeedback => "प्रतिक्रिया";
//   String get labelConfirmLogout => "लॉगआउट की पुष्टि करें";
//   String get labelConfirmLogoutMessage => "क्या आप लॉग आउट करना चाहते हैं?";
//   String get labelLogout => "लॉग आउट";
//   //select tab
//   String get labelOptions => "विकल्प";
//   String get labelFoodTable => "भोजन जोड़ें";
//   String get labelTop10Food => "शीर्ष 10 भोजन";
//   String get labelActivityTrack => "गतिविधि ट्रैक";
//   String get labelsteptracker => "स्टेप ट्रैकर";

//   String get labelTodayTarget => "जल -लक्ष्य";
//   String get labelJoggingTrack => "जॉगिंग ट्रैक";
//   String get labelMensurationTrack => "मेन्सुलेशन ट्रैक";
// //String get labelFoodTable => "भोजन की मेज";
//   String get labelPassword => "पासवर्ड बदलें";
//   String get labelDarkMode => "डार्क मोड का प्रयास करें";
//   String get labelconectWatch => "कनेक्ट वॉच";
//   @override
//   String get labelSleep => "नींद";
//   @override
//   String get labelBookStore => "बही -भंडार";
//   @override
//   String get labelSearchBooks => "खोज पुस्तकों";
//   @override
//   String get labelPrice => "कीमत";
//   @override
//   String get labelAddToCart => "कार्ट में जोड़ें";
//   @override
//   String get labelAuthor => "लेखक";
//   @override
//   String get labelYear => "वर्ष";
//   @override
//   String get labelQuantityAvailable => "उपलब्ध मात्रा";
//   @override
//   String get labelCart => "कार्ट में जोड़ें";
//   @override
//   String get labelMyOrders => "मेरे आदेश";
//   @override
//   String get labelAllOrders => "सभी आदेश";
//   @override
//   String get labelOrderDetail => "ऑर्डर विवरण";
//   @override
//   String get labelOrderId => "आदेश कामतत्व";
//   @override
//   String get labelOrdersInMyOrders => "मेरे आदेशों में आदेश";
//   @override
//   String get labelItemsInMyOrders => "मेरे आदेशों में आइटम";
//   @override
//   String get labelTotal => "कुल";
//   @override
//   String get labelTotalPrice => "कुल कीमत";
//   @override
//   String get labelCheckout => "चेक आउट";

//   // Meal List
//   @override
//   String get labelMealList => "भोजन सूची";
//   @override
//   String get labelAnalyze => "विश्लेषण";
//   @override
//   String get labelAddDish => "डिश जोड़ें";
//   @override
//   String get labelTop10Foods => "शीर्ष 10 खाद्य पदार्थ";
//   @override
//   String get labelRecentMeal => "हाल ही में भोजन";
//   @override
//   String get labelAnalyzeIngredientsTaken => "लिया गया अवयवों का विश्लेषण करें";

//   // Nutrition Summary
//   @override
//   String get labelCarbs => "कार्बोहाइड्रेट";
//   // @override
//   // String get labelCalories => "कैलोरी";
//   @override
//   String get labelFibers => "रेशे";
//   @override
//   String get labelFats => "वसा";
//   @override
//   String get labelProteins => "प्रोटीन";
//   @override
//   String get labelCalcium => "कैल्शियम";

//   @override
//   String get labelNiacinB3 => "खुद (बी 3)";

//   @override
//   String get labelThiamineB1 => "थियामिन (बी 1)";

//   @override
//   String get labelIron => "लोहा";

//   @override
//   String get labelZinc => "जस्ता";

//   @override
//   String get labelFolatesB9 => "मूर्ख (B9)";

//   @override
//   String get labelRiboflavinB2 => "रेस्पॉन्विन (बीए)";

//   @override
//   String get labelRetinolVitA => "रेटिनोल (विटामिन ए)";

//   @override
//   String get labelMagnesium => "मैगनीशियम";

//   @override
//   String get labelTodaysNutritionSummary => "आज का पोषण सारांश";
//   @override
//   String get labelChangeGoal => "लक्ष्य बदलें";
//   @override
//   String get labelIngredientsTaken => "सामग्री ली गई";
//   @override
//   String get labelIngredientsLeft => "सामग्री छोड़ दिया";

//   // Food Table
//   // @override
//   // String get labelFoodTable => "भोजन की मेज";
//   // @override
//   // String get labelBreakfast => "नाश्ता";
//   // @override
//   // String get labelLunch => "दिन का खाना";
//   // @override
//   // String get labelDinner => "रात का खाना";
//   // @override
//   // String get labelSnacks => "नाश्ता";
//   @override
//   String get labelTop10FoodsSleep => "शीर्ष 10 खाद्य पदार्थ";
//   @override
//   String get labelFavouriteDishes => "पसंदीदा व्यंजन";

//   // User Profile
//   @override
//   String get labelHelp => "मदद";
//   // @override
//   // String get labelLogout => "लॉग आउट";
//   // @override
//   // String get labelWeight => "वज़न";
//   @override
//   String get labelEmail => "ईमेल";
//   // @override
//   // String get labelHeight => "ऊंचाई";
//   @override
//   String get labelLinkedInProfileLink => "लिंक्डइन प्रोफाइल लिंक";
//   @override
//   String get labelGoogleProfileLink => "Google प्रोफ़ाइल लिंक";
//   @override
//   String get labelFacebookProfileLink => "फेसबुक प्रोफाइल लिंक";
//   @override
//   String get labelTwitterProfileLink => "ट्विटर प्रोफाइल लिंक";
//   @override
//   String get labelName => "नाम";
//   @override
//   String get labelPhoneNumber => "फोन नंबर।";
//   @override
//   String get labelDateOfBirth => "डिपो";
//   @override
//   String get labelBMI => "बीएमआई";
//   // @override
//   // String get labelAge => "आयु";

//   // Contact Us
//   @override
//   String get labelMessage => "संदेश";
//   @override
//   String get labelSubmit => "जमा करना";
//   @override
//   String get labelCompanyContacts => "कंपनी के संपर्क";
//   @override
//   String get labelAddress => "पता";
//   @override
//   String get labelDirectorsEmail => "निदेशक का ईमेल";
//   @override
//   String get labelFax => "फैक्स";

//   // Settings
//   @override
//   String get labelResetPassword => "पासवर्ड रीसेट";
//   // @override
//   // String get labelFeedback => "प्रतिक्रिया";
//   @override
//   String get labelPleaseProvideFeedback => "कृपया अपनी प्रतिक्रिया प्रदान करें";
//   @override
//   String get labelEnterYourFeedbackHere => "यहां अपनी प्रतिक्रिया दर्ज करें";
//   @override
//   String get labelSubmitFeedback => "प्रतिपुष्टि दें";

//   // Credits
//   // @override
//   // String get labelContactUs => "संपर्क करें";
//   @override
//   String get labelDevelopmentTeam => "विकास दल";
//   @override
//   String get labelAcknowledgments => "स्वीकृतियाँ";
//   @override
//   String get labelPartnerships => "भागीदारी";

//   // Mobile
//   @override
//   String get labelSearchComponents => "खोज घटक";
//   @override
//   String get labelSearchComponentsHere => "यहां खोज घटक";
//   @override
//   String get lablelDishName => 'डिश नाम';
//   @override
//   String get labelCredits => 'क्रेडिट';
//   @override
//   String get labelShareAppButton => "शेयर करना";
//   @override
//   String get labelShareApp =>
//       "बारकोड स्कैनर ऐप और डाउनलोड ऐप के साथ क्यूआर कोड को स्कैन करें";
//   // New translations
//   @override
//   String get labelConnectedWatch => "कनेक्टेड वॉच है";
//   @override
//   String get labelDisconnect => "डिस्कनेक्ट";
//   @override
//   String get labelFitbit => "Fitbit";
//   @override
//   String get labelGoogleFit => "Google Fit";
//   @override
//   String get labelAppleWatch => "एप्पल घड़ी";
//   @override
//   String get labelSamsungSmartWatch => "सैमसंग स्मार्ट वॉच";
//   @override
//   String get labelBookDetails => "बही -विवरण";
//   @override
//   String get labelDeliverystatus => "डिलीवरी की तारीख";
//   @override
//   String get labelOrderDate => "आर्डर की तारीख";
  @override
  String get totalEnergyConsumption => "कुल ऊर्जा खपत";
  @override
  String get totalEnergyExpenditure => "कुल ऊर्जा खर्च";
  @override
  String get energybalance => "ऊर्जा संतुलन";
  @override
  String get indicatorhealth =>
      "('+' ऊर्जा की अधिकता को दर्शाता है; '-' ऊर्जा की कमी को दर्शाता है)";

//   @override
//   String get labelAnalyseIngredientsTaken => "लिया गया अवयवों का विश्लेषण करें";
//   @override
//   String get labelAddDishIngredients => "डिश सामग्री जोड़ें";
//   @override
//   String get labelIngredientName => "अवयव नाम";
//   @override
//   String get labelEnterIngredientName => "एक घटक नाम दर्ज करें";
//   @override
//   String get labelIngredientQuantity => "अवयव मात्रा";
//   @override
//   String get labelEnterIngredientQuantity => "घटक मात्रा दर्ज करें";
//   @override
//   String get labelAdd => "जोड़ना";
//   @override
//   String get labelSave => "बचाना";
//   @override
//   String get labelwatch => "घड़ी";

//   //
//   @override
//   String get labelBloodOxygenHeart =>
//       'महत्वपूर्ण संकेतों को मापें और समग्र स्वास्थ्य को ट्रैक करें।';
//   @override
//   String get labelTop10FoodS =>
//       'एक स्वस्थ जीवन शैली बनाए रखने के लिए अनुशंसित खाद्य पदार्थों की खोज करें।';
//   @override
//   String get labelWaterTrack =>
//       'दैनिक फिटनेस हाइड्रेशन लक्ष्यों को सेट करें और प्राप्त करें।';
//   @override
//   String get labelPersonalDetails =>
//       'व्यक्तिगत जानकारी को सुरक्षित रूप से प्रबंधित करें और अपडेट करें।';
//   @override
//   String get labelFeedbackS =>
//       'अपने विचारों और सुझावों को हमारे साथ साझा करें।';
//   @override
//   String get labelContactUsS =>
//       'ग्राहक सहायता तक पहुंचें और हमारे साथ संपर्क करें।';
//   @override
//   String get labelBMICalculator =>
//       'स्वास्थ्य अंतर्दृष्टि के लिए अपने बॉडी मास इंडेक्स की गणना करें।';
//   @override
//   String get labelBMRCalculator =>
//       'फिटनेस योजना के लिए अपने बेसल चयापचय दर की गणना करें।';
//   @override
//   String get labelRunningJoggingSteps =>
//       'एक स्वस्थ जीवन शैली के लिए अपने रनिंग और जॉगिंग स्टेप्स को ट्रैक करें।';
//   @override
//   String get labelHealthyDietChart =>
//       'एक स्वस्थ आहार अवलोकन के लिए एक व्यापक चार्ट का उपयोग करें।';
//   @override
//   String get labelHealthyRecommendation =>
//       'व्यक्तिगत स्वास्थ्य सिफारिशें प्राप्त करें।';
//   @override
//   String get labelSleepTracker =>
//       'अपने नींद के पैटर्न को ट्रैक करें और नींद की गुणवत्ता में सुधार करें।';
//   @override
//   String get labelSetReminder =>
//       'स्वास्थ्य और फिटनेस गतिविधियों के लिए अनुस्मारक सेट करें।';
//   // @override
//   // String get labelMenstruationCycle =>
//   //     'बेहतर अंतर्दृष्टि के लिए अपने मासिक धर्म चक्र को ट्रैक और प्रबंधित करें।';
//   @override
//   String get labelCSVDownload =>
//       'आसान विश्लेषण के लिए CSV प्रारूप में अपना डेटा डाउनलोड करें।';

//   // New Headings
//   @override
//   String get headingBloodOxygenHeart => 'खून |ऑक्सीजन |दिल';
//   @override
//   String get headingTop10Food => 'शीर्ष 10 भोजन';
//   @override
//   String get headingWaterTrack => 'पानी का नक़्शा';
//   @override
//   String get headingPersonalDetails => 'व्यक्तिगत विवरण';
//   @override
//   String get headingFeedback => 'प्रतिक्रिया';
//   @override
//   String get headingContactUs => 'संपर्क करें';
//   @override
//   String get headingBMICalculator => 'बीएमआई कैलकुलेटर';
//   @override
//   String get headingBMRCalculator => 'बीएमआर कैलकुलेटर';
//   @override
//   String get headingRunningJoggingSteps => 'रनिंग / जॉगिंग / स्टेप्स';
//   @override
//   String get headingHealthyDietChart => 'स्वस्थ आहार चार्ट';
//   @override
//   String get headingHealthyRecommendation => 'स्वस्थ सिफारिश';
//   @override
//   String get headingSleepTracker => 'स्लीप ट्रैकर';
//   @override
//   String get headingSetReminder => 'अनुस्मारक सेट करें';
//   // @override
//   // String get headingMenstruationCycle => 'मासिक धर्म चक्र';
//   @override
//   String get headingCSVDownload => 'सीएसवी डाउनलोड';

//   // Water-related phrases
//   @override
//   String get labelWaterTarget => "जल -लक्ष्य";
//   // @override
//   // String get labelTodayTarget => "आज लक्ष्य";
//   @override
//   String get labelWaterGoal => "जल -लक्ष्य";
//   // @override
//   // String get labelWaterIntake => "पानी सेवन";
//   @override
//   String get labelWaterProgress => "पानी की प्रगति";
//   // @override
//   // String get labelWeekly => "साप्ताहिक";
//   @override
//   String get labelDateWise => "दिनांक वार";
//   @override
//   String get labelSun => "सूरज";
//   @override
//   String get labelMon => "सोमवार";
//   @override
//   String get labelTue => "मंगल";
//   @override
//   String get labelWed => "बुध";
//   @override
//   String get labelThu => "गुरु";
//   @override
//   String get labelFri => "शुक्र";

//   // BMI Calculator
//   // @override
//   // String get labelBMI => "बीएमआई";
//   @override
//   String get labelEnterHeight => "ऊंचाई दर्ज करें (सेमी)";
//   @override
//   String get labelEnterWeight => "वजन दर्ज करें (किग्रा)";
//   @override
//   String get labelCalculateBMI => "बीएमआई की गणना करें";

//   // BMR Calculator
//   @override
//   String get labelMale => "पुरुष";
//   @override
//   String get labelFemale => "महिला";
//   @override
//   String get labelEnterAge => "आयु में प्रवेश करना";
//   @override
//   String get labelCalculateBMR => "बीएमआर की गणना करें";
//   @override
//   String get labelBMR => "बीएमआर";
//   @override
//   String get labelCaloriesPerDay => "कैलोरी/दिन";

//   // Step Tracker
//   @override
//   String get labelStepsTracker => "स्टेप ट्रैकर";
//   @override
//   String get labelRunningTracker => "रनिंग ट्रैकर";
//   @override
//   String get labelAddStep => "कदम जोड़ें";
//   @override
//   String get labelSelectDate => "तारीख़ चुनें";
//   @override
//   String get labelJoggingTracker => "जॉगिंग ट्रैकर";
//   @override
//   String get labelCaloriesBurn => "कैलोरी बर्न";

//   // Sleep Tracker
//   @override
//   String get labelSleepTarget => "नींद का निशाना";
//   @override
//   String get labelTodaySleep => "आज नींद";
//   @override
//   String get labelSleepProgress => "नींद की प्रगति";
//   @override
//   String get labelTotalSleep => "कुल नींद";
//   @override
//   String get labelSleepGoal => "नींद का लक्ष्य";
//   @override
//   String get labelSetNotification => "अधिसूचना निर्धारित करें";
//   @override
//   String get labelStartTime => "समय शुरू";
//   @override
//   String get labelEndTime => "अंत समय";
//   @override
//   String get labelSelect => "चुनना";
//   @override
//   String get labelSat => "बैठा";
//   // @override
//   // String get labelSave => "बचाना";
//   @override
//   String get labelStart => "शुरू";
//   @override
//   String get labelEnd => "अंत";
//   @override
//   String get labelType => "प्रकार";
//   @override
//   String get labelIsConnected => "जुड़ा है";

//   // @override
//   // String get labelMensurationCycle => "चक्र माहवारी";

//   @override
//   String get labelTrackAndManage =>
//       "बेहतर अंतर्दृष्टि के लिए अपने मेसरेशन चक्र को ट्रैक और प्रबंधित करें";

//   @override
//   String get labelMensurationStatus => "स्थिति माप";

//   @override
//   String get labelDaysLength => "दिन की लंबाई";

//   @override
//   String get labelDay => "दिन";

//   @override
//   String get labelNextDate => "अगली तारीख";

//   @override
//   String get labelLastPeriodStartDate => "अंतिम अवधि प्रारंभ तिथि";

//   @override
//   String get labelAverageCycleLength => "औसत चक्र लंबाई";

//   @override
//   String get labelChange => "परिवर्तन";

//   // Common Messages
//   @override
//   String get messageSent => "संदेश भेजा गया";

//   @override
//   String get thankYouForContactingUs => "हमसे संपर्क करने के लिए धन्यवाद!";

//   @override
//   String get alert => "चेतावनी";

//   @override
//   String get fillInAllFields => "कृपया सभी स्थानों को भरें।";

//   @override
//   String get thankYouFeedbackSubmitted => "आपकी प्रतिक्रिया प्रस्तुत की गई है।";

//   @override
//   String get resetPassword => "पासवर्ड रीसेट";

//   @override
//   String get dishAdded => "डिश जोड़ा!";

//   @override
//   String get dishAndIngredientsAddedSuccessfully =>
//       "सफलतापूर्वक डिश और सामग्री जोड़ा गया।";

//   @override
//   String get failed => "असफल";

//   @override
//   String get error => "गलती";

//   @override
//   String get enterBloodGlucoseLevel =>
//       "मिलीग्राम/डीएल में रक्त शर्करा का स्तर दर्ज करें";

//   @override
//   String get enterBloodPressureLevel => "MMHG में रक्तचाप का स्तर दर्ज करें";

//   @override
//   String get enterHeartLevel =>
//       "कृपया हृदय गति को बीट्स प्रति मिनट (बीपीएम) में दर्ज करें।";

//   @override
//   String get cancel => "रद्द करना";

//   @override
//   String get submit => "जमा करना";

//   @override
//   String get valueCannotBeGreaterThan100 => "मूल्य 100 से अधिक नहीं हो सकता।";

//   @override
//   String get bloodStatusSubmittedSuccessfully =>
//       "रक्त की स्थिति सफलतापूर्वक प्रस्तुत की गई।";

//   @override
//   String get failedToSubmitBlood => "रक्त जमा करने में विफल रहा।";

//   @override
//   String get enterHeartLevel1to100 =>
//       "कृपया प्रति मिनट (बीपीएम) बीट्स में हार्ट रेट दर्ज करें।";

//   @override
//   String get heartLevelSubmittedSuccessfully =>
//       "हार्ट लेवल सफलतापूर्वक प्रस्तुत किया गया।";

//   @override
//   String get enterOxygenSaturationLevel1to100 =>
//       "ऑक्सीजन संतृप्ति स्तर 1%-100%दर्ज करें";

//   @override
//   String get oxygenLevelSubmittedSuccessfully =>
//       "ऑक्सीजन का स्तर सफलतापूर्वक प्रस्तुत किया गया।";

//   @override
//   String get updateData => "अद्यतन आकड़ें";

//   @override
//   String get selectLastPeriodStartDate => "अंतिम अवधि प्रारंभ तिथि का चयन करें";

//   @override
//   String get update => "अद्यतन";

//   @override
//   String get failedToFetchBooks =>
//       "किताबें लाने में विफल रहे।कृपया पुन: प्रयास करें।";

//   @override
//   String get errorOccurred => "एक त्रुटि पाई गई:";

//   @override
//   String get invalidEndTime => "अमान्य अंत समय";

//   @override
//   String get chooseTimeWithin1Hour =>
//       "कृपया प्रारंभ समय के 1 घंटे के भीतर एक समय चुनें।";

//   @override
//   String get notificationSaved => "अधिसूचना बच गई";

//   @override
//   String get notificationSetSuccessfully => "अधिसूचना सफलतापूर्वक सेट।";

//   @override
//   String get thereIsSomeError => "कुछ त्रुटि है।";

//   @override
//   String get watchDisconnected => "देखो डिस्कनेक्ट";

//   @override
//   String get watchDisconnectedSuccessfully =>
//       "घड़ी को सफलतापूर्वक काट दिया गया है।";

//   @override
//   String get addCup => "कप जोड़ें";

//   @override
//   String get numberOfCups => "कप की संख्या";

//   @override
//   String get addCupCapacityInMl => "एमएल में कपकैप्सिटी जोड़ें";

//   @override
//   String get cupCapacitySubmittedSuccessfully =>
//       "कप क्षमता सफलतापूर्वक प्रस्तुत की गई।";

//   @override
//   String get pleaseEnterValidValuesForAllFields =>
//       "कृपया सभी फ़ील्ड के लिए मान्य मान दर्ज करें।";

//   @override
//   String get enterWater => "पानी में प्रवेश करना";

//   @override
//   String get waterGoalLiters => "जल लक्ष्य (लीटर)";

//   @override
//   String get waterSubmittedSuccessfully =>
//       "पानी का लक्ष्य सफलतापूर्वक प्रस्तुत किया गया।";

//   @override
//   String get addActivityData => "गतिविधि डेटा जोड़ें";

//   @override
//   String get enterValue => "दर्ज मूल्य";

//   @override
//   String get addStepsData => "चरण डेटा जोड़ें";

//   @override
//   String get numberOfSteps => "चरणों की संख्या";

//   @override
//   String get stepsDataSubmittedSuccessfully =>
//       "स्टेप्स डेटा सफलतापूर्वक प्रस्तुत किया गया।";

//   @override
//   String get enterSleepTarget => "नींद का लक्ष्य दर्ज करें";

//   @override
//   String get sleepTargetInHours => "घंटों में नींद का लक्ष्य";

//   @override
//   String get addYourSleepDuration => "अपनी नींद की अवधि जोड़ें";

//   @override
//   String get enterDurationInMinutes => "मिनटों में अवधि दर्ज करें:";

//   @override
//   String get add => "जोड़ना";

//   @override
//   String get ok => "ठीक है";

//   @override
//   String get csvFileSavedTo => "CSV फ़ाइल को सहेजा गया";

//   @override
//   String get ageMustBeBetween2And100Years =>
//       "आयु 2 से 100 वर्ष के बीच होनी चाहिए";

//   @override
//   String get next => "अगला";

//   @override
//   String get register => "पंजीकरण करवाना";

//   @override
//   String get oopsSomethingWentWrong => "उफ़!कुछ गलत हो गया";

//   @override
//   String get errorFetchingMeals => "भोजन लाने के दौरान एक त्रुटि हुई:";

//   @override
//   String get reviewAddedSuccessfully => "समीक्षा सफलतापूर्वक जोड़ा गया!";

//   @override
//   String get failedToAddReview => "समीक्षा जोड़ने में विफल:";

//   @override
//   String get alreadyInCart => "पहले से ही गाड़ी में";

//   @override
//   String get addedToCart => "कार्ट में जोड़ा गया";

//   @override
//   String get quantityNotBetween1And2 =>
//       "मात्रा 2 से अधिक नहीं है और 1 से कम है";

//   String get createcustomdish => "कस्टम डिश बनाएं";
//   String get quantityingram => "मात्रा (ग्राम)";
//   String get labelCaloriestaken => 'ऊर्जा';
//   String get mainlabelEarlyMorning => "बहुत सवेरे";
//   String get mainlabelMidMorning => "सुबह के दौरान";
//   String get mainlabelEvening => "शाम";
//   String get mainlabelBedtime => "सोने का समय";
//   String get mainlabelTimeSpentOn => "विभिन्न गतिविधियों में बिताया गया समय";
//   String get mainlabelHealthCalculator => "स्वास्थ्य गणना करने वाला";
//   String get mainlabelStepProgress => "कदम प्रगति";
//   String get mainlabelRealTimeIntakes => "असली समय इंटेक";
//   String get mainlabelCaloriesBurnProgress => "कैलोरी बर्न प्रगति";
//   String get mainlabelCaloriesBurnBreakdown => "कैलोरी बर्न ब्रेकडाउन";
//   String get mainlabelHeartReportsTrends => "दिल की रिपोर्ट के रुझान";
//   String get mainlabelOxygenStatus => "ऑक्सीजन की स्थिति";
//   String get mainlabelNoRecord => "कोई रिकॉर्ड नहीं";
//   String get mainlabelSystolicBloodPressure => "सिस्टोलिक रक्तचाप";
//   String get mainlabelMeasuredon => "पर मापा गया";
//   String get mainlabelEnterBloodPressure => "रक्तचाप दर्ज करें";
//   String get mainlabelBloodPressure => "रक्तचाप";
//   String get mainlabelDiastolicBloodPressure => "डायस्टोलिक रक्तचाप";
//   String get mainlabelBloodGlucose => "रक्त द्राक्ष - शर्करा";
//   String get mainlabelHeartStatus => "दिल की स्थिति";
//   String get mainlabelAllExercise => "सभी व्यायाम";
//   String get mainlabelCleaningOrMopping => "सफाई या मोपिंग";
//   String get mainlabelGardening => "बागवानी";
//   String get mainlabelWatchingTV => "टीवी देखना";
//   String get mainlabelCycling => "साइकिल चलाना";
//   String get mainlabelRunning => "दौड़ना";
//   String get mainlabelWalking => "चलना";
//   String get mainlabelShuttle => "शटल";
//   String get mainlabelTableTennis => "टेबल टेनिस";
//   String get mainlabelTennis => "टेनिस";
//   String get mainlabelVolleyBall => "वालीबाल";
//   String get mainlabelDancing => "नृत्य";
//   String get mainlabelFishing => "मछली पकड़ने";
//   String get mainlabelShopping => "खरीदारी";
//   String get mainlabelTyping => "टाइपिंग";
//   String get mainlabelSleeping => "सोना";
//   String get mainlabelStanding => "खड़ा है";
//   String get mainlabelSitting => "बैठक";
//   String get mainlabelClickToStartActivity =>
//       "गतिविधि शुरू करने के लिए क्लिक करें";
//   String get mainlabelBMICalculator => "बीएमआई कैलकुलेटर";
//   String get mainlabelBMRCalculator => "बीएमआर कैलकुलेटर";
//   String get mainlabelDownloadActivityReportInCsv =>
//       "CSV में गतिविधि रिपोर्ट डाउनलोड करें";
//   String get mainlabelSelectStartDate => "प्रारंभ तिथि का चयन करें";
//   String get mainlabelSelectEndDate => "अंतिम तिथि का चयन करें";
//   String get mainlabelDownloadFile => "डाउनलोड फ़ाइल";
//   String get mainlabelDate => "तारीख";
//   String get mainlabelValue => "कीमत";
//   String get mainlabelLink => "जोड़ना";
//   String get mainlabelNoNotificationFound => "कोई अधिसूचना नहीं मिली";
//   String get mainlabelTotalNutritionTaken => "कुल पोषण लिया गया";
//   String get mainlabelSearchFood => "खोज व्यंजनों";
//   String get mainlabelSelectFromPersonalFood =>
//       "व्यक्तिगत व्यंजनों से चयन करें";
//   String get mainlabelRecipeName => "नुस्खा नाम";
//   String get mainlabelSelectDate => "तारीख़ चुनें";
//   String get mainlabelNutrientOfAllIngredientsRaw =>
//       "सभी अवयवों का पोषक (कच्चा)";
//   String get mainlabelNutrientsCompostionOfCookedWeight =>
//       "पोषक तत्वों के लिए पके हुए वजन की संरचना";
//   String get mainlabelWantToEditThisRecipyFollowThe =>
//       "इस नुस्खा को संपादित करना चाहते हैं?का पीछा करो";
//   String get mainlabelAddIngredientFrom => "से घटक जोड़ें";
//   String get mainlabelAddFromNutrientSpecifcFood =>
//       "पोषक तत्व विशिष्ट भोजन से जोड़ें";
//   String get mainlabelAddFromAllFoods => "सभी खाद्य पदार्थों से जोड़ें";
//   String get mainlabelNumberOfServing => "सर्विंग्स की संख्या";
//   String get mainlabelWeightInG => "वजन (छ)";
//   String get mainlabelEditIngredientsWeight => "सामग्री का वजन संपादित करें";
//   String get mainlabelIngredient => "सामग्री";
//   String get mainlabelNewWeightInG => "नया वजन (छ)";
//   String get mainlabelCancel => "रद्द करना";
//   String get mainlabelUpdate => "अद्यतन";
//   String get mainlabelCookedWeightInG => "पका हुआ वजन (छ)";
//   String get mainlabelEnterWeight => "वजन दर्ज करें";
//   String get mainlabelEditRecipy => "नुस्खा संपादित करें";
//   String get mainlabelAlert => "चेतावनी";
//   String get mainlabelToSeeNutritionCompositionPleaseEnterNoOfServing =>
//       "पोषण रचना देखने के लिए, कृपया सर्विंग्स की संख्या दर्ज करें";
//   String get mainlabelNutrirntsIn100CookedWeight =>
//       "100 (पका हुआ) वजन में पोषक तत्व";
//   String get mainlabelSetNutritionTargetInG =>
//       "ग्राम में पोषण लक्ष्य निर्धारित करें";
//   String get mainlabelFoodAnalyse => "खाद्य विश्लेषण";
//   String get mainlabelExploreTop10Foods =>
//       "शीर्ष 10 खाद्य पदार्थों का अन्वेषण करें";
//   String get mainlabelSearchCookedFood => "व्यंजनों में पोषक तत्व खोजें";
//   String get mainlabelNutritionBasedOnEAR => "कान पर आधारित पोषण";
//   String get mainlabelDietDiary => "आहार डायरी";
//   String get mainlabelRecipes => "व्यंजनों";
//   String get mainlabelSearchByFoodName => "भोजन के नाम से खोजें";
//   String get mainlabelAllRecipeOf100G => "100 ग्राम का सभी नुस्खा";
//   String get mainlabelNutritionRequirement => "पोषण की आवश्यकता";
//   String get mainlabelGender => "लिंग";
//   String get mainlabelParticulars => "ब्यौरा";
//   String get mainlabelBodyWeight => "शरीर का वजन";
//   String get mainlabelDietaryDiaryReports => "पोषक तत्वों का सेवन";
//   String get mainlabelTotalNutritionTakenOn => "कुल पोषण पर लिया गया";
//   String get mainlabelAttachImage => "छवि संलग्न करें";
//   String get mainlabelFixedRecipy => "नियत नुस्खा";
//   String get mainlabelFoodInDetail => "विस्तार से भोजन";
//   String get TextAppNutrientsInMyFood => "मेरे भोजन में पोषक तत्व";
//   String get TextAppMyActivity => "मेरी गतिविधि";
//   String get TextAppToday => "आज";
//   String get TextAppMyNutrientRequirements => "मेरी पोषक आवश्यकताएँ";
//   String get TextAppTotalNutrition => "कुल पोषण";
//   String get TextAppTaken => "लिया";
//   String get TextAppRatings => "रेटिंग";
//   String get TextAppSearchComponents => "खोज घटक";
//   String get TextAppTotalNutrientTaken => "कुल पोषक तत्व लिया गया";
//   String get TextAppShareApp => "ऐप शेयर करें";
//   String get TextAppNoNotificationsFound => "कोई सूचना नहीं मिली";
//   String get TextAppConnectWatch => "कनेक्ट वॉच";
//   String get TextAppYourBMIIs => "आपका बीएमआई है";
//   String get TextAppBMI => "बीएमआई";
//   String get TextAppBMICategories => "बीएमआई श्रेणियां";
//   String get TextAppUnderweight => "वजन";
//   String get TextAppNormal => "सामान्य";
//   String get TextAppOverweight => "अधिक वजन";
//   String get TextAppObesity => "मोटापा";
//   String get TextAppSelectDate => "तारीख़ चुनें";
//   String get TextAppOxygen => "ऑक्सीजन";
//   String get TextAppBlood => "खून";
//   String get TextAppNoRecord => "कोई रिकॉर्ड नहीं";
//   String get TextAppAllExercise => "सभी व्यायाम";
//   String get TextAppCleaningOrMopping => "सफाई या मोपिंग";
//   String get TextAppGardening => "बागवानी";
//   String get TextAppWatchingTV => "टीवी देखना";
//   String get TextAppCycling => "साइकिल चलाना";
//   String get TextAppRunning => "दौड़ना";
//   String get TextAppWalking => "चलना";
//   String get TextAppShuttle => "शटल";
//   String get TextAppTableTennis => "टेबल टेनिस";
//   String get TextAppTennis => "टेनिस";
//   String get TextAppVolleyBall => "वालीबाल";
//   String get TextAppDancing => "नृत्य";
//   String get TextAppFishing => "मछली पकड़ने";
//   String get TextAppShopping => "खरीदारी";
//   String get TextAppTyping => "टाइपिंग";
//   String get TextAppSleeping => "सोना";
//   String get TextAppStanding => "खड़ा है";
//   String get TextAppSitting => "बैठक";
//   String get TextAppClickStartToStartActivity =>
//       "गतिविधि शुरू करने के लिए प्रारंभ करें पर क्लिक करें";
//   String get TextAppCaloriesBurn => "कैलोरी बर्न";
//   String get TextAppAddDurationManually => "मैन्युअल रूप से अवधि जोड़ें";
//   String get TextAppStartOrMopping => "शुरू या मोप करना";
//   String get TextAppMale => "पुरुष";
//   String get TextAppFemale => "महिला";
//   String get TextAppWeightManager => "भार प्रबंधक";
//   String get TextAppUpdateWeight => "अद्यतन भार";
//   String get TextAppSetWeightGoal => "वजन लक्ष्य निर्धारित करें";
//   String get TextAppCurrentWeight => "वर्तमान वजन";
//   String get TextAppWeightProgress => "भार प्रगति";
//   String get TextAppPrevious30Days => "पिछले 30 दिन";
//   String get TextAppYourWeightGoalIsSet => "आपका वजन लक्ष्य निर्धारित है";
//   String get TextAppMaintain => "बनाए रखना";
//   String get TextAppInitialWeightOf => "प्रारंभिक वजन";
//   String get TextAppFinalWeightOf => "का अंतिम वजन";
//   String get TextAppWeight => "वज़न";
//   String get TextAppYouAreNotYetAchievingYourWeightGoalKeepGoing =>
//       "आप अभी तक अपने वजन लक्ष्य को प्राप्त नहीं कर रहे हैं।जाता रहना!";
//   String get TextAppYouAreAchievedYourWeightGoalKeepGoing =>
//       "आप अपना वजन लक्ष्य हासिल कर रहे हैं।जाता रहना!";
//   String get TextAppAndYourWeightChangeIsSet => "और आपका वजन परिवर्तन सेट है";
//   String get TextApp1NutrientsInMyFood => "मेरे भोजन में पोषक तत्व";
//   String get TextAppSearchNutrientsInRawFoods =>
//       "कच्चे खाद्य पदार्थों में पोषक तत्व खोजें";
//   String get TextAppRawIngredients => "कच्ची सामग्री";
//   String get TextAppSearchRawFoodByName => "नाम से कच्चा भोजन खोजें";
//   String get TextApp1MyActivity => "मेरी गतिविधि";
//   String get TextAppCheckOthersDates => "दूसरों की तारीखों की जाँच करें";
//   String get TextAppYour24HoursChart => "आपका 24 घंटे का चार्ट";
//   String get TextAppActivity => "गतिविधि";
//   String get TextAppOthers => "अन्य";
//   String get TextAppExerciseDetails => "व्यायाम विवरण";
//   String get TextAppActivityType => "क्रिया के प्रकार";
//   String get TextAppDuration => "अवधि";
//   String get TextAppMyActivityOfCustomDates => "कस्टम तिथियों की मेरी गतिविधि";
//   String get TextAppOurCustomerFeedback => "हमारी ग्राहक प्रतिक्रिया";
//   String get TextAppOverallRatings => "समग्र रेटिंग";
//   String get TextAppEnterCookedWeight => "पका हुआ वजन दर्ज करें";
//   String get TextAppCookedWeightGram => "पका हुआ वजन (ग्राम)";
//   String get TextAppNutrientIn100gCooked => "100 ग्राम में पोषक तत्व (पका हुआ)";
//   String get TextAppEnterServingSize => "सेवारत आकार दर्ज करें";
//   String get TextAppSearchByRecipeName => "नुस्खा नाम से खोजें";
//   String get TextAppMyPersonalRecipe => "मेरा व्यक्तिगत नुस्खा";
//   String get TextAppFixedRecipe => "नियत नुस्खा";
//   String get TextApp2NutrientsInMyFood => "मेरे भोजन में पोषक तत्व";
//   String get TextAppMyDietDiary => "मेरी आहार डायरी";
//   String get TextApp2MyActivity => "मेरी गतिविधि";
//   String get TextAppDownloadFile => "डाउनलोड फ़ाइल";
//   String get TextAppStartMyNewDietDiary => "मेरी नई आहार डायरी शुरू करें";
//   String get TextAppGoogle => "गूगल";
//   String get TextAppFacebook => "फेसबुक";
//   String get TextAppLinkedin => "Linkedin";
//   String get TextAppTwitter => "ट्विटर";
//   String get TextAppContactUs => "संपर्क करें";
//   String get TextAppReportBug => "रिपोर्ट बग";
//   String get TextAppAttachImage => "छवि संलग्न करें";
//   String get TextAppResetPassword => "पासवर्ड रीसेट";
//   String get TextAppNINAppCreditsPage => "निन ऐप क्रेडिट पेज";
//   String get NINTextOopsSomethingWentWrong => "उफ़!कुछ गलत हो गया";
//   String get NINTextPleaseEnterAllFields => "कृपया सभी फ़ील्ड दर्ज करें";
//   String get NINTextSubmittedSuccessfully1 => "सफलतापूर्वक जमा";
//   String get NINTextSubmittedSuccessfully2 => "सफलतापूर्वक जमा";
//   String get NINTextFitbitAuthentication => "फिटबिट प्रमाणीकरण";
//   String get NINTextHours => "घंटे";
//   String get NINTextMinutes => "मिनट";
//   String get NINTextEnterDurationFor => "के लिए अवधि दर्ज करें";
//   String get NINTextTimerRunning => "टाइमर रनिंग";
//   String get NINTextPleaseStopTheTimerBeforeSubmitting =>
//       "कृपया जमा करने से पहले टाइमर को रोकें";
//   String get NINTextTotalDuration => "कुल अवधि";
//   String get NINTextSec => "सेकंड";
//   String get NINTextStartYourActivity => "अपनी गतिविधि शुरू करें!";
//   String get NINTextPause => "विराम";
//   String get NINTextReset => "रीसेट";
//   String get NINTextError => "गलती";
//   String get NINTextPleaseEnterCookedWeightAndServingSize =>
//       "कृपया पका हुआ वजन और सेवारत आकार दर्ज करें";
//   String get NINTextEditIngredient => "संविधान संपादित करें";
//   String get NINTextAlert => "चेतावनी";
//   String get NINTextEnterWeightFor => "के लिए वजन दर्ज करें";
//   String get NINTextNewWeightGram => "नया वजन (छ)";
//   String get NINTextEditRecipeName => "नुस्खा नाम संपादित करें";
//   String get NINTextNewRecipeName => "नया प्राप्ति नाम";
//   String get NINTextSubmitted => "प्रस्तुत";
//   String get NINTextSuccess => "सफलता";
//   String get NINTextDietaryDiaryReportSavedTo => "आहार डायरी रिपोर्ट को बचाया";
//   String get NINTextErrorSavingFile => "त्रुटि सहेजने वाली फ़ाइल";
//   String get NINTextClose => "बंद करना";
//   String get NINTextIWantTo => "मैं चाहता हूँ";
//   String get NINTextGain => "पाना";
//   String get NINTextMaintain => "बनाए रखना";
//   String get NINTextLose => "खोना";
//   String get NINTextWeightChangeKg => "वजन परिवर्तन (किग्रा)";
//   String get NINTextAddNewWeight => "नया वजन जोड़ें";
//   String get NINTextEnterWeight => "वजन दर्ज करें";
//   String get NINTextOf100Gram => "100 ग्राम का";
//   String get NINTextProximateComposition => "निकटता रचना";
//   String get NINTextVitamins => "विटामिन";
//   String get NINTextMinerals => "खनिज पदार्थ";
//   String get NINTextTotalSaturatedFattyAcids => "कुल संतृप्त फैटी एसिड";
//   String get NINTextAllRecipeOf100Grams => "100 ग्राम का सभी नुस्खा";
//   String get NINTextOurCustomerFeedback => "हमारी ग्राहक प्रतिक्रिया";
//   String get NINTextOverallRatings => "समग्र रेटिंग";
//   String get NINTextRateUs => "हमें रेटिंग दें";
//   String get NINTextBookDetails => "पुस्तक विवरण";
//   String get NINTextOne => "एक";
//   String get NINTextWeightOf => "wt।का";
//   String get NINTextSelectStartDate => "प्रारंभ तिथि का चयन करें";
//   String get NINTextSelectEndDate => "अंतिम तिथि का चयन करें";
//   String get NINTextNoData => "कोई डेटा नहीं";
//   String get NINTextWorkLevel => "कार्य स्तर";
//   String get NINTextOldPassword => "पुराना पासवर्ड";
//   String get NINTextNewPassword => "नया पासवर्ड";
//   String get NINTextUpdateProfile => "प्रोफ़ाइल अपडेट करें";
//   String get NINTextChangeImage => "चित्र को बदलें";
//   String get NINTextNoFavouriteFoodFound => "कोई पसंदीदा भोजन नहीं मिला";
//   String get NINTextCookedQuantity => "पके हुए मात्रा";
//   String get NINTextServingQuantity => "सेवारत मात्रा";
//   String get NINTextNutrientInformation => "पोषक जानकारी";
//   String get NINTextIngredient => "घटक";
//   String get NINTextMealsTakenOn => "भोजन पर लिया गया";
//   String get NINTextPercentage => "को प्रतिशतता";
//   String get NINTextEAR => "कान";
//   String get NINTextValue => "कीमत";
//   String get NINTextNutrient => "पुष्टिकर";
//   String get NINTextEnergyKcal => "ऊर्जा (kcal)";
//   String get NINTextProteinG => "प्रोटीन";
//   String get NINTextFatG => "वसा (जी)";
//   String get NINTextCarbohydratesG => "कार्बोहाइड्रेट";
//   String get NINTextCalciumMg => "कैल्शियम (मिलीग्राम)";
//   String get NINTextFiberG => "फाइबर (जी)";
//   String get NINTextIronMg => "लोहे (मिलीग्राम)";
//   String get NINTextZincMg => "जस्ता (मिलीग्राम)";
//   String get NINTextMagnesiumMg => "मैग्नीशियम (मिलीग्राम)";
//   String get NINTextThiamineB1Mg => "थियामिन (बी 1) (एमजी)";
//   String get NINTextRiboflavinB2Mg => "रेस्पॉन्विन (बीए) (मेजर)";
//   String get NINTextNiacinB3Mg => "नियासिन (बी 3) (संयुक्त राज्य अमेरिका)";
//   String get NINTextFolatesB9Mcg => "फोल्स (बी 9) (एमसीजी)";
//   String get NINTextRetinolVitAMcg => "रेटिनोल (विट ए) (एमसीजी)";
//   String get VitaminCmg => "विटामिन सी (मिलीग्राम)";
//   String get Iodinemcg => "आयोडीन (एमसीजी)";
//   String get serving => "की सेवा";
//   String get Mynutritionstatus => "मेरी पोषण स्थिति";
//   String get ninTextMyHealthStatus => 'मेरी स्वास्थ्य स्थिति';
//   String get ninTextNutrientsInRawFoods => 'कच्चे खाद्य पदार्थों में पोषक तत्व';
//   String get ninTextNutrientsInRecipes => 'रेसिपी में पोषक तत्व';
//   String get ninTextIcmrNinMyPlateForTheDay =>
//       'आईसीएमआर-एनआईएन मेरी प्लेट फॉर द डे';
//   String get ninTextToday => 'आज';
//   String get ninTextTrackMyActivity => 'मेरी गतिविधि का पता लगाएं';
//   String get ninTextMyHeartRate => 'मेरी दिल की दर';
//   String get ninTextMyWaterIntake => 'मेरी पानी की खपत';
//   String get ninTextSleepTracker => 'नींद ट्रैकर';
//   String get ninTextLit => 'प्रकाशित';
//   String get ninTextRecordMyBloodPressure =>
//       'मेरा ब्लड प्रेशर / ब्लड ग्लूकोज / एसपीओ2 रिकॉर्ड करें';
//   String get ninTextNutritionEducationContent => 'पोषण शिक्षा सामग्री';
//   String get ninTextMyNutrientIntake => 'मेरी पोषक तत्व आवंटन';
//   String get ninTextOn => 'पर';
//   String get ninTextWithReferenceToEAR => 'ईएआर के संदर्भ में';
//   String get ninTextAchieveYourHealthGoals =>
//       'अपने स्वास्थ्य लक्ष्य प्राप्त करें';
//   String get ninTextPercentage => 'प्रतिशत';
//   String get ninTextMyPreviousDietDiaries => 'मेरा पिछला आहार डायरी';
//   String get ninTextRecordReviewSleep => 'नींद का रिकॉर्ड/समीक्षा';
//   String get ninTextHours => 'घंटे';
//   String get ninTextIngredient => 'सामग्री';
//   String get ninTextOthersSpecify => 'अन्य विशेषित करें';
//   String get ninTextAddNewIngredient => 'नई सामग्री जोड़ें';
//   String get ninTextFoodName => 'खाद्य पदार्थ का नाम';
//   String get ninTextSource => 'स्रोत';
//   String get ninTextEnterBrandAndProductName =>
//       'ब्रांड और उत्पाद का नाम दर्ज करें';
//   String get ninTextEnterAuthorDetails =>
//       'लेखक का नाम, वर्ष, पत्रिका, पृष्ठ दर्ज करें';
//   String get ninTextEnterFctName => 'एफसीटी का नाम दर्ज करें';
//   String get ninTextName => 'नाम';
//   String get ninTextProductName => 'उत्पाद का नाम';
//   String get ninTextSelectStartDate => 'प्रारंभ तिथि का चयन करें';
//   String get ninTextSelectEndDate => 'समाप्ति तिथि का चयन करें';
//   String get ninTextNoExercise => 'कोई व्यायाम नहीं';
//   String get ninTextDevelopedWithExpertiseAndInputs =>
//       'एनआईएन द्वारा विशेषज्ञता और इनपुट के साथ विकसित किया गया';
//   String get ninTextMyNutrientIntakeToday => 'मेरा पोषक तत्व आवंटन आज';
//   String get ninTextIcmrNationalInstituteOfNutritionAddress =>
//       'आईसीएमआर - राष्ट्रीय पोषण संस्थान टर्नाका मेट्रो स्टेशन के पास, जमाई-उस्मानिया पीओ, हैदराबाद-500 007, भारत।';
//   String get ninTextKcal => 'कैलोरी';
//   String get ninTextKcalPerDay => 'कैलोरी/दिन';
//   String get ninTextDeleteNotification => 'अधिसूचना हटाएं';
//   String get ninTextConfirmDeleteNotification =>
//       'क्या आप वाकई इस अधिसूचना को हटाना चाहते हैं?';
//   String get ninTextTimeFor => 'हे, अब समय हो गया है';
//   String get ninTextFitbitWatch => 'फिटबिट घड़ी';
//   String get ninTextGoogleFitApp => 'गूगल फिट ऐप';
//   String get ninTextUnderweight => 'कमजोरी';
//   String get ninTextNormal => 'सामान्य';
//   String get ninTextOverweight => 'अतिरिक्त वजन';
//   String get ninTextObesity => 'मोटापा';
//   String get ninTextMale => 'पुरुष';
//   String get ninTextFemale => 'महिला';
//   String get ninTextAgeInYears => 'आयु (साल में)';
//   String get ninTextChangeInWeight => 'वजन में परिवर्तन';
//   String get ninTextSteps => 'कदम';
//   String get ninTextFor => 'के लिए';
//   String get ninTextMinutes => 'मिनट';
//   String get ninTextPause => 'रोकें';
//   String get ninTextReset => 'रीसेट';
//   String get ninTextStartActivity => 'अपनी गतिविधि शुरू करें';
//   String get ninTextCartIsEmpty => 'आपका कार्ट खाली है';
//   String get ninTextMyPersonalRecipe => 'मेरा व्यक्तिगत रेसिपी';
//   String get ninTextSearchByRecipeName => 'रेसिपी के नाम से खोजें';
//   String get ninTextHelpCenter => 'सहायता केंद्र';
//   String get ninTextDelete => 'हटाएं';
//   String get your => 'आपका';

//   String get ninTextCommonProblems => 'सामान्य समस्याएं';
//   String get ninTextFAQs => 'सामान्य प्रश्न';
//   String get ninTextHowActiveAreYou => 'आप कितने सक्रिय हैं?';
//   String get ninTextVitaminC => 'विटामिन सी (मि.ग्रा.)';
//   String get ninTextVitaminA => 'विटामिन ए (आईयू)';
//   String get ninTextSodium => 'सोडियम (मि.ग्रा.)';
//   String get ninTextJournal => 'जर्नल';
//   String get ninTextPage => 'पृष्ठ';
//   String get ninTextAdequateIntakeCarbs =>
//       '*कार्बोहाइड्रेट के लिए पर्याप्त आवश्यकता (ए.आई.) सिफारिश: वयस्क पुरुष और महिलाओं के लिए 130 ग्राम।';
//   String get ninTextAdequateIntakeFiber =>
//       '**फाइबर के लिए पर्याप्त आवश्यकता (ए.आई.) सिफारिश: महिलाओं के लिए 25 ग्राम और पुरुषों के लिए 38 ग्राम।';
//   String get question1 => 'क्या मैं अपना व्यक्तिगत विवरण संपादित कर सकता हूँ?';
//   String get answer1 =>
//       'हाँ। आप अपने प्रोफाइल में अपने व्यक्तिगत डेटा को संपादित कर सकते हैं।';
//   String get linkText1 =>
//       'अपना व्यक्तिगत विवरण संपादित करने के लिए यहाँ क्लिक करें';

//   String get question2 => 'क्या मैं अपना संपर्क विवरण बदल सकता हूँ?';
//   String get answer2 =>
//       'हाँ। आप अपने प्रोफाइल में जाकर ‘व्यक्तिगत डेटा’ विकल्प में अपना संपर्क विवरण बदल सकते हैं।';
//   String get linkText2 =>
//       'अपने संपर्क विवरण संपादित करने के लिए यहाँ क्लिक करें';

//   String get question3 => 'क्या मैं अपना पासवर्ड बदल सकता हूँ?';
//   String get answer3 =>
//       'हाँ। आप अपने प्रोफाइल में जाकर ‘सेटिंग’ विकल्प में अपना पासवर्ड बदल सकते हैं।';
//   String get linkText3 => 'अपना पासवर्ड बदलने के लिए यहाँ क्लिक करें';

//   String get question4 => 'मैं अपना बीएमआई कैसे जांच सकता हूँ?';
//   String get answer4 =>
//       'आप अपने होम पेज में दिखाई गई ‘स्वास्थ्य कैलकुलेटर’ विकल्प में अपनी ऊंचाई और शरीर के वजन को दर्ज करके ‘बीएमआई कैलकुलेटर’ में अपना बीएमआई जांच सकते हैं।';
//   String get linkText4 =>
//       'बीएमआई कैलकुलेटर का उपयोग करने के लिए यहाँ क्लिक करें';

//   String get question5 => 'क्या मैं पिछले महीने का वजन ट्रैक कर सकता हूँ?';
//   String get answer5 =>
//       'हाँ। आप होम पेज में दिए गए ‘वेट मैनेजर’ विकल्प में पिछले महीने/साल के अपने शारीरिक वजन में परिवर्तनों का विवरण देख सकते हैं।';
//   String get linkText5 => 'अपने वजन को ट्रैक करने के लिए यहाँ क्लिक करें';

//   String get question6 =>
//       'मैं किसी विशेष दिन पर अपनी कुल शारीरिक गतिविधि कैसे जांच सकता हूँ?';
//   String get answer6 =>
//       'आप होम पेज में ‘माय एक्टिविटी’ विकल्प से अपनी शारीरिक गतिविधि का ट्रैक कर सकते हैं।';
//   String get linkText6 => 'अपनी गतिविधि देखने के लिए यहाँ क्लिक करें';

//   String get question7 =>
//       'मैं पानी की खपत के लिए एक याद दिलाने को कैसे सेट कर सकता हूँ?';
//   String get answer7 =>
//       'आप होम पेज में दिए गए ‘सेट नोटिफिकेशन’ विकल्प में पानी की खपत के लिए समय सेट कर सकते हैं।';
//   String get linkText7 => 'एक पानी की खपत याद दिलाने के लिए यहाँ क्लिक करें';

//   String get question8 =>
//       'मैं अपनी स्मार्ट घड़ी को ऐप के साथ कैसे इंटीग्रेट कर सकता हूँ?';
//   String get answer8 =>
//       'आप होम पेज में दिए गए ‘वाच जोड़ें’ विकल्प में अपनी स्मार्ट घड़ी को ऐप के साथ इंटीग्रेट कर सकते हैं।';
//   String get linkText8 =>
//       'अपनी स्मार्ट घड़ी को कनेक्ट करने के लिए यहाँ क्लिक करें';

//   String get question9 =>
//       'मैं ऐप के साथ कितनी पहनने वाले डिवाइस को एक साथ इंटीग्रेट कर सकता हूँ?';
//   String get answer9 =>
//       'आप ऐप के साथ फिटबिट घड़ी और गूगल फिट को इंटीग्रेट कर सकते हैं।';
//   String get linkText9 => '';

//   String get question10 => 'कौन सी स्मार्ट घड़ियाँ ऐप के साथ संगत हैं?';
//   String get answer10 => 'फिटबिट घड़ी और गूगल फिट।';
//   String get linkText10 => '';

//   String get question11 =>
//       'क्या मैं अपनी गतिविधि को ट्रैक कर सकता हूँ अगर मेरे पास स्मार्ट घड़ी नहीं है?';
//   String get answer11 =>
//       'हाँ, आप अपनी गतिविधि को ट्रैक कर सकते हैं। इसके लिए, आपको गूगल फिट ऐप डाउनलोड करना होगा, एक गूगल खाता के साथ साइन इन करना होगा, और फिर उसी गूगल खाते से हमारे वाच खंड में लॉग इन करना होगा।';
//   String get linkText11 => '';

//   String get question12 => 'मैं अपनी नींद को कैसे ट्रैक कर सकता हूँ?';
//   String get answer12 =>
//       'आप होम पेज में दिए गए ‘नींद ट्रैकर’ विकल्प में हफ्ते/महीने के आधार पर अपनी नींद को ट्रैक कर सकते हैं।';
//   String get linkText12 => 'अपनी नींद को ट्रैक करने के लिए यहाँ क्लिक करें';

//   String get question13 =>
//       'मैं कैसे ऐप के माध्यम से किसी भी एनआईएन प्रकाशन को खरीद सकता हूँ?';
//   String get answer13 =>
//       'आप होम पेज में दिए गए ‘बुक स्टोर’ विकल्प से एनआईएन प्रकाशनों को खरीद सकते हैं।';
//   String get linkText13 => 'बुक स्टोर पर जाने के लिए यहाँ क्लिक करें';

//   String get question14 => 'मैं अपना व्यक्तिगत आहार डायरी कैसे बना सकता हूँ?';
//   String get answer14 =>
//       'आप दिनभर खाने की जानकारी दर्ज करके अपनी खाने की डायरी के विकल्प में जाकर विवरण दर्ज कर सकते हैं।';
//   String get linkText14 => 'अपनी आहार डायरी बनाने के लिए यहाँ क्लिक करें';

//   String get question15 =>
//       'मैं कैसे किसी खाद्य पदार्थ में किसी विशेष पोषक तत्व से धनी रेसिपी खोज सकता हूँ?';
//   String get answer15 =>
//       'आप पहले होम पेज में दिए गए ‘न्यूट्रिएंट्स इन माय फूड’ टैब में दिए गए ‘रेसिपी में न्यूट्रिएंट्स खोजें’ विकल्प को चुनें। फिर ऊपर दाईं ओर ड्रॉप-डाउन सूची से आवश्यक पोषक तत्व का चयन करें।';
//   String get linkText15 => 'रेसिपीज़ खोजने के लिए यहाँ क्लिक करें';

//   String get question16 =>
//       'मैं कैसे अपनी पिछले महीने सहेजी गई दिन की पोषण लेन की जांच कर सकता हूँ?';
//   String get answer16 =>
//       'आप ‘मील सूची’ पृष्ठ में ‘कैलेंडर आइकन’ से एक तिथि का चयन करके एक विशिष्ट दिन के लिए अपनी पोषण लेन को देख सकते हैं।';
//   String get linkText16 => 'अपनी पोषण लेन की जांच करने के लिए यहाँ क्लिक करें';

//   String get question17 =>
//       'मैं अपनी रेसिपी में प्रयोग किए गए कच्चे उपयोग हुए सामग्रियों के पोषक तत्व कैसे जान सकता हूँ?';
//   String get answer17 =>
//       'आप पहले होम पेज में दिए गए ‘न्यूट्रिएंट्स इन माय फूड’ टैब में दिए गए ‘रॉ फूड्स में न्यूट्रिएंट्स खोजें’ विकल्प को चुनें।';
//   String get linkText17 =>
//       'कच्चे खाद्य पदार्थों में पोषक तत्व खोजने के लिए यहाँ क्लिक करें';

//   String get question18 => 'मैं किसी रेसिपी की पोषक संरचना कैसे जान सकता हूँ?';
//   String get answer18 =>
//       'आप पहले होम पेज में दिए गए ‘न्यूट्रिएंट्स इन माय फूड’ टैब में दिए गए ‘रेसिपी में न्यूट्रिएंट्स खोजें’ विकल्प को चुनें।';
//   String get linkText18 => 'पोषक संरचना जानने के लिए यहाँ क्लिक करें';

//   String get question19 =>
//       'क्या मैं ऐप में उपलब्ध नहीं होने वाली किसी नई रेसिपी को शामिल कर सकता हूँ?';
//   String get answer19 =>
//       'हाँ। आप या तो किसी मौजूदा रेसिपी को संशोधित कर सकते हैं जिसे विशेष फिक्स रेसिपी के निचले भाग में दिए गए लिंक का प्रयोग करके, या पूरी तरह से नई रेसिपी बना सकते हैं, जिसका प्रत्येक भोजन में डायरी पृष्ठ में ‘कस्टम डिश बनाएं’ विकल्प प्रदान किया गया है।';
//   String get linkText19 => 'कस्टम रेसिपी बनाने के लिए यहाँ क्लिक करें';

//   String get question20 =>
//       'क्या मुझे किसी विशेष स्वास्थ्य स्थिति के लिए आहारिक सिफारिश मिल सकती है?';
//   String get answer20 =>
//       'हाँ। आप होम पेज में दिए गए ‘खोज कॉम्पोनेंट’ विकल्प से स्वास्थ्य सिफारिशें या आहार चार्ट दिशानिर्देश प्राप्त कर सकते हैं।';
//   String get linkText20 => 'आहारिक सिफारिश प्राप्त करने के लिए यहाँ क्लिक करें';

//   String get question21 =>
//       'क्या मैं अंग्रेजी के अलावा किसी अन्य भाषा में ऐप का उपयोग कर सकता हूँ?';
//   String get answer21 =>
//       'हाँ। आप अपने प्रोफाइल में दिए गए ‘सेटिंग’ विकल्प से वांछित भाषा का चयन कर सकते हैं।';
//   String get linkText21 => 'भाषा बदलने के लिए यहाँ क्लिक करें';
//   String get ninTextBmiHwading => 'शारीरिक माप (BMI) :';
//   String get ninTextBmiDiscription =>
//       'BMI को व्यक्ति के वजन के किलोग्राम में व्यक्ति की ऊँचाई के मीटर में वर्ग (kg/m2) से विभाजित किया जाता है। BMI शरीर के अत्यधिक शरीर वसा के प्रभाव पर रोग और मौत की स्थिति के आधार पर हैं और तोड़ और संबंधित रूप से अधिक हैं। BMI एक रोग के जोखिम चिह्नात्मक के रूप में विकसित किया गया था; जैसे ही BMI बढ़ता है, कुछ बीमारियों का जोखिम बढ़ता है। जिर्ण और मोटापे से संबंधित कुछ सामान्य स्थितियों में: पूर्वघटना, हृदय रोग, उच्च रक्तचाप, ऑस्टियोआर्थ्राइटिस, कुछ कैंसर, और मधुमेह।';
//   String get ninTextbminutritionsta => 'BMI पोषण स्थिति';
//   String get ninTextNutritionstat => 'पोषण स्थिति';
//   String get ninTextBelow => 'नीचे';
//   String get ninTextPreobesity => 'पूर्व ओबेसिटी';
//   String get ninTextAchieveyourhealthgoal =>
//       'अपने स्वास्थ्य लक्ष्य को प्राप्त करें';

//   String get ninTextbesity => 'ओबेसिटी कक्षा I';
//   String get ninTextbesity2 => 'ओबेसिटी कक्षा II';
//   String get heavyDescription =>
//       'इस श्रेणी में उन व्यवसायों का समावेश होता है जिनमें नियमित और तीव्र शारीरिक गतिविधि होती है, जैसे दौड़ना, साइकिलिंग, या भारी वस्तुओं को उठाना, और यह अधिकतम घंटे प्रतिदिन होता है। उदाहरणों में शामिल हैं लोहार, खनिज, और निर्माण कार्यकर्ता।';
//   String get moderateDescription =>
//       'इस श्रेणी में व्यक्ति कुछ स्तर की शारीरिक गतिविधि करते हैं, जैसे चलना या हल्की दौड़, और यह लगभग 30 मिनट से एक घंटे तक प्रतिदिन होता है। मानव श्रमिक, कारीगर, और कुछ प्रकार के कुशल कार्यकर्ता इस श्रेणी में आते हैं।';
//   String get sedentaryDescription =>
//       'इस श्रेणी में व्यावसायिक नौकरियां शामिल हैं जिनमें पूरे दिन शारीरिक गतिविधि कम या नहीं होती है। इन कामों में लोग अधिकांश समय बैठे या लेटे रहते हैं। उदाहरणों में कार्यालय कर्मचारी, शिक्षक, और प्रशासनिक भूमिकाओं में लोग शामिल हैं।';

//   String get ninTextbesity3 => 'ओबेसिटी कक्षा III';
//   String get ninTextBMRfull => 'मूलभूत अवशेषित दर (BMR)';
//   String get ninTextBMRDiscription =>
//       'मूलभूत अवशेषित दर (BMR) व्यक्ति शांत अवस्था में ऊर्जा खपत की दर है';
//   String get ninTextPreviousdays => 'पिछले 30 दिन';
//   String get ninTextason => 'जैसा कि';
//   String get ninTextYearly => 'सालाना';
//   String get ninTextabove => 'ऊपर';
//   String get Foodprotein => "प्रोटीन";
//   String get Foodfat => "वसा";
//   String get Foodenergy => "ऊर्जा";
//   String get FoodtotalB2 => "कुल बी2";
//   String get Foodvitamins => "विटामिन्स";
//   String get FoodtotalFat => "कुल वसा";
//   String get FoodproximateComposition => "प्राकृतिक संरचना";
//   String get FoodnutrientsIn100g => "100 ग्राम में पोषक तत्व";
//   String get FoodtotalCarotenoids => "कुल कैरोटिनॉयड्स";
//   String get FoodtotalAscorbicAcid => "कुल एस्कॉर्बिक एसिड";
//   String get FoodtotalB9 => "कुल बी9";
//   String get FoodtotalB6 => "कुल बी6";
//   String get Foodcalcium => "कैल्शियम";
//   String get Foodsodium => "सोडियम";
//   String get Foodpotassium => "पोटैशियम";
//   String get Foodzinc => "जिंक";
//   String get Foodiron => "लौह";
//   String get Foodminerals => "खनिज";
//   String get FoodtotalSaturatedFattyAcids => "कुल संतृप्त फैटी एसिड";
//   String get FoodfattyAcids => "फैटी एसिड्स";
//   String get FoodtotalDietaryFiber => "कुल आहारी फाइबर";
//   String get Foodmanganese => "मैंगनीज";
//   String get Foodcopper => "तांबा";
//   String get Foodselenium => "सेलेनियम";
//   String get Foodmagnesium => "मैग्नीशियम";
//   String get Foodphosphorus => "फास्फोरस";
//   String get Foodcholesterol => "कोलेस्ट्रॉल";
//   String get Foodcarbohydrate => "कार्बोहाइड्रेट";
//   String get FoodvitaminB6 => "विटामिन बी6 (मि.ग्रा.)";
  @override
  String get appName => "NIN2.0";

  @override
  String get labelWelcome => "स्वागत";

  @override
  String get labelSelectLanguage => "भाषा चुने";

  @override
  String get labelInfo => "यह बहु-भाषा डेमो एप्लिकेशन है";

  @override
  // TODO: implement labelChangeLanguage
  String get labelChangeLanguage => "भाषा बदलें";
  @override
  String get labelWelcomeBack => "वापसी पर स्वागत है,";

  @override
  String get labelUnderweight => "आपका वज़न कम है";

  @override
  String get labelNormalWeight => "आपका वज़न सामान्य है";

  @override
  String get labelOverweight => "आपका वजन अधिक है";

  @override
  String get labelObese => "आप मोटे हैं";

  @override
  String get labelViewMore => "और देखें";

  @override
  String get labelTodaySteps => "आज के कदम";

  @override
  String get labelCheck => "जाँच करना";

  @override
  String get labelHealthData => "मेरा रक्तचाप/रक्त ग्लूकोज/एसपीओ2 रिकॉर्ड करें";

  @override
  String get labelActivityStatus => "गतिविधि स्थिति";

  @override
  String get labelHeartRate => "हृदय दर";

  @override
  String get labelHeartRateValue => "78 बीपीएम";

  @override
  String get labelMinutesAgo => "मिनट पहले";

  @override
  String get labelWaterIntake => "मेरा जल सेवन";

  @override
  String get labelLiters => "लीटर";

  @override
  String get labelZeroLiters => "0 लीटर";

  @override
  String get labelRealTimeGoal => "वास्तविक समय, लक्ष्य";

  @override
  String get labelCalories => "कैलोरी बर्न हुई";

  @override
  String get labelCaloriesEarned => "कैलोरी अर्जित की";

  @override
  String get labelFoodPlan => "भोजन योजना";

  @override
  String get labelWorkoutProgress => "कसरत की प्रगति";

  @override
  String get labelWeekly => "साप्ताहिक";

  @override
  String get labelMonthly => "महीने के";

  @override
  String get labelLatestWorkout => "नवीनतम कसरत";

  @override
  String get labelSeeMore => "और देखें";
  @override
  String get labelBreakfast => "नाश्ता";
  @override
  String get labelLunch => "दिन का खाना";
  @override
  String get labelDinner => "रात का खाना";
  @override
  String get labelSnacks => "नाश्ता";
  @override
  String get labelTaken => "लिया";
  @override
  String get labelTarget => "लक्ष्य";

  //profile

  @override
  String get labelProfile => "प्रोफ़ाइल";
  @override
  String get labelEdit => "संपादन करना";
  @override
  String get labelUser => "उपयोगकर्ता";
  @override
  String get labelProgram => "एक मोटा कार्यक्रम खोना";
  @override
  String get labelHeight => "ऊंचाई";
  @override
  String get labelWeight => "वज़न";
  @override
  String get labelAge => "आयु";
  @override
  String get labelAccount => "खाता";
  @override
  String get labelPersonalData => "व्यक्तिगत डेटा";
  @override
  String get labelAchievement => "उपलब्धि";
  @override
  String get labelActivityHistory => "गतिविधि इतिहास";
//String get labelWorkoutProgress => "कसरत प्रगति";
  @override
  String get labelNotification => "अधिसूचना";
  @override
  String get labelPopupNotification => "पापुलेशन इन्वर्शन";
  @override
  String get labelMensurationCycle => "चक्र माप";
  @override
  String get labelOther => "अन्य";
  @override
  String get labelContactUs => "संपर्क करें";
  @override
  String get labelPrivacyPolicy => "गोपनीयता नीति";
  @override
  String get labelSetting => "सेटिंग";
  @override
  String get labelFeedback => "प्रतिक्रिया";
  @override
  String get labelConfirmLogout => "लॉगआउट की पुष्टि करें";
  @override
  String get labelConfirmLogoutMessage => "क्या आप लॉग आउट करना चाहते हैं?";
  @override
  String get labelLogout => "लॉग आउट";
  //select tab
  @override
  String get labelOptions => "विकल्प";
  @override
  String get labelFoodTable => "भोजन जोड़ें";
  @override
  String get labelTop10Food => "शीर्ष 10 भोजन";
  @override
  String get labelActivityTrack => "गतिविधि ट्रैकर";
  @override
  String get labelsteptracker => "कदम ट्रैकर";

  @override
  String get labelTodayTarget => "जल लक्ष्य";
  @override
  String get labelJoggingTrack => "जॉगिंग ट्रैक";
  @override
  String get labelMensurationTrack => "क्षेत्रमिति ट्रैक";
//String get labelFoodTable => "खाने की मेज";
  @override
  String get labelPassword => "पासवर्ड बदलें";
  @override
  String get labelDarkMode => "डार्क मोड आज़माएं";
  @override
  String get labelconectWatch => "घड़ी कनेक्ट करें";
  @override
  String get labelSleep => "नींद";
  @override
  String get labelBookStore => "किताब की दुकान";
  @override
  String get labelSearchBooks => "पुस्तकें खोजें";
  @override
  String get labelPrice => "कीमत";
  @override
  String get labelAddToCart => "कार्ट में जोड़ें";
  @override
  String get labelAuthor => "लेखक";
  @override
  String get labelYear => "वर्ष";
  @override
  String get labelQuantityAvailable => "उपलब्ध मात्रा";
  @override
  String get labelCart => "कार्ट में जोड़ें";
  @override
  String get labelMyOrders => "मेरे आदेश";
  @override
  String get labelAllOrders => "सभी आदेश";
  @override
  String get labelOrderDetail => "ऑर्डर विवरण";
  @override
  String get labelOrderId => "आदेश कामतत्व";
  @override
  String get labelOrdersInMyOrders => "मेरे आदेशों में आदेश";
  @override
  String get labelItemsInMyOrders => "मेरे ऑर्डर में आइटम";
  @override
  String get labelTotal => "कुल";
  @override
  String get labelTotalPrice => "कुल कीमत";
  @override
  String get labelCheckout => "चेक आउट";

  // Meal List
  @override
  String get labelMealList => "मेरा आहार";
  @override
  String get labelAnalyze => "विश्लेषण";
  @override
  String get labelAddDish => "डिश जोड़ें";
  @override
  String get labelTop10Foods => "शीर्ष 10 खाद्य पदार्थ";
  @override
  String get labelRecentMeal => "हाल का भोजन";
  @override
  String get labelAnalyzeIngredientsTaken => "भोजन सेवन का विश्लेषण करें";

  // Nutrition Summary
  @override
  String get labelCarbs => "कार्बोहाइड्रेट";
  // @override
  // String get labelCalories => "कैलोरी";
  @override
  String get labelFibers => "कुल फाइबर";
  @override
  String get labelFats => "मोटा";
  @override
  String get labelProteins => "प्रोटीन";
  @override
  String get labelCalcium => "कैल्शियम";

  @override
  String get labelNiacinB3 => "नियासिन (बी3)";

  @override
  String get labelThiamineB1 => "थियामिन (बी1)";

  @override
  String get labelIron => "लोहा";

  @override
  String get labelZinc => "जस्ता";

  @override
  String get labelFolatesB9 => "फोलेट (बी9)";

  @override
  String get labelRiboflavinB2 => "राइबोफ्लेविन (बी2)";

  @override
  String get labelRetinolVitA => "रेटिनॉल (विटामिन ए)";

  @override
  String get labelMagnesium => "मैगनीशियम";

  @override
  String get labelTodaysNutritionSummary => "आज का पोषण सारांश";
  @override
  String get labelChangeGoal => "लक्ष्य बदलें";
  @override
  String get labelIngredientsTaken => "सामग्री ली गई";
  @override
  String get labelIngredientsLeft => "सामग्री बची है";

  // Food Table
  // @override
  // String get labelFoodTable => "खाने की मेज";
  // @override
  // String get labelBreakfast => "नाश्ता";
  // @override
  // String get labelLunch => "दिन का खाना";
  // @override
  // String get labelDinner => "रात का खाना";
  // @override
  // String get labelSnacks => "नाश्ता";
  @override
  String get labelTop10FoodsSleep => "शीर्ष 10 खाद्य पदार्थ";
  @override
  String get labelFavouriteDishes => "पसंदीदा व्यंजन";

  // User Profile
  @override
  String get labelHelp => "मदद";
  // @override
  // String get labelLogout => "लॉग आउट";
  // @override
  // String get labelWeight => "वज़न";
  @override
  String get labelEmail => "ईमेल";
  // @override
  // String get labelHeight => "ऊंचाई";
  @override
  String get labelLinkedInProfileLink => "लिंक्डइन प्रोफ़ाइल लिंक";
  @override
  String get labelGoogleProfileLink => "गूगल प्रोफ़ाइल लिंक";
  @override
  String get labelFacebookProfileLink => "फेसबुक प्रोफ़ाइल लिंक";
  @override
  String get labelTwitterProfileLink => "ट्विटर प्रोफ़ाइल लिंक";
  @override
  String get labelName => "नाम";
  @override
  String get labelPhoneNumber => "फोन नंबर।";
  @override
  String get labelDateOfBirth => "जन्मतिथि";
  @override
  String get labelBMI => "बीएमआई";
  // @override
  // String get labelAge => "आयु";

  // Contact Us
  @override
  String get labelMessage => "संदेश";
  @override
  String get labelSubmit => "जमा करना";
  @override
  String get labelCompanyContacts => "कंपनी संपर्क";
  @override
  String get labelAddress => "पता";
  @override
  String get labelDirectorsEmail => "निदेशक का ईमेल";
  @override
  String get labelFax => "फैक्स";

  // Settings
  @override
  String get labelResetPassword => "पासवर्ड रीसेट";
  // @override
  // String get labelFeedback => "प्रतिक्रिया";
  @override
  String get labelPleaseProvideFeedback => "कृपया अपनी प्रतिक्रिया दें";
  @override
  String get labelEnterYourFeedbackHere => "अपनी प्रतिक्रिया यहां दर्ज करें";
  @override
  String get labelSubmitFeedback => "प्रतिपुष्टि दें";

  // Credits
  // @override
  // String get labelContactUs => "संपर्क करें";
  @override
  String get labelDevelopmentTeam => "विकास दल";
  @override
  String get labelAcknowledgments => "स्वीकृतियाँ";
  @override
  String get labelPartnerships => "भागीदारी";

  // Mobile
  @override
  String get labelSearchComponents => "घटक खोजें";
  @override
  String get labelSearchComponentsHere => "यहां घटक खोजें";
  @override
  String get lablelDishName => 'डिश का नाम';
  @override
  String get labelCredits => 'क्रेडिट';
  @override
  String get labelShareAppButton => "शेयर करना";
  @override
  String get labelShareApp =>
      "बारकोड स्कैनर ऐप से क्यूआर कोड को स्कैन करें और ऐप डाउनलोड करें";
  // New translations
  @override
  String get labelConnectedWatch => "कनेक्टेड घड़ी है";
  @override
  String get labelDisconnect => "डिस्कनेक्ट";
  @override
  String get labelFitbit => "Fitbit";
  @override
  String get labelGoogleFit => "गूगल फ़िट";
  @override
  String get labelAppleWatch => "एप्पल घड़ी";
  @override
  String get labelSamsungSmartWatch => "सैमसंग स्मार्ट घड़ी";
  @override
  String get labelBookDetails => "पुस्तक विवरण";
  @override
  String get labelDeliverystatus => "डिलीवरी स्थिति";
  @override
  String get labelOrderDate => "आर्डर की तारीख";
  @override
  String get labelAnalyseIngredientsTaken => "भोजन सेवन का विश्लेषण करें";
  @override
  String get labelAddDishIngredients => "पकवान सामग्री जोड़ें";
  @override
  String get labelIngredientName => "संघटक का नाम";
  @override
  String get labelEnterIngredientName => "एक घटक का नाम दर्ज करें";
  @override
  String get labelIngredientQuantity => "संघटक मात्रा";
  @override
  String get labelEnterIngredientQuantity => "घटक मात्रा दर्ज करें";
  @override
  String get labelAdd => "जोड़ना";
  @override
  String get labelSave => "बचाना";
  @override
  String get labelwatch => "घड़ी";

  //
  @override
  String get labelBloodOxygenHeart =>
      'महत्वपूर्ण संकेतों को मापें और समग्र स्वास्थ्य पर नज़र रखें।';
  @override
  String get labelTop10FoodS =>
      'स्वस्थ जीवनशैली बनाए रखने के लिए अनुशंसित खाद्य पदार्थों की खोज करें।';
  @override
  String get labelWaterTrack =>
      'दैनिक फिटनेस हाइड्रेशन लक्ष्य निर्धारित करें और प्राप्त करें।';
  @override
  String get labelPersonalDetails =>
      'व्यक्तिगत जानकारी को सुरक्षित रूप से प्रबंधित और अद्यतन करें।';
  @override
  String get labelFeedbackS => 'अपने विचार और सुझाव हमारे साथ साझा करें।';
  @override
  String get labelContactUsS => 'ग्राहक सहायता तक पहुंचें और हमसे संपर्क करें।';
  @override
  String get labelBMICalculator =>
      'स्वास्थ्य संबंधी जानकारी के लिए अपने बॉडी मास इंडेक्स की गणना करें।';
  @override
  String get labelBMRCalculator =>
      'फिटनेस योजना के लिए अपने बेसल मेटाबॉलिक रेट की गणना करें।';
  @override
  String get labelRunningJoggingSteps =>
      'स्वस्थ जीवनशैली के लिए अपने दौड़ने और जॉगिंग के चरणों पर नज़र रखें।';
  @override
  String get labelHealthyDietChart =>
      'स्वस्थ आहार अवलोकन के लिए एक व्यापक चार्ट तक पहुंचें।';
  @override
  String get labelHealthyRecommendation =>
      'वैयक्तिकृत स्वास्थ्य अनुशंसाएँ प्राप्त करें।';
  @override
  String get labelSleepTracker =>
      'अपनी नींद के पैटर्न को ट्रैक करें और नींद की गुणवत्ता में सुधार करें।';
  @override
  String get labelSetReminder =>
      'स्वास्थ्य और फिटनेस गतिविधियों के लिए अनुस्मारक सेट करें।';
  // @override
  // String get labelMenstruationCycle =>
  //     'बेहतर जानकारी के लिए अपने मासिक धर्म चक्र को ट्रैक और प्रबंधित करें।';
  @override
  String get labelCSVDownload =>
      'आसान विश्लेषण के लिए अपना डेटा सीएसवी प्रारूप में डाउनलोड करें।';

  // New Headings
  @override
  String get headingBloodOxygenHeart => 'रक्त | ऑक्सीजन';
  @override
  String get headingTop10Food => 'शीर्ष 10 भोजन';
  @override
  String get headingWaterTrack => 'जल ट्रैकर';
  @override
  String get headingPersonalDetails => 'व्यक्तिगत विवरण';
  @override
  String get headingFeedback => 'प्रतिक्रिया';
  @override
  String get headingContactUs => 'संपर्क करें';
  @override
  String get headingBMICalculator => 'बीएमआई कैलकुलेटर';
  @override
  String get headingBMRCalculator => 'बीएमआर कैलकुलेटर';
  @override
  String get headingRunningJoggingSteps => 'दौड़ना/जॉगिंग/कदम';
  @override
  String get headingHealthyDietChart => 'स्वस्थ आहार चार्ट';
  @override
  String get headingHealthyRecommendation => 'स्वस्थ अनुशंसा';
  @override
  String get headingSleepTracker => 'स्लीप ट्रैकर';
  @override
  String get headingSetReminder => 'अनुस्मारक सेट करें';
  // @override
  // String get headingMenstruationCycle => 'मासिक धर्म चक्र';
  @override
  String get headingCSVDownload => 'सीएसवी डाउनलोड';

  // Water-related phrases
  @override
  String get labelWaterTarget => "जल लक्ष्य";
  // @override
  // String get labelTodayTarget => "आज का लक्ष्य";
  @override
  String get labelWaterGoal => "जल लक्ष्य";
  // @override
  // String get labelWaterIntake => "पानी सेवन";
  @override
  String get labelWaterProgress => "जल प्रगति";
  // @override
  // String get labelWeekly => "साप्ताहिक";
  @override
  String get labelDateWise => "तिथिवार";
  @override
  String get labelSun => "सूरज";
  @override
  String get labelMon => "सोमवार";
  @override
  String get labelTue => "मंगल";
  @override
  String get labelWed => "बुध";
  @override
  String get labelThu => "गुरु";
  @override
  String get labelFri => "शुक्र";

  // BMI Calculator
  // @override
  // String get labelBMI => "बीएमआई";
  @override
  String get labelEnterHeight => "ऊंचाई दर्ज करें (सेमी)";
  @override
  String get labelEnterWeight => "वज़न दर्ज करें (किग्रा)";
  @override
  String get labelCalculateBMI => "बीएमआई की गणना करें";

  // BMR Calculator
  @override
  String get labelMale => "पुरुष";
  @override
  String get labelFemale => "महिला";
  @override
  String get labelEnterAge => "आयु दर्ज करें";
  @override
  String get labelCalculateBMR => "बीएमआर की गणना करें";
  @override
  String get labelBMR => "बीएमआर";
  @override
  String get labelCaloriesPerDay => "कैलोरी/दिन";

  // Step Tracker
  @override
  String get labelStepsTracker => "कदम ट्रैकर";
  @override
  String get labelRunningTracker => "रनिंग ट्रैकर";
  @override
  String get labelAddStep => "चरण जोड़ें";
  @override
  String get labelSelectDate => "तारीख़ चुनें";
  @override
  String get labelJoggingTracker => "जॉगिंग ट्रैकर";
  @override
  String get labelCaloriesBurn => "कैलोरी बर्न हुई";

  // Sleep Tracker
  @override
  String get labelSleepTarget => "नींद का लक्ष्य";
  @override
  String get labelTodaySleep => "आज सो जाओ";
  @override
  String get labelSleepProgress => "नींद की प्रगति";
  @override
  String get labelTotalSleep => "पूरी नींद";
  @override
  String get labelSleepGoal => "नींद का लक्ष्य";
  @override
  String get labelSetNotification => "अधिसूचना सेट करें";
  @override
  String get labelStartTime => "समय शुरू";
  @override
  String get labelEndTime => "अंत समय";
  @override
  String get labelSelect => "चुनना";
  @override
  String get labelSat => "बैठा";
  // @override
  // String get labelSave => "बचाना";
  @override
  String get labelStart => "शुरू";
  @override
  String get labelEnd => "अंत";
  @override
  String get labelType => "प्रकार";
  @override
  String get labelIsConnected => "जुड़ा है";

  // @override
  // String get labelMensurationCycle => "चक्र मापन";

  @override
  String get labelTrackAndManage =>
      "बेहतर जानकारी के लिए अपने क्षेत्रमिति चक्र को ट्रैक और प्रबंधित करें";

  @override
  String get labelMensurationStatus => "माप की स्थिति";

  @override
  String get labelDaysLength => "दिनों की लंबाई";

  @override
  String get labelDay => "दिन";

  @override
  String get labelNextDate => "अगली तारीख";

  @override
  String get labelLastPeriodStartDate => "अंतिम अवधि आरंभ तिथि";

  @override
  String get labelAverageCycleLength => "औसत चक्र की लंबाई";

  @override
  String get labelChange => "परिवर्तन";

  // Common Messages
  @override
  String get messageSent => "संदेश भेजा गया";

  @override
  String get thankYouForContactingUs => "हमसे संपर्क करने के लिए धन्यवाद!";

  @override
  String get alert => "चेतावनी";

  @override
  String get fillInAllFields => "कृपया सभी स्थानों को भरें।";

  @override
  String get thankYouFeedbackSubmitted => "आपकी प्रतिक्रिया सबमिट कर दी गई है.";

  @override
  String get resetPassword => "पासवर्ड रीसेट";

  @override
  String get dishAdded => "पकवान जोड़ा गया!";

  @override
  String get dishAndIngredientsAddedSuccessfully =>
      "व्यंजन और सामग्री सफलतापूर्वक जोड़ी गई।";

  @override
  String get failed => "असफल";

  @override
  String get error => "गलती";

  @override
  String get enterBloodGlucoseLevel =>
      "रक्त ग्लूकोज स्तर एमजी/डीएल में दर्ज करें";

  @override
  String get enterBloodPressureLevel => "mmHg में रक्तचाप का स्तर दर्ज करें";

  @override
  String get enterHeartLevel =>
      "कृपया हृदय गति को बीट्स प्रति मिनट (बीपीएम) में दर्ज करें।";

  @override
  String get cancel => "रद्द करना";

  @override
  String get submit => "जमा करना";

  @override
  String get valueCannotBeGreaterThan100 => "मान 100 से अधिक नहीं हो सकता.";

  @override
  String get bloodStatusSubmittedSuccessfully =>
      "रक्त स्थिति सफलतापूर्वक सबमिट की गई.";

  @override
  String get failedToSubmitBlood => "रक्त जमा करने में विफल.";

  @override
  String get enterHeartLevel1to100 =>
      "कृपया हृदय गति को बीट्स प्रति मिनट (बीपीएम) में दर्ज करें।";

  @override
  String get heartLevelSubmittedSuccessfully =>
      "हृदय स्तर सफलतापूर्वक प्रस्तुत किया गया।";

  @override
  String get enterOxygenSaturationLevel1to100 =>
      "ऑक्सीजन संतृप्ति स्तर 1%-100% दर्ज करें";

  @override
  String get oxygenLevelSubmittedSuccessfully =>
      "ऑक्सीजन लेवल सफलतापूर्वक जमा हो गया।";

  @override
  String get updateData => "अद्यतन आकड़ें";

  @override
  String get selectLastPeriodStartDate => "अंतिम अवधि आरंभ तिथि चुनें";

  @override
  String get update => "अद्यतन";

  @override
  String get failedToFetchBooks =>
      "पुस्तकें लाने में विफल. कृपया पुन: प्रयास करें।";

  @override
  String get errorOccurred => "एक त्रुटि पाई गई:";

  @override
  String get invalidEndTime => "अमान्य समाप्ति समय";

  @override
  String get chooseTimeWithin1Hour =>
      "कृपया प्रारंभ समय से 1 घंटे के भीतर का समय चुनें।";

  @override
  String get notificationSaved => "अधिसूचना सहेजी गई";

  @override
  String get notificationSetSuccessfully => "अधिसूचना सफलतापूर्वक सेट हो गई.";

  @override
  String get thereIsSomeError => "कुछ त्रुटि है.";

  @override
  String get watchDisconnected => "घड़ी डिसकनेक्ट हो गई";

  @override
  String get watchDisconnectedSuccessfully =>
      "घड़ी सफलतापूर्वक डिस्कनेक्ट हो गई है.";

  @override
  String get addCup => "कप जोड़ें";

  @override
  String get numberOfCups => "कपों की संख्या";

  @override
  String get addCupCapacityInMl => "एमएल में कप क्षमता जोड़ें";

  @override
  String get cupCapacitySubmittedSuccessfully =>
      "कप क्षमता सफलतापूर्वक सबमिट की गई.";

  @override
  String get pleaseEnterValidValuesForAllFields =>
      "कृपया सभी फ़ील्ड के लिए मान्य मान दर्ज करें।";

  @override
  String get enterWater => "पानी डालें";

  @override
  String get waterGoalLiters => "जल लक्ष्य (लीटर)";

  @override
  String get waterSubmittedSuccessfully =>
      "जल लक्ष्य सफलतापूर्वक प्रस्तुत किया गया.";

  @override
  String get addActivityData => "गतिविधि डेटा जोड़ें";

  @override
  String get enterValue => "मान दर्ज करें";

  @override
  String get addStepsData => "चरण डेटा जोड़ें";

  @override
  String get numberOfSteps => "चरणों की संख्या";

  @override
  String get stepsDataSubmittedSuccessfully =>
      "चरण डेटा सफलतापूर्वक सबमिट किया गया.";

  @override
  String get enterSleepTarget => "नींद का लक्ष्य दर्ज करें";

  @override
  String get sleepTargetInHours => "घंटों में नींद का लक्ष्य";

  @override
  String get addYourSleepDuration => "अपनी नींद की अवधि जोड़ें";

  @override
  String get enterDurationInMinutes => "अवधि मिनटों में दर्ज करें:";

  @override
  String get add => "जोड़ना";

  @override
  String get ok => "ठीक है";

  @override
  String get csvFileSavedTo => "CSV फ़ाइल सहेजी गई";

  @override
  String get ageMustBeBetween2And100Years =>
      "आयु 2 से 100 वर्ष के बीच होनी चाहिए";

  @override
  String get next => "अगला";

  @override
  String get register => "पंजीकरण करवाना";

  @override
  String get oopsSomethingWentWrong => "उफ़! कुछ गलत हो गया";

  @override
  String get errorFetchingMeals => "भोजन लाते समय एक त्रुटि हुई:";

  @override
  String get reviewAddedSuccessfully => "समीक्षा सफलतापूर्वक जोड़ी गई!";

  @override
  String get failedToAddReview => "समीक्षा जोड़ने में विफल:";

  @override
  String get alreadyInCart => "पहले से ही कार्ट में";

  @override
  String get addedToCart => "कार्ट में जोड़ा गया";

  @override
  String get quantityNotBetween1And2 => "मात्रा 2 से अधिक और 1 से कम नहीं है";

  @override
  String get createcustomdish => "कस्टम डिश बनाएं";
  @override
  String get quantityingram => "मात्रा (ग्राम)";
  @override
  String get labelCaloriestaken => 'ऊर्जा';
  @override
  String get mainlabelEarlyMorning => "बहुत सवेरे";
  @override
  String get mainlabelMidMorning => "सुबह के दौरान";
  @override
  String get mainlabelEvening => "शाम";
  @override
  String get mainlabelBedtime => "सोने का समय";
  @override
  String get mainlabelTimeSpentOn => "विभिन्न गतिविधियों में समय व्यतीत हुआ";
  @override
  String get mainlabelHealthCalculator => "स्वास्थ्य कैलकुलेटर";
  @override
  String get mainlabelStepProgress => "कदम प्रगति";
  @override
  String get mainlabelRealTimeIntakes => "वास्तविक समय का सेवन";
  @override
  String get mainlabelCaloriesBurnProgress => "कैलोरी बर्न हुई प्रगति";
  @override
  String get mainlabelCaloriesBurnBreakdown =>
      "कैलोरी बर्न होने पर ब्रेकडाउन हो गया";
  @override
  String get mainlabelHeartReportsTrends => "हृदय रुझानों की रिपोर्ट करता है";
  @override
  String get mainlabelOxygenStatus => "ऑक्सीजन की स्थिति";
  @override
  String get mainlabelNoRecord => "मुझे याद नहीं";
  @override
  String get mainlabelSystolicBloodPressure => "सिस्टोलिक रक्तचाप";
  @override
  String get mainlabelMeasuredon => "पर मापा गया";
  @override
  String get mainlabelEnterBloodPressure => "रक्तचाप दर्ज करें";
  @override
  String get mainlabelBloodPressure => "रक्तचाप";
  @override
  String get mainlabelDiastolicBloodPressure => "डायस्टोलिक रक्तचाप";
  @override
  String get mainlabelBloodGlucose => "रक्त द्राक्ष - शर्करा";
  @override
  String get mainlabelHeartStatus => "हृदय स्थिति";
  @override
  String get mainlabelAllExercise => "सभी व्यायाम करें";
  @override
  String get mainlabelCleaningOrMopping => "सफ़ाई करना या पोछा लगाना";
  @override
  String get mainlabelGardening => "बागवानी";
  @override
  String get mainlabelWatchingTV => "टीवी देखना";
  @override
  String get mainlabelCycling => "साइकिल चलाना";
  @override
  String get mainlabelRunning => "दौड़ना";
  @override
  String get mainlabelWalking => "चलना";
  @override
  String get mainlabelShuttle => "शटल";
  @override
  String get mainlabelTableTennis => "टेबल टेनिस";
  @override
  String get mainlabelTennis => "टेनिस";
  @override
  String get mainlabelVolleyBall => "वॉलीबॉल";
  @override
  String get mainlabelDancing => "नृत्य";
  @override
  String get mainlabelFishing => "मछली पकड़ने";
  @override
  String get mainlabelShopping => "खरीदारी";
  @override
  String get mainlabelTyping => "टाइपिंग";
  @override
  String get mainlabelSleeping => "सोना";
  @override
  String get mainlabelStanding => "खड़ा है";
  @override
  String get mainlabelSitting => "बैठक";
  @override
  String get mainlabelClickToStartActivity =>
      "गतिविधि शुरू करने के लिए क्लिक करें";
  @override
  String get mainlabelBMICalculator => "बीएमआई कैलकुलेटर";
  @override
  String get mainlabelBMRCalculator => "बीएमआर कैलकुलेटर";
  @override
  String get mainlabelDownloadActivityReportInCsv =>
      "सीएसवी में गतिविधि रिपोर्ट डाउनलोड करें";
  @override
  String get mainlabelSelectStartDate => "आरंभ तिथि चुनें";
  @override
  String get mainlabelSelectEndDate => "अंतिम तिथि चुनें";
  @override
  String get mainlabelDownloadFile => "डाउनलोड फ़ाइल";
  @override
  String get mainlabelDate => "तारीख";
  @override
  String get mainlabelValue => "कीमत";
  @override
  String get mainlabelLink => "जोड़ना";
  @override
  String get mainlabelNoNotificationFound => "कोई सूचना नहीं मिली";
  @override
  String get mainlabelTotalNutritionTaken => "=पूरा पोषण लिया गया";
  @override
  String get mainlabelSearchFood => "रेसिपी खोजें";
  @override
  String get mainlabelSelectFromPersonalFood =>
      "व्यक्तिगत व्यंजनों में से चुनें";
  @override
  String get mainlabelRecipeName => "रेसिपी का नाम";
  @override
  String get mainlabelSelectDate => "तारीख़ चुनें";
  @override
  String get mainlabelNutrientOfAllIngredientsRaw =>
      "सभी सामग्रियों के पोषक तत्व (कच्चे)";
  @override
  String get mainlabelNutrientsCompostionOfCookedWeight =>
      "पके हुए वजन की पोषक तत्वों की संरचना";
  @override
  String get mainlabelWantToEditThisRecipyFollowThe =>
      "क्या आप इस रेसिपी को संपादित करना चाहते हैं? का पीछा करो";
  @override
  String get mainlabelAddIngredientFrom => "से सामग्री जोड़ें";
  @override
  String get mainlabelAddFromNutrientSpecifcFood =>
      "पोषक तत्व विशिष्ट भोजन से जोड़ें";
  @override
  String get mainlabelAddFromAllFoods => "सभी खाद्य पदार्थों में से जोड़ें";
  @override
  String get mainlabelNumberOfServing => "सर्विंग्स की संख्या";
  @override
  String get mainlabelWeightInG => "वजन (जी)";
  @override
  String get mainlabelEditIngredientsWeight => "सामग्री का वजन संपादित करें";
  @override
  String get mainlabelIngredient => "घटक";
  @override
  String get mainlabelNewWeightInG => "नया वजन (ग्राम)";
  @override
  String get mainlabelCancel => "रद्द करना";
  @override
  String get mainlabelUpdate => "अद्यतन";
  @override
  String get mainlabelCookedWeightInG => "पका हुआ वजन (ग्राम)";
  @override
  String get mainlabelEnterWeight => "वजन दर्ज करें";
  @override
  String get mainlabelEditRecipy => "नुस्खा संपादित करें";
  @override
  String get mainlabelAlert => "चेतावनी";
  @override
  String get mainlabelToSeeNutritionCompositionPleaseEnterNoOfServing =>
      "पोषण संरचना देखने के लिए, कृपया सर्विंग्स की संख्या दर्ज करें";
  @override
  String get mainlabelNutrirntsIn100CookedWeight =>
      "100 (पके हुए) वजन में पोषक तत्व";
  @override
  String get mainlabelSetNutritionTargetInG =>
      "ग्राम में पोषण लक्ष्य निर्धारित करें";
  @override
  String get mainlabelFoodAnalyse => "अन्वेषण करना";
  @override
  String get mainlabelExploreTop10Foods =>
      "शीर्ष 10 खाद्य पदार्थों का अन्वेषण करें";
  @override
  String get mainlabelSearchCookedFood => "व्यंजनों में पोषक तत्व खोजें";
  @override
  String get mainlabelNutritionBasedOnEAR =>
      "ईएआर पर आधारित पोषक तत्व की आवश्यकता";
  @override
  String get mainlabelDietDiary => "आहार डायरी";
  @override
  String get mainlabelRecipes => "व्यंजनों";
  @override
  String get mainlabelSearchByFoodName => "भोजन के नाम से खोजें";
  @override
  String get mainlabelAllRecipeOf100G => "सभी रेसिपी 100 ग्राम की";
  @override
  String get mainlabelNutritionRequirement => "पोषण की आवश्यकता";
  @override
  String get mainlabelGender => "लिंग";
  @override
  String get mainlabelParticulars => "ब्यौरा";
  @override
  String get mainlabelBodyWeight => "शरीर का वजन";
  @override
  String get mainlabelDietaryDiaryReports => "पोषक तत्वों का सेवन";
  @override
  String get mainlabelTotalNutritionTakenOn => "कुल पोषण लिया गया";
  @override
  String get mainlabelAttachImage => "छवि संलग्न करें";
  @override
  String get mainlabelFixedRecipy => "निश्चित नुस्खा";
  @override
  String get mainlabelFoodInDetail => "भोजन विस्तार से";
  @override
  String get TextAppNutrientsInMyFood => "खाद्य पदार्थों में पोषक तत्व खोजें";
  @override
  String get TextAppMyActivity => "मेरी गतिविधि";
  @override
  String get TextAppToday => "आज";
  @override
  String get TextAppMyNutrientRequirements => "मेरी पोषक तत्व आवश्यकताएँ";
  @override
  String get TextAppTotalNutrition => "संपूर्ण पोषण";
  @override
  String get TextAppTaken => "लिया";
  @override
  String get TextAppRatings => "रेटिंग";
  @override
  String get TextAppSearchComponents => "घटक खोजें";
  @override
  String get TextAppTotalNutrientTaken => "आज मेरा पोषक तत्व का सेवन";
  @override
  String get TextAppShareApp => "ऐप शेयर करें";
  @override
  String get TextAppNoNotificationsFound => "कोई सूचना नहीं मिली";
  @override
  String get TextAppConnectWatch => "घड़ी कनेक्ट करें";
  @override
  String get TextAppYourBMIIs => "आपका बीएमआई है";
  @override
  String get TextAppBMI => "बीएमआई";
  @override
  String get TextAppBMICategories => "बीएमआई श्रेणियाँ";
  @override
  String get TextAppUnderweight => "वजन";
  @override
  String get TextAppNormal => "सामान्य";
  @override
  String get TextAppOverweight => "अधिक वजन";
  @override
  String get TextAppObesity => "मोटापा";
  @override
  String get TextAppSelectDate => "तारीख़ चुनें";
  @override
  String get TextAppOxygen => "ऑक्सीजन";
  @override
  String get TextAppBlood => "खून";
  @override
  String get TextAppNoRecord => "कोई रिकॉर्ड नहीं";
  @override
  String get TextAppAllExercise => "सभी व्यायाम";
  @override
  String get TextAppCleaningOrMopping => "सफ़ाई या पोछा लगाना";
  @override
  String get TextAppGardening => "बागवानी";
  @override
  String get TextAppWatchingTV => "टीवी देखना";
  @override
  String get TextAppCycling => "साइकिल चलाना";
  @override
  String get TextAppRunning => "दौड़ना";
  @override
  String get TextAppWalking => "चलना";
  @override
  String get TextAppShuttle => "शटल";
  @override
  String get TextAppTableTennis => "टेबल टेनिस";
  @override
  String get TextAppTennis => "टेनिस";
  @override
  String get TextAppVolleyBall => "वॉली बॉल";
  @override
  String get TextAppDancing => "नृत्य";
  @override
  String get TextAppFishing => "मछली पकड़ने";
  @override
  String get TextAppShopping => "खरीदारी";
  @override
  String get TextAppTyping => "टाइपिंग";
  @override
  String get TextAppSleeping => "सोना";
  @override
  String get TextAppStanding => "खड़ा है";
  @override
  String get TextAppSitting => "बैठक";
  @override
  String get TextAppClickStartToStartActivity =>
      "गतिविधि शुरू करने के लिए प्रारंभ पर क्लिक करें";
  @override
  String get TextAppCaloriesBurn => "कैलोरी बर्न हुई";
  @override
  String get TextAppAddDurationManually => "अवधि मैन्युअल रूप से जोड़ें";
  @override
  String get TextAppStartOrMopping => "प्रारंभ या पोंछना";
  @override
  String get TextAppMale => "पुरुष";
  @override
  String get TextAppFemale => "महिला";
  @override
  String get TextAppWeightManager => "मेरे शरीर के वजन पर नज़र रखें";
  @override
  String get TextAppUpdateWeight => "वज़न अपडेट करें";
  @override
  String get TextAppSetWeightGoal => "वज़न का लक्ष्य निर्धारित करें";
  @override
  String get TextAppCurrentWeight => "वर्तमान वजन";
  @override
  String get TextAppWeightProgress => "वजन में प्रगति";
  @override
  String get TextAppPrevious30Days => "पिछले 30 दिन";
  @override
  String get TextAppYourWeightGoalIsSet => "आपका लक्ष्य है";
  @override
  String get TextAppMaintain => "बनाए रखना";
  @override
  String get TextAppInitialWeightOf => "प्रारंभिक वजन";
  @override
  String get TextAppFinalWeightOf => "नवीनतम वजन";
  @override
  String get TextAppWeight => "वज़न";
  @override
  String get TextAppYouAreNotYetAchievingYourWeightGoalKeepGoing =>
      "आप अभी तक अपना वजन लक्ष्य हासिल नहीं कर पाए हैं। जाता रहना!";
  @override
  String get TextAppYouAreAchievedYourWeightGoalKeepGoing =>
      "आपने अपना वज़न लक्ष्य हासिल कर लिया है. जाता रहना!";
  @override
  String get TextAppAndYourWeightChangeIsSet =>
      "और आपका वजन परिवर्तन निर्धारित है";
  @override
  String get TextApp1NutrientsInMyFood => "मेरे भोजन में पोषक तत्व";
  @override
  String get TextAppSearchNutrientsInRawFoods =>
      "कच्चे खाद्य पदार्थों में पोषक तत्व खोजें";
  @override
  String get TextAppRawIngredients => "कच्ची सामग्री";
  @override
  String get TextAppSearchRawFoodByName => "नाम से कच्चा भोजन खोजें";
  @override
  String get TextApp1MyActivity => "मेरी गतिविधि रिपोर्ट";
  @override
  String get TextAppCheckOthersDates => "अन्य तिथियां जांचें";
  @override
  String get TextAppYour24HoursChart => "आपका 24 घंटे का चार्ट";
  @override
  String get TextAppActivity => "गतिविधि";
  @override
  String get TextAppOthers => "अन्य";
  @override
  String get TextAppExerciseDetails => "व्यायाम विवरण";
  @override
  String get TextAppActivityType => "क्रिया के प्रकार";
  @override
  String get TextAppDuration => "अवधि";
  @override
  String get TextAppMyActivityOfCustomDates => "कस्टम तिथियों की मेरी गतिविधि";
  @override
  String get TextAppOurCustomerFeedback => "हमारी ग्राहक प्रतिक्रिया";
  @override
  String get TextAppOverallRatings => "कुल मिलाकर रेटिंग";
  @override
  String get TextAppEnterCookedWeight => "पका हुआ वजन दर्ज करें";
  @override
  String get TextAppCookedWeightGram => "पका हुआ वजन (ग्राम)";
  @override
  String get TextAppNutrientIn100gCooked => "100 ग्राम में पोषक तत्व (पका हुआ)";
  @override
  String get TextAppEnterServingSize => "परोसने का आकार दर्ज करें";
  @override
  String get TextAppSearchByRecipeName => "रेसिपी के नाम से खोजें";
  @override
  String get TextAppMyPersonalRecipe => "मेरी निजी रेसिपी";
  @override
  String get TextAppFixedRecipe => "निश्चित नुस्खा";
  @override
  String get TextApp2NutrientsInMyFood => "मेरे भोजन में पोषक तत्व";
  @override
  String get TextAppMyDietDiary => "मेरी आहार डायरी";
  @override
  String get TextApp2MyActivity => "मेरी गतिविधि";
  @override
  String get TextAppDownloadFile => "डाउनलोड फ़ाइल";
  @override
  String get TextAppStartMyNewDietDiary => "मेरी नई आहार डायरी प्रारंभ करें";
  @override
  String get TextAppGoogle => "गूगल";
  @override
  String get TextAppFacebook => "फेसबुक";
  @override
  String get TextAppLinkedin => "Linkedin";
  @override
  String get TextAppTwitter => "ट्विटर";
  @override
  String get TextAppContactUs => "संपर्क करें";
  @override
  String get TextAppReportBug => "रिपोर्ट बग";
  @override
  String get TextAppAttachImage => "छवि संलग्न करें";
  @override
  String get TextAppResetPassword => "पासवर्ड रीसेट";
  @override
  String get TextAppNINAppCreditsPage => "एनआईएन ऐप क्रेडिट पेज";
  @override
  String get NINTextOopsSomethingWentWrong => "उफ़! कुछ गलत हो गया";
  @override
  String get NINTextPleaseEnterAllFields => "कृपया सभी फ़ील्ड दर्ज करें";
  @override
  String get NINTextSubmittedSuccessfully1 => "सफलतापूर्वक जमा";
  @override
  String get NINTextSubmittedSuccessfully2 => "सफलतापूर्वक जमा";
  @override
  String get NINTextFitbitAuthentication => "फिटबिट प्रमाणीकरण";
  @override
  String get NINTextHours => "घंटे";
  @override
  String get NINTextMinutes => "मिनट";
  @override
  String get NINTextEnterDurationFor => "के लिए अवधि दर्ज करें";
  @override
  String get NINTextTimerRunning => "टाइमर चल रहा है";
  @override
  String get NINTextPleaseStopTheTimerBeforeSubmitting =>
      "कृपया सबमिट करने से पहले टाइमर बंद कर दें";
  @override
  String get NINTextTotalDuration => "कुल अवधि";
  @override
  String get NINTextSec => "सेकंड";
  @override
  String get NINTextStartYourActivity => "अपनी गतिविधि शुरू करें!";
  @override
  String get NINTextPause => "विराम";
  @override
  String get NINTextReset => "रीसेट";
  @override
  String get NINTextError => "गलती";
  @override
  String get NINTextPleaseEnterCookedWeightAndServingSize =>
      "कृपया पका हुआ वजन और परोसने का आकार दर्ज करें";
  @override
  String get NINTextEditIngredient => "घटक संपादित करें";
  @override
  String get NINTextAlert => "चेतावनी";
  @override
  String get NINTextEnterWeightFor => "के लिए वज़न दर्ज करें";
  @override
  String get NINTextNewWeightGram => "नया वजन (ग्राम)";
  @override
  String get NINTextEditRecipeName => "रेसिपी का नाम संपादित करें";
  @override
  String get NINTextNewRecipeName => "नई रेसिपी का नाम";
  @override
  String get NINTextSubmitted => "प्रस्तुत";
  @override
  String get NINTextSuccess => "सफलता";
  @override
  String get NINTextDietaryDiaryReportSavedTo => "आहार डायरी रिपोर्ट सहेजी गई";
  @override
  String get NINTextErrorSavingFile => "फ़ाइल सहेजने में त्रुटि";
  @override
  String get NINTextClose => "बंद करना";
  @override
  String get NINTextIWantTo => "मैं चाहता हूँ";
  @override
  String get NINTextGain => "पाना";
  @override
  String get NINTextMaintain => "बनाए रखना";
  @override
  String get NINTextLose => "खोना";
  @override
  String get NINTextWeightChangeKg => "वजन में बदलाव (किलो)";
  @override
  String get NINTextAddNewWeight => "नया वजन जोड़ें";
  @override
  String get NINTextEnterWeight => "वजन दर्ज करें";
  @override
  String get NINTextOf100Gram => "100 ग्राम का";
  @override
  String get NINTextProximateComposition => "समीपस्थ रचना";
  @override
  String get NINTextVitamins => "विटामिन";
  @override
  String get NINTextMinerals => "खनिज पदार्थ";
  @override
  String get NINTextTotalSaturatedFattyAcids => "कुल संतृप्त फैटी एसिड";
  @override
  String get NINTextAllRecipeOf100Grams => "सारी रेसिपी 100 ग्राम की";
  @override
  String get NINTextOurCustomerFeedback => "हमारी ग्राहक प्रतिक्रिया";
  @override
  String get NINTextOverallRatings => "कुल मिलाकर रेटिंग";
  @override
  String get NINTextRateUs => "हमें रेटिंग दें";
  @override
  String get NINTextBookDetails => "पुस्तक विवरण";
  @override
  String get NINTextOne => "एक";
  @override
  String get NINTextWeightOf => "wt. का";
  @override
  String get NINTextSelectStartDate => "आरंभ तिथि चुनें";
  @override
  String get NINTextSelectEndDate => "अंतिम तिथि चुनें";
  @override
  String get NINTextNoData => "कोई डेटा नहीं";
  @override
  String get NINTextWorkLevel => "कार्य स्तर";
  @override
  String get NINTextOldPassword => "पुराना पासवर्ड";
  @override
  String get NINTextNewPassword => "नया पासवर्ड";
  @override
  String get NINTextUpdateProfile => "प्रोफ़ाइल अपडेट करें";
  @override
  String get NINTextChangeImage => "चित्र को बदलें";
  @override
  String get NINTextNoFavouriteFoodFound => "कोई पसंदीदा भोजन नहीं मिला";
  @override
  String get NINTextCookedQuantity => "पकी हुई मात्रा";
  @override
  String get NINTextServingQuantity => "परोसने की मात्रा";
  @override
  String get NINTextNutrientInformation => "पोषक तत्वों की जानकारी";
  @override
  String get NINTextIngredient => "घटक";
  @override
  String get NINTextMealsTakenOn => "भोजन किया गया";
  @override
  String get NINTextPercentage => "को PERCENTAGE";
  @override
  String get NINTextEAR => "कान";
  @override
  String get NINTextValue => "कीमत";
  @override
  String get NINTextNutrient => "पुष्टिकर";
  @override
  String get NINTextEnergyKcal => "ऊर्जा (किलो कैलोरी)";
  @override
  String get NINTextProteinG => "प्रोटीन (जी)";
  @override
  String get NINTextFatG => "वसा (जी)";
  @override
  String get NINTextCarbohydratesG => "कार्बोहाइड्रेट (जी)";
  @override
  String get NINTextCalciumMg => "कैल्शियम (मिलीग्राम)";
  @override
  String get NINTextFiberG => "फाइबर (जी)";
  @override
  String get NINTextIronMg => "आयरन (मिलीग्राम)";
  @override
  String get NINTextZincMg => "जिंक (मिलीग्राम)";
  @override
  String get NINTextMagnesiumMg => "मैग्नीशियम (मिलीग्राम)";
  @override
  String get NINTextThiamineB1Mg => "थियामिन (बी1) (मिलीग्राम)";
  @override
  String get NINTextRiboflavinB2Mg => "राइबोफ्लेविन (बी2) (मिलीग्राम)";
  @override
  String get NINTextNiacinB3Mg => "नियासिन (बी3) (मिलीग्राम)";
  @override
  String get NINTextFolatesB9Mcg => "फोलेट्स (बी9) (एमसीजी)";
  @override
  String get NINTextRetinolVitAMcg => "विटामिन ए (एमसीजी)";
  @override
  String get VitaminCmg => "विटामिन सी (मिलीग्राम)";
  @override
  String get Iodinemcg => "आयोडीन (एमसीजी)";
  @override
  String get serving => "की सेवा";
  @override
  String get Mynutritionstatus => "मेरी पोषण स्थिति";

  @override
  String get ninTextMyHealthStatus => 'मेरी स्वास्थ्य स्थिति';
  @override
  String get ninTextNutrientsInRawFoods => 'कच्चे खाद्य पदार्थों में पोषक तत्व';
  @override
  String get ninTextNutrientsInRecipes => 'व्यंजनों में पोषक तत्व';
  @override
  String get ninTextIcmrNinMyPlateForTheDay =>
      'आईसीएमआर-एनआईएन आज के लिए मेरी थाली';
  @override
  String get ninTextToday => 'आज';
  @override
  String get ninTextTrackMyActivity => 'मेरी गतिविधि पर नज़र रखें';
  @override
  String get ninTextMyHeartRate => 'मेरी हृदय गति';
  @override
  String get ninTextMyWaterIntake => 'मेरा जल सेवन';
  @override
  String get ninTextSleepTracker => 'स्लीप ट्रैकर';
  @override
  String get ninTextLit => 'ज्योतिर्मय';
  @override
  String get ninTextRecordMyBloodPressure =>
      'मेरा रक्तचाप/रक्त ग्लूकोज/एसपीओ2 रिकॉर्ड करें';
  @override
  String get ninTextNutritionEducationContent => 'पोषण शिक्षा सामग्री';
  @override
  String get ninTextMyNutrientIntake => 'मेरे पोषक तत्वों का सेवन';
  @override
  String get ninTextOn => 'पर';
  @override
  String get ninTextWithReferenceToEAR => 'ईएआर के संदर्भ में';
  @override
  String get ninTextAchieveYourHealthGoals =>
      'अपने स्वास्थ्य लक्ष्य प्राप्त करें';
  @override
  String get ninTextPercentage => 'को PERCENTAGE';
  @override
  String get ninTextMyPreviousDietDiaries => 'मेरी पिछली आहार डायरियाँ';
  @override
  String get ninTextRecordReviewSleep => 'नींद को रिकॉर्ड/समीक्षा करें';
  @override
  String get ninTextHours => 'घंटे';
  @override
  String get ninTextIngredient => 'घटक';
  @override
  String get ninTextOthersSpecify => 'अन्य (निर्दिष्ट करें';
  @override
  String get ninTextAddNewIngredient => 'नई सामग्री जोड़ें';
  @override
  String get ninTextFoodName => 'भोजन का नाम';
  @override
  String get ninTextSource => 'स्रोत';
  @override
  String get ninTextEnterBrandAndProductName =>
      'ब्रांड और उत्पाद का नाम दर्ज करें';
  @override
  String get ninTextEnterAuthorDetails =>
      'लेखक का नाम, वर्ष, पत्रिका, पृष्ठ दर्ज करें';
  @override
  String get ninTextEnterFctName => 'एफसीटी का नाम दर्ज करें';
  @override
  String get ninTextName => 'नाम';
  @override
  String get ninTextProductName => 'प्रोडक्ट का नाम';
  @override
  String get ninTextSelectStartDate => 'आरंभ तिथि चुनें';
  @override
  String get ninTextSelectEndDate => 'अंतिम तिथि चुनें';
  @override
  String get ninTextNoExercise => 'कोई व्यायाम नहीं';
  @override
  String get ninTextDevelopedWithExpertiseAndInputs =>
      'सेंटर फॉर डेवलपमेंट एंड एडवांस्ड कंप्यूटिंग (सी-डैक), हैदराबाद द्वारा एनआईएन से विशेषज्ञता और इनपुट के साथ विकसित भाषा लिंक';
  @override
  String get ninTextMyNutrientIntakeToday => 'आज मेरा पोषक तत्व का सेवन';
  @override
  String get ninTextIcmrNationalInstituteOfNutritionAddress =>
      'आईसीएमआर - तरनाका मेट्रो स्टेशन के बगल में राष्ट्रीय पोषण संस्थान, जमाई-उस्मानिया पीओ, हैदराबाद-500 007, भारत।';

  @override
  String get ninTextKcal => 'किलो कैलोरी';
  @override
  String get ninTextKcalPerDay => 'किलो कैलोरी/दिन';
  @override
  String get ninTextDelete => 'मिटाना';
  @override
  String get ninTextDeleteNotification => 'अधिसूचना हटाएँ';
  @override
  String get ninTextConfirmDeleteNotification =>
      'क्या आप वाकई इस अधिसूचना को हटाना चाहते हैं?';
  @override
  String get ninTextTimeFor => 'अरे, यह\'s time for';
  @override
  String get ninTextFitbitWatch => 'फिटबिट घड़ी';
  @override
  String get ninTextGoogleFitApp => 'गूगल फिट ऐप';
  @override
  String get ninTextUnderweight => 'वजन';
  @override
  String get ninTextNormal => 'सामान्य';
  @override
  String get ninTextOverweight => 'अधिक वजन';
  @override
  String get ninTextObesity => 'मोटापा';
  @override
  String get ninTextMale => 'पुरुष';
  @override
  String get ninTextFemale => 'महिला';
  @override
  String get ninTextAgeInYears => 'वर्ष में उम्र';
  @override
  String get ninTextChangeInWeight => 'वजन में बदलाव';
  @override
  String get ninTextSteps => 'कदम';
  @override
  String get ninTextFor => 'के लिए';
  @override
  String get ninTextMinutes => 'मिनट';
  @override
  String get ninTextPause => 'विराम';
  @override
  String get ninTextReset => 'रीसेट';
  @override
  String get ninTextStartActivity => 'अपनी गतिविधि प्रारंभ करें';
  @override
  String get ninTextCartIsEmpty => 'आपकी गाड़ी खाली है';
  @override
  String get ninTextMyPersonalRecipe => 'मेरी निजी रेसिपी';
  @override
  String get ninTextSearchByRecipeName => 'रेसिपी के नाम से खोजें';
  @override
  String get ninTextHelpCenter => 'सहायता केंद्र';
  @override
  String get ninTextCommonProblems => 'सामान्य समस्या';
  @override
  String get ninTextFAQs => 'पूछे जाने वाले प्रश्न';
  @override
  String get ninTextHowActiveAreYou => 'आप कितने सक्रिय हैं';
  @override
  String get ninTextVitaminC => 'विटामिन सी (मिलीग्राम)';
  @override
  String get ninTextVitaminA => 'विटामिन ए (आईयू)';
  @override
  String get ninTextSodium => 'सोडियम (मिलीग्राम)';
  @override
  String get ninTextJournal => 'पत्रिका';
  @override
  String get ninTextPage => 'पृष्ठ';
  @override
  String get ninTextAdequateIntakeCarbs =>
      '*कार्बोहाइड्रेट के लिए अनुशंसित पर्याप्त सेवन (एआई): वयस्क पुरुषों और महिलाओं के लिए 130 ग्राम।';
  @override
  String get ninTextAdequateIntakeFiber =>
      '**फाइबर के लिए AI अनुशंसित: महिलाओं के लिए 25 ग्राम और पुरुषों के लिए 38 ग्राम।';
  @override
  String get your => 'आपका';
  @override
  String get question1 => 'क्या मैं अपना व्यक्तिगत विवरण संपादित कर सकता हूँ?';
  @override
  String get answer1 =>
      'हाँ। आपका व्यक्तिगत डेटा आपकी प्रोफ़ाइल में संपादित किया जा सकता है।';
  @override
  String get linkText1 =>
      'अपना व्यक्तिगत विवरण संपादित करने के लिए यहां क्लिक करें';

  @override
  String get question2 => 'क्या मैं अपना संपर्क विवरण बदल सकता हूँ?';
  @override
  String get answer2 =>
      "हाँ। आपके संपर्क विवरण को आपकी प्रोफ़ाइल में 'व्यक्तिगत डेटा' विकल्प पर जाकर बदला जा सकता है।";
  @override
  String get linkText2 =>
      'अपना संपर्क विवरण संपादित करने के लिए यहां क्लिक करें';

  @override
  String get question3 => 'क्या मैं अपना उपयोगकर्ता पासवर्ड बदल सकता हूँ?';
  @override
  String get answer3 =>
      "हाँ। आपकी प्रोफ़ाइल में 'सेटिंग' विकल्प पर जाकर आपका पासवर्ड बदला जा सकता है।";
  @override
  String get linkText3 => 'अपना पासवर्ड बदलने के लिए यहां क्लिक करें';

  @override
  String get question4 => 'मैं अपना बीएमआई कैसे जांच सकता हूं?';
  @override
  String get answer4 =>
      "आप होम पेज पर प्रदर्शित 'स्वास्थ्य कैलकुलेटर' विकल्प में दिए गए 'बीएमआई कैलकुलेटर' में अपनी ऊंचाई और शरीर का वजन दर्ज करके अपना बीएमआई जांच सकते हैं।";
  @override
  String get linkText4 =>
      'बीएमआई कैलकुलेटर का उपयोग करने के लिए यहां क्लिक करें';

  @override
  String get question5 =>
      'क्या मैं पिछले महीने का अपना वज़न ट्रैक कर सकता हूँ?';
  @override
  String get answer5 =>
      "हाँ। आप होम पेज पर दिए गए 'वेट मैनेजर' विकल्प में पिछले महीने/वर्ष के लिए अपने शरीर के वजन में बदलाव का विवरण देख सकते हैं।";
  @override
  String get linkText5 => 'अपना वजन ट्रैक करने के लिए यहां क्लिक करें';

  @override
  String get question6 =>
      'मैं किसी विशेष दिन पर अपनी समग्र शारीरिक गतिविधि की जाँच कैसे कर सकता हूँ?';
  @override
  String get answer6 =>
      "आप होम पेज पर 'मेरी गतिविधि' विकल्प से अपनी शारीरिक गतिविधि को ट्रैक कर सकते हैं।";
  @override
  String get linkText6 => 'अपनी गतिविधि देखने के लिए यहां क्लिक करें';

  @override
  String get question7 =>
      'मैं पानी पीने के लिए अनुस्मारक कैसे सेट कर सकता हूँ?';
  @override
  String get answer7 =>
      "आप होम पेज पर दिए गए 'सेट नोटिफिकेशन' विकल्प में पानी सेवन अनुस्मारक के लिए एक समय निर्धारित कर सकते हैं।";
  @override
  String get linkText7 => 'जल सेवन अनुस्मारक सेट करने के लिए यहां क्लिक करें';

  @override
  String get question8 =>
      'मैं ऐप को अपनी स्मार्ट घड़ी के साथ कैसे एकीकृत कर सकता हूं?';
  @override
  String get answer8 =>
      "आप होम पेज पर दिए गए 'कनेक्ट वॉच' विकल्प पर जाकर अपनी स्मार्ट वॉच को ऐप के साथ एकीकृत कर सकते हैं।";
  @override
  String get linkText8 =>
      'अपनी स्मार्ट घड़ी कनेक्ट करने के लिए यहां क्लिक करें';

  @override
  String get question9 =>
      'मैं एक समय में कितने पहनने योग्य उपकरणों को ऐप के साथ एकीकृत कर सकता हूं?';
  @override
  String get answer9 =>
      'आप ऐप के साथ फिटबिट वॉच और गूगल फिट को इंटीग्रेट कर सकते हैं।';
  @override
  String get linkText9 => '';

  @override
  String get question10 => 'कौन सी स्मार्ट घड़ियाँ ऐप के साथ संगत हैं?';
  @override
  String get answer10 => 'फिटबिट घड़ी और गूगल फिट।';
  @override
  String get linkText10 => '';

  @override
  String get question11 =>
      'यदि मेरे पास स्मार्ट घड़ी नहीं है तो क्या मैं अपनी गतिविधि को ट्रैक कर सकता हूँ?';
  @override
  String get answer11 =>
      'हाँ, आप अपनी गतिविधि को ट्रैक कर सकते हैं। उसके लिए, आपको Google फ़िट ऐप डाउनलोड करना होगा, Google खाते से साइन इन करना होगा और उसी Google खाते से आपको हमारे वॉच सेक्शन में लॉग इन करना होगा।';
  @override
  String get linkText11 => '';

  @override
  String get question12 => 'मैं अपनी नींद को कैसे ट्रैक कर सकता हूँ?';
  @override
  String get answer12 =>
      'आप होम पेज पर दिए गए स्लीप ट्रैकर विकल्प पर जाकर साप्ताहिक/मासिक आधार पर अपनी नींद को ट्रैक कर सकते हैं।';
  @override
  String get linkText12 => 'अपनी नींद को ट्रैक करने के लिए यहां क्लिक करें';

  @override
  String get question13 =>
      "मैं ऐप के माध्यम से कोई एनआईएन प्रकाशन कैसे खरीद सकता हूं?";
  @override
  String get answer13 =>
      "आप होम पेज पर दिए गए 'बुक स्टोर' विकल्प से एनआईएन प्रकाशन खरीद सकते हैं।";
  @override
  String get linkText13 => 'बुक स्टोर पर जाने के लिए यहां क्लिक करें';

  @override
  String get question14 => 'मैं अपनी व्यक्तिगत आहार डायरी कैसे बना सकता हूँ?';
  @override
  String get answer14 =>
      "आप 'माई डाइट डायरी' विकल्प पर जाकर पूरे दिन खाए गए भोजन का विवरण दर्ज कर सकते हैं।";
  @override
  String get linkText14 => 'अपनी आहार डायरी बनाने के लिए यहां क्लिक करें';

  @override
  String get question15 =>
      'मैं ऐसे व्यंजन की खोज कैसे कर सकता हूं जो किसी विशेष पोषक तत्व से भरपूर हो?';
  @override
  String get answer15 =>
      "आप सबसे पहले होम पेज पर 'मेरे भोजन में पोषक तत्व' टैब में दिए गए 'व्यंजनों में पोषक तत्व खोजें' विकल्प का चयन कर सकते हैं। फिर ऊपरी दाएं कोने पर ड्रॉप-डाउन सूची से आवश्यक पोषक तत्व का चयन करें।";
  @override
  String get linkText15 => 'रेसिपी खोजने के लिए यहां क्लिक करें';

  @override
  String get question16 =>
      'मैं उस दिन के लिए अपने पोषक तत्वों के सेवन की जांच कैसे कर सकता हूं जो पिछले महीने बचा लिया गया था?';
  @override
  String get answer16 =>
      "आप 'भोजन सूची' पृष्ठ में 'कैलेंडर आइकन' से एक तारीख का चयन करके किसी विशिष्ट दिन पर अपने पोषक तत्वों का सेवन देख सकते हैं।";
  @override
  String get linkText16 =>
      'अपने पोषक तत्वों का सेवन जांचने के लिए यहां क्लिक करें';

  @override
  String get question17 =>
      'मैं अपने व्यंजनों में प्रयुक्त कच्ची सामग्रियों में पोषक तत्वों का पता कैसे लगा सकता हूँ?';
  @override
  String get answer17 =>
      "आप होम पेज पर 'मेरे भोजन में पोषक तत्व' टैब में दिए गए 'कच्चे खाद्य पदार्थों में पोषक तत्व खोजें' विकल्प का चयन करके किसी विशिष्ट घटक में पोषक तत्वों को जान सकते हैं।";
  @override
  String get linkText17 =>
      'कच्चे खाद्य पदार्थों में पोषक तत्वों की खोज के लिए यहां क्लिक करें';

  @override
  String get question18 => 'मैं किसी व्यंजन की पोषक संरचना कैसे जान सकता हूँ?';
  @override
  String get answer18 =>
      "आप होम पेज पर 'मेरे भोजन में पोषक तत्व' टैब में दिए गए 'व्यंजनों में पोषक तत्व खोजें' विकल्प का चयन करके किसी विशिष्ट घटक में पोषक तत्वों को जान सकते हैं।";
  @override
  String get linkText18 => 'पोषक तत्वों की संरचना जानने के लिए यहां क्लिक करें';

  @override
  String get question19 =>
      'क्या मैं कोई नई रेसिपी शामिल कर सकता हूँ जो ऐप में उपलब्ध नहीं है?';
  @override
  String get answer19 =>
      "हाँ। आप या तो विशिष्ट निश्चित रेसिपी के नीचे दिए गए लिंक का उपयोग करके मौजूदा रेसिपी को संशोधित कर सकते हैं या आहार डायरी पृष्ठ में प्रत्येक भोजन के लिए दिए गए 'कस्टम डिश बनाएं' विकल्प पर क्लिक करके एक पूरी तरह से नई रेसिपी बना सकते हैं।";
  @override
  String get linkText19 => 'कस्टम रेसिपी बनाने के लिए यहां क्लिक करें';

  @override
  String get question20 =>
      'क्या मुझे किसी विशिष्ट स्वास्थ्य स्थिति के लिए आहार संबंधी अनुशंसाएँ मिल सकती हैं?';
  @override
  String get answer20 =>
      "हाँ। आप होम पेज में 'खोज घटक' विकल्प से स्वास्थ्य सिफारिशें या आहार चार्ट दिशानिर्देश प्राप्त कर सकते हैं।";
  @override
  String get linkText20 =>
      'आहार संबंधी अनुशंसाएँ प्राप्त करने के लिए यहां क्लिक करें';

  @override
  String get question21 =>
      'क्या मैं ऐप का उपयोग अंग्रेजी के अलावा किसी अन्य भाषा में कर सकता हूं?';
  @override
  String get answer21 =>
      "हाँ। आप अपनी प्रोफ़ाइल में दिए गए 'सेटिंग' विकल्प से वांछित भाषा का चयन कर सकते हैं।";
  @override
  String get linkText21 => 'भाषा बदलने के लिए यहां क्लिक करें';

  @override
  String get ninTextBmiHwading => 'बॉडी मास इंडेक्स (बीएमआई) :';
  @override
  String get ninTextBmiDiscription =>
      'बीएमआई को किसी व्यक्ति के वजन को किलोग्राम में व्यक्ति की ऊंचाई के वर्ग मीटर (किलो/एम2) से विभाजित करने के रूप में परिभाषित किया जाता है। बीएमआई श्रेणियाँ शरीर की अत्यधिक वसा के बीमारी और मृत्यु पर पड़ने वाले प्रभाव पर आधारित होती हैं और वसा से काफी हद तक संबंधित होती हैं। बीएमआई को बीमारी के जोखिम संकेतक के रूप में विकसित किया गया था; जैसे-जैसे बीएमआई बढ़ता है, वैसे-वैसे कुछ बीमारियों का खतरा भी बढ़ता है। अधिक वजन और मोटापे से संबंधित कुछ सामान्य स्थितियों में शामिल हैं: समय से पहले मौत, हृदय रोग, उच्च रक्तचाप, ऑस्टियोआर्थराइटिस, कुछ कैंसर और मधुमेह।';
  @override
  String get ninTextbminutritionsta => 'बीएमआई पोषण संबंधी स्थिति';
  @override
  String get ninTextNutritionstat => 'पोषक तत्वों का स्तर';
  @override
  String get ninTextBelow => 'नीचे';
  @override
  String get ninTextPreobesity => 'पूर्व मोटापा';
  @override
  String get recordMyDiet => "मेरे आहार को रिकॉर्ड करें";

  @override
  String get ninTextbesity => 'मोटापा वर्ग I';
  @override
  String get ninTextbesity2 => 'मोटापा वर्ग II';
  @override
  String get moisture => "नमी";
  @override
  String get indianFoodCompositionTitle => "भारतीय खाद्य संघटन तालिकाएँ (2017)";

  @override
  String get indianFoodCompositionDescription =>
      "भारतीय खाद्य संघटन तालिकाएँ (2017): भारतीय खाद्य पदार्थों के लिए व्यापक पोषण संबंधी डेटा।";

  @override
  String get ninTextbesity3 => 'मोटापा वर्ग III';
  @override
  String get ninTextBMRfull => 'बेसल मेटाबोलिक दर (बीएमआर)';
  @override
  String get ninTextBMRDiscription =>
      'बेसल मेटाबॉलिक रेट (बीएमआर) वह दर है जिस पर कोई व्यक्ति आराम करते समय ऊर्जा खर्च करता है';
  @override
  String get ninTextPreviousdays => 'पिछले 30 दिन';
  @override
  String get ninTextason => 'एक बेटा';
  @override
  String get ninTextYearly => 'सालाना';
  @override
  String get ninTextabove => 'ऊपर';
  @override
  String get ninTextAchieveyourhealthgoal =>
      'अपने स्वास्थ्य लक्ष्य को प्राप्त करें';
  @override
  String get heavyDescription =>
      'इस श्रेणी में ऐसे व्यवसाय शामिल हैं जिनमें प्रतिदिन एक घंटे से अधिक समय तक नियमित और गहन शारीरिक गतिविधि, जैसे दौड़ना, साइकिल चलाना या भारी सामान उठाना शामिल है। उदाहरणों में लोहार, खनिक और निर्माण श्रमिक शामिल हैं।';
  @override
  String get moderateDescription =>
      'इस श्रेणी के व्यक्ति प्रतिदिन लगभग 30 मिनट से एक घंटे तक कुछ स्तर की शारीरिक गतिविधि में संलग्न होते हैं, जैसे चलना या हल्की जॉगिंग। शारीरिक मजदूर, कारीगर और कुछ प्रकार के कुशल श्रमिक जैसे व्यवसाय इस श्रेणी में आते हैं।';
  @override
  String get sedentaryDescription =>
      'इस श्रेणी में ऐसे व्यवसाय शामिल हैं जिनमें दिन भर बहुत कम या कोई शारीरिक हलचल नहीं होती। इन नौकरियों में लोग अपना ज्यादातर समय बैठने या लेटने में बिताते हैं। उदाहरणों में कार्यालय कर्मचारी, शिक्षक और प्रशासनिक भूमिका वाले लोग शामिल हैं।';
  @override
  String get Foodprotein => "प्रोटीन";
  @override
  String get Foodfat => "मोटा";
  @override
  String get Foodenergy => "ऊर्जा";
  @override
  String get FoodtotalB2 => "कुल बी2";
  @override
  String get Foodvitamins => "विटामिन";
  @override
  String get FoodtotalFat => "कुल वसा";
  @override
  String get FoodproximateComposition => "समीपस्थ रचना";
  @override
  String get FoodnutrientsIn100g => "100 ग्राम में पोषक तत्व";
  @override
  String get FoodtotalCarotenoids => "कुल कैरोटीनॉयड";
  @override
  String get FoodtotalAscorbicAcid => "कुल एस्कॉर्बिक एसिड";
  @override
  String get FoodtotalB9 => "कुल बी9";
  @override
  String get FoodtotalB6 => "कुल बी6";
  @override
  String get Foodcalcium => "कैल्शियम";
  @override
  String get Foodsodium => "सोडियम";
  @override
  String get Foodpotassium => "पोटैशियम";
  @override
  String get Foodzinc => "जस्ता";
  @override
  String get Foodiron => "लोहा";
  @override
  String get Foodminerals => "खनिज पदार्थ";
  @override
  String get FoodtotalSaturatedFattyAcids => "कुल संतृप्त फैटी एसिड";
  @override
  String get FoodfattyAcids => "वसायुक्त अम्ल";
  @override
  String get FoodtotalDietaryFiber => "कुल आहारीय फ़ाइबर";
  @override
  String get Foodmanganese => "मैंगनीज";
  @override
  String get Foodcopper => "ताँबा";
  @override
  String get Foodselenium => "सेलेनियम";
  @override
  String get Foodmagnesium => "मैगनीशियम";
  @override
  String get Foodphosphorus => "फास्फोरस";
  @override
  String get Foodcholesterol => "कोलेस्ट्रॉल";
  @override
  String get Foodcarbohydrate => "कार्बोहाइड्रेट";
  @override
  String get FoodvitaminB6 => "विटामिन बी6 (मिलीग्राम)";

  @override
  String get Punjabi => "पंजाबी";
  @override
  String get Gujarati => "गुजराती";
  @override
  String get Odia => "ओड़िया";
  @override
  String get Kannada => "कन्नड़";
  @override
  String get Marathi => "मराठी";
  @override
  String get Tamil => "तमिल";
  @override
  String get Bengali => "बंगाली";
  @override
  String get Telugu => "तेलुगु";
  @override
  String get English => "अंग्रेज़ी";
  @override
  String get Hindi => "हिंदी";
  @override
  String get firstname => 'पहला नाम';
  @override
  String get lastname => 'अंतिम नाम';
  @override
  String get labelSodium => "सोडियम";
  @override
  String get labelVitaminC => "विटामिन सी";
  @override
  String get FinanameEnergy => "ऊर्जा";
  @override
  String get FinanameCarbohydrate => "कार्बोहाइड्रेट";
  @override
  String get FinanameFat => "वसा";
  @override
  String get FinanameSodium => "सोडियम";
  @override
  String get FinanameDietaryFibre => "आहारी फाइबर";
  @override
  String get FinanameCalcium => "कैल्शियम";
  @override
  String get FinanameIron => "लोहा";
  @override
  String get FinanameMagnesium => "मैग्नीशियम";
  @override
  String get FinanameZinc => "जिंक";
  @override
  String get FinanameProtein => "प्रोटीन";
  @override
  String get FinanameThiamine => "थायमिन";
  @override
  String get FinanameRiboflavin => "राइबोफ्लेविन";
  @override
  String get FinanameNiacin => "नियासिन";
  @override
  String get FinanameVitaminB => "विटामिन बी";
  @override
  String get FinanameFolate => "फोलेट";
  @override
  String get FinanameVitaminC => "विटामिन सी";
  @override
  String get FinanameVitaminA => "विटामिन ए";
  String get FinanameVitaminB6 => "विटामिन बी 6";
  @override
  String get FinanameVitaminb6 => "विटामिन B6";
  @override
  String get confirmDeleteAllNotifications =>
      "क्या आप वाकई सभी सूचनाएं हटाना चाहते हैं?";
  @override
  String get fillAllFields => "कृपया सभी क्षेत्रों को भरें";
  @override
  String get successfullyAddedIngredient => "सामग्री सफलतापूर्वक जोड़ी गई";
  @override
  String get confirmDeletion => "हटाने की पुष्टि करें";
  @override
  String get confirmDeleteIngredient =>
      "क्या आप वाकई इस सामग्री को हटाना चाहते हैं?";
  @override
  String get fileDownloaded =>
      "फ़ाइल सफलतापूर्वक डाउनलोड हो गई और फ़ाइल का स्थान";
  @override
  String get confirmDeleteFood => "क्या आप वाकई भोजन को हटाना चाहते हैं?";
  @override
  String get estimatedAverageRequirement =>
      'अनुमानित औसत आवश्यकता (EAR): औसत दैनिक सेवन स्तर, जो 50% स्वस्थ व्यक्तियों की आवश्यकताओं को पूरा करने का अनुमान है';
  @override
  String get editQuantity => "मात्रा संपादित करें";
  @override
  String get confirmDelete => "क्या आप वाकई हटाना चाहते हैं?";
  @override
  String get exerciseDeleted => "व्यायाम सफलतापूर्वक हटाया गया।";
  @override
  String get confirmDeleteExercise =>
      "क्या आप वाकई इस व्यायाम को हटाना चाहते हैं?";
  @override
  String get EssentialNutritionalGuidelines =>
      "भारतीयों की आहार आवश्यकताओं के लिए अनुकूलित आवश्यक पोषण दिशानिर्देश।";
  @override
  String get NutrientRequirementsRDA2020 =>
      "भारतीयों के लिए पोषक तत्व आवश्यकताएँ और अनुशंसित आहार भत्ते (आरडीए 2020)।";
  @override
  String get RecommendationsBalancedDiets =>
      "भारत में संतुलित आहार और स्वस्थ खाने की आदतों को बढ़ावा देने के लिए सिफारिशें।";
  @override
  String get DietaryGuidelinesForIndians => "भारतीयों के लिए आहार दिशानिर्देश।";
  @override
  String get Nutritionstat =>
      "पोषण सांख्यिकी"; // यदि आवश्यक हो तो वास्तविक अनुवाद के साथ बदलें
  @override
  String get referenceMen65kg => "संदर्भ पुरुष (65 किग्रा)";
  @override
  String get referenceWomen55kg => "संदर्भ महिला (55 किग्रा)";
  @override
  String get valueForMen => "1506";
  @override
  String get valueForWomen => "1184";
  @override
  String get referenceMenWomenDescription =>
      "संदर्भ पुरुष और महिलाएं स्वस्थ वयस्क होते हैं जो 19-39 वर्ष के होते हैं, जिनका बीएमआई सामान्य होता है और जो मध्यम रूप से सक्रिय होते हैं (आईसीएमआर-एनआईएन)। देखें";
  @override
  String get personalizedDietDiaryDescription =>
      "वैयक्तिकृत आहार डायरी आपके वर्तमान से पिछले महीने तक के पोषक तत्वों के सेवन को ट्रैक करती है";
}
