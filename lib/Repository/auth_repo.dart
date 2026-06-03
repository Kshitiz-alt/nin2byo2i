import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nin2byo2i/constants/server.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  static String _User_id = "";
  String get User_id => _User_id;
  static const String _tokenKey = "token";
  // static const String _tokenKeyfit = "tokenfit";
  // static const String idfit = "idfit";
  static const String _refreshTokenKey = "refreshToken";
  static const String _newUserKey = "newuserkey";
  static const String _isCompleted = 'isCompleted';
  //client id
  // // store token
  // static Future<void> storeidfit(String token) async {
  //   try {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setString(idfit, token);
  //   } on PlatformException {
  //     // throw LocalDatabaseError(e.toString());
  //   } catch (e) {
  //     // throw LocalDatabaseError(e.toString());
  //   }
  // }

// //get token
//   static Future<String?> getidfit() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       debugPrint("gettoken------------$idfit");
//       return prefs.getString(idfit);
//     } catch (e) {
//       return null;
//     }
//   }

// // store token
//   static Future<void> storeTokenfit(String token) async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString(_tokenKeyfit, token);
//     } on PlatformException {
//       // throw LocalDatabaseError(e.toString());
//     } catch (e) {
//       // throw LocalDatabaseError(e.toString());
//     }
//   }

// //get token
//   static Future<String?> getTokenfit() async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       debugPrint("gettoken------------$_tokenKeyfit");
//       return prefs.getString(_tokenKeyfit);
//     } catch (e) {
//       return null;
//     }
//   }
  static Future<void> checkTokenExpired() async {
    final String? token = await getToken();
    if (token == null) {
      try {
        final String? refreshToken = await getRefreshToken();
        if (refreshToken != null) {
          //  final response = await http.post(
          //       Uri.parse(
          //           '${API.server}/ingredient/setIngredientsForDish?mealName=$mealtype&dishName=$dishname'),
          //       body: jsonEncode(data
          //           // 'dishName': data['dishName'],
          //           // 'dishQuantity': data['dishQuantity'],
          //           // 'mealName': data['mealName'],
          //           ),
          //       headers: headers);

          final response = await http.post(
            Uri.parse('${API.server}/auth/refresh-token'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'refreshToken': refreshToken}),
          );

          if (response.statusCode == 200) {
            final Map<String, dynamic> data = json.decode(response.body);
            final String newJwtToken = data['jwtToken'];
            final String newRefreshToken = data['refreshToken'];

            // Update tokens in SharedPreferences
            storeToken(newJwtToken);
            storeRefreshToken(newRefreshToken);

            // You can also extract other data from the response if needed
            final String username = data['username'];
            final String userId = data['userId'];

            // Log or use the extracted data as needed
            debugPrint('New JWT Token: $newJwtToken');
            debugPrint('New Refresh Token: $newRefreshToken');
            debugPrint('Username: $username');
            debugPrint('User ID: $userId');
          } else {
            // Handle error
            debugPrint(
                'Refresh token API failed with status code: ${response.statusCode}');
          }
        }
      } catch (e) {
        // Handle exception
        debugPrint('Error refreshing token: $e');
      }
      return;
    }
    if ((JwtDecoder.isExpired(token) == true)) {
      try {
        final String? refreshToken = await getRefreshToken();
        if (refreshToken != null) {
          //  final response = await http.post(
          //       Uri.parse(
          //           '${API.server}/ingredient/setIngredientsForDish?mealName=$mealtype&dishName=$dishname'),
          //       body: jsonEncode(data
          //           // 'dishName': data['dishName'],
          //           // 'dishQuantity': data['dishQuantity'],
          //           // 'mealName': data['mealName'],
          //           ),
          //       headers: headers);

          final response = await http.post(
            Uri.parse('${API.server}/auth/refresh-token'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'refreshToken': refreshToken}),
          );

          if (response.statusCode == 200) {
            final Map<String, dynamic> data = json.decode(response.body);
            final String newJwtToken = data['jwtToken'];
            final String newRefreshToken = data['refreshToken'];

            // Update tokens in SharedPreferences
            storeToken(newJwtToken);
            storeRefreshToken(newRefreshToken);

            // You can also extract other data from the response if needed
            final String username = data['username'];
            final String userId = data['userId'];

            // Log or use the extracted data as needed
            debugPrint('New JWT Token: $newJwtToken');
            debugPrint('New Refresh Token: $newRefreshToken');
            debugPrint('Username: $username');
            debugPrint('User ID: $userId');
          } else {
            // Handle error
            debugPrint(
                'Refresh token API failed with status code: ${response.statusCode}');
          }
        }
      } catch (e) {
        // Handle exception
        debugPrint('Error refreshing token: $e');
      }
    }
  }

  // store refresh token
  static Future<void> storeRefreshToken(String refreshToken) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_refreshTokenKey, refreshToken);
    } on PlatformException {
      // handle exception
    } catch (e) {
      // handle exception
    }
  }

  // get refresh token
  static Future<String?> getRefreshToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_refreshTokenKey);
    } catch (e) {
      return null;
    }
  }

  // clear refresh token
  static Future<void> clearRefreshToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(_refreshTokenKey);
    } on PlatformException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }

// store token
  static Future<void> storeToken(String token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
    } on PlatformException {
      // throw LocalDatabaseError(e.toString());
    } catch (e) {
      // throw LocalDatabaseError(e.toString());
    }
  }

//get token
  static Future<String?> getToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      debugPrint("gettoken------------$_tokenKey");
      return prefs.getString(_tokenKey);
    } catch (e) {
      return null;
    }
  }

// clear token
  static Future<void> clearToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(_tokenKey);
      // debugPrint('succefullly removed-------');
    } on PlatformException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    debugPrint("user creadential google isd $googleSignInAccount ");
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      debugPrint(
          "user creadential googlbghnne isd ${googleSignInAuthentication.accessToken} ");

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        debugPrint(
            "user creadential google isd $userCredential fsgsdgf ${userCredential.credential?.token}");
        // Assume 'userCredential' is the UserCredential obtained after authentication.
        // String idToken = (await userCredential.credential?.token) as String;
        if (userCredential.user != null) {
          String? idToken = await userCredential.user?.getIdToken();
          // Now you have the ID token, you can send it to your backend via HTTPS
          // Send idToken to your backend for further processing
          debugPrint('ID Tohgfjgjgkjhgkken: $idToken');
        }
        debugPrint(
            "user creadential google isd fsgsdgf ${userCredential.credential?.token}");
        return userCredential.user!;
      } on FirebaseAuthException {
        // Handle FirebaseAuthExceptions as needed
        rethrow;
      } catch (e) {
        // Handle other exceptions as needed
        rethrow;
      }
    }
    return null;
  }

  Future<http.Response> register(
    String userName,
    String phoneNumber,
    String email,
    String password,
    String longitude,
    String latitude,
  ) async {
    try {
      final res = await http.post(
        Uri.parse(API.register),
        body: jsonEncode({
          "userName": userName,
          "mobileNo": phoneNumber,
          "email": email,
          "password": password,
          "registrationTermCondition": true,
          "deviceType": "Android",
          "latitude": latitude,
          "longitude": longitude,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        debugPrint('response ${res.body}');
        return res;
      } else if (res.statusCode == 400) {
        throw Exception('Email is already registered');
      } else {
        throw Exception(
          'Status Code: ${res.statusCode}\nBody: ${res.body}',
        );
      }
    } catch (e) {
      debugPrint("register error $e");
      log(e.toString());
      rethrow;
    }
  }

  Future login(String email, String password) async {
    try {
      http.Response res = await http.post(
        Uri.parse(API.login),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        debugPrint("Successful login respfrtgrronse: ${res.body}");
        await storeToken(data['jwtToken']);
        _User_id = data["userId"].toString();

        return data;
      } else {
        debugPrint("Successful login respfrtgrronse: ${res.body}");
        throw Exception('Failed to login:  ${res.body}');
      }
    } catch (e) {
      debugPrint("Error caught: $e");
      log(e.toString());
      rethrow;
    }
  }

  // Future login(String email, String password) async {
  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse(API.login),
  //       body: jsonEncode({
  //         "email": email,
  //         "password": password,
  //       }),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //     final data = jsonDecode(res.body);
  //     debugPrint("error cought herehfhhfhh ${res.body}");
  //     await storeToken(data['jwtToken']);
  //     _User_id = data["userId"].toString();

  //     return data;
  //   } catch (e) {
  //     debugPrint("error cought fdgfhfhgfjgjghgh $e   lklklklkk${e.toString()}");
  //     log(e.toString());
  //     rethrow;
  //   }
  // }
//save new user

  static Future<void> saveNewUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_newUserKey, true);
    } on PlatformException {
      // throw LocalDatabaseError(e.toString());
    } catch (e) {
      // throw LocalDatabaseError(e.toString());
    }
  }

//get new user

  static getNewUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_newUserKey);
    } catch (e) {
      return false;
    }
  }

  static Future<void> isCompletedSave() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      await preferences.setBool(_isCompleted, true);
    } catch (e) {
      debugPrint("Error saving completion status: $e");
    }
  }

  static Future<bool?> isCompletedeGet() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      return preferences.getBool(_isCompleted);
    } on PlatformException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future updateProfile(
    userId,
    token,
    String firstName,
    String lastName,
    String gender,
    String dob,
    String weight,
    String heightInFeet,
    String heightInInch,
    String googlelink,
    String facebooklink,
    String linkdinlink,
    String twitterlink,
    String workLevel,
    String wakeupTime,
  ) async {
    try {
      debugPrint(
          'data is dfcd $firstName - $lastName - $gender $dob - $weight - $heightInFeet.$heightInInch');

      Map<String, dynamic> data = {
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "dateOfBirth": dob.substring(0, 10),
        "heightFt": heightInFeet,
        "heightIn": heightInInch,
        "weight": weight,
        "googleAccountLink": googlelink,
        "facebookAccountLink": facebooklink,
        "twitterAccountLink": twitterlink,
        "linkedInAccountLink": linkdinlink,
        "workLevel": workLevel,
        "wakeupTime": wakeupTime
      };

      Uri uri = API.updateProfile(userId); // Ensure this returns a Uri object.
      // debugPrint('date of birth ${dob.substring(0, 10)}');
      final res = await http.post(
        uri, // Use the Uri object as the URL.
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Auth': 'Bearer $token',
        },
      );
      // debugPrint("Response body: ${res.body}");
      // debugPrint('Successful update with id $userId on server $uri');
      return res;
    } catch (e) {
      // debugPrint('Unsuccessful call to update: $e');
      rethrow;
    }
  }
}

// headers: {'Authorization': 'Bearer $token'},
