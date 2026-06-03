import 'package:flutter/material.dart';

/*
Title:Languages
Purpose:Languages
Created By:Kalpesh Khandla
*/

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get totalEnergyConsumption;
  String get totalEnergyExpenditure;

  String get appName;

  String get labelWelcome;

  String get labelInfo;

  String get labelChangeLanguage;
  String get labelPassword;
  String get labelDarkMode;

  String get labelSelectLanguage;
  String get labelWelcomeBack;
  String get labelNormalWeight;
  String get labelUnderweight;

  String get labelOverweight;
  String get labelObese;
  String get labelViewMore;
  String get labelTodaySteps;
  String get labelCheck;
  String get labelHealthData;
  String get labelActivityStatus;
  String get labelHeartRate;
  String get labelHeartRateValue;
  String get labelMinutesAgo;
  String get labelWaterIntake;
  String get labelLiters;
  String get labelZeroLiters;
  String get labelRealTimeGoal;
  String get labelCalories;
  String get labelCaloriesEarned;
  String get labelFoodPlan;
  String get labelWorkoutProgress;
  String get labelWeekly;
  String get labelMonthly;
  String get labelLatestWorkout;
  String get labelSeeMore;
  String get labelBreakfast;
  String get labelLunch;
  String get labelDinner;
  String get labelSnacks;
  String get labelTaken;
  String get labelTarget;

  //profile
  String get labelProfile;
  String get labelEdit;
  String get labelUser;
  String get labelProgram;
  String get labelHeight;
  String get labelWeight;
  String get labelAge;
  String get labelAccount;
  String get labelPersonalData;
  String get labelAchievement;
  String get labelActivityHistory;
//String get labelWorkoutProgress => "व्यायाम प्रगति";
  String get labelNotification;
  String get labelPopupNotification;
  String get labelMensurationCycle;
  String get labelOther;
  String get labelContactUs;
  String get labelPrivacyPolicy;
  String get labelSetting;
  String get labelFeedback;
  String get labelConfirmLogout;
  String get labelConfirmLogoutMessage;
  String get labelLogout;

  //select tab
  String get labelOptions;
  String get labelFoodTable;
  String get labelTop10Food;
  String get labelActivityTrack;
  String get labelsteptracker;
  String get labelTodayTarget;
  String get labelJoggingTrack;
  String get labelMensurationTrack;
  String get labelconectWatch;
  //String get labelFoodTable => "खाने की सारणी";

  ///
  // Sleep Book Store
  String get labelSleep;
  String get labelBookStore;
  String get labelSearchBooks;
  String get labelPrice;
  String get labelAddToCart;
  String get labelAuthor;
  String get labelYear;
  String get labelQuantityAvailable;
  String get labelCart;
  String get labelMyOrders;
  String get labelAllOrders;
  String get labelOrderDetail;
  String get labelOrderId;
  String get labelOrdersInMyOrders;
  String get labelItemsInMyOrders;
  String get labelTotal;
  String get labelTotalPrice;
  String get labelCheckout;

  // Meal List
  String get labelMealList;
  String get labelAnalyze;
  String get labelAddDish;
  String get lablelDishName;
  String get labelTop10Foods;
  String get labelRecentMeal;
  String get labelAnalyzeIngredientsTaken;

  // Nutrition Summary
  String get labelCarbs;
  // String get labelCalories;
  String get labelFibers;
  String get labelFats;
  String get labelProteins;
  String get labelCalcium;
  String get labelNiacinB3;
  String get labelThiamineB1;
  String get labelIron;
  String get labelZinc;
  String get labelFolatesB9;
  String get labelRiboflavinB2;
  String get labelRetinolVitA;
  String get labelMagnesium;

  String get labelTodaysNutritionSummary;
  String get labelChangeGoal;
  String get labelIngredientsTaken;
  String get labelIngredientsLeft;

  // Food Table
  // String get labelFoodTable;
  // String get labelBreakfast;
  // String get labelLunch;
  // String get labelDinner;
  // String get labelSnacks;
  String get labelTop10FoodsSleep;
  String get labelFavouriteDishes;

  // User Profile
  String get labelHelp;
  // String get labelLogout;
  // String get labelWeight;
  String get labelEmail;
  // String get labelHeight;
  String get labelLinkedInProfileLink;
  String get labelGoogleProfileLink;
  String get labelFacebookProfileLink;
  String get labelTwitterProfileLink;
  String get labelName;
  String get labelPhoneNumber;
  String get labelDateOfBirth;
  String get labelBMI;
  // String get labelAge;

  // Contact Us
  String get labelMessage;
  String get labelSubmit;
  String get labelCompanyContacts;
  String get labelAddress;
  String get labelDirectorsEmail;
  String get labelFax;

  // Settings
  String get labelResetPassword;
  //String get labelFeedback;
  String get labelPleaseProvideFeedback;
  String get labelEnterYourFeedbackHere;
  String get labelSubmitFeedback;

  // Credits
  //String get labelContactUs;
  String get labelDevelopmentTeam;
  String get labelAcknowledgments;
  String get labelPartnerships;

  // Mobile
  String get labelSearchComponents;
  String get labelSearchComponentsHere;
  String get labelCredits;
  String get labelShareApp;
  String get labelShareAppButton;
  // New Translations
  String get labelConnectedWatch;
  String get labelDisconnect;
  String get labelFitbit;
  String get labelGoogleFit;
  String get labelAppleWatch;
  String get labelSamsungSmartWatch;
  String get labelBookDetails;
  String get labelDeliverystatus;
  String get labelOrderDate;
  String get labelAnalyseIngredientsTaken;
  String get labelAddDishIngredients;
  String get labelIngredientName;
  String get labelEnterIngredientName;
  String get labelIngredientQuantity;
  String get labelEnterIngredientQuantity;
  String get labelAdd;
  String get labelSave;

  String get labelwatch;

  ///
  /// // New Translations
  String get labelBloodOxygenHeart;
  String get labelTop10FoodS;
  String get labelWaterTrack;
  String get labelPersonalDetails;
  String get labelFeedbackS;
  String get labelContactUsS;
  String get labelBMICalculator;
  String get labelBMRCalculator;
  String get labelRunningJoggingSteps;
  String get labelHealthyDietChart;
  String get labelHealthyRecommendation;
  String get labelSleepTracker;
  String get labelSetReminder;
  String get labelCSVDownload;

  // New Headings
  String get headingBloodOxygenHeart;
  String get headingTop10Food;
  String get headingWaterTrack;
  String get headingPersonalDetails;
  String get headingFeedback;
  String get headingContactUs;
  String get headingBMICalculator;
  String get headingBMRCalculator;
  String get headingRunningJoggingSteps;
  String get headingHealthyDietChart;
  String get headingHealthyRecommendation;
  String get headingSleepTracker;
  String get headingSetReminder;
  String get headingCSVDownload;

  // Water-related phrases
  String get labelWaterTarget;
  // String get labelTodayTarget;
  String get labelWaterGoal;
  // String get labelWaterIntake;
  String get labelWaterProgress;
  // String get labelWeekly;
  String get labelDateWise;
  String get labelSun;
  String get labelMon;
  String get labelTue;
  String get labelWed;
  String get labelThu;
  String get labelFri;
  String get labelSat;

  // BMI Calculator
  // String get labelBMI;
  String get labelEnterHeight;
  String get labelEnterWeight;
  String get labelCalculateBMI;

  // BMR Calculator
  String get labelMale;
  String get labelFemale;
  String get labelEnterAge;
  String get labelCalculateBMR;
  String get labelBMR;
  String get labelCaloriesPerDay;

  // Step Tracker
  String get labelStepsTracker;
  String get labelRunningTracker;
  String get labelAddStep;
  String get labelSelectDate;
  String get labelJoggingTracker;
  String get labelCaloriesBurn;

  // Sleep Tracker
  String get labelSleepTarget;
  String get labelTodaySleep;
  String get labelSleepProgress;
  String get labelTotalSleep;
  String get labelSleepGoal;
  String get labelSetNotification;
  String get labelStartTime;
  String get labelEndTime;
  String get labelSelect;
  // String get labelSave;
  String get labelStart;
  String get labelEnd;
  String get labelType;

  // String get labelMensurationCycle;

  String get labelTrackAndManage;

  String get labelMensurationStatus;

  String get labelDaysLength;

  String get labelDay;

  String get labelNextDate;

  String get labelLastPeriodStartDate;

  String get labelAverageCycleLength;

  String get labelChange;
  String get labelIsConnected;

  String get messageSent;
  String get thankYouForContactingUs;
  String get alert;
  String get fillInAllFields;
  String get thankYouFeedbackSubmitted;
  String get resetPassword;
  String get dishAdded;
  String get dishAndIngredientsAddedSuccessfully;
  String get failed;
  String get error;
  String get enterBloodGlucoseLevel;
  String get enterBloodPressureLevel;
  String get enterHeartLevel;
  // String get enterOxygenSaturationLevel;
  String get cancel;
  String get submit;
  String get valueCannotBeGreaterThan100;
  String get bloodStatusSubmittedSuccessfully;
  String get failedToSubmitBlood;
  String get enterHeartLevel1to100;
  String get heartLevelSubmittedSuccessfully;
  String get enterOxygenSaturationLevel1to100;
  String get oxygenLevelSubmittedSuccessfully;
  String get updateData;
  String get selectLastPeriodStartDate;
  String get update;
  String get failedToFetchBooks;
  String get errorOccurred;
  String get invalidEndTime;
  String get chooseTimeWithin1Hour;
  String get notificationSaved;
  String get notificationSetSuccessfully;
  String get thereIsSomeError;
  String get watchDisconnected;
  String get watchDisconnectedSuccessfully;
  String get addCup;
  String get numberOfCups;
  String get addCupCapacityInMl;
  String get cupCapacitySubmittedSuccessfully;
  String get pleaseEnterValidValuesForAllFields;
  String get enterWater;
  String get waterGoalLiters;
  String get waterSubmittedSuccessfully;
  String get addActivityData;
  String get enterValue;
  String get addStepsData;
  String get numberOfSteps;
  String get stepsDataSubmittedSuccessfully;
  String get enterSleepTarget;
  String get sleepTargetInHours;
  String get addYourSleepDuration;
  String get enterDurationInMinutes;
  String get add;

  String get ok;
  String get csvFileSavedTo;

  String get ageMustBeBetween2And100Years;

  String get next;

  String get register;

  String get oopsSomethingWentWrong;

  String get errorFetchingMeals;
  String get tryLater;

  String get reviewAddedSuccessfully;

  String get failedToAddReview;

  String get alreadyInCart;

  String get addedToCart;

  String get quantityNotBetween1And2;
  String get createcustomdish;
  String get quantityingram;
  String get labelCaloriestaken;

  // Time Spent in Different Activities
  String get mainlabelEarlyMorning;
  String get mainlabelMidMorning;
  String get mainlabelEvening;
  String get mainlabelBedtime;

// Health Calculator
  String get mainlabelStepProgress;
  String get mainlabelRealTimeIntakes;
  String get mainlabelCaloriesBurnProgress;
  String get mainlabelCaloriesBurnBreakdown;
  String get mainlabelHeartReportsTrends;
  String get mainlabelOxygenStatus;
  String get mainlabelNoRecord;
  String get mainlabelSystolicBloodPressure;
  String get mainlabelBloodPressure;
  String get mainlabelMeasuredon;
  String get mainlabelEnterBloodPressure;
  String get mainlabelDiastolicBloodPressure;
  String get mainlabelBloodGlucose;
  String get mainlabelHeartStatus;
  String get mainlabelAllExercise;
  String get mainlabelCleaningOrMopping;
  String get mainlabelGardening;
  String get mainlabelWatchingTV;
  String get mainlabelCycling;
  String get mainlabelRunning;
  String get mainlabelWalking;
  String get mainlabelShuttle;
  String get mainlabelTableTennis;
  String get mainlabelTennis;
  String get mainlabelVolleyBall;
  String get mainlabelDancing;
  String get mainlabelFishing;
  String get mainlabelShopping;
  String get mainlabelTyping;
  String get mainlabelSleeping;
  String get mainlabelStanding;
  String get mainlabelSitting;

// Click to Start Activity
  String get mainlabelClickToStartActivity;

// BMI Calculator
  String get mainlabelBMICalculator;

// BMR calculator
  String get mainlabelBMRCalculator;

// Download Activity Report in Csv
  String get mainlabelDownloadActivityReportInCsv;

// Select Start Date
  String get mainlabelSelectStartDate;

// Select End Date
  String get mainlabelSelectEndDate;

// Download File
  String get mainlabelDownloadFile;

// Date
  String get mainlabelDate;

// Value
  String get mainlabelValue;

// link
  String get mainlabelLink;

// No Notification Found
  String get mainlabelNoNotificationFound;

// Total Nutrition taken
  String get mainlabelTotalNutritionTaken;

// Search Food
  String get mainlabelSearchFood;

// Select From Personal Food
  String get mainlabelSelectFromPersonalFood;

// Recipy name
  String get mainlabelRecipeName;

// Select Date
  String get mainlabelSelectDate;

// Nutrient of All Ingredients(Raw)
  String get mainlabelNutrientOfAllIngredientsRaw;

// Nutrients Compostion of Cooked weight
  String get mainlabelNutrientsCompostionOfCookedWeight;

// Want to edit this recipy ? Follow the
  String get mainlabelWantToEditThisRecipyFollowThe;

// Add Ingredient from
  String get mainlabelAddIngredientFrom;

// Add from Nutrient specifc food
  String get mainlabelAddFromNutrientSpecifcFood;

// Add from All foods
  String get mainlabelAddFromAllFoods;

// no. of serving
  String get mainlabelNumberOfServing;

// weight(g)
  String get mainlabelWeightInG;

// Edit Ingredients Weight
  String get mainlabelEditIngredientsWeight;

// Ingredient:
  String get mainlabelIngredient;

// New Weight (g)
  String get mainlabelNewWeightInG;

// cancel
  String get mainlabelCancel;

// update
  String get mainlabelUpdate;

// Cooked Weight(g)
  String get mainlabelCookedWeightInG;

// Enter Weight
  String get mainlabelEnterWeight;

// Edit Recipe
  String get mainlabelEditRecipy;

// Alert
  String get mainlabelAlert;

// To see nutrition composition
// please enter no. of serving
  String get mainlabelToSeeNutritionCompositionPleaseEnterNoOfServing;

// Nutrirnts in 100(Cooked) weight
  String get mainlabelNutrirntsIn100CookedWeight;

// set nutrition target in gram
  String get mainlabelSetNutritionTargetInG;

// Food Analyse
  String get mainlabelFoodAnalyse;

// Explore top 10 foods
  String get mainlabelExploreTop10Foods;

// Search Cooked Food
  String get mainlabelSearchCookedFood;

// Nutrition Based On EAR
  String get mainlabelNutritionBasedOnEAR;

// Diet Diary
  String get mainlabelDietDiary;

// Recipes
  String get mainlabelRecipes;

// Search by food Name
  String get mainlabelSearchByFoodName;

// All Recipe of 100 grams
  String get mainlabelAllRecipeOf100G;

// Nutrition Requirement
  String get mainlabelNutritionRequirement;

// gender
  String get mainlabelGender;

// particulars
  String get mainlabelParticulars;

// bodyweight
  String get mainlabelBodyWeight;

// Dietary Diary Reports
  String get mainlabelDietaryDiaryReports;

// Total Nutrition Taken on
  String get mainlabelTotalNutritionTakenOn;

// attach image
  String get mainlabelAttachImage;
  String get mainlabelTimeSpentOn;
  String get mainlabelHealthCalculator;
  String get mainlabelFixedRecipy;
  String get mainlabelFoodInDetail;
  String get TextAppNutrientsInMyFood;
  String get TextAppMyActivity;
  String get TextAppToday;
  String get TextAppMyNutrientRequirements;
  String get TextAppTotalNutrition;
  String get TextAppTaken;
  String get TextAppRatings;
  String get TextAppSearchComponents;
  String get TextAppTotalNutrientTaken;
  String get TextAppShareApp;
  String get TextAppNoNotificationsFound;
  String get TextAppConnectWatch;
  String get TextAppYourBMIIs;
  String get TextAppBMI;
  String get TextAppBMICategories;
  String get TextAppUnderweight;
  String get TextAppNormal;
  String get TextAppOverweight;
  String get TextAppObesity;
  String get TextAppSelectDate;
  String get TextAppOxygen;
  String get TextAppBlood;
  String get TextAppNoRecord;
  String get TextAppAllExercise;
  String get TextAppCleaningOrMopping;
  String get TextAppGardening;
  String get TextAppWatchingTV;
  String get TextAppCycling;
  String get TextAppRunning;
  String get TextAppWalking;
  String get TextAppShuttle;
  String get TextAppTableTennis;
  String get TextAppTennis;
  String get TextAppVolleyBall;
  String get TextAppDancing;
  String get TextAppFishing;
  String get TextAppShopping;
  String get TextAppTyping;
  String get TextAppSleeping;
  String get TextAppStanding;
  String get TextAppSitting;
  String get TextAppClickStartToStartActivity;
  String get TextAppCaloriesBurn;
  String get TextAppAddDurationManually;
  String get TextAppStartOrMopping;
  String get TextAppMale;
  String get TextAppFemale;
  String get TextAppWeightManager;
  String get TextAppUpdateWeight;
  String get TextAppSetWeightGoal;
  String get TextAppCurrentWeight;
  String get TextAppWeightProgress;
  String get TextAppPrevious30Days;
  String get TextAppYourWeightGoalIsSet;
  String get TextAppMaintain;
  String get TextAppInitialWeightOf;
  String get TextAppFinalWeightOf;
  String get TextAppWeight;
  String get TextAppYouAreNotYetAchievingYourWeightGoalKeepGoing;
  String get TextAppYouAreAchievedYourWeightGoalKeepGoing;
  String get TextAppAndYourWeightChangeIsSet;
  String get TextApp1NutrientsInMyFood;
  String get TextAppSearchNutrientsInRawFoods;
  String get TextAppRawIngredients;
  String get TextAppSearchRawFoodByName;
  String get TextApp1MyActivity;
  String get TextAppCheckOthersDates;
  String get TextAppYour24HoursChart;
  String get TextAppActivity;
  String get TextAppOthers;
  String get TextAppExerciseDetails;
  String get TextAppActivityType;
  String get TextAppDuration;
  String get TextAppMyActivityOfCustomDates;
  String get TextAppOurCustomerFeedback;
  String get TextAppOverallRatings;
  String get TextAppEnterCookedWeight;
  String get TextAppCookedWeightGram;
  String get TextAppNutrientIn100gCooked;
  String get TextAppEnterServingSize;
  String get TextAppSearchByRecipeName;
  String get TextAppMyPersonalRecipe;
  String get TextAppFixedRecipe;
  String get TextApp2NutrientsInMyFood;
  String get TextAppMyDietDiary;
  String get TextApp2MyActivity;
  String get TextAppDownloadFile;
  String get TextAppStartMyNewDietDiary;
  String get TextAppGoogle;
  String get TextAppFacebook;
  String get TextAppLinkedin;
  String get TextAppTwitter;
  String get TextAppContactUs;
  String get TextAppReportBug;
  String get TextAppAttachImage;
  String get TextAppResetPassword;
  String get TextAppNINAppCreditsPage;

  String get NINTextOopsSomethingWentWrong;
  String get NINTextPleaseEnterAllFields;
  String get NINTextSubmittedSuccessfully1;
  String get NINTextSubmittedSuccessfully2;
  String get NINTextFitbitAuthentication;
  String get NINTextHours;
  String get NINTextMinutes;
  String get NINTextEnterDurationFor;
  String get NINTextTimerRunning;
  String get NINTextPleaseStopTheTimerBeforeSubmitting;
  String get NINTextTotalDuration;
  String get NINTextSec;
  String get NINTextStartYourActivity;
  String get NINTextPause;
  String get NINTextReset;
  String get NINTextError;
  String get NINTextPleaseEnterCookedWeightAndServingSize;
  String get NINTextEditIngredient;
  String get NINTextAlert;
  String get NINTextEnterWeightFor;
  String get NINTextNewWeightGram;
  String get NINTextEditRecipeName;
  String get NINTextNewRecipeName;
  String get NINTextSubmitted;
  String get NINTextSuccess;
  String get NINTextDietaryDiaryReportSavedTo;
  String get NINTextErrorSavingFile;
  String get NINTextClose;
  String get NINTextIWantTo;
  String get NINTextGain;
  String get NINTextMaintain;
  String get NINTextLose;
  String get NINTextWeightChangeKg;
  String get NINTextAddNewWeight;
  String get NINTextEnterWeight;
  String get NINTextOf100Gram;
  String get NINTextProximateComposition;
  String get NINTextVitamins;
  String get NINTextMinerals;
  String get NINTextTotalSaturatedFattyAcids;
  String get NINTextAllRecipeOf100Grams;
  String get NINTextOurCustomerFeedback;
  String get NINTextOverallRatings;
  String get NINTextRateUs;
  String get NINTextBookDetails;
  String get NINTextOne;
  String get NINTextWeightOf;
  String get NINTextSelectStartDate;
  String get NINTextSelectEndDate;
  String get NINTextNoData;
  String get NINTextWorkLevel;
  String get NINTextOldPassword;
  String get NINTextNewPassword;
  String get NINTextUpdateProfile;
  String get NINTextChangeImage;
  String get NINTextNoFavouriteFoodFound;
  String get NINTextCookedQuantity;
  String get NINTextServingQuantity;
  String get NINTextNutrientInformation;
  String get NINTextIngredient;
  String get NINTextMealsTakenOn;
  String get NINTextPercentage;
  String get NINTextEAR;
  String get NINTextValue;
  String get NINTextNutrient;
  String get NINTextEnergyKcal;
  String get NINTextProteinG;
  String get NINTextFatG;
  String get NINTextCarbohydratesG;
  String get NINTextCalciumMg;
  String get NINTextFiberG;
  String get NINTextIronMg;
  String get NINTextZincMg;
  String get NINTextMagnesiumMg;
  String get NINTextThiamineB1Mg;
  String get NINTextRiboflavinB2Mg;
  String get NINTextNiacinB3Mg;
  String get NINTextFolatesB9Mcg;
  String get NINTextRetinolVitAMcg;
  String get VitaminCmg;
  String get Iodinemcg;
  String get serving;
  String get Mynutritionstatus;
  String get ninTextMyHealthStatus;
  String get ninTextNutrientsInRawFoods;
  String get ninTextNutrientsInRecipes;
  String get ninTextIcmrNinMyPlateForTheDay;
  String get ninTextToday;
  String get ninTextTrackMyActivity;
  String get ninTextMyHeartRate;
  String get ninTextMyWaterIntake;
  String get ninTextSleepTracker;
  String get ninTextLit;
  String get ninTextRecordMyBloodPressure;
  String get ninTextNutritionEducationContent;
  String get ninTextMyNutrientIntake;
  String get ninTextOn;
  String get ninTextWithReferenceToEAR;
  String get ninTextAchieveYourHealthGoals;
  String get ninTextPercentage;
  String get ninTextMyPreviousDietDiaries;
  String get ninTextRecordReviewSleep;
  String get ninTextHours;
  String get ninTextIngredient;
  String get ninTextOthersSpecify;
  String get ninTextAddNewIngredient;
  String get ninTextFoodName;
  String get ninTextSource;
  String get ninTextEnterBrandAndProductName;
  String get ninTextEnterAuthorDetails;
  String get ninTextEnterFctName;
  String get ninTextName;
  String get ninTextProductName;
  String get ninTextSelectStartDate;
  String get ninTextSelectEndDate;
  String get ninTextNoExercise;
  String get ninTextDevelopedWithExpertiseAndInputs;
  String get ninTextMyNutrientIntakeToday;
  String get ninTextIcmrNationalInstituteOfNutritionAddress;

  String get ninTextKcal;
  String get ninTextKcalPerDay;
  String get ninTextDeleteNotification;
  String get ninTextConfirmDeleteNotification;
  String get ninTextTimeFor;
  String get ninTextFitbitWatch;
  String get ninTextGoogleFitApp;
  String get ninTextUnderweight;
  String get ninTextNormal;
  String get ninTextOverweight;
  String get ninTextObesity;
  String get ninTextMale;
  String get ninTextFemale;
  String get ninTextAgeInYears;
  String get ninTextChangeInWeight;
  String get ninTextSteps;
  String get ninTextFor;
  String get ninTextMinutes;
  String get ninTextPause;
  String get ninTextReset;
  String get ninTextStartActivity;
  String get ninTextCartIsEmpty;
  String get ninTextMyPersonalRecipe;
  String get ninTextSearchByRecipeName;
  String get ninTextHelpCenter;
  String get ninTextCommonProblems;
  String get ninTextFAQs;
  String get ninTextHowActiveAreYou;
  String get ninTextVitaminC;
  String get ninTextVitaminA;
  String get ninTextSodium;
  String get ninTextJournal;
  String get ninTextPage;
  String get ninTextDelete;
  String get ninTextAdequateIntakeCarbs;
  String get ninTextAdequateIntakeFiber;
  String get your;
  String get question1;
  String get answer1;
  String get linkText1;

  String get question2;
  String get answer2;
  String get linkText2;

  String get question3;
  String get answer3;
  String get linkText3;

  String get question4;
  String get answer4;
  String get linkText4;

  String get question5;
  String get answer5;
  String get linkText5;

  String get question6;
  String get answer6;
  String get linkText6;

  String get question7;
  String get answer7;
  String get linkText7;

  String get question8;
  String get answer8;
  String get linkText8;

  String get question9;
  String get answer9;
  String get linkText9;

  String get question10;
  String get answer10;
  String get linkText10;

  String get question11;
  String get answer11;
  String get linkText11;

  String get question12;
  String get answer12;
  String get linkText12;

  String get question13;
  String get answer13;
  String get linkText13;

  String get question14;
  String get answer14;
  String get linkText14;

  String get question15;
  String get answer15;
  String get linkText15;

  String get question16;
  String get answer16;
  String get linkText16;

  String get question17;
  String get answer17;
  String get linkText17;

  String get question18;
  String get answer18;
  String get linkText18;

  String get question19;
  String get answer19;
  String get linkText19;

  String get question20;
  String get answer20;
  String get linkText20;

  String get question21;
  String get answer21;
  String get linkText21;

  String get ninTextBmiHwading;
  String get ninTextBmiDiscription;
  String get ninTextbminutritionsta;
  String get ninTextNutritionstat;
  String get ninTextBelow;
  String get ninTextPreobesity;

  String get ninTextbesity;
  String get ninTextbesity2;
  String get ninTextbesity3;
  String get ninTextBMRfull;
  String get ninTextBMRDiscription;
  String get ninTextPreviousdays;
  String get ninTextason;
  String get ninTextYearly;
  String get ninTextabove;
  String get heavyDescription;
  String get moderateDescription;
  String get sedentaryDescription;
  String get ninTextAchieveyourhealthgoal;
  String get Foodprotein;
  String get Foodfat;
  String get Foodenergy;
  String get FoodtotalB2;
  String get Foodvitamins;
  String get FoodtotalFat;
  String get FoodproximateComposition;
  String get FoodnutrientsIn100g;
  String get FoodtotalCarotenoids;
  String get FoodtotalAscorbicAcid;
  String get FoodtotalB9;
  String get FoodtotalB6;
  String get Foodcalcium;
  String get Foodsodium;
  String get Foodpotassium;
  String get Foodzinc;
  String get Foodiron;
  String get Foodminerals;
  String get FoodtotalSaturatedFattyAcids;
  String get FoodfattyAcids;
  String get FoodtotalDietaryFiber;
  String get Foodmanganese;
  String get Foodcopper;
  String get Foodselenium;
  String get Foodmagnesium;
  String get Foodphosphorus;
  String get Foodcholesterol;
  String get Foodcarbohydrate;
  String get FoodvitaminB6;

  String get Punjabi;
  String get Gujarati;
  String get Odia;
  String get Kannada;
  String get Marathi;
  String get Tamil;
  String get Bengali;
  String get Telugu;
  String get English;
  String get Hindi;

  String get firstname;
  String get lastname;
  String get labelSodium;
  String get labelVitaminC;
  String get FinanameEnergy;
  String get FinanameCarbohydrate;
  String get FinanameFat;
  String get FinanameSodium;
  String get FinanameDietaryFibre;
  String get FinanameCalcium;
  String get FinanameIron;
  String get FinanameMagnesium;
  String get FinanameZinc;
  String get FinanameProtein;
  String get FinanameThiamine;
  String get FinanameRiboflavin;
  String get FinanameNiacin;
  String get FinanameVitaminB;
  String get FinanameFolate;
  String get FinanameVitaminC;
  String get FinanameVitaminA;
  String get FinanameVitaminb6;
  String get confirmDeleteAllNotifications;
  String get fillAllFields;
  String get successfullyAddedIngredient;
  String get confirmDeletion;
  String get confirmDeleteIngredient;
  String get fileDownloaded;
  String get confirmDeleteFood;
  String get estimatedAverageRequirement;
  String get editQuantity;
  String get confirmDelete;
  String get exerciseDeleted;
  String get confirmDeleteExercise;
  String get EssentialNutritionalGuidelines;
  String get NutrientRequirementsRDA2020;
  String get RecommendationsBalancedDiets;
  String get DietaryGuidelinesForIndians;
  String get Nutritionstat; // Replace with actual translation if needed
  String get referenceMen65kg;
  String get referenceWomen55kg;
  String get valueForMen;
  String get valueForWomen;
  String get referenceMenWomenDescription;
  String get personalizedDietDiaryDescription;
  String get energybalance;
  String get indicatorhealth;
  String get inputActivityDataPrompt;
  String get myEnergyBalanceYesterday;
  String get caloriesBurnFromWatch;
  String get activities;
  String get searchActivityHere;
  String get orSelectActivityFromBelow;
  String get recordMyDiet;
  String get moisture;
  String get indianFoodCompositionTitle;

  String get indianFoodCompositionDescription;
}
