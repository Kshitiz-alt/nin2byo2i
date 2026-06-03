// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Firebase Facebook Login',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginPage(),
//     );
//   }
// }

// class LoginPage extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> _loginWithFacebook(BuildContext context) async {
//     try {
//       final LoginResult result = await FacebookAuth.instance.login();
//       if (result.status == LoginStatus.success) {
//         final OAuthCredential credential =
//             FacebookAuthProvider.credential(result.accessToken!.token);
//         final UserCredential userCredential =
//             await _auth.signInWithCredential(credential);
//         // Navigate to the next screen or do something with the user's data
//         debugPrint('Login successful! User: ${userCredential.user}');
//       } else {
//         // Handle the error case
//         debugPrint('Login failed: ${result.message}');
//       }
//     } catch (e) {
//       // Handle exceptions
//       debugPrint('Exception occurred: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firebase Facebook Login'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => _loginWithFacebook(context),
//           child: Text('Login with Facebook'),
//         ),
//       ),
//     );
//   }
// }
