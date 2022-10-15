import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static MaterialStateProperty buttonBackground1 =
      MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 214, 214, 214));
  static MaterialStateProperty materialGreen =
      MaterialStateProperty.all<Color>(Colors.green);

  TextStyle interFont({required fontWeight, required fontSize}) {
    return GoogleFonts.inter(
        textStyle: TextStyle(fontWeight: fontWeight, fontSize: fontSize));
  }

  TextStyle heading1() {
    return GoogleFonts.inter(
        textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 28));
  }

  TextStyle subTitle1() {
    return GoogleFonts.inter(
        textStyle: const TextStyle(
            fontWeight: FontWeight.w400, fontSize: 20, color: Colors.grey));
  }

  ButtonStyle buttonStyle1() {
    return ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.green))));
  }

  ButtonStyle buttonStyle2() {
    return ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.green))),
        backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 214, 214, 214)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.green));
  }

  InputDecoration inputDecoration1() {
    return InputDecoration(
        border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ));
  }
}
