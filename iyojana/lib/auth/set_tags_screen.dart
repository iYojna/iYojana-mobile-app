import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iyojana/styles.dart';

import '../bottom_tab_nav.dart';

class Tags {
  String id;
  String name;
  bool enabled;

  Tags({
    required this.id,
    required this.name,
    required this.enabled,
  });
}

class SetTagsScreen extends StatefulWidget {
  const SetTagsScreen({Key? key}) : super(key: key);
  static const routeName = "SetTagsScreen";
  @override
  State<SetTagsScreen> createState() => _SetTagsScreenState();
}

class _SetTagsScreenState extends State<SetTagsScreen> {
  List<Tags> tags = [
    Tags(id: "1", name: "Agriculture and Cooperation", enabled: false),
    Tags(id: "2", name: "Education", enabled: false),
    Tags(id: "3", name: "Civil", enabled: false),
    Tags(id: "4", name: "Social Justice & Empowerment", enabled: false),
    Tags(id: "5", name: "Urban", enabled: false),
  ];
  @override
  Widget build(BuildContext context) {
    print("Build Set tags Screen");
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
                  child: Text(
                    'Welcome',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 28)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text('Choose your preferred scheme',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      )),
                ),
                Wrap(
                    children: tags
                        .map((tag) => Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                            child: ElevatedButton(
                                // add border radius
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  primary: tag.enabled
                                      ? Color.fromARGB(255, 227, 255, 217)
                                      : Color.fromARGB(255, 245, 244, 244),
                                  side: BorderSide(
                                      width: 2,
                                      color: tag.enabled
                                          // 0, 166, 36, 1
                                          ? Color.fromARGB(255, 0, 166, 36)
                                          : Colors.transparent),
                                  // backgroundColor: MaterialStateProperty.all(
                                  //     tag.enabled
                                  //         ? Color.fromARGB(255, 227, 255, 217)
                                  //         : Color.fromARGB(
                                  //             255, 245, 244, 244))
                                ),
                                onPressed: () {
                                  setState(() {
                                    print("clicked");
                                    tag.enabled = !tag.enabled;
                                  });
                                },
                                child: Container(
                                  child: Text(
                                    tag.name,
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            // rgba(0, 166, 36, 1)
                                            color: tag.enabled
                                                ? Color.fromARGB(
                                                    255, 0, 166, 36)
                                                : Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16)),
                                  ),
                                ))))
                        .toList()),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: ElevatedButton(
                              style: Styles().buttonStyle1(),
                              onPressed: () {},
                              child: Text("Skip for now"))),
                      SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: ElevatedButton(
                              style: Styles().buttonStyle2(),
                              onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return BasicBottomNavBar();
                                  }));
                              },
                              child: Text("Done")))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
