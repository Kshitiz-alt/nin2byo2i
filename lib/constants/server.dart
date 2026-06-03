//server configuration
class API {
  //static const server = 'http://68.183.89.215:7073';
  static const server = 'https://apis.nutrifyindianow.in';
  // static const server = 'https://nin40-production.up.railway.app';
  static const register = '$server/register';
  static const login = '$server/auth/login';

  // static login(id) {zsssss
  //   return '$server/api'
  // }

  static Uri updateProfile(String id) {
    print('------------id---$id');
    return Uri.parse('$server/api/profile/createProfile/$id');
  }
}
