import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//report missing ingredient from this page
class ReportMissingIngredients extends StatefulWidget {
  const ReportMissingIngredients({super.key});

  @override
  _ReportMissingIngredientsState createState() =>
      _ReportMissingIngredientsState();
}

class _ReportMissingIngredientsState extends State<ReportMissingIngredients> {
  final TextEditingController _messageController = TextEditingController();
  final UserProfileController _controller = UserProfileController();
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
              color: ThemeManager.themeText,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Report missing Ingredient",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            sizedBox30(),
            Container(
              height: 300,
              padding: const EdgeInsets.all(8.0), // Padding for the TextFormField
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10.0), // Adjust the radius as needed
                border: Border.all(
                    color: Colors.grey, width: 2.0), // Border properties
              ),
              child: TextFormField(
                controller: _messageController,
                keyboardType: TextInputType.multiline, // Allows multiline input
                maxLines: null, // Allows unlimited lines
                decoration: const InputDecoration(
                  labelText: 'Enter a message',
                  border: InputBorder
                      .none, // Removes the default border of TextFormField
                  prefixIcon: Icon(Icons.message), // Border icon
                ),
              ),
            ),
            const SizedBox(height: 20),
            RoundButton(
                title: Languages.of(context)!.labelSubmit,
                type: RoundButtonType.bgGradient,
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.w400,
                onPressed: () {
                  _sendMessage();
                }),
            // ElevatedButton(
            //   onPressed: () {
            //     _sendMessage();
            //   },
            //   child: Text('Send Message'),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage() async {
    String message = _messageController.text;
    if (message.isNotEmpty) {
      try {
        await _controller.sendMissingMessage(message);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message sent successfully'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Failed to send message: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please enter a message'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
