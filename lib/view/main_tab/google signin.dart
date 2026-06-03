// main.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';

//google sign in page

class SignInDemo extends StatefulWidget {
  const SignInDemo({super.key});

  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential?> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        debugPrint("User cancelled the sign-in process");
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      debugPrint("Signing in with Google: $credential");

      return await _auth.signInWithCredential(credential);
    } catch (error) {
      debugPrint("Error during Google Sign-In: $error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign In Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: TColor
                .secondaryColor1, // Set the background color to light blue
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(25.0), // Set the border radius
            ),
          ),
          onPressed: () async {
            UserCredential? userCredential = await _handleSignIn();
            if (userCredential != null) {
              debugPrint("Signed in: ${userCredential.user!.displayName}");
            }
          },
          child: const Text('Sign In with Google'),
        ),
      ),
    );
  }
}
