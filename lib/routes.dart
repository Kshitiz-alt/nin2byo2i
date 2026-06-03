import 'package:flutter/material.dart';
import 'package:nin2byo2i/view/profile/UpdateProfileData.dart';
import 'package:nin2byo2i/screens/SignIn/complete_profile.dart';
import 'package:nin2byo2i/screens/SignIn/create_account.dart';
import 'package:nin2byo2i/screens/SignIn/login.dart';
import 'package:nin2byo2i/screens/SignIn/otp.dart';
import 'package:nin2byo2i/screens/SignIn/sucess_registration.dart';

import 'package:nin2byo2i/screens/onboard/onboard_screen1.dart';
import 'package:nin2byo2i/screens/onboard/onboard_screen2.dart';
import 'package:nin2byo2i/screens/onboard/onboard_screen3.dart';
import 'package:nin2byo2i/screens/welcome_screen.dart';
import 'package:nin2byo2i/view/main_tab/main_tab_view.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => const WelcomeScreen(),
  '/onboard1': (context) => const Onboarding1(),
  '/onboard2': (context) => const OnboardScreen2(),
  '/onboard3': (context) => const OnboardScreen3(),
  // '/onboard4': (context) => const OnboardScreen4(),
  '/createaccount': (context) => const CreateAccount(),
  '/otp': (context) => const OtpScreen(),
  //'/verification': (context) => const VerificationScreen(str data),
  '/successrig': (context) => const SuccessRegistration(),
  '/completeProfile': (context) => const CompleteProfile(),
  '/login': (context) => const LoginScreen(),
  '/root': (context) => const MainTabView(),
  // '/notifications': (context) => const Notifications(),
  // '/workout': (context) => const WorkoutTracker(),
  // '/MealShedule': (context) => const MealSheduleWidget(),mm
  '/UpdateProfilePage': (context) => UpdateProfilePage(),
};
