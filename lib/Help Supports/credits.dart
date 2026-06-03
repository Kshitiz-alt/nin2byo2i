import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Help%20Supports/ContactUs.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//credits page
class HealthAppCreditsPage extends StatelessWidget {
  const HealthAppCreditsPage({super.key});

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
              "assets/img/black_btn.png", // Replace with your health app logo asset path
              width: 15,
              height: 15,
              color: ThemeManager.themeText,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.labelCredits,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Health App Logo
              Container(
                color: Colors.white,
                child: Image.asset(
                  "assets/NIN-logo.png", // Replace with your health app logo asset path
                  width: MediaQuery.of(context).size.width * 0.9,
                  // height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                Languages.of(context)!.TextAppNINAppCreditsPage,
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Contact Email
              Text(
                "${Languages.of(context)!.labelContactUs}:",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactUsPage()));
                },
                child: const Text(
                  "nutrifyindianow.nin@gmail.com", // Replace with your health app contact email
                  style: TextStyle(
                      fontSize: AppFontSizes.mediumDefault, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 16),
              // Other Sample Sections
              Text(
                "1.${Languages.of(context)!.labelDevelopmentTeam}",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Meet the talented individuals who contributed to the development of the Health App.",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "2. ${Languages.of(context)!.labelAcknowledgments}",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "We would like to express our gratitude to all the users who have supported and provided valuable feedback for the Health App.",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "3. ${Languages.of(context)!.labelPartnerships}",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Special thanks to our partners for their collaboration in promoting a healthier lifestyle.",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                ),
              ),
              const SizedBox(height: 16),
              // Add more sections as needed
            ],
          ),
        ),
      ),
    );
  }
}
