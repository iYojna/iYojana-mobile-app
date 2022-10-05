import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('./assets/splash_icon.png'),
            Text("iYojna", style: GoogleFonts.inter(
              textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ))
          ]
        ),
      ),
    );
  }
}