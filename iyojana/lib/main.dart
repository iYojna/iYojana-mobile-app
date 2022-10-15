import 'package:flutter/material.dart';
import 'package:iyojana/auth/auth_dashboard.dart';
import 'package:iyojana/auth/login_screen.dart';
import 'package:iyojana/auth/register_screen.dart';
import 'package:iyojana/auth/set_tags_screen.dart';
import 'package:iyojana/home/home_screen.dart';
import 'package:iyojana/language_constants.dart';
import 'package:iyojana/scheme/scheme.dart';
import 'package:iyojana/scheme/scheme_category.dart';
import 'package:iyojana/scheme/scheme_category_detail_screen.dart';
import 'package:iyojana/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
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
  void didChangeDependencies() {
    
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }
  SchemeCategory temp = SchemeCategory(
    id: "1", 
    name: "Housing and Relocation", 
    schemes: [
      Scheme(
        id: "11",
        details: "LOL",
        name: "Scheme 1",
        posterUrl: "https://picsum.photos/250?image=9"
      ),
      Scheme(
        id: "12",
        details: "LOL",
        name: "Scheme 2",
        posterUrl: "https://picsum.photos/250?image=9"
      ),
      Scheme(
        id: "13",
        details: "LOL",
        name: "Scheme 3",
        posterUrl: "https://picsum.photos/250?image=9"
      )
    ],
    isFollwed: true, 
    description: "This contains the list of all the housing and Relocation Schemes offered by the Government of Gujrat . Write more details regarding the same"
  );
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
      home: SplashScreen(),
      // home: SchemeCategoryDetailPage(category: temp),
      routes: {
        AuthDashboard.routeName: (context) => AuthDashboard(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        SetTagsScreen.routeName: (context) => SetTagsScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        
      },
    );
  }
}
