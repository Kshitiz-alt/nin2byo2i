import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Help%20Supports/Poliices.dart';
import 'package:nin2byo2i/Help%20Supports/TermsAndCondition.dart';
import 'package:nin2byo2i/Help%20Supports/contactus2.dart';
import 'package:nin2byo2i/Providers/auth_provider.dart';
import 'package:nin2byo2i/common_widget/SuccessAlertBox.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/custom_textfield.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/screens/SignIn/login.dart';
import 'package:nin2byo2i/screens/SignIn/verification.dart';
import 'package:provider/provider.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//create a account page
class CreateAccount extends StatefulWidget {
  static const routeName = '/createaccount';
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  late String email, userName, password, phone;
  bool isChecked = false;
  bool isChecked2 = false;
  bool _isRegistering = false;
  late LocationData _currentLocation = LocationData.fromMap({
    "latitude": 0.0,
    "longitude": 0.0,
    // Add any other necessary properties here
  });
  bool _obscureText = true; // Initially obscure the text
  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      var location = Location();
      var currentLocation = await location.getLocation();
      setState(() {
        _currentLocation = currentLocation;
      });
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.themeColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<AuthProviderNin>(builder: (context, authProvider, _) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Hey there,',
                          style: TextStyle(
                            color: ThemeManager.themeText,
                            fontSize: AppFontSizes.mediumDefault,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Create an Account',
                          style: TextStyle(
                            color: ThemeManager.themeText,
                            fontSize: AppFontSizes.mediumDefault,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          label: 'Email',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          onProgress: (String value) {
                            email = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (!EmailValidator.validate(value.trim())) {
                              return 'Please enter valid Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField(
                          label: 'Create New UserName',
                          icon: Icons.person_2_outlined,
                          keyboardType: TextInputType.name,
                          onProgress: (String value) {
                            userName = value;
                          },
                          validator: (value) {
                            final RegExp usernameRegExp =
                                RegExp(r'^[A-Za-z0-9_]+$');
                            if (value == null || value.isEmpty) {
                              return 'UserName is required';
                            }
                            bool isValid =
                                usernameRegExp.hasMatch(value.trim());

                            if (!isValid) {
                              return 'Only letters, numbers, and _ are allowed.';
                            }
                            if (value.length < 4) {
                              return 'UserName must be at least 4 characters long';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: ThemeManager.themelightColor,
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: ThemeManager.themeText,
                                fontSize: AppFontSizes.smallDefault,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: ThemeManager.themeText,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: ThemeManager.themeText,
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(color: ThemeManager.themeText),
                            onChanged: (String value) {
                              password = value;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscureText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 10) {
                                return 'Password must be at least 10 characters long';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField(
                            label: 'Mobile Number',
                            icon: Icons.phone,
                            keyboardType: TextInputType.number,
                            onProgress: (String value) {
                              phone = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Phone Number is required';
                              } else if (value.length != 10) {
                                return 'Please enter a valid 10-digit Phone Number';
                              }

                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  if (value != null) {
                                    isChecked = value;
                                  }
                                });
                              },
                              activeColor: Colors.green, // Tick color
                              checkColor: Colors.white, // Check color
                              focusColor: Colors.blue, // Border color
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: ThemeManager.themeText, // Border color
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            Flexible(
                              // Wrap the Text widget with Flexible
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'By continuing you accept our',
                                      style: TextStyle(
                                        color: Color(0xFFACA3A5),
                                        fontSize: AppFontSizes.mediumDefault,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Term of Use',
                                      style: const TextStyle(
                                        color: Color(0xFFACA3A5),
                                        fontSize: AppFontSizes.mediumDefault,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TermsAndConditionsPage(),
                                            ),
                                          );
                                        },
                                    ),
                                    const TextSpan(
                                      text: ' and',
                                      style: TextStyle(
                                        color: Color(0xFFACA3A5),
                                        fontSize: AppFontSizes.mediumDefault,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Privacy Policy',
                                      style: const TextStyle(
                                        color: Color(0xFFACA3A5),
                                        fontSize: AppFontSizes.mediumDefault,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PrivacyPolicyPage(),
                                            ),
                                          );
                                        },
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked2,
                              onChanged: (value) {
                                setState(() {
                                  if (value != null) {
                                    isChecked2 = value;
                                  }
                                });
                              },
                              activeColor: Colors.green, // Tick color
                              checkColor: Colors.white, // Check color
                              focusColor: Colors.blue, // Border color
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.blue, // Border color
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            const Flexible(
                              // Wrap the Text widget with Flexible
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          ' Accept Recieve NewLetter Policies',
                                      style: TextStyle(
                                        color: Color(0xFFACA3A5),
                                        fontSize: AppFontSizes.mediumDefault,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        SizedBox(
                          height: 55,
                          child: RoundButton(
                            title: "Register",
                            type: RoundButtonType.bgGradient,
                            fontSize: AppFontSizes.mediumDefault,
                            fontWeight: FontWeight.w400,
                            onPressed: () async {
                              try {
                                if (_isRegistering) {
                                  // If registration is already in progress, do nothing

                                  return;
                                }
                                final formKeyState = _formKey.currentState!;

                                if (formKeyState.validate()) {
                                  if (!isChecked) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomAlertWidget(
                                          title: '',
                                          description:
                                              'please accept Privacy Policies ',
                                          color: Colors.red,
                                        );
                                      },
                                    );
                                    return;
                                  }
                                  setState(() {
                                    _isRegistering =
                                        true; // Set the flag to true before registration
                                  });

                                  final authProvider =
                                      Provider.of<AuthProviderNin>(context,
                                          listen: false);
                                  authProvider.setLoading(true);
                                  authProvider.setEmail(email);
                                  authProvider.setUserName(userName);
                                  authProvider.setPassword(password);
                                  authProvider.setPhoneNumber(phone);
                                  authProvider.setLongitude(
                                      _currentLocation.longitude.toString());
                                  authProvider.setLatitude(
                                      _currentLocation.latitude.toString());

                                  await Provider.of<AuthProviderNin>(context,
                                          listen: false)
                                      .register();
                                  // await authProvider.verifyPhoneNumber(phone);
                                  if (mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            VerificationScreen(email: email),
                                      ),
                                    );
                                  }
                                }
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomAlertWidget(
                                      title: 'Oops! Something went wrong',
                                      description: e.toString(),
                                      color: Colors.red,
                                    );
                                  },
                                );
                                // debugPrint(e.toString());
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(content: Text(e.toString())));
                              } finally {
                                setState(() {
                                  _isRegistering =
                                      false; // Reset the flag after registration
                                });
                                //  final authProvider =
                                //       Provider.of<AuthProviderNin>(context,
                                //           listen: false);
                                authProvider.setLoading(false);
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: ThemeManager.themeText,
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'or',
                                style: TextStyle(color: ThemeManager.themeText),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: ThemeManager.themeText,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       InkWell(
                        //           onTap: () async {
                        //             try {
                        //               await Provider.of<AuthProviderNin>(
                        //                       context,
                        //                       listen: false)
                        //                   .signInWithGoogle();

                        //               if (!mounted) {
                        //                 return;
                        //               }
                        //               Navigator.pushNamed(context, '/root');
                        //             } catch (e) {
                        //               debugPrint(e.toString());
                        //             }
                        //           },
                        //           child:
                        //               SocialLoginButton(path: Assets.google)),
                        //       InkWell(
                        //           onTap: () {},
                        //           child:
                        //               SocialLoginButton(path: Assets.linkedin)),
                        //       InkWell(
                        //           onTap: () {},
                        //           child:
                        //               SocialLoginButton(path: Assets.twitter)),
                        //       InkWell(
                        //           onTap: () {},
                        //           child:
                        //               SocialLoginButton(path: Assets.facebook))
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 12,
                        // ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account?',
                                style: TextStyle(
                                  color: ThemeManager.themeText,
                                  fontSize: AppFontSizes.mediumDefault,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: ThemeManager.themeText,
                                  fontSize: AppFontSizes.mediumDefault,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                  text: 'Login\n',
                                  style: const TextStyle(
                                    color: Color(0xFF007BC1),
                                    fontSize: AppFontSizes.mediumDefault,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacementNamed(
                                          context, LoginScreen.routeName);
                                    }),
                              TextSpan(
                                  text: 'Skip Registration',
                                  style: const TextStyle(
                                    color: Color(0xFF007BC1),
                                    fontSize: AppFontSizes.mediumDefault,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, '/root');
                                    }),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'For any query ? ',
                                style: TextStyle(
                                  color: ThemeManager.themeText,
                                  fontSize: AppFontSizes.mediumDefault,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: 'Contact us',
                                style: const TextStyle(
                                  color: Color(0xFF007BC1),
                                  fontSize: AppFontSizes.mediumDefault,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ContactUsPage2()));
                                  },
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        sizedBox30(),
                      ],
                    ),
                  ),
                ),
                if (authProvider.isLoading)
                  Positioned.fill(
                    child: Container(
                      color: ThemeManager.themeColor,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              TColor.primaryColor1),
                          strokeWidth: 4.0,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
