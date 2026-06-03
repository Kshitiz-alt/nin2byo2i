
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static String ConnectedWatch = '';
  static const String _tokenKey = 'auth_token';
  static const String _idKey = 'auth_id';
  static const String _refreshTokenKey = 'auth_refreshToken';
  static const String _watchTypeKey = 'watch_type';

  // Save watch type to shared preferences
  static Future<void> saveWatchType(String watchType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_watchTypeKey, watchType);
  }

  // Retrieve watch type from shared preferences
  static Future<String?> getWatchType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_watchTypeKey);
  }

  // Remove watch type from shared preferences
  static Future<void> removeWatchType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_watchTypeKey);
  }

  // Save token to shared preferences
  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Retrieve token from shared preferences
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Remove token from shared preferences
  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Save ID to shared preferences
  static Future<void> saveId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_idKey, id);
  }

  // Retrieve ID from shared preferences
  static Future<String?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_idKey);
  }

  // Remove ID from shared preferences
  static Future<void> removeId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_idKey);
  }

  // Save refresh token to shared preferences
  static Future<void> saveRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  // Retrieve refresh token from shared preferences
  static Future<String?> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  // Remove refresh token from shared preferences
  static Future<void> removeRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_refreshTokenKey);
  }

  //check token expiry
  static Future<bool> isTokenExpired() async {
    final String? token = await getToken();
    if (token != null) {
      // debugPrint("token has contains get");
      try {
        // Retrieve the expiration time from the access token
        final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        final int? expirationTimestamp = decodedToken['exp'];

        if (expirationTimestamp == null) {
          // If the expiration time is not available, consider the token expired
          return true;
        }

        // Get the current time in seconds
        final int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

        // Check if the token has expired
        return expirationTimestamp < currentTime;
      } catch (e) {
        // Error decoding token or missing 'exp' field
        //debugPrint("token has contains get  exception $e");

        return true;
      }
    } else {
      // Token not found
      return true;
    }
  }
}
