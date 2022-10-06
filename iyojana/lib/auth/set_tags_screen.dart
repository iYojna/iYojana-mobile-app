import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                Text(
                  'Welcome',
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 20)),
                ),
                Text('Choose your preferred scheme',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )),
                Wrap(
                    children: tags
                        .map((tag) => Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top:5.0, bottom: 5.0),
                          child: ElevatedButton(
                          
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(tag.enabled? Colors.green : Color.fromARGB(255, 184, 183, 183))
                            ),
                            onPressed: (){
                              setState(() {
                                print("clicked");
                                tag.enabled = !tag.enabled;
                              });
                            }, 
                            child: Container(
                              child: Text(tag.name),
                            )
                          )
                        )).toList()),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: ElevatedButton(
                             style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 214, 214, 214)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                              onPressed: () {}, child: Text("Skip for now"))),
                      SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: ElevatedButton(
                              onPressed: () {}, child: Text("Done")))
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
