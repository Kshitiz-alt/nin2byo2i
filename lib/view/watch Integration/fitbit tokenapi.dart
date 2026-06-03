import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//fitbit watch connect page
class FitbitApiExample extends StatelessWidget {
  final String apiUrl = 'https://api.fitbit.com/oauth2/token';

  final String clientId = '23RGPC';

  final String code = 'e3e7d820637917fc50eef0b237399c895c41c518';
  final String codeVerifier =
      'Q7laS4s0ercASoZu1xLKJUMUB6-XhLUdN2V0epAT5at6CtBK1BB4aTfiaIYfEhc4xMxtQQDsHNYc61wRcwckog';
  final String grantType = 'authorization_code';

  const FitbitApiExample({super.key});

  ///String url='https://api.fitbit.com/oauth2/token?client_id=$clientId&code=$code&code_verifier=$codeVerifier&grant_type=authorization_code';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fitbit API Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _postData();
            },
            child: const Text('Make API Call'),
          ),
        ),
      ),
    );
  }

  void _postData() async {
    try {
      var response = await http.post(
        Uri.parse(
            'https://api.fitbit.com/oauth2/token?client_id=$clientId&code=$code&code_verifier=$codeVerifier&grant_type=authorization_code'),
        headers: {
          'Authorization':
              'Basic MjNSR1BDOmEwMjY1OTE1YjRkZmM5YTcyM2VmOGI1NmMxNTIyMzgw',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        // body: {
        //   'client_id': clientId,
        //   'code': code,
        //   'code_verifier': codeVerifier,
        //   'grant_type': grantType,
        // },
      );

      if (response.statusCode == 200) {
        // Successful API call, handle the response
        debugPrint('API call successful');
        debugPrint('Response: ${response.body}');
      } else {
        // Handle error
        debugPrint('Error: ${response.statusCode}');
        debugPrint('Response: ${response.body}');
      }
    } catch (error) {
      // Handle exceptions
      debugPrint('Error: $error');
    }
  }
}

void main() {
  runApp(FitbitApiExample());
}
