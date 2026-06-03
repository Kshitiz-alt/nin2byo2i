import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInPage extends StatefulWidget {
  const GoogleSignInPage({super.key});

  @override
  _GoogleSignInPageState createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication auth = await account.authentication;
        debugPrint('Access Token: $auth ${auth.accessToken}');
        debugPrint('ID Token: ${auth.idToken}');
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign-In Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _currentUser != null
                ? Column(
                    children: <Widget>[
                      ListTile(
                        leading: GoogleUserCircleAvatar(
                          identity: _currentUser!,
                        ),
                        title: Text(_currentUser!.displayName ?? ''),
                        subtitle: Text(_currentUser!.email),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _handleSignOut,
                        child: const Text('Sign Out'),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: _handleSignIn,
                    child: const Text('Sign In with Google'),
                  ),
          ],
        ),
      ),
    );
  }
}
