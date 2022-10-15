import 'package:flutter/material.dart';
import 'package:iyojana/auth/login_screen.dart';
import 'package:iyojana/auth/register_screen.dart';
import 'package:iyojana/auth/widgets/custom_elevated_button.dart';
import 'package:iyojana/auth/widgets/language_dropdown.dart';

import '../language.dart';
import '../language_constants.dart';
import '../main.dart';
import '../styles.dart';

class AuthDashboard extends StatefulWidget {
  const AuthDashboard({Key? key}) : super(key: key);
  static const routeName = 'authdashboard';
  @override
  State<AuthDashboard> createState() => _AuthDashboardState();
}

class _AuthDashboardState extends State<AuthDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          languageDropdown(context)
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('./assets/authpage_icon.png'),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      translation(context).authDashboardTitle,
                      style: Styles().heading1(),
                    ),
                  )
                ],
              ),
              customElevatedButton(context: context, onPressed: (){
                //print("Lol");
                Navigator.pushNamed(context, RegisterScreen.routeName);
              }, content: "Sign Up", style: Styles().buttonStyle1()),
              // SizedBox(
              //   height: 50,
              //   width: double.infinity,
              //   child: ElevatedButton(
              //       style: ButtonStyle(
              //         elevation: MaterialStateProperty.all(0),
              //       ),
              //       onPressed: () {
              //         Navigator.pushNamed(context, RegisterScreen.routeName);
              //       },
              //       child: Text("Sign Up")),
              // ),
              const SizedBox(
                height: 10,
              ),
              // SizedBox(
              //     height: 50,
              //     width: double.infinity,
              //     child: ElevatedButton(
              //       onPressed: () {
              //         Navigator.pushNamed(
              //             context, LoginScreen.routeName);
              //       },
              //       style: ButtonStyle(
              //           elevation: MaterialStateProperty.all(0),
              //           backgroundColor: MaterialStateProperty.all<Color>(
              //               Color.fromARGB(255, 214, 214, 214)),
              //           foregroundColor:
              //               MaterialStateProperty.all<Color>(Colors.green)),
              //       child: const Text("Login"),
              //     )),
              customElevatedButton(context: context, onPressed: (){
                Navigator.pushNamed(
                          context, LoginScreen.routeName);
              }, content: "Login", style: Styles().buttonStyle2())
            ],
          ),
        ),
      ),
    );
  }
}
