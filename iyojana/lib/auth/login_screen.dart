import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iyojana/auth/widgets/custom_back_button.dart';
import 'package:iyojana/auth/widgets/custom_elevated_button.dart';
import 'package:iyojana/auth/widgets/language_dropdown.dart';
import 'package:iyojana/language_constants.dart';
import '../styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = "loginScreen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: customBackButton(context),
        actions: <Widget>[
          languageDropdown(context)
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(translation(context).welcomeBack,
                              style:Styles().heading1()),
                          Text(translation(context).loginSubtitle,
                              style: Styles().subTitle1()),
                        ]),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                  children: [
                  Image.asset('./assets/login.png'),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Enter Your Email Address",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w700,
                            fontSize: 17)),
                  ),
                  TextField(
                      decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(179, 208, 208, 208),
                    hintText: "Email"
                  )),
                  const SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(179, 208, 208, 208),
                    hintText: "Password"
                  ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  customElevatedButton(context: context, onPressed: (){}, content: "Login", style: Styles().buttonStyle1())
                  ],
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom : 10.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Sign Up',
                            style: const TextStyle(color: Colors.green),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                //TODO : Add Sign up screen route
                                print('Sign Up');
                              }),
                      ],
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
