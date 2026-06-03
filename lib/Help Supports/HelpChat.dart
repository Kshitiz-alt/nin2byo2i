import 'package:flutter/material.dart';
import 'package:nin2byo2i/Help%20Supports/FAQs.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//helf chat screen
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
          Languages.of(context)!.ninTextHelpCenter,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "How can we assist you today?",
            //   style: TextStyle(
            //       fontSize: AppFontSizes.mediumDefault,
            //       fontWeight: FontWeight.bold,
            //       color: ThemeManager.themeColor),
            // ),
            const SizedBox(height: 16),
            // Container(
            //   width: 200,
            //   child: RoundButton(
            //     title: "Chat Support",
            //     type: RoundButtonType.bgGradient,
            //     fontSize: AppFontSizes.mediumDefault,
            //     fontWeight: FontWeight.w400,
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => ChatScreen()));
            //     },
            //   ),
            // ),

            const SizedBox(height: 16),
            Text(
              Languages.of(context)!.ninTextCommonProblems,
              style: TextStyle(
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.bold,
                color: ThemeManager.themeText,
              ),
            ),
            sizedBox12(),
            Container(
              color: ThemeManager.themelightColor,
              child: ListTile(
                title: Text(
                  "1. ${Languages.of(context)!.ninTextFAQs}",
                  style: TextStyle(
                    color: ThemeManager.themeText,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FAQsPage()));
                },
              ),
            ),
            sizedBox12(),
            // Container(
            //   color: ThemeManager.themelightColor,
            //   child: ListTile(
            //     title: Text(
            //       "2. Account Issues",
            //       style: TextStyle(
            //         color: ThemeManager.themeText,
            //       ),
            //     ),
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => AccountIssuesScreen()));
            //     },
            //   ),
            // ),
            // sizedBox12(),
            // Container(
            //   color: ThemeManager.themelightColor,
            //   child: ListTile(
            //     title: Text(
            //       "3. Technical Support",
            //       style: TextStyle(
            //         color: ThemeManager.themeText,
            //       ),
            //     ),
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => TechnicalSupportScreen()));
            //     },
            //   ),
            // ),
            // Add more problem categories as needed.
          ],
        ),
      ),
    );
  }
}

class AccountIssuesScreen extends StatelessWidget {
  const AccountIssuesScreen({super.key});

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
          " Account Issues ",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1. Account Issues",
                style: TextStyle(
                  fontSize: AppFontSizes.mediumDefault,
                  color: ThemeManager.themeText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "If you are facing account issues, you can try the following steps:",
                style: TextStyle(
                    fontSize: AppFontSizes.mediumDefault, color: Colors.black),
              ),
              const ListTile(
                title: Text(
                  "1.1 Login Issues",
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Steps to Solve:",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "1. Double-check your username and password for accuracy.",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "2. Ensure your internet connection is stable.",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "3. Reset your password if you've forgotten it.",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const ListTile(
                title: Text(
                  "1.2 Forgot Password",
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Steps to Solve:",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "1. Click on 'Forgot Password' on the login screen.",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "2. Follow the instructions sent to your registered email to reset your password.",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const ListTile(
                title: Text(
                  "1.3 Registering an Account",
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Steps to Solve:",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "1. Click on 'Register' or 'Sign Up' on the main screen.",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "2. Provide the required information and follow the registration process.",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const ListTile(
                title: Text(
                  "1.4 Account Verification",
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Steps to Solve:",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "1. Check your email for a verification link after registration.",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "2. Click on the link to verify your account.",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              // Add more account-related details and steps to solve as needed.
            ],
          ),
        ),
      ),
    );
  }
}

class TechnicalSupportScreen extends StatelessWidget {
  const TechnicalSupportScreen({super.key});

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
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          " Technical Support ",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "2. Technical Support",
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "If you are experiencing technical issues, please follow the steps below:",
                style: TextStyle(
                    fontSize: AppFontSizes.mediumDefault, color: Colors.black),
              ),
              const ListTile(
                title: Text(
                  "2.1 App Crashes",
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Steps to Solve:",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "1. Ensure your app is up to date. Check for available updates.",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "2. Clear app cache and data (Settings > Apps > [Your App] > Storage).",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "3. Restart your device.",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "4. Contact our technical support for further assistance.",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const ListTile(
                title: Text(
                  "2.2 Slow Performance",
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Steps to Solve:",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "1. Close background apps to free up device resources.",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "2. Check for available app updates.",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "3. Restart your device to clear temporary data.",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "4. Contact our technical support for further assistance.",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const ListTile(
                title: Text(
                  "2.3 Connectivity Issues",
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Steps to Solve:",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "1. Ensure you have a stable internet connection.",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "2. Check if other apps and websites work to verify the internet connection.",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "3. Restart your modem or router.",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "4. Contact your internet service provider if the issue persists.",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "5. Contact our technical support for further assistance.",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              // Add more technical support details and steps as needed.
            ],
          ),
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _chatMessages = [];

  void _sendMessage() {
    setState(() {
      _chatMessages.add(_messageController.text);
      _messageController.clear();
    });
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
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Chat",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_chatMessages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                        hintText: "Type your message...",
                        fillColor: Colors.black),
                    cursorColor: ThemeManager.themeText,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: ThemeManager.themeText,
                  ),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
