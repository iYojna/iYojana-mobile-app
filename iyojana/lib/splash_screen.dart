import 'dart:async';
import "package:flutter/material.dart";
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iyojana/auth/auth_dashboard.dart';

import '../language.dart';
import '../language_constants.dart';
import '../main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 10),
        () => Navigator.of(context)
            .pushReplacementNamed(AuthDashboard.routeName));
    return Scaffold(
      body: Center(
          child: ShakeItem(
              shakeList: ShakeRotateConstant1(),
              duration: const Duration(seconds: 5))),
    );
  }
}

class ShakeItem extends StatelessWidget {
  final bool autoPlay;
  final Duration? duration;
  final ShakeConstant shakeList;
  const ShakeItem(
      {Key? key, required this.shakeList, this.autoPlay = true, this.duration})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    //TODO: Debug this
    return ShakeWidget(
      shakeConstant: shakeList,
      duration: duration,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('./assets/splash_icon.png'),
            Text(translation(context).iYojana,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w700),
                ))
          ]),
    );
  }
}
