//user class use at the time of logine

class MyUser {
  final String userId;
  final String userName;
  final String token;
  final String Refreshtoken;

  MyUser(
      {required this.userId,
      required this.userName,
      required this.token,
      required this.Refreshtoken});

  factory MyUser.fromJson(Map<dynamic, dynamic> json) {
    return MyUser(
        userId: json['userId'],
        userName: json['username'],
        token: json['jwtToken'],
        Refreshtoken: json['refreshToken']);
  }
}
