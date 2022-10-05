import 'package:flutter/material.dart';
import 'package:iyojana/auth/auth_dashboard.dart';
import 'package:iyojana/auth/login_screen.dart';
import 'package:iyojana/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iYojna App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LoginScreen(),
      routes: {
        AuthDashboard.routeName : (context)=> AuthDashboard(),
        LoginScreen.routeName : (context)=> LoginScreen(),
      },
    );
  }
}

