import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Help%20Supports/ContactUs.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//terms and condition screen
class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.themeColor,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ThemeManager.themelightColor,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/black_btn.png",
              width: 15,
              height: 15,
              color: ThemeManager.themeText,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          " Terms and Conditions",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nutrify India Now 2.0 App - Terms and Conditions",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "1. Introduction",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Welcome to Nutrify India Now 2.0, a health and fitness app. By using this app, you agree to comply with and be bound by the following terms and conditions. If you do not agree with these terms and conditions, please do not use the app.",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "2. Use of the App",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "- You must be at least 18 years of age to use this app.",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                ),
              ),
              // Add more sections as needed
              const SizedBox(height: 16),
              Text(
                "6. Contact Us",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "If you have any questions or concerns about these terms and conditions, please contact us at support@nutrifyindia.com or",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactUsPage()));
                },
                child: const Text(
                  "Click here",
                  style: TextStyle(
                      fontSize: AppFontSizes.mediumDefault, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "This document was last updated on November 2, 2023.",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
