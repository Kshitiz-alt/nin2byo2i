//class for user profile
class UserProfile {
  final String firstName;
  final String lastName;

  final String mobile;
  final double weight;
  final String email;
  final int heightFt;
  final int heightIn;
  final double bmi;
  final double bmr;
  final double age;
  final String Dob;
  final String gender;
  final String googlelink, facebooklink, linkdinlink, twitterlink;
  final String ioslink, androidLink, messageOfLink, workLevel, wakeupTime;

  UserProfile(
      {required this.firstName,
      required this.lastName,
      required this.mobile,
      required this.weight,
      required this.email,
      required this.heightFt,
      required this.heightIn,
      required this.bmi,
      required this.bmr,
      required this.age,
      required this.Dob,
      required this.gender,
      required this.facebooklink,
      required this.googlelink,
      required this.linkdinlink,
      required this.twitterlink,
      required this.ioslink,
      required this.androidLink,
      // required this.occupation,
      required this.workLevel,
      required this.messageOfLink,
      required this.wakeupTime});
}
