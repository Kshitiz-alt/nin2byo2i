import 'package:flutter/material.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
//feed back page

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final UserProfileController _controller = UserProfileController();
  String feedbackText = '';
  void senfeedback(String feed) async {
    // Call the API function to update the data with newData
    await _controller.SendFeedbackUser(feed);
    Navigator.of(context).pop(); // Close the update modal
    Navigator.of(context).pop();
    }

  void showThankYouDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeManager.themelightColor,
          title: Text(
            Languages.of(context)!.thankYouFeedbackSubmitted,
            style: TextStyle(
              color: ThemeManager.themeText,
            ),
          ),
          content: Text(
            Languages.of(context)!.thankYouFeedbackSubmitted,
            style: TextStyle(color: ThemeManager.themeText),
          ),
          actions: [
            TextButton(
              onPressed: () {
                senfeedback(feedbackText);
                // Navigator.of(context).pop();
                // Navigator.of(context).pop();
              },
              child: Text(
                Languages.of(context)!.ok,
                style: TextStyle(color: ThemeManager.themeText),
              ),
            ),
          ],
        );
      },
    );
  }

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
              color: ThemeManager.themeText,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.labelFeedback,
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
            children: <Widget>[
              Text(
                '${Languages.of(context)!.labelPleaseProvideFeedback}:',
                style: TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    color: ThemeManager.themeText),
              ),
              const SizedBox(height: 10),
              TextField(
                maxLines: 5,
                onChanged: (text) {
                  setState(() {
                    feedbackText = text;
                  });
                },
                style: TextStyle(color: ThemeManager.themeText),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintText: Languages.of(context)!.labelEnterYourFeedbackHere,
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ThemeManager.themeText), // Border color
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: RoundButton(
                  title: Languages.of(context)!.labelSubmitFeedback,
                  type: RoundButtonType.bgGradient,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.w400,
                  onPressed: () {
                    showThankYouDialog();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
