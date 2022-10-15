import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:iyojana/auth/set_tags_screen.dart';
import 'package:iyojana/auth/widgets/custom_dropdown.dart';
import 'package:iyojana/auth/widgets/custom_text_field.dart';
import 'package:iyojana/auth/widgets/registration_page1.dart';
import 'package:iyojana/auth/widgets/registration_page2.dart';
import 'package:iyojana/styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = 'register_screen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<Widget> pages = [RegistrationPage1(), RegistrationPage2()];
  late PageController _controller;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController(initialPage: 0);
    super.initState();
    //_controller =
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Colors.green : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        //physics: NeverScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset("assets/appBG.png")),
                    Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset("assets/registerimg.png")),
                    ),
                  ]),

                  Expanded(
                    child: PageView.builder(
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (value) {
                          setState(() {
                            currentIndex = value;
                          });
                        },
                        itemCount: pages.length,
                        itemBuilder: (context, index) {
                          // Contents of Slider that we
                          // created in Modal Class
                          return pages[index];
                        }),
                  ),
                  // add elevation to the container

                  Card(
                    elevation: 10.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        currentIndex == 1
                            ? Expanded(
                                child: TextButton(
                                  child: Text("Previous",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey)),
                                  onPressed: () {
                                    _controller.previousPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                ),
                              )
                            : Expanded(
                                child: SizedBox(),
                              ),
                        Expanded(
                          child: Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              pages.length,
                              (index) => buildDot(index, context),
                            ),
                          )),
                        ),
                        currentIndex == 0
                            ? Expanded(
                                child: TextButton(
                                  child: Text("Next",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey)),
                                  onPressed: () {
                                    _controller.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                ),
                              )
                            : Expanded(
                                child: SizedBox(),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
