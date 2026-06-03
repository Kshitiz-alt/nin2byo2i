import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nin2byo2i/Classes/FitnessData.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Language/localization/locale_constants.dart';
import 'package:nin2byo2i/Language/localization/localizations_delegate.dart';
// import 'package:nin2byo2i/NotificationServices/NotificationServices.dart';
import 'package:nin2byo2i/Providers/timer_provider.dart';

import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Repository/auth_repo.dart';
import 'package:nin2byo2i/routes.dart';
import 'package:nin2byo2i/splashscreen.dart';
import 'package:nin2byo2i/view/watch%20Integration/WatchApi.dart';
// import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';
import 'Providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'Providers/auth_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();

  // await Permission.activityRecognition.request();
  // await Permission.location.request();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // final AuthRepo _authRepo = AuthRepo();
  await AuthRepo.checkTokenExpired();
  runApp(
    MaterialApp(
      home: SplashScreen(), // Display the SplashScreen as the first screen
    ),
  );

  // Delay for 2 seconds to show the splash screen
  await Future.delayed(const Duration(seconds: 1));

  runApp(MyApp(
    token: prefs.getString('token'),
  ));
  // DependencyInjection.init();
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  final token;
  const MyApp({
    required this.token,
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String S = '';
  late Locale _locale = const Locale('en', '');
  void setLocale(Locale locale) {
    setState(() {
      getnewtoken();
      // debugPrint("dsgvbdddddddddddf 2 $locale");
      _locale = locale;
    });
  }

  void getnewtoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Use the late modifier to assign a value after initialization

    S = prefs.getString('token') ?? '';
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    loadtheme();
    super.initState();
  }

  Future<void> loadtheme() async {
    ThemeManager.loadThemePreference();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProviderNin(),
        ),
        ChangeNotifierProvider(
          create: (context) => TimerProvider(),
        ),
        ChangeNotifierProvider(create: (context) => UserProfileController()),
        ChangeNotifierProvider(create: (context) => WatchApiDataProvider()),
        ChangeNotifierProvider(create: (context) => FitnessData()),
      ],
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // FirebaseAuth.instance.signOut();
            String initialRoute;
            if ((widget.token == null)) {
              initialRoute = '/';
              if (S != '') {
                initialRoute = '/root';
                final apiDataProvider =
                    Provider.of<WatchApiDataProvider>(context, listen: false);

                // Call the API function during app startup
                // WidgetsBinding.instance!.addPostFrameCallback((_) {
                apiDataProvider.makeApiCalls();
              }
            } else if ((JwtDecoder.isExpired(widget.token) == false))
            // if (snapshot.data != null)

            {
              initialRoute = '/root';
              final apiDataProvider =
                  Provider.of<WatchApiDataProvider>(context, listen: false);

              // Call the API function during app startup
              // WidgetsBinding.instance!.addPostFrameCallback((_) {
              apiDataProvider.makeApiCalls();

              //context.read<AuthProvider>().user = snapshot.data!;
            } else {
              // debugPrint('token is herdfde ${widget.token}');
              initialRoute = '/';
              if (S != '') {
                initialRoute = '/root';
                final apiDataProvider =
                    Provider.of<WatchApiDataProvider>(context, listen: false);

                // Call the API function during app startup
                // WidgetsBinding.instance!.addPostFrameCallback((_) {
                apiDataProvider.makeApiCalls();
              }
            }

            return MaterialApp(
              initialRoute: initialRoute,
              routes: routes,
              locale: _locale,
              debugShowCheckedModeBanner: false,
              title: 'NIN 2.0',
              theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  fontFamily: 'Poppins'),
              supportedLocales: const [
                Locale('en', ''),
                Locale('hi', ''),
                Locale('ml', ''),
                Locale('mr', ''),
                Locale('te', ''), // Add 'te' for Telugu
                Locale('bn', ''), // Add 'bn' for Bengali
                Locale('ta', ''), // Add 'ta' for Tamil
                Locale('ur', ''), // Add 'ur' for Urdu
                Locale('gu', ''), // Add 'gu' for Gujarati
                Locale('kn', ''), // Add 'kn' for Kannada
                Locale('pa', ''), // Add 'pa' for Panjabi Punjabi
                Locale('or', ''), // Add 'or' for Oriya
                // Add other supported locales as needed
              ],
              localizationsDelegates: const [
                AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode &&
                      supportedLocale.countryCode == locale?.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
