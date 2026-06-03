import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Help%20Supports/contactus2.dart';
import 'package:nin2byo2i/Providers/auth_provider.dart';
import 'package:nin2byo2i/common_widget/SuccessAlertBox.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/custom_textfield.dart';
import 'package:nin2byo2i/screens/SignIn/create_account.dart';
import 'package:nin2byo2i/view/home/GuestLogine.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//login page
class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email, _password;
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadinitialdata();
  }

  bool balckthemeeon = true;
  Future<void> loadinitialdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isBlackTheme = prefs.getBool('isBlackTheme');

    setState(() {
      if (isBlackTheme == true) {
        balckthemeeon = true;
      }
    });
  }

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.themeColor,
      body: SafeArea(
        child: Consumer<AuthProviderNin>(builder: (context, authProvider, _) {
          return Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Text(
                        //         "Try Dark Mode",
                        //         style: TextStyle(
                        //           color: ThemeManager.themeText,
                        //         ),
                        //       ),
                        //       Switch(
                        //         value: balckthemeeon,
                        //         onChanged: (value) {
                        //           setState(() {
                        //             balckthemeeon = value;
                        //             // if (balckthemeeon==true) {

                        //             // }
                        //             ThemeManager.blackTheme = balckthemeeon;
                        //           });
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Text(
                          'Hey there,',
                          style: TextStyle(
                            color: ThemeManager.themeText,
                            fontSize: AppFontSizes.mediumDefault,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Welcome Back',
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
                            _email = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is Required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        // CustomTextField(
                        //   label: 'Password',
                        //   icon: Icons.lock_outline_rounded,
                        //   keyboardType: TextInputType.visiblePassword,
                        //   isobscureText: true,
                        //   onProgress: (String value) {
                        //     _password = value;
                        //   },
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Password is Required';
                        //     }
                        //     return null;
                        //   },
                        // ),
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
                              _password = value;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscureText,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is Required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'Forgot your password?',
                          style: TextStyle(
                            color: Color(0xFFACA3A5),
                            fontSize: AppFontSizes.smallDefault,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4 - 100,
                        ),
                        // InkWell(
                        //   onTap: () async {
                        //     try {
                        //       final formKeyState = _formKey.currentState!;

                        //       if (formKeyState.validate()) {
                        //         final authProvider = Provider.of<AuthProvider>(
                        //             context,
                        //             listen: false);
                        //         authProvider.setEmail(_email);
                        //         authProvider.setPassword(_password);
                        //         await authProvider.signInwithEmailPassword();
                        //         if (!mounted) {
                        //           return;
                        //         }
                        //         Navigator.pushNamed(context, '/root');
                        //       }
                        //     } catch (e) {
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //           SnackBar(content: Text(e.toString())));
                        //     }
                        //     // Navigator.pushNamedAndRemoveUntil(
                        //     //     context, RootScreen.routeName, (route) => false);
                        //   },
                        //   child: const CustomButton(
                        //     text: 'Login',
                        //     isColored: true,
                        //   ),
                        // ),
                        SizedBox(
                          height: 55,
                          child: RoundButton(
                            title: "Login",
                            type: RoundButtonType.bgGradient,
                            fontSize: AppFontSizes.mediumDefault,
                            fontWeight: FontWeight.w400,
                            onPressed: () async {
                              try {
                                final formKeyState = _formKey.currentState!;

                                if (formKeyState.validate()) {
                                  final authProvider =
                                      Provider.of<AuthProviderNin>(context,
                                          listen: false);
                                  authProvider.setEmail(_email);
                                  authProvider.setPassword(_password);
                                  await authProvider.login();
                                  if (!mounted) {
                                    return;
                                  }
                                  Navigator.pushNamed(context, '/root');
                                }
                              } catch (e) {
                                String removeExceptionPrefix(
                                    String errorMessage) {
                                  const String prefix = "Exception: ";
                                  if (errorMessage.startsWith(prefix)) {
                                    return errorMessage
                                        .substring(prefix.length);
                                  }
                                  return errorMessage;
                                }

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomAlertWidget(
                                      title: 'Oops! Something went wrong ',
                                      description:
                                          removeExceptionPrefix(e.toString()),
                                      color: Colors.red,
                                    );
                                  },
                                );

                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(content: Text(e.toString())));
                              }
                              // Navigator.pushNamedAndRemoveUntil(
                              //     context, RootScreen.routeName, (route) => false);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        // InkWell(
                        //   onTap: () {

                        //   },
                        //   child: const CustomButton(
                        //     text: 'Login as Guest',
                        //     isColored: true,
                        //   ),
                        // ),
                        SizedBox(
                          height: 55,
                          child: RoundButton(
                            title: "Login as Guest",
                            type: RoundButtonType.bgGradient,
                            fontSize: AppFontSizes.mediumDefault,
                            fontWeight: FontWeight.w400,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GuestLoginPage()),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 55,
                          child: RoundButton(
                            title: "Register",
                            type: RoundButtonType.bgGradient,
                            fontSize: AppFontSizes.mediumDefault,
                            fontWeight: FontWeight.w400,
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, CreateAccount.routeName);
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
                          height: 20,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       InkWell(
                        //           onTap: () async {
                        //             try {
                        //               debugPrint("googlelog 1");
                        //               await Provider.of<AuthProviderNin>(
                        //                       context,
                        //                       listen: false)
                        //                   .signInWithGoogle();

                        //               if (!mounted) {
                        //                 return;
                        //               }
                        //               Navigator.pushNamed(context, '/root');
                        //             } catch (e) {
                        //               ScaffoldMessenger.of(context)
                        //                   .showSnackBar(SnackBar(
                        //                       backgroundColor: Colors.white,
                        //                       duration:
                        //                           Duration(milliseconds: 500),
                        //                       content: Text(e.toString())));
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
                        //   height: 20,
                        // ),
                        // Text.rich(
                        //   TextSpan(
                        //     children: [
                        //       TextSpan(
                        //         text: 'Don’t have an account yet ? ',
                        //         style: TextStyle(
                        //           color: ThemeManager.themeText,
                        //           fontSize: AppFontSizes.mediumDefault,
                        //           fontWeight: FontWeight.w600,
                        //         ),
                        //       ),
                        //       // const TextSpan(
                        //       //   text: ' ',
                        //       //   style: TextStyle(
                        //       //     color: Color(0xFF1D1517),
                        //       //     fontSize: AppFontSizes .mediumDefault,
                        //       //     fontWeight: FontWeight.w500,
                        //       //   ),
                        //       // ),
                        //       TextSpan(
                        //         text: 'Register',
                        //         style: const TextStyle(
                        //           color: Color(0xFF007BC1),
                        //           fontSize: AppFontSizes.mediumDefault,
                        //           fontWeight: FontWeight.w600,
                        //         ),
                        //         recognizer: TapGestureRecognizer()
                        //           ..onTap = () {
                        //             Navigator.pushReplacementNamed(
                        //                 context, CreateAccount.routeName);
                        //           },
                        //       ),
                        //     ],
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),

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
                              // const TextSpan(
                              //   text: ' ',
                              //   style: TextStyle(
                              //     color: Color(0xFF1D1517),
                              //     fontSize: AppFontSizes .mediumDefault,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (authProvider.isLoading)
                Positioned.fill(
                  child: Container(
                    color: ThemeManager.themeColor,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(TColor.primaryColor1),
                        strokeWidth: 4.0,
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
