import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Repository/auth_repo.dart';
import 'package:nin2byo2i/models/user.dart';

class AuthProviderNin with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  String _verificationId = '';

  late User user;
  late MyUser myUser;

  final AuthRepo _authRepo = AuthRepo();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isLoading => _isLoading;
  String get phoneNumber => _phoneNumer;

  // Required fields
  String _email = '';
  String _userName = '';
  String _password = '';
  String _phoneNumer = '';

  String _firstName = '';
  String _lastName = '';
  String _gender = 'Male';

  DateTime _dateOfBirth = DateTime.now();

  String _weight = '';
  String _heightInFeet = '';
  String _heightInInch = '';

  // Optional fields
  String workLevel = '';
  String Latitude = '0';
  String Longitude = '0';

  String googlelink = '';
  String facebooklink = '';
  String linkdinlink = '';
  String twitterlink = '';

  String wakeupTime = '';

  // ================= SETTERS =================

  void setLatitude(String val) {
    Latitude = val;
  }

  void setLongitude(String val) {
    Longitude = val;
  }

  void setworkLevel(String val) {
    workLevel = val;
  }

  void setwakeupTime(String val) {
    wakeupTime = val;
  }

  void setGoogleLink(String val) {
    googlelink = val;
  }

  void setFacebookLink(String val) {
    facebooklink = val;
  }

  void setLinkedInLink(String val) {
    linkdinlink = val;
  }

  void setTwitterLink(String val) {
    twitterlink = val;
  }

  void setEmail(String val) {
    _email = val;
  }

  void setUserName(String val) {
    _userName = val;
  }

  void setPassword(String val) {
    _password = val;
  }

  void setPhoneNumber(String val) {
    _phoneNumer = val;
  }

  void setFirstName(String val) {
    _firstName = val;
  }

  void setLastName(String val) {
    _lastName = val;
  }

  void setGender(String val) {
    _gender = val;
  }

  void setDateOfBirth(DateTime val) {
    _dateOfBirth = val;
  }

  void setWeight(String val) {
    _weight = val;
  }

  void setHeightInFeet(String val) {
    _heightInFeet = val;
  }

  void setHeightInInch(String val) {
    _heightInInch = val;
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setVerificationId(String val) {
    _verificationId = val;
  }

  // ================= GOOGLE SIGN IN =================

  Future<void> signInWithGoogle() async {
    try {
      setLoading(true);

      final res = await _authRepo.signInWithGoogle();

      if (res != null) {
        user = res;
        debugPrint("Google Sign-In Success: ${res.uid}");
      }
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  // ================= PHONE VERIFICATION =================

  Future<void> verifyPhoneNumber(String number) async {
    setPhoneNumber(number);

    void verificationCompleted(AuthCredential credential) async {
      await signInWithCredential(credential);
    }

    void verificationFailed(FirebaseAuthException authException) {
      debugPrint('Verification failed: ${authException.message}');

      switch (authException.code) {
        case 'invalid-phone-number':
          _errorMessage = 'Invalid phone number';
          break;

        case 'invalid-verification-code':
          _errorMessage = 'Invalid verification code';
          break;

        case 'session-expired':
          _errorMessage = 'OTP expired';
          break;

        case 'too-many-requests':
          _errorMessage = 'Too many requests';
          break;

        default:
          _errorMessage = 'Something went wrong';
      }

      setLoading(false);
    }

    void codeSent(String verificationId, [int? forceResendingToken]) {
      setVerificationId(verificationId);
      setLoading(false);
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
    }

    await _auth.verifyPhoneNumber(
      phoneNumber: '+91$number',
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: const Duration(seconds: 30),
    );
  }

  // ================= SIGN IN WITH OTP =================

  Future<void> signInWithCredential(AuthCredential credential) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? res = userCredential.user;

      if (res != null) {
        user = res;
        debugPrint('Phone Sign-In Success: ${user.uid}');
      } else {
        debugPrint('Phone Sign-In Failed');
      }
    } catch (e) {
      debugPrint("Phone Sign-In Error: $e");
      rethrow;
    }
  }

  // ================= REGISTER =================

  Future<void> register() async {
    try {
      final res = await _authRepo.register(
        _userName,
        _phoneNumer,
        _email,
        _password,
        Longitude,
        Latitude,
      );

      debugPrint("REGISTER RESPONSE: ${res.body}");
    } catch (e, stackTrace) {
      debugPrint("REGISTER ERROR: $e");
      debugPrint(stackTrace.toString());
      rethrow;
    }
  }

  // ================= LOGIN =================

  Future<void> login() async {
    try {
      final res = await _authRepo.login(_email, _password);

      debugPrint("LOGIN RESPONSE: $res");

      myUser = MyUser.fromJson(res);

      AuthRepo.storeToken(myUser.token);
      AuthRepo.storeRefreshToken(myUser.Refreshtoken);

      debugPrint("TOKEN: ${myUser.token}");
    } catch (e, stackTrace) {
      debugPrint("LOGIN ERROR: $e");
      debugPrint(stackTrace.toString());
      rethrow;
    }
  }

  // ================= UPDATE PROFILE =================

  Future<void> updateProfile() async {
    try {
      debugPrint("Updating Profile...");

      final res = await _authRepo.updateProfile(
        myUser.userId,
        myUser.token,
        _firstName,
        _lastName,
        _gender,
        _dateOfBirth.toIso8601String(),
        _weight,
        _heightInFeet,
        _heightInInch,
        googlelink,
        facebooklink,
        linkdinlink,
        twitterlink,
        workLevel,
        wakeupTime,
      );

      debugPrint("PROFILE UPDATE RESPONSE: $res");
    } catch (e, stackTrace) {
      debugPrint("PROFILE UPDATE ERROR: $e");
      debugPrint(stackTrace.toString());
      rethrow;
    }
  }
}