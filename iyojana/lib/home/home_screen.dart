import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iyojana/bottom_tab_nav.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const routeName = 'home-screen';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("HOME LMAO")),
      bottomNavigationBar: BasicBottomNavBar(),
    );
  }
}
