//all the api used in app

import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nin2byo2i/Classes/BloodPressure.dart';
import 'package:nin2byo2i/Classes/FitnessData.dart';
import 'package:nin2byo2i/Classes/Food%20Classes/EarFoodValue.dart';
import 'package:nin2byo2i/Classes/Food%20Classes/analysefoodintake.dart';
import 'package:nin2byo2i/Classes/Food%20Classes/foodtableingredient.dart';
import 'package:nin2byo2i/Classes/MensurationClass.dart';
import 'package:nin2byo2i/Classes/OxygenClass.dart';
import 'package:nin2byo2i/Classes/WaterClass.dart';
import 'package:nin2byo2i/Classes/earclassforuser.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Repository/auth_repo.dart';
import 'package:nin2byo2i/constants/server.dart';
import 'dart:convert';

import 'package:nin2byo2i/Classes/userprofileModal.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/home/connectivitycheckfile.dart';

import '../Classes/HeartClass.dart';

class UserProfileController extends ChangeNotifier {
  final bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    // _isLoading = value;
    // notifyListeners();
  }

  bool _isConnected = false;
  bool get isConnected => _isConnected;
  void setcheckInternet(bool value) {
    _isConnected = value;
    notifyListeners();
  }

  // Future<void> _checkInternetConnection() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi) {
  //     debugPrint("ewfddgdffhfh $isConnected");
  //     setcheckInternet(false);
  //     setCheckModalBool(false);
  //     // isConnected = true;
  //   } else {
  //     debugPrint("ewfddgdffhfh $isConnected");
  //     setcheckInternet(true);
  //     // isConnected = false;
  //   }
  // }

  bool _checkModalBool = false;
  bool get checkModalBool => _checkModalBool;

  void setCheckModalBool(bool value) {
    _checkModalBool = value;
    notifyListeners();
  }

  bool _checkModalBoolSuccess = false;
  bool get checkModalBoolSuccess => _checkModalBoolSuccess;

  void setCheckModalBoolSuccess(bool value) {
    _checkModalBoolSuccess = value;
    notifyListeners();
  }

  String _modalMessage = '';
  String get modalMessage => _modalMessage;

  void setModalMessage(String message) {
    _modalMessage = message;
    notifyListeners();
  }

  Future<void> _SetmodalUpdate(bool value, String message) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      debugPrint("ewfddgdffhfh $isConnected");
      setCheckModalBool(value);
      setModalMessage(message);
      // isConnected = true;
    } else {
      debugPrint("ewfddgdffhfh $isConnected");
      setcheckInternet(true);
      // isConnected = false;
    }
    // if (isConnected==false) {
    //    setCheckModalBool(value);
    // setModalMessage(message);
    // }
  }

  final ConnectivityService _connectivityService = ConnectivityService();
  Future<void> checkInternet(BuildContext context) async {
    bool isConnected = await _connectivityService.isConnected();
    debugPrint("erfeghfgjhgjhgjn yes internet");
    if (!isConnected) {
      // Show an alert dialog when there is no internet connection
      debugPrint("erfeghfgjhgjhgjn no internet");
      _showAlertDialog(context, 'No internet connection',
          'Please check your internet connection and try again.', Colors.red);
      return;
    }
  }

  void showloadingIcon(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog from closing on outside tap
      builder: (BuildContext context) {
        return Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(TColor.primaryColor1),
                  ),
                ),
                sizedBox12(),
                sizedBox12(),
                sizedBox12(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close and Retry',
                    style: TextStyle(
                      color: TColor.secondaryColor1,
                      fontSize: 12,
                      decoration: TextDecoration.none, // Removes underline
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAlertDialog(BuildContext context, String title,
      String message, Color dialogColor) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          backgroundColor: dialogColor,
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  FitnessData fitnessData = FitnessData.instance;
  UserProfile? _userProfile;
  UserProfile? get userProfile => _userProfile;

  void updateUserProfile(UserProfile newUserProfile) {
    _userProfile = newUserProfile;
    notifyListeners();
  }

  Future<void> deleteDishPersonal(int dishId) async {
    try {
      String? token = await AuthRepo.getToken();
      debugPrint('Dish deleted successfully $dishId');
      if (token != null) {
        final headers = {
          'Content-Type': 'application/json',
          'Auth': 'Bearer $token',
        };

        final response = await http.delete(
          Uri.parse('${API.server}/personal/$dishId'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          debugPrint('Dish deleted successfully');
        } else {
          throw Exception('Failed to delete dish: ${response.statusCode}');
        }
      } else {
        throw Exception('Failed to fetch token');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<void> deleteDish(int dishId) async {
    try {
      String? token = await AuthRepo.getToken();
      debugPrint('Dish deleted successfully $dishId');
      if (token != null) {
        final headers = {
          'Content-Type': 'application/json',
          'Auth': 'Bearer $token',
        };

        final response = await http.delete(
          Uri.parse('${API.server}/personal/dish/$dishId'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          debugPrint('Dish deleted successfully');
        } else {
          throw Exception('Failed to delete dish: ${response.statusCode}');
        }
      } else {
        throw Exception('Failed to fetch token');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<void> updateDishQuantity(int dishId, double newQuantity) async {
    try {
      String? token = await AuthRepo.getToken();
      if (token != null) {
        final headers = {
          'Content-Type': 'application/json',
          'Auth': 'Bearer $token',
        };

        final Uri uri = Uri.parse(
            '${API.server}/dishes/updateQuantity?newQuantity=$newQuantity&dishId=$dishId');
        final response = await http.put(
          uri,
          headers: headers,
        );

        if (response.statusCode == 200) {
          debugPrint('Dish quagdfhfdhfghjccessfully ${response.body}');
        } else {
          debugPrint('Dish quagdfhfdhfghjccessfully ${response.body}');
          throw Exception(
              'Failed to update disjfgjghjkmghkhghgh quantity: ${response.statusCode}');
        }
      } else {
        throw Exception('Failed to fetch token');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

//resendemail
  //feedback
  Future<bool> ResenDEmail(String REmail) async {
    // String? token = await AuthRepo.getToken();
    // String valueApi = '';
    // if (Type == 'running') {
    //   valueApi = 'runningDurationInSeconds';
    //   debugPrint('if called $REmail , $Type');
    // } else if (Type == 'jogging') {
    //   valueApi = 'joggingDurationInSeconds';
    // }
    // if (token != null) {
    //   // debugPrint("Token: $token");

    final response = await http.get(
      Uri.parse(
          '${API.server}/register/resendVerificationEmail/resendVerification?email=$REmail'),
      // body: jsonEncode({
      //   'feedback': REmail,
      //   // 'mealName': data['mealName'],
      // }),
      // headers: headers
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      //  debugPrint('data is response ${response.body}  date is $date');
      // final double jsonData = json.decode(response.body);

      // final List parsedData =
      //     jsonData.map((value) => value.toDouble()).toList();
      // debugPrint('jkdsjkfsdfvdjsvfds ${response.body}');
      return true;
    } else {
      return false;
      //throw Exception('Failed to fetch data');
    }
  }

  Future<bool> fetchUserProfileFromAPI() async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // Handle the non-null case
      debugPrint("Token is here: $token");
    } else {
      // Handle the null case
      // debugPrint("Token not found.");
    }
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };
    try {
      debugPrint("Token nohjygjmghyjkmght found.");
      final response = await http.get(
        Uri.parse('${API.server}/api/profile/get-userProfile?A'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        debugPrint("usedfre3fergrtgrthund ${response.body}");
        final Map<String, dynamic> data = json.decode(response.body);
        final userProfile = UserProfile(
          firstName: data['firstName'],
          lastName: data['lastName'],
          mobile: data['mobile'],
          weight: data['weight'].toDouble(),
          email: data['email'],
          heightFt: data['heightFt'],
          heightIn: data['heightIn'],
          bmi: data['bmi'].toDouble(),
          bmr: data['bmr'].toDouble(),
          age: data['age'].toDouble(),
          Dob: data['dateOfBirth'],
          gender: data['gender'],
          facebooklink: data['facebookAccountLink'],
          linkdinlink: data['linkedinAccountLink'],
          googlelink: data['googleAccountLink'],
          twitterlink: data['twitterAccountLink'],
          ioslink: data['IOS App Link'],
          androidLink: data['Android App Link'],
          messageOfLink: data['App message'],
          // occupation: data['occupation'],
          workLevel: data['workLevel'],
          wakeupTime: data['wakeupTime'],
        );
        updateUserProfile(userProfile);
        return true;
      } else if (response.statusCode == 404) {
        debugPrint("user profile not found");
        return false;
      } else {
        return false;
        // throw Exception('Failed tutruo load user profile');
      }
    } catch (error) {
      // debugPrint('Error fetching user profile: $error');

      throw Exception('Failed trhytrto load user profile $error');
    }
  }

  static Future<void> RecompleteProfile(Map<String, dynamic> userData) async {
    String? token = await AuthRepo.getToken();
    // String jsonData = json.encode(userData);
    String dateOfBirthString =
        DateFormat('yyyy-MM-dd').format(userData['dateOfBirth']);

    userData['dateOfBirth'] = dateOfBirthString;
    final AuthRepo authRepo = AuthRepo();
    debugPrint(
        "khjkjhljljkll;kj;kj;${userData['dateOfBirth']} ${authRepo.User_id}    sfdgdfgh  $userData");

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };

    final response = await http.post(
        Uri.parse(
            '${API.server}/api/profile/createProfile/${authRepo.User_id}'),
        headers: headers,
        body: jsonEncode(userData));

    if (response.statusCode == 200) {
      debugPrint("faildehtghjtyjytjgj ${response.statusCode} ${response.body}  ");
      return;
    } else if (response.statusCode != 201) {
      debugPrint(
          "failde ${response.statusCode} ${response.body} ${userData['dateOfBirth']} ${authRepo.User_id} ");
      throw Exception('Failed to add review ');
    }

    // String apiUrl = "https://your-api-endpoint.com/userdata";

    // try {
    //   // Convert the map to JSON
    //   String jsonData = json.encode(userData);

    //   // Send data to API using HTTP POST request
    //   final response = await http.post(
    //     Uri.parse(apiUrl),
    //     body: jsonData,
    //     headers: {
    //       "Content-Type": "application/json",
    //     },
    //   );

    //   // Handle the API response here
    //   debugPrint("API Response: ${response.body}");
    // } catch (error) {
    //   // Handle errors here
    //   debugPrint("Error: $error");
    // }
  }

  Future<void> updateProfileInAPI(UserProfile updatedProfile) async {
    debugPrint("google link here ${updatedProfile.workLevel}");
    final Map<String, dynamic> requestData = {
      "firstName": updatedProfile.firstName,
      "lastName": updatedProfile.lastName,
      "mobile": updatedProfile.mobile,
      "weight": updatedProfile.weight,
      "dateOfBirth": updatedProfile.Dob,
      "email": updatedProfile.email,
      "heightFt": updatedProfile.heightFt,
      "heightIn": updatedProfile.heightIn,
      "workLevel": updatedProfile.workLevel,
      //  heightFt: data['heightFt'].toDouble(),
      //     heightIn: data['height'].toDouble(),
      "googleAccountLink": updatedProfile.googlelink,
      "facebookAccountLink": updatedProfile.facebooklink,
      "twitterAccountLink": updatedProfile.twitterlink,
      "linkedInAccountLink": updatedProfile.linkdinlink,
      "wakeupTime": updatedProfile.wakeupTime
      // "bmi": updatedProfile.bmi,
    };
    // debugPrint("data is mobile: ${updatedProfile.mobile}${updatedProfile.email}");
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // Handle the non-null case
      // debugPrint("Token: $token");
    } else {
      // Handle the null case
      // debugPrint("Token not found.");
    }
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };
    try {
      final response = await http.put(
        Uri.parse('${API.server}/api/profile/update-userProfile?'),
        headers: headers,
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        debugPrint("goojghjghjkghkgle  here ${response.body}");
        updateUserProfile(updatedProfile);
      } else {
        debugPrint("googgfhfgle  here ${response.body}");
        throw Exception('Failed to updajghjghjte user profile');
      }
    } catch (error) {
      // debugPrint('Error updating user profile: $error');
    }
  }

//oxygen data
  Future<List<OxygenClass>> fetchOxygenData(String parameter) async {
    String? token = await AuthRepo.getToken();
    String selected = "today";
    if (parameter == "Today") {
      selected = DateFormat('yyyy-MM-dd').format(DateTime.now());
    } else if (parameter == "Weekly") {
      selected = 'one-week-ago';
    } else if (parameter == 'Monthly') {
      selected = 'one-month-ago';
    } else if (parameter == 'Yesterday') {
      DateTime currentDate = DateTime.now();
      DateTime oneDayBefore = currentDate.subtract(const Duration(days: 1));
      selected = DateFormat('yyyy-MM-dd').format(oneDayBefore);
    } else {
      selected = parameter;
    }
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${API.server}/api/oxygen-saturated-level/get/$selected'),
      headers: headers,
    );
    // final response = await http.get('YOUR_API_ENDPOINT_HERE' as Uri);
    if (response.statusCode == 200) {
      debugPrint('Failed to dfhfghjfgjgf data ${response.body}');
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((data) => OxygenClass(
              value: data['value'],
              id: data['oxygenSaturatedLevelId'],
              localDate: List<int>.from(data['localDate'])))
          .toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  //add oxygen level new value
  Future<bool> SaveOxygenLevel(String date, double oxValue) async {
    debugPrint("ewjhcfeijvkdnvjfghvb $date");
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.post(
            Uri.parse('${API.server}/api/oxygen-saturated-level/'),
            body: jsonEncode({"value": oxValue, "localDate": date}),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          // debugPrint('data is response ${response.body}');

          return true;
        } else {
          // debugPrint('data is response not success ${response.body}');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      // debugPrint("Token not found.");
      return false;
    }
  }

  //heart rate

  Future<List<HeartClass>> fetchheartData(String parameter) async {
    String? token = await AuthRepo.getToken();
    String selected = "today";
    if (parameter == "today") {
      selected = DateFormat('yyyy-MM-dd').format(DateTime.now());
    } else if (parameter == "Weekly") {
      selected = 'one-week-ago';
    } else if (parameter == 'Monthly') {
      selected = 'one-month-ago';
    } else if (parameter == 'yesterday') {
      DateTime currentDate = DateTime.now();
      DateTime oneDayBefore = currentDate.subtract(const Duration(days: 1));
      selected = DateFormat('yyyy-MM-dd').format(oneDayBefore);
    } else {
      selected = parameter;
    }
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${API.server}/api/heart-rates/get/$selected'),
      headers: headers,
    );
    // final response = await http.get('YOUR_API_ENDPOINT_HERE' as Uri);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((data) => HeartClass(
              value: data['value'],
              localDate: List<int>.from(data['localDate'])))
          .toList();
    } else {
      debugPrint('Failed to dsfcf data ${response.body}');
      throw Exception('Failed to fetch data $e');
    }
  }

  //add oxygen level new value
  Future<bool> SaveheartLevel(double oxValue) async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response =
            await http.post(Uri.parse('${API.server}/api/heart-rates/'),
                body: jsonEncode({
                  "value": oxValue,
                }),
                headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          // debugPrint('data is response ${response.body}');

          return true;
        } else {
          // debugPrint('data is response not success ${response.body}');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      // debugPrint("Token not found.");
      return false;
    }
  }

  //Blood pressure

  Future<List<BloodPressure>> fetchBloodPressureData(String parameter) async {
    // debugPrint('data  here is -----------$parameter');
    String? token = await AuthRepo.getToken();
    String selected = "today";
    if (parameter == "today") {
      selected = DateFormat('yyyy-MM-dd').format(DateTime.now());
    } else if (parameter == "Weekly") {
      selected = 'one-week-ago';
    } else if (parameter == 'Monthly') {
      selected = 'one-month-ago';
    } else if (parameter == 'yesterday') {
      DateTime currentDate = DateTime.now();
      DateTime oneDayBefore = currentDate.subtract(const Duration(days: 1));
      selected = DateFormat('yyyy-MM-dd').format(oneDayBefore);
    } else {
      selected = parameter;
    }
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${API.server}/api/systolic-blood-pressure/get/$selected'),
      headers: headers,
    );
    // final response = await http.get('YOUR_API_ENDPOINT_HERE' as Uri);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((data) => BloodPressure(
              value: data['value'],
              id: data['bloodGlucoseId'],
              localDate: List<int>.from(data['localDate'])))
          .toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<BloodPressure>> fetchBloodPressureDataDiastolic(
      String parameter) async {
    // debugPrint('data  here is -----------$parameter');
    String? token = await AuthRepo.getToken();
    String selected = "today";
    if (parameter == "today") {
      selected = DateFormat('yyyy-MM-dd').format(DateTime.now());
    } else if (parameter == "Weekly") {
      selected = 'one-week-ago';
    } else if (parameter == 'Monthly') {
      selected = 'one-month-ago';
    } else if (parameter == 'yesterday') {
      DateTime currentDate = DateTime.now();
      DateTime oneDayBefore = currentDate.subtract(const Duration(days: 1));
      selected = DateFormat('yyyy-MM-dd').format(oneDayBefore);
    } else {
      selected = parameter;
    }
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${API.server}/api/diastolic-blood-pressure/get/$selected'),
      headers: headers,
    );
    // final response = await http.get('YOUR_API_ENDPOINT_HERE' as Uri);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((data) => BloodPressure(
              id: data['bloodGlucoseId'],
              value: data['value'],
              localDate: List<int>.from(data['localDate'])))
          .toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<bool> SaveBloodPressureLevel(double oxValue) async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.post(
            Uri.parse('${API.server}/api/systolic-blood-pressure/'),
            body: jsonEncode({
              "value": oxValue,
            }),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          // debugPrint('data is response ${response.body}');

          return true;
        } else {
          // debugPrint('data is response not success ${response.body}');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      // debugPrint("Token not found.");
      return false;
    }
  }

  Future<bool> saveBloodPressureLevel(
      String date, double systolicValue, double diastolicValue) async {
    final Map<String, dynamic> requestData = {
      "localDate": date,
      "systolicValue": systolicValue,
      "diastolicValue": diastolicValue
    };
    String? token = await AuthRepo.getToken();
    if (token != null) {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token',
      };
      try {
        final response = await http.post(
          Uri.parse('${API.server}/api/systolic-blood-pressure/bloodpressure'),
          headers: headers,
          body: jsonEncode(requestData),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint("dfsgfdghfhfghgffghgfhfh ${response.body} ");
          return true;
        } else {
          debugPrint("dfsgfdghfhfghgfh ${response.body} ");
          return false;
        }
      } catch (error) {
        debugPrint("dfsgfdghfhfghgfh $error ");
        return false;
      }
    } else {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getBloodPressureDataByDateRange(
      String startDate, String endDate) async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      final headers = {
        'Content-Type': 'application/json',
        'Auth': 'Bearer $token',
      };
      debugPrint("fhgbfhgjhgkfgghmjhk $startDate $endDate");
      final Uri uri = Uri.parse(
          '${API.server}/api/systolic-blood-pressure/getByDateRange?startDate=$startDate&endDate=$endDate');
      try {
        final response = await http.get(uri, headers: headers);
        if (response.statusCode == 200) {
          debugPrint('Received blood pbgfgjghressure data: ${response.body}');
          // Decode the response body and return it
          List<dynamic> jsonData = json.decode(response.body);
          List<Map<String, dynamic>> dataList =
              jsonData.cast<Map<String, dynamic>>();
          return dataList;
        } else {
          debugPrint('Failed to get blood pressure data: ${response.body}');
          throw Exception(
              'Failed to get blood pressure data: ${response.body}');
        }
      } catch (error) {
        throw Exception('Failed to get blood pressure data: $error');
      }
    } else {
      throw Exception('Failed to get token.');
    }
  }

  Future<bool> SaveBloodPressureDiastolicLevel(double oxValue) async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.post(
            Uri.parse('${API.server}/api/diastolic-blood-pressure/'),
            body: jsonEncode({
              "value": oxValue,
            }),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          // debugPrint('data is response ${response.body}');

          return true;
        } else {
          // debugPrint('data is response not success ${response.body}');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      // debugPrint("Token not found.");
      return false;
    }
  }
  //Blood Glucose

  Future<List<BloodPressure>> fetchBloodGlucoseData(String parameter) async {
    // debugPrint('data  here is -----------$parameter');
    String? token = await AuthRepo.getToken();
    String selected = "today";
    if (parameter == "Today") {
      selected = DateFormat('yyyy-MM-dd').format(DateTime.now());
    } else if (parameter == "Weekly") {
      selected = 'one-week-ago';
    } else if (parameter == 'Monthly') {
      selected = 'one-month-ago';
    } else if (parameter == 'Yesterday') {
      DateTime currentDate = DateTime.now();
      DateTime oneDayBefore = currentDate.subtract(const Duration(days: 1));
      selected = DateFormat('yyyy-MM-dd').format(oneDayBefore);
    } else {
      selected = parameter;
    }
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${API.server}/api/blood-glucose/get/$selected'),
      headers: headers,
    );
    // final response = await http.get('YOUR_API_ENDPOINT_HERE' as Uri);
    if (response.statusCode == 200) {
      debugPrint('Failed to dfhfghjfgjgf data ${response.body}');
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((data) => BloodPressure(
              value: data['value'],
              id: data['bloodGlucoseId'],
              localDate: List<int>.from(data['localDate'])))
          .toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<bool> SaveBloodGlucoseLevel(String date, double oxValue) async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.post(
            Uri.parse('${API.server}/api/blood-glucose/'),
            body: jsonEncode({"value": oxValue, "localDate": date}),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          // debugPrint('data is response ${response.body}');

          return true;
        } else {
          // debugPrint('data is response not success ${response.body}');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      // debugPrint("Token not found.");
      return false;
    }
  }

//get food list
  Future<List<Map<String, dynamic>>> fetchFstDataFromApi(
      String parameter, String type) async {
    if (type == "Non Vegetarian") {
      type = "non veg";
    }
    String getValue(String parameter) {
      switch (parameter.toLowerCase()) {
        case "energy":
          return "energy";
        case "carbohydrate":
          return "carbohydrate";
        case "fat":
          return "total_fat";
        case "sodium":
          return "sodium";
        case "dietary fibre":
          return "total_dietary_fibre";
        case "calcium":
          return "calcium";
        case "iron":
          return "iron";
        case "magnesium":
          return "magnesium";
        case "zinc":
          return "zinc";
        case "protein":
          return "protein";
        case "thiamine":
          return "thiamine";
        case "riboflavin":
          return "riboflavin";
        case "niacin":
          return "niacin";
        case "vitamin b6":
          return "vitb";
        case "folate":
          return "totalfloate";
        case "vitamin c":
          return "vitc";
        case "vitamin a":
          return "vita";
        default:
          return "Nutrient not found";
      }
    }

    debugPrint(
        'Fetch data succedgthfjhfhjfss: 3 $parameter ${getValue(parameter)}');

    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse(
          '${API.server}/api/food/top10?column=${getValue(parameter)}&typesOfFood=$type'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      debugPrint('Fetch data success: ${response.body} $parameter');

      return jsonData
          .map((data) => {
                'id': data['id'],
                'food': data['name'],
                'nutritionName': data[getValue(parameter)] ?? 0,
                'category': data['category'] ?? 0,
                'unit': data['unit'],
                'foodCode': data['foodCode'],
              })
          .toList();
    } else {
      debugPrint('Failed to fetch data');
      throw Exception('Failed to fetch data');
    }
  }

//get food list
  Future<List<Map<String, dynamic>>> fetchallIngredientsDataFromApi(
      String parameter, String type) async {
    if (type == "Non Vegetarian") {
      type = "non veg";
    }
    // if (parameter == "total fat") {
    //   debugPrint('Fetch data succgjhgjghfggess:  $parameter');
    //   parameter = "total_Fat";
    // } else if (parameter == "total dietary fibre") {
    //   parameter = "total_Dietary_Fibre";
    // }

    String getValue(String parameter) {
      switch (parameter.toLowerCase()) {
        case "energy":
          return "energy";
        case "carbohydrate":
          return "carbohydrate";
        case "fat":
          return "total_fat";
        case "sodium":
          return "sodium";
        case "dietary fibre":
          return "total_dietary_fibre";
        case "calcium":
          return "calcium";
        case "iron":
          return "iron";
        case "magnesium":
          return "magnesium";
        case "zinc":
          return "zinc";
        case "protein":
          return "protein";
        case "thiamine":
          return "thiamine";
        case "riboflavin":
          return "riboflavin";
        case "niacin":
          return "niacin";
        case "vitamin b6":
          return "vitb";
        case "folate":
          return "totalfloate";
        case "vitamin c":
          return "vitc";
        case "vitamin a":
          return "vita";
        default:
          return "Nutrient not found";
      }
    }

    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse(
          '${API.server}/api/food/nolimit?column=${getValue(parameter)}&typesOfFood=$type'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      debugPrint(
          'Fetch data  ${getValue(parameter)} succgjhgjgess $parameter: ${response.body} ');

      return jsonData
          .map((data) => {
                'id': data['id'],
                'food': data['name'],
                'foodCode': data['foodCode'],
                'nutritionName': data[getValue(parameter)] ?? 0,
                'category': data['category'] ?? '',
                'unit': data['unit'] ?? '',
              })
          .toList();
    } else {
      debugPrint('Failed to fetch data');
      throw Exception('Failed to fetch data');
    }
  }

//get food list
  Future<List<Map<String, dynamic>>>
      fetchallIngredientsDataFromApiOntheBasisioFType(String type) async {
    if (type == "Non Vegetarian") {
      type = "non veg";
    }
    // if (parameter == "total_fat") {
    //   parameter = "total_Fat";
    // } else if (parameter == "total_dietary_fibre") {
    //   parameter = "total_Dietary_Fibre";
    // }
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${API.server}/api/food/all-food-nolimit?typesOfFood=$type'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      debugPrint('Fetch data succeggfhfghfgjfgss: ${response.body} ');

      return jsonData
          .map((data) => {
                'id': data['id'],
                'food': data['name'],
                'foodCode': data['foodCode'],
                // 'nutritionName': data[parameter] ?? 0,
                "energy": data['energy'],
                "carbohydrate": data['carbohydrate'],
                "protein": data['protein'],
                "total_Fat": data['total_Fat'],
                'category': data['category'] ?? '',
              })
          .toList();
    } else {
      debugPrint('Failed to fetch fvdgdfh');
      throw Exception('Failed to fethjfgjjfch data');
    }
  }

  Future<List<Map<String, dynamic>>> fetchFoodDetailsFromApi(int foodId) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Auth': 'Bearer ${await AuthRepo.getToken()}',
    };

    final response = await http.get(
      Uri.parse('${API.server}/foods/ing-details?foodId=$foodId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      debugPrint('Fetch food detailrfeeffgfs success ${response.body}');
      List<Map<String, dynamic>> mappedData =
          jsonData.cast<Map<String, dynamic>>();

      return mappedData;
    } else {
      debugPrint('Failed to fetch food details $foodId');
      throw Exception('Failed to fetch food details');
    }
  }

  //mensuration
  Future<bool> MensurationOnOffBool() async {
    // return true;
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.get(
            Uri.parse(
                '${API.server}/api/menstrualCycle/menstrual-cycle-status?A'),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          // debugPrint('data is response ${response.body}');

          if (response.body == 'true') {
            return true;
          } else {
            return false;
          }
        } else {
          // debugPrint('data is response not success ${response.body}');

          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      // debugPrint("Token not found.");
      return false;
    }
  }

  // Future<void> MensurationOnOfffdgfdghfhBool(context) async {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Failed to load data after attempts.'),
  //       duration: Duration(seconds: 2), // Adjust the duration as needed
  //       backgroundColor: Colors.red, // Set the background color
  //     ),
  //   );
  // }

  // Future<void> Mddd(context) async {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Failed to load data after attempts.'),
  //       duration: Duration(seconds: 2), // Adjust the duration as needed
  //       backgroundColor: Colors.blue, // Set the background color
  //     ),
  //   );
  // }
  Future<void> MensurationOnOfffdgfdghfhBool(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Failed to load data after attempts.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('${Languages.of(context)!.ok} '),
            ),
          ],
        );
      },
    );
  }

  Future<void> Mddd(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Failed to load data after attempts.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

//notification
  Future<bool> GetNotificationOnOff() async {
    // return true;
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.get(
            Uri.parse('${API.server}/notification-settings/get-notify-on-off'),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('data is reshfgjfjgjgfjkkponse ${response.body}');
          Map<String, dynamic> response1 = json.decode(response.body);

          if (response1['notificationOn'] == true) {
            debugPrint('datatrtrtrtr is reshfgjfjgjgfjkkponse ${response.body}');
            return true;
          } else {
            return false;
          }
        } else {
          debugPrint(
              'data is response not sucdata is reshfgjfjgjgfjkkponse cess ${response.body}');

          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      // debugPrint("Token not found.");
      return false;
    }
  }

  Future<bool> onOffMensuration(bool Flag) async {
    //return false;
    String status;
    if (Flag == true) {
      status = 'on';
    } else {
      status = 'off';
    }
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
        'status': status
      };
      try {
        final response = await http.post(
            Uri.parse(
                '${API.server}/api/menstrualCycle/toggle-menstrual-cycle'),
            // body: jsonEncode({
            //   "value": oxValue,
            // }),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          // debugPrint('data is response ${response.body}');

          return true;
        } else {
          // debugPrint('data is response not success ${response.body}');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      // debugPrint("Token not found.");
      return false;
    }
  }

  Future<bool> notificationOnOff(bool Flag) async {
    //return false;
    String status;
    if (Flag == true) {
      status = 'true';
    } else {
      status = 'false';
    }
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        // 'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
        // 'status': status
      };
      try {
        final response = await http.put(
            Uri.parse(
                '${API.server}/notification-settings/update-notify-on-off?notificationOn=$status'),
            // body: jsonEncode({
            //   "value": oxValue,
            // }),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('data is respoyikuoholnse ${response.body}');

          return true;
        } else {
          debugPrint('data is response noljk;pj;;;jkt success ${response.body}');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      // debugPrint("Token not found.");
      return false;
    }
  }

  Future<MenstrualCycle> FetchMensuration() async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };

      final response = await http.get(
          Uri.parse(
              '${API.server}/api/menstrualCycle/calculate-next-period-start-date'),
          headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // debugPrint('data is response ${response.body}');
        debugPrint('error fhgyfhjjhcot ${response.body}');
        final data = json.decode(response.body);
        return MenstrualCycle.fromJson(data);
      } else {
        debugPrint('error fhgyfhjjhcot ${response.body}');
        throw Exception('Failed to fetch data');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<MenstrualCycle> UpdateMensuration(MenstrualCycle newData) async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      String addZeroIfNeeded(int number) {
        String numberString = number.toString();
        if (numberString.length < 2) {
          return '0$numberString';
        } else {
          return numberString;
        }
      }

      debugPrint(
          'mensuration len ${newData.averageCycleLength}selected date${newData.lastPeriodStartDate[0]}-${newData.lastPeriodStartDate[1]}-${newData.lastPeriodStartDate[2]}m');
      final response =
          await http.put(Uri.parse('${API.server}/api/menstrualCycle/update'),
              body: jsonEncode({
                "lastPeriodStartDate":
                    "${addZeroIfNeeded(newData.lastPeriodStartDate[0])}-${addZeroIfNeeded(newData.lastPeriodStartDate[1])}-${addZeroIfNeeded(newData.lastPeriodStartDate[2])}",
                // 'lastPeriodStartDate':
                //     '${newData.lastPeriodStartDate[0]}-${newData.lastPeriodStartDate[1]}-${newData.lastPeriodStartDate[2]}}',
                'averageCycleLength': newData.averageCycleLength,
              }),
              headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // debugPrint('data is response ${response.body}');
        //final data = json.decode(response.body);
        return newData;
      } else {
        debugPrint('data is rfdesponse ${response.body}');
        throw Exception('Failed to fetch data');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  //fetch water data

  Future<WaterData> GetWaterDataOfUser() async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };

      final response = await http.get(
          Uri.parse('${API.server}/api/all-target/get-water-goal'),
          headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // debugPrint('data is response ${response.body}');
        final data = json.decode(response.body);
        fitnessData.waterIntakeToday = data['waterIntakeForCurrentDate']
            .toStringAsFixed(data['waterIntakeForCurrentDate'] >= 99 ? 0 : 2);
        fitnessData.waterGoal = data['waterGoal'].toString();
        fitnessData.percentage = double.parse(fitnessData.waterIntakeToday) /
            double.parse(fitnessData.waterGoal);
        debugPrint(
            'data is respvfdgbfdhfgonse ${fitnessData.percentage} ${data['waterGoal'].toString()}');
        return WaterData(
            waterGoal: data['waterGoal'] ?? 0.0,
            // cupCapacity: data['cupCapacity'],
            // noOfCups: data['noOfCups'],
            waterIntake: data['waterIntakeForCurrentDate'] ?? 0.0);
      } else {
        // throw Exception('Failed to fetch data');
        return WaterData(
            waterGoal: 0,
            // cupCapacity: data['cupCapacity'],
            // noOfCups: data['noOfCups'],
            waterIntake: 0);
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<bool> AddWaterIntake(Map<String, dynamic> data) async {
    debugPrint('Data is here: $data');
    String? token = await AuthRepo.getToken();

    if (token != null) {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Using 'Auth' as specified
      };
      try {
        final response = await http.post(
          Uri.parse('${API.server}/api/water/update-water-entity1'),
          body: jsonEncode(data),
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('Data response: ${response.body}');
          return true; // Return true on successful API call
        } else {
          debugPrint('Data response not success: ${response.body}');
          return false; // Return false on failed API call
        }
      } catch (error) {
        debugPrint('Error: $error');
        return false; // Return false if an exception is thrown
      }
    } else {
      debugPrint("Token not found.");
      return false; // Return false if token is not found
    }
  }

  Future<bool> SaveWaterData(double data) async {
    debugPrint('Data is here: $data');
    String? token = await AuthRepo.getToken();

    if (token != null) {
      debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Using 'Auth' as specified
      };
      try {
        final response = await http.post(
          Uri.parse(
              '${API.server}/api/all-target/update-water-goal?newWaterGoal=$data'),
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('Data is response: ${response.body}');
          return true; // Return true on successful API call
        } else {
          debugPrint('Data is response not success: ${response.body}');
          return false; // Return false on failed API call
        }
      } catch (error) {
        debugPrint('Error: $error');
        return false; // Return false if an exception is thrown
      }
    } else {
      debugPrint("Token not found.");
      return false; // Return false if token is not found
    }
  }

  //fooddatta
  Future<List<Meal>> festchmealtabelCustom(String date, String date2) async {
    String? token = await AuthRepo.getToken();
    String url =
        '${API.server}/ingredient/getDishesWithIngredients-by-date-range?startDate=$date&endDate=$date2';

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };
    debugPrint(
        ' //68.183.89.215:7073/ingredient/getDishesWithIngredients?date=$date&mealType=$date2');
    final response = await http.get(Uri.parse(url), headers: headers);
    debugPrint("meals dats ai shere ${response.body}");
    // final response = await http.get(
    //     '${API.server}/ingredient/getDishesWithIngredients?date=2023-11-06&mealType=BreakFast'
    //         as Uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      debugPrint("jhgjkhkjhkfhfgjh of food table${response.body} ");
      return data.map((json) => Meal.fromJson(json)).toList();
    } else {
      debugPrint("response of dfvhhfrhfood table${response.body} ");
      throw Exception('Failed to load data');
    }
  }

  //fooddatta
  Future<List<Meal>> festchmealtabel(String date, String type) async {
    String? token = await AuthRepo.getToken();
    String url =
        '${API.server}/ingredient/getDishesWithIngredients?date=$date&mealType=$type';
    if (type == 'Full Day') {
      url =
          '${API.server}/ingredient/getDishesWithIngredients-by-date?date=$date';
    }
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };
    debugPrint(
        ' //68.183.89.215:7073/ingredient/getDishesWithIngredients?date=$date&mealType=$type');
    final response = await http.get(Uri.parse(url), headers: headers);
    debugPrint("meals dats ai shere ${response.body}");
    // final response = await http.get(
    //     '${API.server}/ingredient/getDishesWithIngredients?date=2023-11-06&mealType=BreakFast'
    //         as Uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      debugPrint("response of fofghgjhgjhgfhfgod table${response.body} ");
      return data.map((json) => Meal.fromJson(json)).toList();
    } else {
      debugPrint("response of fdbgbhvjvbhood table${response.body} ");
      throw Exception('Failed to load data');
    }
  }

  //fooddatta
  Future<List<dynamic>> Analysefoodintake() async {
    String? token = await AuthRepo.getToken();
    // String url =
    //     '${API.server}/ingredient/getDishesWithIngredients?date=$date&mealType=$type';
    // if (type == 'all') {
    //   url =
    //       '${API.server}/ingredient/getDishesWithIngredients-by-date?date=$date';
    // }
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };

    final response = await http.get(Uri.parse('${API.server}/target/analyse'),
        headers: headers);
    // final response = await http.get(
    //     '${API.server}/ingredient/getDishesWithIngredients?date=2023-11-06&mealType=BreakFast'
    //         as Uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      debugPrint('ghgfhfhfh ${response.body}');
      debugPrint('sdsfsfsf ${[
        Ingredientstaken.fromJson(data[0]),
        Ingredientsleft.fromJson(data[1])
      ]}');
      return [
        Ingredientstaken.fromJson(data[0]),
        Ingredientsleft.fromJson(data[1])
      ];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> EditDailyNutritionApi(Map<String, dynamic> data) async {
    // return true;
    debugPrint('data is here n $data');
    String? token = await AuthRepo.getToken();
    if (token != null) {
      debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.post(
            Uri.parse('${API.server}/target/update'),
            body: jsonEncode(data),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('data is resgfponse ${response.body}');

          return true;
        } else {
          debugPrint('data is reyyspongfgse not success ${response.body}');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      debugPrint("Token not found.");
      return false;
    }
  }

  Future<Map<String, dynamic>?> getRecipes(String recipeName) async {
    String? token = await AuthRepo.getToken();

    if (token != null) {
      debugPrint("Token: $token");

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token',
      };

      try {
        final response = await http.get(
          Uri.parse('${API.server}/recipess/$recipeName'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          debugPrint('Data responsfhfghjgfe: ${response.body}');
          // Parse the response and return it
          Map<String, dynamic> responseData = jsonDecode(response.body);
          return responseData;
        } else {
          debugPrint('Data response not jfgjgjsuccessful: ${response.body}');
          // You might want to throw an exception or handle error cases differently
          return null;
        }
      } catch (error) {
        debugPrint('Error: $error');
        // Handle error cases, you might want to throw an exception or log it
        return null;
      }
    } else {
      debugPrint("Token not found.");
      // You might want to throw an exception or handle the case differently
      return null;
    }
  }

  Future<Map<String, dynamic>?> getRecipesfromPersonal(
      String recipeName) async {
    String? token = await AuthRepo.getToken();

    if (token != null) {
      debugPrint("Token: $token");

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token',
      };

      try {
        final response = await http.get(
          Uri.parse(
              '${API.server}/personal/personal-recipe?foodName=$recipeName'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          debugPrint('Data responsfhfghjgfe: ${response.body}');
          // Parse the response and return it
          Map<String, dynamic> responseData = jsonDecode(response.body);
          return responseData;
        } else {
          debugPrint('Data response not jfgjgjsuccessful: ${response.body}');
          // You might want to throw an exception or handle error cases differently
          return null;
        }
      } catch (error) {
        debugPrint('Error: $error');
        // Handle error cases, you might want to throw an exception or log it
        return null;
      }
    } else {
      debugPrint("Token not found.");
      // You might want to throw an exception or handle the case differently
      return null;
    }
  }

  Future<void> addDishByRecipe(
      String date, Map<String, dynamic> dishData) async {
    debugPrint("fdgdhgfjgfhgdfddgdgfhjgf $dishData");
    String? token = await AuthRepo.getToken();

    if (token != null) {
      debugPrint("Token: $token");

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token',
      };

      try {
        final response = await http.post(
          Uri.parse('${API.server}/recipess/save-dish-ing?date=$date'),
          headers: headers,
          body: jsonEncode(dishData),
        );

        if (response.statusCode == 200) {
          debugPrint('Data response: ${response.body}');
          // You might want to handle success cases here
        } else {
          debugPrint('Data response not successful: ${response.body}');
          // You might want to throw an exception or handle error cases differently
        }
      } catch (error) {
        debugPrint('Error: $error');
        // Handle error cases, you might want to throw an exception or log it
      }
    } else {
      debugPrint("Token not found.");
      // You might want to throw an exception or handle the case differently
    }
  }

  // Future<void> AddFoodDish(Map<String, dynamic> data) async {
  //   // return true;
  //   debugPrint('data is gfjg n $data');
  //   String? token = await AuthRepo.getToken();
  //   if (token != null) {
  //     debugPrint("Token: $token");
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
  //     };
  //     try {
  //       final response = await http.post(
  //           Uri.parse('${API.server}/dishes/add-dish'),
  //           body: json.encode(data),
  //           headers: headers);

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         debugPrint('data is resFDFDFDFponse ${response.body}');

  //         return;
  //       }
  //       else {
  //         debugPrint('data is response not success ${response.body}');
  //         return;
  //       }
  //     } catch (error) {
  //       debugPrint('data is resFDFDFDFdfgp88onse');
  //       throw Exception('Failed to load daywise sleep data $error');
  //     }
  //   } else {
  //     debugPrint("Token not fgfgfhfound.");
  //     return;
  //   }
  // }

  Future<void> AddFoodDishCustom(Map<String, dynamic> data) async {
    // return true;
    debugPrint('data is hedsdre n $data');
    String? token = await AuthRepo.getToken();
    if (token != null) {
      debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response =
            await http.post(Uri.parse('${API.server}/dishes/add-dish'),
                body: jsonEncode({
                  'dishName': data['dishName'],
                  'dishQuantity': data['dishQuantity'],
                  'servingSize': data['servingSize'],
                  // 'dishQuantity': 1,
                  // data['dishQuantity']
                  'mealName': data['mealName'],
                }),
                headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('data is resFDFDFDFponse ${response.body}');

          return;
        }
        // else {
        //   debugPrint('data is response not success ${response.body}');
        //   return;
        // }
      } catch (error) {
        debugPrint('data is resFDFDFDFp88onse');
        throw Exception('Failed to load daywise sleep data $error');
      }
    } else {
      debugPrint("Token not found.");
      return;
    }
  }

  Future<List<Map<String, String>>> IngredientsListtemp() async {
    try {
      debugPrint('data is here mmm ');
      String? token = await AuthRepo.getToken();
      if (token != null) {
        debugPrint("Token: $token");

        final headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Auth': 'Bearer $token',
        };
        final response = await http.get(
          Uri.parse('${API.server}/foods/all-food-list'),
          headers: headers,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint(
              'Request failedmmmmdfggfgfrhmmm with status code: ${response.body}');
          debugPrint(
              'Request failedmmmmmmm withnbnbnb status code: ${response.body}');
          final List<dynamic> data = json.decode(response.body);
          // Convert the dynamic list into a list of strings.
          List<Map<String, String>> foodDataList = [];
          for (var item in data) {
            foodDataList.add({
              'foodName': item['foodName'],
              'foodCode': item['foodCode'],
              'category': item['category'] ?? "",
            });
            debugPrint("Vfcnhgvbvbmbmbn,item  $item");
          }
          debugPrint("dvfdgbfdhhfg $foodDataList");
          return foodDataList;
        } else {
          // Handle non-success status codes here (e.g., show an error message).
          debugPrint(
              'Request failedmmmmmmm with status code: ${response.statusCode}');
        }
      } else {
        debugPrint("Token notmmmmmmm found.");
      }
    } catch (error) {
      // Handle exceptions (e.g., network errors) here.
      debugPrint('Errormmmmmmm occurred: $error');
    }

    // Return an empty list in case of any errors or failures.
    return [];
  }

  Future<List<String>> IngredientsList() async {
    try {
      debugPrint('data is here mmm ');
      String? token = await AuthRepo.getToken();
      if (token != null) {
        debugPrint("Token: $token");
        // final headers = {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization':
        //       'Bearer $token', // Use 'Authorization' instead of 'Auth'
        // };

        // final response = await http.get(
        //   Uri.parse(
        //       'https://nin40-production.up.railway.app/foods/all-food-list'),
        //   headers: headers,
        // );
        final headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Auth': 'Bearer $token',
        };
        final response = await http.get(
          Uri.parse('${API.server}/foods/all-food-list'),
          headers: headers,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          final List<dynamic> data = json.decode(response.body);
          // Convert the dynamic list into a list of strings.
          debugPrint('data is here mmm ${response.body}');
          List<String> ingredientsList =
              data.map((item) => item.toString()).toList();
          return ingredientsList;
        } else {
          // Handle non-success status codes here (e.g., show an error message).
          debugPrint(
              'Request failedmmmmmmm with status code: ${response.statusCode}');
        }
      } else {
        debugPrint("Token notmmmmmmm found.");
      }
    } catch (error) {
      // Handle exceptions (e.g., network errors) here.
      debugPrint('Errormmmmmmm occurred: $error');
    }

    // Return an empty list in case of any errors or failures.
    return [];
  }

  Future<List<Map<String, dynamic>>> getPersonalInfo() async {
    try {
      debugPrint('Fetching personal info...');
      String? token = await AuthRepo.getToken();
      if (token != null) {
        debugPrint("Token: $token");

        final headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Auth': 'Bearer $token',
        };

        final response = await http.get(
          Uri.parse('${API.server}/personal/get-personal-info'),
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final List<dynamic> data = json.decode(response.body);
          // Return the dynamic list as is (List<Map<String, dynamic>>).
          debugPrint('Personal info data: ${response.body}');
          return data.cast<Map<String, dynamic>>().toList();
        } else {
          // Handle non-success status codes here (e.g., show an error message).
          debugPrint('Request failed with status code: ${response.statusCode}');
        }
      } else {
        debugPrint("Token not found.");
      }
    } catch (error) {
      // Handle exceptions (e.g., network errors) here.
      debugPrint('Error occurred: $error');
    }

    // Return an empty list in case of any errors or failures.
    return [];
  }

  Future<Map<String, dynamic>> getPersonalDetails(int perRecId) async {
    try {
      debugPrint('Fetching personal details...');
      String? token = await AuthRepo.getToken();
      if (token != null) {
        debugPrint("Token: $token");

        final headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Auth': 'Bearer $token',
        };

        final response = await http.get(
          Uri.parse('${API.server}/personal/get-personal-dish/$perRecId'),
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('gfjjgjghkkhjkhj details data: ${response.body}');
          final Map<String, dynamic> data = json.decode(response.body);
          // Return the dynamic map as is (Map<String, dynamic>).

          return data;
        } else {
          // Handle non-success status codes here (e.g., show an error message).
          debugPrint('Request failed with status code: ${response.statusCode}');
        }
      } else {
        debugPrint("Token not found.");
      }
    } catch (error) {
      // Handle exceptions (e.g., network errors) here.
      debugPrint('Error occurred: $error');
    }

    // Return an empty map in case of any errors or failures.
    return {};
  }

  Future<void> saveDishPersonal({
    required int recipeId,
    required String recipeName,
    required String totalCookedQuantity,
    required String servingUnit,
    required String valueForOneUnit,
    required List<dynamic> ingredients,
  }) async {
    try {
      debugPrint('Saving dish uyjuy... $ingredients');
      String? token = await AuthRepo.getToken();
      if (token != null) {
        debugPrint("Token: $token");

        final headers = {
          'Content-Type': 'application/json',
          'Auth': 'Bearer $token',
        };

        final body = json.encode({
          'recipeId': recipeId,
          'recipeName': recipeName,
          'totalCookedQuantity': totalCookedQuantity,
          'servingUnit': servingUnit,
          'valueForOneUnit': valueForOneUnit,
          'ingredients': ingredients,
        });

        final response = await http.post(
          Uri.parse('${API.server}/personal/save-dish-personal'),
          headers: headers,
          body: body,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('Dish personal saved successfully.');
        } else {
          // Handle non-success status codes here (e.g., show an error message).
          debugPrint('Request failed with status code: ${response.statusCode}');
        }
      } else {
        debugPrint("Token not found.");
      }
    } catch (error) {
      // Handle exceptions (e.g., network errors) here.
      debugPrint('Error occurred: $error');
    }
  }

  Future<Map<String, dynamic>> calculateIngredients(
      List<Map<String, dynamic>> ingredients) async {
    try {
      debugPrint('Calculating ingredgdggdgdients... $ingredients');
      String? token = await AuthRepo.getToken();
      if (token != null) {
        debugPrint("Token: $token");

        final headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Auth': 'Bearer $token',
        };

        final requestBody = {
          'ingredients': ingredients,
        };

        final response = await http.post(
          Uri.parse('${API.server}/ingredient/calculate-nutrition'),
          headers: headers,
          body: json.encode(requestBody),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint(
              'Calculation failed FGFGFGFGFGFGFGFG status code: ${response.body}');
          return json.decode(response.body);
        } else {
          // Handle non-success status codes here (e.g., show an error message).
          debugPrint(
              'Calculation failed with stathfghus code: ${response.statusCode}');
          throw Exception(
              'Calculation failed with stahfghgftus code: ${response.statusCode}');
        }
      } else {
        debugPrint("Token not found.");
        throw Exception('Token not found.');
      }
    } catch (error) {
      // Handle exceptions (e.g., network errors) here.
      debugPrint('Error occurred during calculation: $error');
      throw Exception('Error occurred during calculation: $error');
    }
  }

  Future<List<String>> CookedDishList() async {
    try {
      debugPrint('data is here mmm ');
      String? token = await AuthRepo.getToken();
      if (token != null) {
        debugPrint("Token: $token");

        final headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Auth': 'Bearer $token',
        };
        final response = await http.get(
          Uri.parse('${API.server}/recipess/names'),
          headers: headers,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          final List<dynamic> data = json.decode(response.body);
          // Convert the dynamic list into a list of strings.
          debugPrint('data is heregdgd mmm ${response.body}');
          List<String> ingredientsList =
              data.map((item) => item.toString()).toList();
          return ingredientsList;
        } else {
          // Handle non-success status codes here (e.g., show an error message).
          debugPrint(
              'Request failedmmmmmmm gdgdgdwith status code: ${response.statusCode}');
        }
      } else {
        debugPrint("Token notmmmmmmm found.");
      }
    } catch (error) {
      // Handle exceptions (e.g., network errors) here.
      debugPrint('Errormmmmmmm occurred: $error');
    }

    // Return an empty list in case of any errors or failures.
    return [];
  }

  //add ingredients
  Future<bool> AddFoodDishIngredients(
      List<Map<String, dynamic>> data, String dishname, String mealtype) async {
    // return true;
    debugPrint('data is herjykkhke n $data');
    String? token = await AuthRepo.getToken();
    if (token != null) {
      debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };

      try {
        debugPrint('data is responsewww ');
        final response = await http.post(
            Uri.parse(
                '${API.server}/ingredient/setIngredientsForDish?mealName=$mealtype&dishName=$dishname'),
            body: jsonEncode(data
                // 'dishName': data['dishName'],
                // 'dishQuantity': data['dishQuantity'],
                // 'mealName': data['mealName'],
                ),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('data is responsewghgjggww ${response.body}');

          return true;
        } else {
          debugPrint('data is response nogjgjgjgt success ${response.body}');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      debugPrint("Token not fojgjgjund.");
      return false;
    }
  }

  //add ingredients
  Future<bool> AddCookedFoodDishIngredients(
      String dishname, String quantity, String mealtype) async {
    // return true;
    debugPrint('data is here n ');
    String? token = await AuthRepo.getToken();
    if (token != null) {
      debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };

      try {
        debugPrint('data is responsewww ');
        final response = await http.post(
            Uri.parse(
                '${API.server}/dishes/add-recipe?recipeName=$dishname&recipeQuantity=$quantity&recipeType=$mealtype'),
            // body: jsonEncode(data
            //     // 'dishName': data['dishName'],
            //     // 'dishQuantity': data['dishQuantity'],
            //     // 'mealName': data['mealName'],
            //     ),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('data is responsewww ${response.body}');

          return true;
        } else {
          debugPrint('data is response not success ${response.body}');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      debugPrint("Token not found.");
      return false;
    }
  }
  //get activity data
  //fetch water data

  Future<List<dynamic>> GetActiviyDataOfUser(String date) async {
    String? token = await AuthRepo.getToken();

    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };

      final response = await http.get(
          Uri.parse(
              '${API.server}/activities/calculateCalories-by-steps?date=$date'),
          headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('data is response ${response.body}  date is $date');
        final List<dynamic> jsonData = json.decode(response.body);

        final List parsedData =
            jsonData.map((value) => value.toDouble()).toList();
        return parsedData;
      } else {
        throw Exception('Failed to fetch data');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<bool> PostCalorieDataOfUser(double calorie) async {
    debugPrint('Calorie data is here: $calorie');
    String? token = await AuthRepo.getToken();
    if (token != null) {
      debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.post(
            Uri.parse(
                '${API.server}/activities/record-by-calorie?calorie=$calorie'),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('Calorie data response: ${response.body}');
          return true;
        } else {
          debugPrint('Calorie data response not successful: ${response.body}');
          return false;
        }
      } catch (error) {
        debugPrint('Error: $error');
        return false;
      }
    } else {
      debugPrint("Token not found.");
      return false;
    }
  }

  Future<bool> PostStepsDataOfUser(int data) async {
    debugPrint('data is here n $data');
    String? token = await AuthRepo.getToken();
    if (token != null) {
      debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        // debugPrint(' rthrtht$data');
        final response = await http.post(
            Uri.parse('${API.server}/activities/record-by-steps?steps=$data'),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('data is responccse ${response.body}');

          return true;
        } else {
          debugPrint('data is response not succesds ${response.body} ');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      debugPrint("Token not found.");
      return false;
    }
  }

  Future<bool> PostSteps7daysDataOfUser(String data) async {
    DateTime selectedDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    final body = {
      'stepsList': data,
      'startDate': formattedDate,
    };

    debugPrint('data is here n $data');
    String? token = await AuthRepo.getToken();
    if (token != null) {
      debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        // debugPrint(' rthrtht$data');
        final response = await http.post(
            Uri.parse('${API.server}/activities/record-by-steps-weekly'),
            headers: headers,
            body: body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('data is respovxvxvnccse ${response.body}');

          return true;
        } else {
          debugPrint('data is response notvxvxvxvv succesds ${response.body} ');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      debugPrint("Token not found.");
      return false;
    }
  }

  // // post seven days  heart rate
  // Future<bool> PostRestingHeartRate7daysDataOfUser(
  //     Map<String, dynamic> restingHeartRateMap) async {
  //   DateTime selectedDate = DateTime.now();
  //   String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
  //   // final body = {
  //   //   'restingHeartRateList': restingHeartRateMap,
  //   //   'startDate': formattedDate,
  //   // };

  //   debugPrint('Resting Heart Rate data is here: $restingHeartRateMap');
  //   String? token = await AuthRepo.getToken();
  //   if (token != null) {
  //     debugPrint("Token: $token");
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Auth': 'Bearer $token',
  //     };
  //     try {
  //       final response = await http.post(
  //         Uri.parse('${API.server}/api/heart-rates/record-weekly'),
  //         headers: headers,
  //         body: jsonEncode({
  //           restingHeartRateMap,
  //         }),
  //       );

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         debugPrint('Resting Heart Rate data response: ${response.body}');
  //         return true;
  //       } else {
  //         debugPrint(
  //             'Resting Heart Rate data response not successful: ${response.body}');
  //         return false;
  //       }
  //     } catch (error) {
  //       debugPrint('Resting Heart Rate data resp1111');
  //       return false;
  //     }
  //   } else {
  //     debugPrint("Token not found.");
  //     return false;
  //   }
  // }
  Future<void> PostRestingHeartRate7daysDataOfUser(
      Map<String, dynamic> sleepMap) async {
    String? token = await AuthRepo.getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };

    final response = await http.post(
      Uri.parse('${API.server}/api/heart-rates/record-weekly'),
      headers: headers,
      body: jsonEncode(sleepMap),
    );

    if (response.statusCode == 200) {
      // Handle success
      debugPrint('Sleep data fghygfhgjg successfully');
    } else {
      // Handle error
      debugPrint(
          'Failed to sendg sleep data. Statdcffdfus code:$sleepMap ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
    }
  }

//post 7 days sleep
//post 7 days sleep
  Future<void> PostSleep7daysDataOfUserGoogleFit(
      Map<String, dynamic> sleepMap) async {
    String? token = await AuthRepo.getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };
    debugPrint('Sleep data segddsfthfhghggfgfdgnt successfully  $sleepMap');
    final response = await http.post(
      Uri.parse('${API.server}/api/sleep-logs/sleep-duration-by-googlefit'),
      headers: headers,
      body: jsonEncode(sleepMap),
    );

    if (response.statusCode == 200) {
      // Handle success
      debugPrint('Sleep data segddsfthfhghggfgfdgnt successfully  $sleepMap');
    } else {
      // Handle error
      debugPrint(
          'Failed to sendg sleep djhgjkhkjhata. Status code:$sleepMap ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
    }
  }

  Future<void> PostSleep7daysDataOfUser(Map<String, dynamic> sleepMap) async {
    String? token = await AuthRepo.getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };

    final response = await http.post(
      Uri.parse('${API.server}/api/sleep-logs/record-sleep-weekly'),
      headers: headers,
      body: jsonEncode(sleepMap),
    );

    if (response.statusCode == 200) {
      // Handle success
      debugPrint('Sleep data segddsfthfhghggfgfdgnt successfully  $sleepMap');
    } else {
      // Handle error
      debugPrint(
          'Failed to sendg sleep djhgjkhkjhata. Status code:$sleepMap ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
    }
  }

  //post calories burn of 7days

  Future<bool> PostCaloriesBurn7daysDataOfUser(String data) async {
    DateTime selectedDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    final body = {
      'stepsList': data,
      'startDate': formattedDate,
    };

    debugPrint('data is hereggg n $data');
    String? token = await AuthRepo.getToken();
    if (token != null) {
      debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        // debugPrint(' rthrtht$data');
        final response = await http.post(
            Uri.parse('${API.server}/activities/record-by-calorie-weekly'),
            headers: headers,
            body: body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('data is gfhuyuyggfgfhgfhgfjoofhhf $data ${response.body}');

          return true;
        } else {
          debugPrint(
              'data is response nothffiyuiyuihhfhvxvxvxvv succesds ${response.body} ');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      debugPrint("Token not found.");
      return false;
    }
  }

  Future<bool> postCaloryData(List<int> stepsList, String startDate) async {
    debugPrint('Calory data is here: $stepsList');

    String? token = await AuthRepo.getToken();

    if (token != null) {
      debugPrint("Token: $token");

      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Auth': 'Bearer $token',
      };

      final data = {
        'stepsList': stepsList.join(','),
        'startDate': startDate,
      };

      try {
        final response = await http.post(
          Uri.parse('${API.server}/activities/record-by-calory'),
          headers: headers,
          body: data,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('Data response: ${response.body}');
          return true;
        } else {
          debugPrint('Data response not successful: ${response.body}');
          return false;
        }
      } catch (error) {
        debugPrint('Error: $error');
        return false;
      }
    } else {
      debugPrint("Token not found.");
      return false;
    }
  }

  Future<bool> PostProfileVariableTypeData(String variableType) async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Auth': 'Bearer $token',
      };

      try {
        final response = await http.post(
          Uri.parse(
              '${API.server}/api/profile/variable-type?variableType=$variableType'),
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('Data responsvcccce: ${response.body}');
          return true;
        } else {
          debugPrint('Data response not sucfdfcessful: ${response.body}');
          return false;
        }
      } catch (error) {
        debugPrint('Error: $error');
        return false;
      }
    } else {
      debugPrint("Token not found.");
      return false;
    }
  }

  Future<void> fetchStepsOfToday() async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };

      final response = await http.get(
          Uri.parse('${API.server}/activities/get-health-data'),
          headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("fvdksjfcfhgbfsj ${response.body}");
        if (response.body != '') {
          final Map<String, dynamic> data = json.decode(response.body);

          fitnessData.steps = data['steps'].toString();
          fitnessData.caloriesBurned = data['totalExerciseCalories'].toString();
          fitnessData.caloriesBurnedTime =
              data['totalExerciseDuration'].toString();
          fitnessData.caloriesBurnedfromwatch = data['calorie'].toString();
          debugPrint("dfdfdgg ${response.body} ${data['totalExerciseDuration']}");
          fitnessData.heartRate = data['heartRateValue'].toString();
          // fitnessData.sleepTime = data['sleepDuration'].toString();

          // Code to execute if the map is empty
          // int durationInSeconds = ((data['sleepDuration'] * 60).round()
          //     //  +
          //     //         (sleepData['manualDuration'] * 60))
          //     )
          //     .toInt();

          // Duration duration = Duration(seconds: durationInSeconds);
          // int hours = duration.inHours;
          // int minutes = (duration.inMinutes % 60);

          // fitnessData.sleepTime = '$hours h $minutes m';
          debugPrint('The map is empty.');

          debugPrint("hbfvdskjgndgkdfnhkjfg ${fitnessData.caloriesBurned}");
        }
      } else {
        // Handle error
        debugPrint('Failed todcfgfhfjjggh ${response.body} load steps');
      }
    }
  }

  static Future<Map<String, dynamic>?> fetchCaloriesBurnedAndEnergyIntake(
      String date) async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint the token for debugging purposes
      // debugPrint("Token: $token");

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };

      final response = await http.get(
        Uri.parse(
            '${API.server}/api/exercises/calories-burned-and-energy-intake?date=$date'),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Response:vfvgfbff $date ${response.body}");
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> data = json.decode(response.body);
          return data;
        }
      } else {
        // Handle error
        debugPrint(
            'Failed to load calories burned and energy intake data: ${response.body}');
      }
    }
    return null;
  }
  //running jogging

  Future<double> GetRuningJoggingDataOfUser(String date, String Type) async {
    String? token = await AuthRepo.getToken();

    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };

      final response = await http.get(
          Uri.parse(
              '${API.server}/activities/calculateCalories-by duration?activityType=$Type&activityDate=$date'),
          headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('data is response ${response.body}  date is $date');
        final double jsonData = json.decode(response.body);

        // final List parsedData =
        //     jsonData.map((value) => value.toDouble()).toList();
        return jsonData;
      } else {
        throw Exception('Failed to fetch data');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<bool> UpdateRuningJoggingDataOfUser(double value, String Type) async {
    String? token = await AuthRepo.getToken();
    String valueApi = '';
    if (Type == 'running') {
      valueApi = 'runningDurationInSeconds';
      debugPrint('if called $value , $Type');
    } else if (Type == 'jogging') {
      valueApi = 'joggingDurationInSeconds';
    }
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };

      final response = await http.put(
          Uri.parse('${API.server}/activities/record-by-activity'),
          body: jsonEncode({
            'activityType': Type,
            valueApi: value,
            // 'mealName': data['mealName'],
          }),
          headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('if called $value , $Type');
        //  debugPrint('data is response ${response.body}  date is $date');
        // final double jsonData = json.decode(response.body);

        // final List parsedData =
        //     jsonData.map((value) => value.toDouble()).toList();
        return true;
      } else {
        return false;
        //throw Exception('Failed to fetch data');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

//feedback
  Future<bool> SendFeedbackUser(String feedback) async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };

      final response = await http.post(Uri.parse('${API.server}/feedback/add'),
          body: jsonEncode({
            'feedback': feedback,
            // 'mealName': data['mealName'],
          }),
          headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('if called $feedback , $Type');
        //  debugPrint('data is response ${response.body}  date is $date');
        // final double jsonData = json.decode(response.body);

        // final List parsedData =
        //     jsonData.map((value) => value.toDouble()).toList();
        return true;
      } else {
        return false;
        //throw Exception('Failed to fetch data');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<bool> sendContactUsFeedback({
    required String name,
    required String number,
    required String email,
    required String queries,
    required String requestType,
    String? imagePath,
  }) async {
    debugPrint("fdssggdfhdf $imagePath");
    String? token = await AuthRepo.getToken();
    // if (token != null) {
    final headers = {
      'Auth': 'Bearer $token',
    };

    // Create a multipart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${API.server}/api/contact-us/upload'),
    );

    // Add form fields
    request.fields.addAll({
      'name': name,
      'number': number,
      'email': email,
      'queries': queries,
      'requestType': requestType,
    });

    // Add image file if imagePath is not null
    if (imagePath != null) {
      if (imagePath != "") {
        request.files.add(
          await http.MultipartFile.fromPath('image', imagePath),
        );
      }
    }

    // Add headers
    request.headers.addAll(headers);

    // Send the request
    final response = await request.send();

    // Check the response status
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint('Contact Us dfgfdghd sent successfully ');
      return true;
    } else {
      debugPrint('Failed to send hfghjgjg Us feedback ');
      return false;
    }
    // } else {
    //   throw Exception('Failed to fetch token');
    // }
  }

  //resetpass
  Future<void> ResetPassward(
      String oldpass, String newpasss, String email) async {
    String? token = await AuthRepo.getToken();

    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };

      final response = await http.post(
          Uri.parse('${API.server}/auth/change-password'),
          body: jsonEncode({
            "email": email,
            "oldPassword": oldpass,
            "newPassword": newpasss
          }),
          headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('if called calldfrjugtjugytjuyed pass  $newpasss ');
        //  debugPrint('data is response ${response.body}  date is $date');
        // final double jsonData = json.decode(response.body);

        // final List parsedData =
        //     jsonData.map((value) => value.toDouble()).toList();
        return;
      } else {
        throw Exception(response.body);
      }
    } else {
      throw Exception('There is any Problem');
    }
  }
  //send notification token to api

  Future<bool> SendNotificationToken(String Ntoken) async {
    // final Map<String, dynamic> requestData = {
    //   "value": Ntoken,
    // };
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.put(
            Uri.parse(
                '${API.server}/api/users/update-notification-token?newToken=$Ntoken'),
            // body: jsonEncode({
            //   "value": Ntoken,
            // }),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('data is gfdhfhfgjresponse ${response.body}');

          return true;
        } else {
          debugPrint('data is yjhgjkgresponse not success ${response.body}');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      // debugPrint("Token not found.");
      return false;
    }
  }

  //send notification timinfg start and end timing
  Future<bool> postNotificationTimingStartEnd(Map<String, dynamic> data) async {
    debugPrint('data is here n $data');
    String? token = await AuthRepo.getToken();
    if (token != null) {
      debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        // debugPrint(' rthrtht$data');
        debugPrint("Token not fhghfgkjgkighkghkfound.true");
        final response = await http.post(
            Uri.parse('${API.server}/notification/scheduleNotification'),
            body: json.encode(data),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('data is resphtgjonse ${response.body}');

          return true;
        } else {
          debugPrint('data is respkhgkkhkonse not succesds ${response.body} ');
          return false;
        }
      } catch (error) {
        debugPrint("Token not fhgfound.true");
        return false;
      }
    } else {
      debugPrint("Token not found.true");
      return false;
    }
  }

  //fetch user books
  Future<List<dynamic>> fetchBooks() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };
    final response = await http.get(Uri.parse('${API.server}/api/booktables'),
        headers: headers);

    if (response.statusCode == 200) {
      debugPrint("response jghjggjg${response.body}");
      final List<dynamic> data = jsonDecode(response.body);
      // setState(() {
      //   books = List<Map<String, dynamic>>.from(data);
      return data;
      // });
    } else {
      debugPrint("response jghjggjg${response.body}");
      throw Exception('Failed to load books');
    }
  }

//get revies of books
  Future<Map<String, dynamic>> getReviewsByBook(int bookId) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };
    final response = await http.get(
        Uri.parse('${API.server}/api/reviews/by-book/$bookId'),
        headers: headers);

    if (response.statusCode == 200) {
      debugPrint("response jghjggjg${response.body}");
      // final List<dynamic> data = jsonDecode(response.body);
      // setState(() {
      //   books = List<Map<String, dynamic>>.from(data);
      return json.decode(response.body);
      // });
    } else {
      debugPrint("response jghjggjg bookId${response.body} $bookId");
      throw Exception('Failed to load books');
    }
  }

  Future<void> addReview(int bookId, String comment, double rating) async {
    String? token = await AuthRepo.getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };

    final response = await http.post(
      Uri.parse(
          '${API.server}/api/reviews/addReview?bookId=$bookId&comment=$comment&rating=$rating'),
      headers: headers,
      // body: jsonEncode({
      //   'bookId': bookId,
      //   'comment': comment,
      //   'rating': rating,
      // }),
    );

    if (response.statusCode != 201) {
      debugPrint("failde ${response.statusCode} ${response.body} $bookId");
      throw Exception('Failed to add review');
    }
  }

  //get order id
  Future<Map<String, dynamic>> SendCartAndGEtOrderID(
      Map<String, dynamic> data) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };

    final response = await http.post(
        Uri.parse('${API.server}/buy/createPayment'),
        body: json.encode(data),
        headers: headers);

    if (response.statusCode == 200) {
      debugPrint("response jghjgtdegtdegdgdgggjg${response.body}");
      final Map<String, dynamic> data = jsonDecode(response.body);
      // setState(() {
      //   books = List<Map<String, dynamic>>.from(data);
      return data;
      // });
    } else {
      debugPrint("response jghjhgjjhjhggjg${response.body}");
      throw Exception('Failed to load books');
    }
  }

  Future<void> ValidatePayment(Map<String, dynamic> data) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };

    final response = await http.post(
        Uri.parse('${API.server}/api/payment/verify'),
        body: json.encode(data),
        headers: headers);

    if (response.statusCode == 200) {
      debugPrint("response jghjgtdegtdegdgdgggfdhfhgjg${response.body}");
      // final Map<String, dynamic> data = jsonDecode(response.body);
      // setState(() {
      //   books = List<Map<String, dynamic>>.from(data);
      return;
      // });
    } else {
      debugPrint("response jghjhgjjhfhgfhfghhjhggjg${response.body}");
      throw Exception('Failed payment');
    }
  }

  //update sleep
  Future<void> UpdateSleepData(Map<String, dynamic> data) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };
    debugPrint("dtaa sending for sleep $data");
    final response = await http.put(
        Uri.parse('${API.server}/api/sleep-logs/creatSleepLog'),
        body: json.encode(data),
        headers: headers);

    if (response.statusCode == 201) {
      debugPrint(
          "response watch APi call Succyujyijuyikuyikessfully ${response.body}");
      // final Map<String, dynamic> data = jsonDecode(response.body);
      // setState(() {
      //   books = List<Map<String, dynamic>>.from(data);
      return;
      // });
    } else {
      debugPrint(
          "response jghjhgjjhjhfhgfhjfgjgfdgjggjg watch APi call Successfully ${response.body}");
      throw Exception('Failed to load books');
    }
  }

  Future<void> updateWeightGoal(String weightGoal) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    final Map<String, String> body = {
      'weightGoal': weightGoal,
    };

    final response = await http.put(
      Uri.parse('${API.server}/api/all-target/weight-goal'),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      debugPrint('Weight goal updatfdhgfhgfjgfjfjed successfully');
    } else {
      throw Exception('Failed to update weight goal');
    }
  }

//update weight

  Future<Map<String, dynamic>> getLatestWeight() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse('${API.server}/api/weight-manager/get-latest-weight'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      debugPrint("fdfgdsgdfyhfgjhgfjkghkgh");
      return json.decode(response.body);
    } else {
      debugPrint("fdfgfgfhfgjhgjdsgdfyhfgjhgfjkghkgh ${response.body}");
      throw Exception('Failed to get latest weight');
    }
  }

  //update sleep

  // Future<void> UpdateWeightData(
  //     double data, String date, BuildContext context) async {
  //   String? token;
  //   try {
  //     token = await AuthRepo.getToken();
  //   } catch (e) {
  //     debugPrint("Error getting token: $e");
  //     // await _showAlertDialog(
  //     //     context, "Error", "Failed to get token", Colors.red);
  //     return;
  //   }

  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Auth': 'Bearer $token', // Corrected header key
  //   };

  //   debugPrint("Data sending for weight: $data");

  //   try {
  //     // setLoading(true);
  //     final response = await http.post(
  //       Uri.parse(
  //           '${API.server}/api/weight-manager/save-weight?weight=$data&date=$date'),
  //       headers: headers,
  //     );

  //     if (response.statusCode == 200) {
  //       //     setLoading(false);
  //       debugPrint("Response from API call: ${response.body}");
  //       // await _showAlertDialog(context, "Success",
  //       //     "Weight data updated successfully", Colors.green);
  //       return;
  //     } else {
  //       //  setLoading(false);
  //       debugPrint("API call failed with status: ${response.statusCode}");
  //       debugPrint("Response from API call: ${response.body}");
  //       // await _showAlertDialog(
  //       //     context, "Error", "Failed to update weight data", Colors.red);
  //     }
  //   } catch (e) {
  //     // setLoading(false);
  //     debugPrint("Exception occurred: $e");
  //     // await _showAlertDialog(context, "Error",
  //     //     "An error occurred while updating weight data", Colors.red);
  //   }
  // }
  // Future<void> UpdateWeightData(double data, String date) async {
  //   try {
  //     String? token = await AuthRepo.getToken();
  //     setLoading(true);

  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Auth': 'Bearer $token', // Correct header name
  //     };

  //     debugPrint("Data sending for weight: $data");

  //     final response = await http.post(
  //       Uri.parse(
  //           '${API.server}/api/weight-manager/save-weight?weight=$data&date=$date'),
  //       headers: headers,
  //     );

  //     if (response.statusCode == 200) {
  //       setLoading(false);
  //       setCheckModalBoolSuccess(true);
  //       debugPrint("API call successfully: ${response.body}");
  //       return;
  //     } else {
  //       debugPrint("API call faidfdgdfgfhled: ${response.body}");
  //       setLoading(false);

  //       _SetmodalUpdate(true, "Something wrong : ${response.body}");
  //       // _checkInternetConnection();
  //       //   _checkInternetConnection();
  //       debugPrint("API call faidfdgdfgfhled: ${response.body}");
  //       //  throw Exception('Failed to update weight data');
  //     }
  //   } catch (e) {
  //     setLoading(false);

  //     _SetmodalUpdate(true, "Something Wrong : $e");
  //     debugPrint("Error during API call: $e");
  //     // You can handle specific actions on different errors here if needed
  //   }
  // }

  Future<bool> UpdateWeightData(double data, String date) async {
    try {
      String? token = await AuthRepo.getToken();

      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Correct header name
      };

      debugPrint("Data sending for weight: $data");

      final response = await http.post(
        Uri.parse(
            '${API.server}/api/weight-manager/save-weight?weight=$data&date=$date'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint("API call successfully: ${response.body}");
        return true; // Return true on successful API call
      } else {
        debugPrint("API call failed: ${response.body}");
        return false; // Return false on failed API call
      }
    } catch (e) {
      debugPrint("Error during API call: $e");
      return false; // Return false if an exception is thrown
    }
  }

  Future<bool> ChangeSleepGoal(double data) async {
    debugPrint('data is here n $data');
    String? token = await AuthRepo.getToken();
    if (token != null) {
      debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.put(
            Uri.parse('${API.server}/api/all-target/sleepTarget'),
            body: jsonEncode({"sleepTarget": data * 60}),
            headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('data is reshjmhgkhgkhjkhponse ${response.body}');

          return true;
        } else {
          debugPrint('data is response not success ${response.body}');
          return false;
        }
      } catch (error) {
        return false;
      }
    } else {
      debugPrint("Token not found.");
      return false;
    }
  }

  //get sleep
  Future<Map<String, dynamic>> getSleepData() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };

    final response = await http.get(
        Uri.parse('${API.server}/api/sleep-logs/getAllSleep'),
        headers: headers);

    if (response.statusCode == 201) {
      debugPrint("response jghjukyukuyjgtdegtdegdgdgggjg${response.body}");
      final Map<String, dynamic> data = jsonDecode(response.body);
      // setState(() {
      //   books = List<Map<String, dynamic>>.from(data);
      return data;
      // });
    } else {
      debugPrint("response jghjhgjjhjhggjg${response.body}");
      throw Exception('Failed to load data');
    }
  }

  //get week steps
  Future<Map<String, double>> getDaywiseStepsData() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };

    final response = await http.get(
      Uri.parse('${API.server}/activities/weekly-steps'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      debugPrint("responcdshfbse: ${response.body}");
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Assuming the response structure is similar to {"WEDNESDAY": 0.0, ...}
      final Map<String, double> daywiseData = Map<String, double>.from(data);

      return daywiseData;
    } else {
      debugPrint("response: ${response.body}");
      throw Exception('Failed to load daywise sleep data');
    }
  }

  //get week calorie
  Future<Map<String, double>> getDaywiseCalorieData() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };

    final response = await http.get(
      Uri.parse('${API.server}/activities/weekly-calorie'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      debugPrint("response:gdgd ${response.body}");
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Assuming the response structure is similar to {"WEDNESDAY": 0.0, ...}
      final Map<String, double> daywiseData = Map<String, double>.from(data);

      return daywiseData;
    } else {
      debugPrint("response:gdgd ${response.body}");
      throw Exception('Failed to load daywise sleep data');
    }
  }

  //get week calorie
  Future<Map<String, double>> getDaywiseHeartRateData() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };

    final response = await http.get(
      Uri.parse('${API.server}/api/heart-rates/weekly-heart'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      debugPrint("response: ${response.body}");
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Assuming the response structure is similar to {"WEDNESDAY": 0.0, ...}
      final Map<String, double> daywiseData = Map<String, double>.from(data);

      return daywiseData;
    } else {
      debugPrint("response: ${response.body}");
      throw Exception('Failed to load daywise sleep data');
    }
  }

  //get week water intake
  Future<Map<String, double>> getDaywiseWaterData() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };

    final response = await http.get(
      Uri.parse('${API.server}/api/water/calculate-intake-last-week'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      debugPrint("response: ${response.body}");
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Assuming the response structure is similar to {"WEDNESDAY": 0.0, ...}
      final Map<String, double> daywiseData = Map<String, double>.from(data);

      return daywiseData;
    } else {
      debugPrint("response: ${response.body}");
      throw Exception('Failed to load daywise sleep data');
    }
  }

  //get week water intake
  Future<Map<String, double>> getDaywiseSleepData() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };

    final response = await http.get(
      Uri.parse('${API.server}/api/sleep-logs/calculate-sleep-last-week'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      debugPrint("response: ${response.body}");
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Assuming the response structure is similar to {"WEDNESDAY": 0.0, ...}
      final Map<String, double> daywiseData = Map<String, double>.from(data);

      return daywiseData;
    } else {
      debugPrint("response: ${response.body}");
      throw Exception('Failed to load daywise sleep data');
    }
  }

  //add dish to favourite list
  //update sleep
  Future<void> UpdateToFavourite(int dishId, bool status) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };
    debugPrint("dtaa sending for sleep $dishId");
    final response = await http.put(
        Uri.parse(
            '${API.server}/dishes/add-favourite?dish_id=$dishId&favourite=$status'),
        // body: json.encode(data),
        headers: headers);

    if (response.statusCode == 200) {
      debugPrint("response jghjukyukuyjgtdegtdegdgdgggjg${response.body}");
      // final Map<String, dynamic> data = jsonDecode(response.body);
      // setState(() {
      //   books = List<Map<String, dynamic>>.from(data);
      return;
      // });
    } else {
      debugPrint("response jghjhgjjhjhfhgfhjfgjgfjggjg${response.body}");
      throw Exception('Failed to load books');
    }
  }

  Future<List<dynamic>> GetFavouriteFoodList() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };
    debugPrint("dtaa sending for sleep ");
    final response =
        await http.get(Uri.parse('${API.server}/dishes/favourites'),
            // body: json.encode(data),
            headers: headers);

    if (response.statusCode == 200) {
      debugPrint("response jghjukyukugdfgdyjgtdegtdegdgdgggjg${response.body}");
      final List<dynamic> apiData = json.decode(response.body);
      // final Map<String, dynamic> data = jsonDecode(response.body);
      // setState(() {
      //   books = List<Map<String, dynamic>>.from(data);
      return apiData;
      // });
    } else {
      debugPrint("response jghjhgjjhjhfhgfhjfgjgfjggjg${response.body}");
      throw Exception('Failed to load books');
    }
  }

  Future<List<NutritionalRequirement>> fetchNutritionalRequirements() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse('${API.server}/api/profile/get-all-ear'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      List<NutritionalRequirement> requirements =
          list.map((model) => NutritionalRequirement.fromJson(model)).toList();
      return requirements;
    } else {
      // Handle error
      throw Exception('Failed to load nutritional requirements');
    }
  }

  //get sleep data from backened
  Future<Map<String, dynamic>> fetchSleepData(String date) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };
    final response = await http.get(
        Uri.parse('${API.server}/api/sleep-logs/getSleepByDate?date=$date'),
        headers: headers);

    if (response.statusCode == 200) {
      debugPrint("Gdfrhrttfhjtyfj ${response.body}");
      return json.decode(response.body);
    } else {
      // throw Exception('Failed to load sleep data');
      Map<String, dynamic> myMap = {};
      return myMap;
    }
  }

  //get sleep data from backened
  Future<int> getSleepTarget() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };
    final response = await http.get(
        Uri.parse('${API.server}/api/all-target/get-sleep-target'),
        headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // throw Exception('Failed to load sleep data');
      int myMap = 0;
      return myMap;
    }
  }

  static Future<List<Map<String, dynamic>>> fetchExerciseData(
      String startDate, String endDate) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    final Uri url = Uri.parse(
        '${API.server}/api/exercises/calories-burned-and-energy-intake-range?startDate=$startDate&endDate=$endDate');

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> exerciseDataList = [];

      Map<String, dynamic> data = json.decode(response.body);

      data.forEach((key, value) {
        Map<String, dynamic> entry = {
          'date': key,
          'totalDuration': value['totalDuration'] ?? 0.0,
          'totalCaloriesExpenditure': value['totalCaloriesExpenditure'] ?? 0.0,
          'totalEnergyIntake': value['totalEnergyIntake'] ?? [],
          'totalCaloriesBurned': value['totalCaloriesBurned'] ?? 0.0,
          'energyBalance': value['energyBalance'] ?? 0.0,
          'restIntakeCalories': value['restIntakeCalories'] ?? 0.0,
        };
        exerciseDataList.add(entry);
      });

      return exerciseDataList;
    } else {
      debugPrint("Failed to load exercise data: ${response.statusCode}");
      throw Exception('Failed to load exercise data');
    }
  }

  static Future<List<dynamic>> fetchWaterIntakeData(String date) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    final Uri url = Uri.parse('${API.server}/api/water/all-intake?date=$date');

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body) as List;
    } else {
      return [];
    }
  }

  static Future<void> deleteWaterIntakeEntry(int entryId) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    final Uri url =
        Uri.parse('${API.server}/api/water/intake/entry?entryId=$entryId');

    final response = await http.delete(url, headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete water intake entry');
    }
  }

  static Future<List<dynamic>> fetchHealthDashboardData(
      String startDate, String endDate) async {
    // Assume AuthRepo.getToken() fetches the token correctly
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Correct header field for Authorization
    };
    final Uri url = Uri.parse(
        '${API.server}/health-dashboard/range?startDate=$startDate&endDate=$endDate');

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      debugPrint(
          "Failed tscdffsdfsdgso load health dashboard data ${response.body}");
      // Since the expected data is a list, decode it as a list
      return json.decode(response.body) as List;
    } else {
      // In case of error, return an empty list instead of an empty map
      debugPrint("Failed to load health dashboard data");
      return [];
    }
  }

//GET REALTIME WATER
  Future<List> getWaterIntake() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };

    final response = await http.get(
      Uri.parse('${API.server}/api/water/intake'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      // Handle error case here
      // You might want to throw an exception or return an empty list based on your use case
      return [];
    }
  }

  Future<List<dynamic>> fetchOrderHistory() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };
    final response = await http.get(Uri.parse('${API.server}/api/orders/user'),
        headers: headers);

    if (response.statusCode == 200) {
      debugPrint("data is here  after fdfsuccefull${response.body}");
      return json.decode(response.body);
    } else {
      debugPrint("data is here  after succefull${response.body}");
      throw Exception('Failed to load sleep data');
    }
  }

  // Assuming that getNotificationSheduledData is a method in your UserProfileController class
  Future<List<Map<String, dynamic>>> getNotificationSheduledData() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Corrected from 'Auth' to 'Authorization'
    };

    try {
      final response = await http.get(
        Uri.parse('${API.server}/notification/get-user-notifications'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint("Data is here after successdvgfdgdgsful fetch: ${response.body}");
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        debugPrint("Failed to load dvfgbfhfhata: ${response.body}");
        throw Exception('Failed to load notification data');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception('Failed to load notification data');
    }
  }

  //on of reminder notifications
  static Future<void> OnOffNotificationForReminders(
      bool notificationOn, String notificationType) async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.put(
            Uri.parse(
                '${API.server}/notification/update-toggle-notification-type?notificationOn=$notificationOn&notificationType=$notificationType'),
            headers: headers);

        if (response.statusCode == 200) {
          // Successful API call
          debugPrint(
              'Notification updated successfully notificationOn=$notificationOn&notificationType=$notificationType');
        } else {
          // Handle API error
          debugPrint(
              'Failed to update notification. Status Code: ${response.statusCode}');
        }
      } catch (error) {
        // Handle network or other errors
        debugPrint('Error: $error');
      }
    }
  }

// Function to fetch Salt and Sugar data
  static Future<Map<String, double>?> fetchSaltAndSugarData2(
      String date) async {
    String? token = await AuthRepo.getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('${API.server}/ingredient/get-salt-and-sugar?date=$date'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        // Successful API call
        var responseData = jsonDecode(response.body);
        double salt = responseData['Salt'];
        double sugar = responseData['Sugar'];
        return {'Salt': salt, 'Sugar': sugar};
      } else {
        // Handle API error
        debugPrint(
            'Failed to fetch Salt and Sugar data. Status Code: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (error) {
      // Handle network or other errors
      debugPrint('Error: $error  ');
      return null;
    }
  }

// Function to fetch Salt and Sugar data
  static Future<Map<String, double>?> fetchSaltAndSugarData() async {
    String? token = await AuthRepo.getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('${API.server}/ingredient/get-salt-and-sugar'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        // Successful API call
        var responseData = jsonDecode(response.body);
        double salt = responseData['Salt'];
        double sugar = responseData['Sugar'];
        return {'Salt': salt, 'Sugar': sugar};
      } else {
        // Handle API error
        debugPrint(
            'Failed to fetch Salt and Sugar data. Status Code: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (error) {
      // Handle network or other errors
      debugPrint('Error: $error  ');
      return null;
    }
  }

// Function to fetch category-wise ingredient quantity data

  static Future<Map<String, double>?> fetchIngredientQuantityData() async {
    String? token = await AuthRepo.getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('${API.server}/ingredient/category-wise-ingredient-quantity'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint(
            'Failed to fetch ingdsefdsgfdhfghjfgjgfjgtity data. Status Code: ${response.body} ');
        // Successful API call
        var responseData = jsonDecode(response.body);
        // Extracting data from the response
        double greenLeafyVegetables = responseData['Green leafy vegetables'];
        // double miscellaneous = responseData['Miscellaneous'];
        double milkAndMilkProducts = responseData['Milk & milk products'];
        double pulsesAndLegumes = responseData['Pulses&legumes'];
        double meatPoultryAndFishes = responseData['Meat, poultry and fishes'];
        double cerealsAndGrains = responseData['Cereals & grains'];
        double nutsAndOilSeeds = responseData['nuts and oil seeds'];
        double egg = responseData['Egg '];
        double rootsAndTubers = responseData['Roots & tubers'];
        double otherVegetables = responseData['Other vegetables'];
        double fruits = responseData['Fruits'];
        // Returning the data as a map
        return {
          'Green leafy vegetables': greenLeafyVegetables,
          // 'Miscellaneous': miscellaneous,
          'Milk & Milk products': milkAndMilkProducts,
          'Pulses & legumes': pulsesAndLegumes,
          'Meat, Poultry and Fishes': meatPoultryAndFishes,
          'Cereals & Grains': cerealsAndGrains,
          'Nuts and Oil seeds': nutsAndOilSeeds,
          'Egg ': egg,
          'Roots & Tubers': rootsAndTubers,
          'Other vegetables': otherVegetables,
          'Fruits': fruits,
        };
      } else {
        // Handle API error
        debugPrint(
            'Failed to fetch ingredient quantity data. Status Code: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (error) {
      // Handle network or other errors
      debugPrint('Error: $error');
      return null;
    }
  }

// Function to calculate Dishes Delivered Score
  static Future<Map<String, dynamic>?> calculateDDScore() async {
    String? token = await AuthRepo.getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('${API.server}/dishes/calculateDDScore'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        debugPrint(
            'Failed to calculate Dishes Delivered Score. Status Code: ${response.body}');
        return responseData;
      } else {
        debugPrint(
            'Failed to calculate Dishes Delivered Score. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      debugPrint('Error: $error');
      return null;
    }
  }

  static Future<void> DleteBloodGLucose(int id) async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.delete(
            Uri.parse('${API.server}/api/blood-glucose/delete/$id'),
            headers: headers);

        if (response.statusCode == 200) {
          // Successful API call
          debugPrint(
              'Notification updated successfully notificationOn=&notificationType=');
        } else {
          // Handle API error
          debugPrint(
              'Failed to update notification. Status Code: ${response.statusCode}');
        }
      } catch (error) {
        // Handle network or other errors
        debugPrint('Error: $error');
      }
    }
  }

  static Future<void> DleteSystolicDiastolic(int id) async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      debugPrint("rggrbfrbfbgfbhhgfb: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.delete(
            Uri.parse('${API.server}/api/systolic-blood-pressure/delete/$id'),
            headers: headers);

        if (response.statusCode == 200) {
          // Successful API call
          debugPrint(
              'Notification updated successfully notificationOn=&notificationType=');
        } else {
          // Handle API error
          debugPrint(
              'Failed to update notification. Status Code: ${response.statusCode}');
        }
      } catch (error) {
        // Handle network or other errors
        debugPrint('Error: $error');
      }
    }
  }

  static Future<void> DleteOxygen(int id) async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.delete(
            Uri.parse('${API.server}/api/oxygen-saturated-level/delete/$id'),
            headers: headers);

        if (response.statusCode == 200) {
          // Successful API call
          debugPrint(
              'Notification updated successfully notificationOn=&notificationType=');
        } else {
          // Handle API error
          debugPrint(
              'Failed to update notification. Status Code: ${response.statusCode}');
        }
      } catch (error) {
        // Handle network or other errors
        debugPrint('Error: $error');
      }
    }
  }

  static Future<void> DleteNotification(int id) async {
    String? token = await AuthRepo.getToken();
    if (token != null) {
      // debugPrint("Token: $token");
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
      };
      try {
        final response = await http.delete(
            Uri.parse('${API.server}/notification/delete-notification/$id'),
            headers: headers);

        if (response.statusCode == 200) {
          // Successful API call
          debugPrint(
              'Notification updated successfully notificationOn=&notificationType=');
        } else {
          // Handle API error
          debugPrint(
              'Failed to update notification. Status Code: ${response.statusCode}');
        }
      } catch (error) {
        // Handle network or other errors
        debugPrint('Error: $error');
      }
    }
  }
  // Future<bool> OnOffNotificationForReminders(bool oxValue) async {
  //   final Map<String, dynamic> requestData = {
  //     "value": oxValue,
  //   };
  //   String? token = await AuthRepo.getToken();
  //   if (token != null) {
  //     // debugPrint("Token: $token");
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
  //     };
  //     try {
  //       final response = await http.post(
  //           Uri.parse('${API.server}/notification/update-toggle-notification-type?notificationOn=true&notificationType=Snacks'),
  //           body: jsonEncode({
  //             "value": oxValue,
  //           }),
  //           headers: headers);

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         // debugPrint('data is response ${response.body}');

  //         return true;
  //       } else {
  //         // debugPrint('data is response not success ${response.body}');
  //         return false;
  //       }
  //     } catch (error) {
  //       return false;
  //     }
  //   } else {
  //     // debugPrint("Token not found.");
  //     return false;
  //   }
  // }

  // Assuming that getNotificationSheduledData is a method in your UserProfileController class

  Future<Map<String, dynamic>> getWeightGoal() async {
    String? token = await AuthRepo
        .getToken(); // Assuming AuthRepo is where you manage authentication tokens

    final headers = {
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Correcting header to 'Authorization'
    };

    try {
      final response = await http.get(
        Uri.parse(
            '${API.server}/api/all-target/get-weight-goal'), // Your API endpoint
        headers: headers,
      );

      if (response.statusCode == 200) {
        // Parse JSON response
        Map<String, dynamic> data = json.decode(response.body);

        String weightGoal = data['weightGoal'];
        double weightChange = data['weightChange'];

        debugPrint("Weight goal retrieved successfully: $weightGoal");
        debugPrint("Weight change: $weightChange");

        return data; // Returning the parsed data
      } else {
        debugPrint(
            "Failed to retrieve weight goal: ${response.statusCode}, ${response.body}");
        throw Exception('Failed to retrieve weight goal');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception('Failed to retrieve weight goal');
    }
  }

  // Future<void> SetWeightGoal(String weightGoal, double weightChange) async {
  //   String? token = await AuthRepo
  //       .getToken(); // Assuming AuthRepo is where you manage authentication tokens

  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Auth': 'Bearer $token', // Using 'Authorization' header with the token
  //   };

  //   final body = json.encode({
  //     'weightGoal': weightGoal,
  //     'weightChange': weightChange,
  //   });

  //   try {
  //     final response = await http.put(
  //       Uri.parse(
  //           '${API.server}/api/all-target/weight-goal'), // Assuming you're interacting with a local server
  //       headers: headers,
  //       body: body,
  //     );

  //     if (response.statusCode == 201) {
  //       debugPrint("Weight goal updated suvfdhfgccessfully: ${response.body}");
  //     } else {
  //       debugPrint(
  //           "Failed to update weight ggghjghjkoal: ${response.statusCode}, ${response.body}");
  //       //  throw Exception('Failed to update wejhkkhkight goal');
  //     }
  //   } catch (e) {
  //     debugPrint("Errokhjkjkhjkr: $e");

  //     // throw Exception('Failed to update weight goal');
  //   }
  // }

  Future<bool> SetWeightGoal(String weightGoal, double weightChange) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Using 'Auth' header with the token
    };

    final body = json.encode({
      'weightGoal': weightGoal,
      'weightChange': weightChange,
    });

    try {
      final response = await http.put(
        Uri.parse('${API.server}/api/all-target/weight-goal'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        debugPrint("Weight goal updated successfully: ${response.body}");
        return true; // Return true on successful API call
      } else {
        debugPrint(
            "Failed to update weight goal: ${response.statusCode}, ${response.body}");
        return false; // Return false on failed API call
      }
    } catch (e) {
      debugPrint("Error: $e");
      return false; // Return false if an exception is thrown
    }
  }

  Future<List<Map<String, dynamic>>> WeightDateRange(
      String startDate, String endDate) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Corrected from 'Auth' to 'Authorization'
    };
    debugPrint(
        "/api/weight-manager/get-weight-by-custom-range?startDate=$startDate&endDate=$endDate");
    try {
      final response = await http.get(
        Uri.parse(
            '${API.server}/api/weight-manager/get-weight-by-custom-range?startDate=$startDate&endDate=$endDate'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint(
            "Data is here after succeshgjhbgfhffgjgjsful fetch: ${response.body}");
        List<dynamic> responseData = json.decode(response.body);
        List<Map<String, dynamic>> activities =
            List<Map<String, dynamic>>.from(responseData);
        return activities;
      } else {
        debugPrint("Failed to load gdhyhjjjjhgjgjhgghjghjk: ${response.body}");
        throw Exception('Failed to load notification data');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception('Failed to load notification data');
    }
  }

  Future<List<Map<String, dynamic>>> getCsvData(
      String startDate, String endDate) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Corrected from 'Auth' to 'Authorization'
    };

    try {
      final response = await http.get(
        Uri.parse(
            '${API.server}/activities/get-steps/custom-range?startDate=$startDate&endDate=$endDate'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint("Data is here after successful fetch: ${response.body}");
        List<dynamic> responseData = json.decode(response.body);
        List<Map<String, dynamic>> activities =
            List<Map<String, dynamic>>.from(responseData);
        return activities;
      } else {
        debugPrint("Failed to load data: ${response.body}");
        throw Exception('Failed to load notification data');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception('Failed to load notification data');
    }
  }

  Future<List<Map<String, dynamic>>> GetWaterGraph(
      String startDate, String endDate) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Corrected from 'Auth' to 'Authorization'
    };

    try {
      final response = await http.get(
        Uri.parse(
            '${API.server}/api/water/get-water/custom-range?startDate=$startDate&endDate=$endDate'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint("Data is here after successful fetch: ${response.body}");
        List<dynamic> responseData = json.decode(response.body);
        List<Map<String, dynamic>> activities =
            List<Map<String, dynamic>>.from(responseData);
        return activities;
      } else {
        debugPrint("Failed to load data: ${response.body}");
        throw Exception('Failed to load notification data');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception('Failed to load notification data');
    }
  }

//get calories data
  Future<List<Map<String, dynamic>>> getCaloriesbargraph(
      String startDate, String endDate) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Corrected from 'Auth' to 'Authorization'
    };

    try {
      final response = await http.get(
        Uri.parse(
            '${API.server}/activities/get-calories/custom-range?startDate=$startDate&endDate=$endDate'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint("Data is here after successful fetch: ${response.body}");
        List<dynamic> responseData = json.decode(response.body);
        List<Map<String, dynamic>> activities =
            List<Map<String, dynamic>>.from(responseData);
        return activities;
      } else {
        debugPrint("Failed to load data: ${response.body}");
        throw Exception('Failed to load notification data');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception('Failed to load notification data');
    }
  }

  //get calories data
  Future<List<Map<String, dynamic>>> getSleepbargraph(
      String startDate, String endDate) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Corrected from 'Auth' to 'Authorization'
    };

    try {
      final response = await http.get(
        Uri.parse(
            '${API.server}/api/sleep-logs/get-sleep-duration/custom-range?startDate=$startDate&endDate=$endDate'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint("Data is here after successfuhfghjfgjl fetch: ${response.body}");
        List<dynamic> responseData = json.decode(response.body);
        List<Map<String, dynamic>> activities =
            List<Map<String, dynamic>>.from(responseData);
        return activities;
      } else {
        debugPrint("Failed to load ngjfjmkghk,mghdata: ${response.body}");
        throw Exception('Failed to load notification data');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception('Failed to lodgdfhbfhfad notification data');
    }
  }

  Future<Map<String, dynamic>> getWaistCircumference() async {
    String? token = await AuthRepo
        .getToken(); // Assuming you have a method to get the token

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final response = await http.get(
      Uri.parse('${API.server}/api/waist-circumference/$formattedDate'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      debugPrint("Response: ${response.body}");
      // Parse the response body into a Map<String, dynamic>
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      debugPrint("Failed with status code: ${response.statusCode}");
      throw Exception('Failed to retrieve waist circumference data');
    }
  }

  // Future<double> getWaistCircumference() async {
  //   String? token = await AuthRepo
  //       .getToken(); // Assuming you have a method to get the token

  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Auth': 'Bearer $token',
  //   };

  //   DateTime now = DateTime.now();
  //   String formattedDate = DateFormat('yyyy-MM-dd').format(now);

  //   final response = await http.get(
  //     Uri.parse('${API.server}/api/waist-circumference/$formattedDate'),
  //     headers: headers,
  //   );

  //   if (response.statusCode == 200) {
  //     debugPrint("Responsdfe: ${response.body}");
  //     // Assuming your response body contains a single double value
  //     return double.parse(response.body);
  //   } else {
  //     debugPrint("Failed with status code: ${response.statusCode}");
  //     throw Exception('Failed to retrieve waist circumference data');
  //   }
  // }

  Future<Map<String, dynamic>> sendWaistCircumference(
      double waistCircumference) async {
    String? token = await AuthRepo
        .getToken(); // Assuming you have a method to get the token

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse(
          '${API.server}/api/waist-circumference?waistCircumference=$waistCircumference'),
      headers: headers,
    );

    if (response.statusCode == 201) {
      debugPrint("Responsfdge: ${response.body}");
      return jsonDecode(response.body);
    } else {
      debugPrint("Failed with status code: ${response.statusCode}");
      throw Exception('Failed to perform waist circumference measurement');
    }
  }

  // Future<Map<String, dynamic>> getHipCircumference() async {
  //   String? token = await AuthRepo
  //       .getToken(); // Assuming you have a method to get the token

  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Auth': 'Bearer $token',
  //   };
  //   DateTime now = DateTime.now();
  //   String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  //   final response = await http.get(
  //     Uri.parse('${API.server}/api/hip-circumference/$formattedDate'),
  //     headers: headers,
  //   );

  //   if (response.statusCode == 200) {
  //     debugPrint("Respofdgdnse: ${response.body}");
  //     return jsonDecode(response.body);
  //   } else {
  //     debugPrint("Failed with status code: ${response.statusCode}");
  //     throw Exception('Failed to retrieve hip circumference data');
  //   }
  // }

  Future<Map<String, dynamic>> getHipCircumference() async {
    String? token = await AuthRepo
        .getToken(); // Assuming you have a method to get the token

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final response = await http.get(
      Uri.parse('${API.server}/api/hip-circumference/$formattedDate'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      debugPrint("Respohgjhgnse: ${response.body}");
      // Parse the response body into a Map<String, dynamic>
      final responseData = json.decode(response.body);
      return responseData;
    } else {
      debugPrint("Failed with status code: ${response.statusCode}");
      throw Exception('Failed to retrieve waist circumference data');
    }
  }

  Future<Map<String, dynamic>> hipcircumferenceCircumference(double hip) async {
    String? token = await AuthRepo
        .getToken(); // Assuming you have a method to get the token

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse('${API.server}/api/hip-circumference?hipCircumference=$hip'),
      headers: headers,
    );

    if (response.statusCode == 201) {
      debugPrint("Responsfdge: ${response.body}");
      return jsonDecode(response.body);
    } else {
      debugPrint("Failed with status code: ${response.statusCode}");
      throw Exception('Failed to perform waist circumference measurement');
    }
  }

//get calories data
  Future<List<Map<String, dynamic>>> getHeartbargraph(
      String startDate, String endDate) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Corrected from 'Auth' to 'Authorization'
    };

    try {
      final response = await http.get(
        Uri.parse(
            '${API.server}/api/heart-rates/get-heart-rate/custom-range?startDate=$startDate&endDate=$endDate'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint("Data is here after successful fetch: ${response.body}");
        List<dynamic> responseData = json.decode(response.body);
        List<Map<String, dynamic>> activities =
            List<Map<String, dynamic>>.from(responseData);
        return activities;
      } else {
        debugPrint("Failed to load data: ${response.body}");
        throw Exception('Failed to load notification data');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception('Failed to load notification data');
    }
  }

  Future<void> saveOrUpdateWorkLevel(String workLevel) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    // final Map<String, dynamic> body = {
    //   'workLevel': workLevel,
    // };

    try {
      final response = await http.post(
        Uri.parse(
            '${API.server}/api/profile/save-update-work-level?workLevel=$workLevel'),
        headers: headers,
        // body: json.encode(body),
      );

      if (response.statusCode == 200) {
        debugPrint('Work level updabgnghnted successfully');
      } else {
        debugPrint('Failed to updatem,mn, work level: ${response.body}');
        throw Exception('Failed to update work level');
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception('Failed to update work level');
    }
  }

//get all calories burn in detail

  Future<List<Map<String, dynamic>>> getExercisesByDate(String date) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse('${API.server}/api/exercises/getByDate?date=$date'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint("Data is here after successful fetch: ${response.body}");
        List<dynamic> responseData = json.decode(response.body);
        List<Map<String, dynamic>> exercises =
            List<Map<String, dynamic>>.from(responseData);
        return exercises;
      } else {
        debugPrint("Failed to load data: ${response.body}");
        throw Exception('Failed to load exercise data');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception('Failed to load exercise data');
    }
  }

  Future<void> deleteExercise(String exerciseId) async {
    // Define the URL
    final url = Uri.parse('${API.server}/api/exercises/delete/$exerciseId');
    String? token = await AuthRepo.getToken();
    // Define the headers
    final headers = {
      'Content-Type': 'application/json',
      'Auth': 'Bearer $token',
    };

    try {
      // Send the DELETE request
      final response = await http.delete(url, headers: headers);

      // Check the status code of the response
      if (response.statusCode == 200) {
        debugPrint('Exercise with ID $exerciseId deleted successfully.');
      } else {
        debugPrint(
            'Failed to delete exercise with ID $exerciseId. Status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error occurred while deleting exercise: $e');
    }
  }

  Future<EarForUser> getProfileEar() async {
    String? token = await AuthRepo.getToken();
    // return EarForUser.fromJson({
    //   "gender": "Male",
    //   "age": "above 60 years",
    //   "group": "Men",
    //   "workLevel": "NoLeavel",
    //   "energy": 1700.0,
    //   "protein": 43.0,
    //   "fatsOilsVisible": 0.2,
    //   "fiber": 0.0,
    //   "calcium": 1000.0,
    //   "magnesium": 370.0,
    //   "iron": 11.0,
    //   "zinc": 14.0,
    //   "thiamine": 1.2,
    //   "riboflavin": 1.6,
    //   "niacin": 12.0,
    //   "folate": 400.0, // Random value
    //   "vitA": 900.0, // Random value
    //   "iodine": 150.0, // Random value
    //   "vitB12": 2.4, // Random value
    //   "vitC": 90.0, // Random value
    //   "carbohydrate": 300.0, // Random value
    // });

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };
    try {
      final response = await http.get(
        Uri.parse('${API.server}/api/profile/ear'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint("Data is here after successfgfrgrdul fetch: ${response.body}");
        return EarForUser.fromJson(json.decode(response.body));
      } else {
        debugPrint("Failed to lohythytjuad data: ${response.body}");
        throw Exception('Failed to load profile data');
      }
    } catch (e) {
      debugPrint("ghghghg: $e");
      throw Exception('Failed to load ear data');
    }
  }

  //notifiacation list
  Future<List<Map<String, dynamic>>> GetNotificationList() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse(
            '${API.server}/notification/get-user-send-success-notifications'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        debugPrint("dtaa getting succeslfmkfhlyhygj ${response.body}");
        return jsonData.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception('Failed to load notification data');
    }
  }

  Future<String> fetchEndTimeByDate(String date) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    final uri = Uri.parse('${API.server}/api/exercises/byDateRange?date=$date');

    try {
      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('lastExercise') &&
            responseBody['lastExercise'] is Map<String, dynamic> &&
            responseBody['lastExercise'].containsKey('endTime')) {
          String endTime = responseBody['lastExercise']['endTime'];
          debugPrint('End Time: $endTime');
          return endTime;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to fetch exercise data');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception('Failed to fetch exercise data');
    }
  }

  Future<void> deleteAllNotifications() async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    try {
      final response = await http.delete(
        Uri.parse('${API.server}/notification/deleteAll-notify'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint('All notifications deleted successfully');
      } else {
        throw Exception('Failed to delete notifications');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception('Failed to delete notifications');
    }
  }

  //  Future<List<Map<String, dynamic>>> fetchData() async {
  //   final response = await http.get(apiUrl);

  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonData = json.decode(response.body);
  //     return jsonData.cast<Map<String, dynamic>>();
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  Future<Map<String, dynamic>> GetCaloriesEarned(String date) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Corrected from 'Auth' to 'Authorization'
    };

    try {
      final response = await http.get(
        Uri.parse('${API.server}/ingredient/get-calories-with-date?date=$date'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        // List<dynamic> jsonData = json.decode(response.body);
        debugPrint("dtaa getting succesdfdlfmkfhlyhygj ${response.body}");
        //update dta a
        final data1 = json.decode(response.body);
        fitnessData.data['Evening'] =
            (data1['Evening'] == null) ? 0.0 : data1['Evening'];
        fitnessData.data['Breakfast'] =
            (data1['Breakfast'] == null) ? 0.0 : data1['Breakfast'];
        fitnessData.data['Dinner'] =
            (data1['Dinner'] == null) ? 0.0 : data1['Dinner'];
        fitnessData.data['Lunch'] =
            (data1['Lunch'] == null) ? 0.0 : data1['Lunch'];
        fitnessData.data['Mid Morning'] =
            (data1['Mid Morning'] == null) ? 0.0 : data1['Mid Morning'];

        debugPrint("dtaa getting succesdfdlfmkfhlyhygj ${response.body}");
        fitnessData.data['Early Morning'] =
            (data1['Early Morning'] == null) ? 0.0 : data1['Early Morning'];
        fitnessData.data['Bed Time'] =
            (data1['Bed Time'] == null) ? 0.0 : data1['Bed Time'];
        //        'Breakfast': 0,
        // 'Dinner': 0,
        // 'Snacks': 0,
        // 'Lunch': 0,
        // 'Early Morning': 0,
        // 'Mid Morning': 0,
        // 'Evening': 0,
        // 'Bed Time': 0,
        return json.decode(response.body);
      } else {
        throw Exception('gdfggf to load data');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception('Failed to loadhfhfhfh notification data');
    }
  }

  Future<List<String>> getAllOccupations() async {
    try {
      String? token = await AuthRepo.getToken();

      if (token != null) {
        final headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Auth':
              'Bearer $token', // Ensure this matches the expected header for your API
        };

        final response = await http.get(
          Uri.parse('${API.server}/api/activity-types/get-all-occupations'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final List<dynamic> responseData = json.decode(response.body);
          final List<String> occupationData = List<String>.from(responseData);
          return occupationData;
        } else {
          throw Exception('Failed to fetch occupation data');
        }
      } else {
        throw Exception('Failed to fetch token');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<void> sendMissingMessage(String missingMessage) async {
    try {
      String? token = await AuthRepo.getToken();

      if (token != null) {
        final headers = {
          'Content-Type': 'application/json',
          'Auth':
              'Bearer $token', // Ensure this matches the expected header for your API
        };

        // final data = {
        //   'missingMessage': missingMessage,
        // };

        final response = await http.post(
          Uri.parse(
              '${API.server}/foods/missing-messages?requestData=missing ingredient = $missingMessage'),
          headers: headers,
          // body: json.encode(data),
        );

        if (response.statusCode == 201) {
          debugPrint('Message sent successfully');
        } else {
          throw Exception('Failed to send message: ${response.statusCode}');
        }
      } else {
        throw Exception('Failed to fetch token');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<bool> saveWorkLevelOccupation(String occupation) async {
    try {
      String? token = await AuthRepo.getToken();

      if (token != null) {
        final headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Auth': 'Bearer $token',
        };

        final Map<String, dynamic> data = {
          'occupation': occupation,
        };

        final response = await http.post(
          Uri.parse(
              '${API.server}/api/activity-types/save-workLevel-occupation'),
          headers: headers,
          body: json.encode(data),
        );

        if (response.statusCode == 200) {
          debugPrint(
              'Failed to save ohgjgjhgkhjccupation $occupation data: ${response.body}');
          // Assuming a 200 OK status means success
          return true;
        } else {
          debugPrint('Failed to save occupation data: ${response.body}');
          return false;
        }
      } else {
        throw Exception('Failed to fetch token');
      }
    } catch (error) {
      debugPrint('Error saving occupation data: $error');
      return false;
    }
  }

  //excersie api
  Future<List<Map<String, dynamic>>> getExerciseByDateAndActivityType(
      String date, String activityType) async {
    switch (activityType) {
      case "Running (12 km/hr)":
        activityType = "Running(12 km per hr)";
      case "Running (10 km/hr)":
        activityType = "Running(10 km per hr)";
      case "Running (8 km/hr)":
        activityType = "Running(8 km per hr)";
      case "Running (6 km/hr)":
        activityType = "Running(6 km per hr)";
      default:
        activityType = activityType;
    }
    try {
      String? token = await AuthRepo.getToken();

      if (token != null) {
        final headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Auth': 'Bearer $token',
        };
        debugPrint(
            "  erfggrt '${API.server}/api/exercises/getByDateAndActivityType?date=$date&activityType=$activityType'");
        final response = await http.get(
          Uri.parse(
              '${API.server}/api/exercises/getByDateAndActivityType?date=$date&activityType=$activityType'),
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final List<dynamic> responseData = json.decode(response.body);
          final List<Map<String, dynamic>> exerciseData = responseData
              .map((exercise) => Map<String, dynamic>.from(exercise))
              .toList();
          return exerciseData;
        } else {
          throw Exception('Failed to fetch exercise data');
        }
      } else {
        throw Exception('Failed to fetch token');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

//get all calories burn in detail
  Future<void> addExercise(
    String activityType,
    String startTime,
    String endTime,
    double duration,
    String Date,
  ) async {
    try {
      String? token = await AuthRepo.getToken();

      await Future.delayed(const Duration(seconds: 5));
      debugPrint("fvbfgbgh $Date");
      if (token != null) {
        final headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Auth': 'Bearer $token',
        };

        debugPrint(
            "data is here  cfdsfddfgfdhhfghfg  /api/exercises/add?activityType=$activityType&startTime=$startTime&endTime=$endTime&duration=$duration&exerciseDate=$Date");
        setLoading(true);
        final response = await http.post(
          Uri.parse(
              '${API.server}/api/exercises/add?activityType=$activityType&startTime=$startTime&endTime=$endTime&duration=$duration&exerciseDate=$Date'),
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          setLoading(false);
          setCheckModalBoolSuccess(true);
          debugPrint('Exercise added cfdsfdfgsuccessfully${response.body}');
        } else {
          setLoading(false);
          _SetmodalUpdate(true, "Something wrong : ${response.body}");
        }
      } else {
        setLoading(false);
        _SetmodalUpdate(true, "Something Wrong : $e");
        //  throw Exception('Failed to fetch token');
      }
    } catch (e) {
      setLoading(false);
      _SetmodalUpdate(true, "Something Wrong : $e");
      debugPrint("Error during API call: $e");
      // You can handle specific actions on different errors here if needed
    }
  }

  //add new ingredients

  Future<void> addUserRowIngredient(Map<String, dynamic> data) async {
    debugPrint("Failed to add fdgbfhfghg: $data");
    String? token = await AuthRepo
        .getToken(); // Assuming you have a method to get the token

    final headers = {
      'Content-Type': 'application/json',
      'Auth': 'Bearer $token', // Corrected from 'Auth' to 'Authorization'
    };

    try {
      final response = await http.post(
        Uri.parse('${API.server}/api/food/add-userRow-Ingredient'),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        debugPrint("Data added successfully: ${response.body}");
      } else {
        debugPrint("Failed to add data: ${response.body}");
        throw Exception('Failed to add data');
      }
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception('Failed to add data');
    }
  }
}
