import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:iyojana/auth/widgets/custom_elevated_button.dart';
import 'package:iyojana/styles.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          Stack(children: [
            Align(
                alignment: Alignment.topLeft,
                child: Image.asset("assets/otpBG.png")),
            Padding(
              padding: const EdgeInsets.only(top: 70.0, left: 25.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('OTP Verification',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold))),
            ),
            Padding(
              padding: EdgeInsets.only(top: 150.0),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset("assets/otpIMG.png")),
            )
          ]),
          SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
                "We will send one time password to the Linked Mobile Number",
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black),
                )),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text('(+91 91744 *****)',
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black),
              )),
          SizedBox(
            height: 20.0,
          ),
          OTPTextField(
            length: 4,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 40,
            style: TextStyle(fontSize: 14),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onCompleted: (pin) {
              print("Completed: " + pin);
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          customElevatedButton(
              context: context,
              onPressed: (value) {},
              content: "Submit",
              style: Styles().buttonStyle1())
        ],
      ),
    )));
  }
}
