import 'package:flutter/material.dart';
import 'package:iyojana/auth/auth_dashboard.dart';
import 'package:iyojana/auth/login_screen.dart';
import 'package:iyojana/auth/register_screen.dart';
import 'package:iyojana/auth/set_tags_screen.dart';
import 'package:iyojana/bottom_tab_nav.dart';
import 'package:iyojana/chat/chat_screen.dart';
import 'package:iyojana/dashboard/dashboard.dart';
import 'package:iyojana/home/home_screen.dart';
import 'package:iyojana/language_constants.dart';
import 'package:iyojana/scheme/scheme.dart';
import 'package:iyojana/scheme/scheme_category.dart';
import 'package:iyojana/scheme/scheme_category_detail_screen.dart';
import 'package:iyojana/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'auth/form_provider.dart';
import 'auth/otp_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      title: 'iYojna App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MultiProvider(providers: [
        Provider<FormProvider>(
          create: (_) => FormProvider(),
        )
      ], child: BasicBottomNavBar() //BasicBottomNavBar() //SplashScreen()//SplashScreen()//OTPScreen()
      ),
      // home: SchemeCategoryDetailPage(category: temp),
      routes: {
        AuthDashboard.routeName: (context) => AuthDashboard(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) =>
            ChangeNotifierProvider<FormProvider>(
                create: (_) => FormProvider(), child: RegisterScreen()),
        SetTagsScreen.routeName: (context) => SetTagsScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
