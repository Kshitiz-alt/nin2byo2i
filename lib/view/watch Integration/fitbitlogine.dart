import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Repository/TokenManagerforWatch.dart';
import 'package:nin2byo2i/Repository/auth_repo.dart';
import 'package:nin2byo2i/view/watch%20Integration/fitbitresp%5Bonse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:nin2byo2i/Common/appfontsize.dart';

//fitbit login page
class FitbitAuthPage extends StatefulWidget {
  const FitbitAuthPage({super.key});

  @override
  _FitbitAuthPageState createState() => _FitbitAuthPageState();
}

class _FitbitAuthPageState extends State<FitbitAuthPage> {
  late final WebViewController _webViewController;
  String _code = '';
  final UserProfileController _controller = UserProfileController();
  final String clientId = '23RGPC';
  final String redirectUri = 'https://www.nin.res.in/';
  final String authorizationEndpoint =
      'https://www.fitbit.com/oauth2/authorize';

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            String accessToken;
            String userId;

            if (url.contains('code=')) {
              Uri uri = Uri.parse(url);
              _code = uri.queryParameters['code'] ?? '';

              // your existing onPageFinished logic here
            }
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          '$authorizationEndpoint?client_id=$clientId&response_type=code&code_challenge=nD69oDMMhxF_E9KHtVpPdUgCCQHZfyl_Yw8_C6bHUdY&code_challenge_method=S256&scope=activity%20heartrate%20location%20nutrition%20oxygen_saturation%20profile%20respiratory_rate%20settings%20sleep%20social%20temperature%20weight',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Fitbit Authentication'),
      // ),
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
          Languages.of(context)!.NINTextFitbitAuthentication,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebViewWidget(
              controller: _webViewController,
            ),
          ),
          const SizedBox(height: 20),
          Text(' wait until we will get Code: $_code'),
        ],
      ),
    );
  }
}
