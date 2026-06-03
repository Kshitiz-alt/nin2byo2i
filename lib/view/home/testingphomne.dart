// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class PhoneSignInPage extends StatefulWidget {
//   @override
//   _PhoneSignInPageState createState() => _PhoneSignInPageState();
// }

// class _PhoneSignInPageState extends State<PhoneSignInPage> {
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _codeController = TextEditingController();
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   String _verificationId = '';
//   bool _codeSent = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Phone Number Sign In'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: _phoneController,
//               decoration: InputDecoration(
//                 hintText: 'Enter phone number',
//               ),
//             ),
//             SizedBox(height: 10),
//             _codeSent
//                 ? TextField(
//                     controller: _codeController,
//                     decoration: InputDecoration(
//                       hintText: 'Enter verification code',
//                     ),
//                   )
//                 : Container(),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed:
//                   _codeSent ? _signInWithPhoneNumber : _verifyPhoneNumber,
//               child: Text(_codeSent ? 'Sign In' : 'Verify'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _verifyPhoneNumber() async {
//     await _auth.verifyPhoneNumber(
//       phoneNumber: _phoneController.text,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await _auth.signInWithCredential(credential);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(
//                 "Phone number automatically verified and user signed in: ${credential.smsCode}")));
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         debugPrint("dvfdvnjdvkgbvkgfnbfbnkjfbg  ${e.toString()}");
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text("Failed to verify phone number: ${e.message}")));
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         setState(() {
//           _codeSent = true;
//           _verificationId = verificationId;
//         });
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         _verificationId = verificationId;
//       },
//     );
//   }

//   void _signInWithPhoneNumber() async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId,
//         smsCode: _codeController.text,
//       );

//       await _auth.signInWithCredential(credential);
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Successfully signed in")));
//     } catch (e) {
//       debugPrint("dvfdvnjdvkgbvkgfnbfbnkjfbg  ${e.toString()}");
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Failed to sign in: ${e.toString()}")));
//     }
//   }
// }
