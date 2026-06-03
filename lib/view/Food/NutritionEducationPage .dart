import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//nutrient education loink page
class NutritionEducationPage extends StatelessWidget {
  const NutritionEducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> languageLinks = {
      Languages.of(context)!.Hindi: 'http://hi.vikaspedia.in/health/nutrition',
      Languages.of(context)!.English: 'http://vikaspedia.in/health/nutrition',
      Languages.of(context)!.Telugu: 'http://te.vikaspedia.in/health/nutrition',
      Languages.of(context)!.Bengali:
          'http://bn.vikaspedia.in/health/9aa9c19b79cd99f9bf',
      Languages.of(context)!.Tamil:
          'http://ta.vikaspedia.in/health/b8ab9fbcdb9fb9abcdb9aba4bcdba4bc1',
      Languages.of(context)!.Marathi:
          'http://mr.vikaspedia.in/health/92a94b93793e93993e930',
      Languages.of(context)!.Kannada:
          'http://kn.vikaspedia.in/health/c86cafcc1cb6ccd',
      Languages.of(context)!.Odia:
          'http://or.vikaspedia.in/health/b2ab41b37b4db1fb3f',
      Languages.of(context)!.Gujarati:
          'http://gu.vikaspedia.in/health/aaaacbab7aa3',
      Languages.of(context)!.Punjabi:
          'http://pa.vikaspedia.in/health/a2aa4ba15-a06a39a3ea30',
    };
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
              color: ThemeManager.themeText,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.ninTextNutritionEducationContent,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: TColor.primaryColor1,
                borderRadius: BorderRadius.circular(
                    10.0), // Optional: Adds rounded corners
              ),
              padding: const EdgeInsets.all(
                  16.0), // Optional: Adds padding inside the container
              child: Text(
                Languages.of(context)!.ninTextDevelopedWithExpertiseAndInputs,
                style: const TextStyle(
                  fontSize: AppFontSizes
                      .mediumDefault, // Set your desired font size here
                  color: Colors.white, // Optional: Set text color
                ),
              ),
            ),
          ),
          // Text(
          //     "Developed with Expertise and Inputs from NIN by Centre for Development and Advanced Computing (C-DAC), Hyderabad Language 	Link"),
          Expanded(
            child: ListView(
              children: [
                for (var entry in languageLinks.entries)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            12.0), // Adjust the radius as needed
                        color: ThemeManager
                            .themelightColor, // Example color, adjust as needed
                      ),
                      child: ListTile(
                        title: Text(
                          "${entry.key} ",
                          style: TextStyle(
                            color: ThemeManager.themeText,
                          ),
                        ),
                        subtitle: Text(entry.value,
                            style: const TextStyle(color: Colors.blue)),
                        onTap: () {
                          _launchURL(entry.value);
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
