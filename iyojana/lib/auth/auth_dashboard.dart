import 'package:flutter/material.dart';
import 'package:iyojana/auth/login_screen.dart';
import 'package:iyojana/auth/register_screen.dart';
import 'package:iyojana/auth/widgets/custom_elevated_button.dart';
import 'package:iyojana/auth/widgets/language_dropdown.dart';
import 'package:iyojana/bottom_tab_nav.dart';

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
        actions: <Widget>[languageDropdown(context)],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('./assets/authpage_icon.png'),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                    child: Text(
                      translation(context).authDashboardTitle,
                      style: Styles().heading1(),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: customElevatedButton(
                          context: context,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RegisterScreen.routeName);
                          },
                          content: translation(context).signUp,
                          style: Styles().buttonStyle1())),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: customElevatedButton(
                        context: context,
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        content: translation(context).login,
                        style: Styles().buttonStyle2()),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customElevatedButton(
                          context: context,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> BasicBottomNavBar()));
                          },
                          content: "SKIP",
                          style: Styles().buttonStyle2()),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
