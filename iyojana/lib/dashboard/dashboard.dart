import 'dart:convert';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:iyojana/bottom_tab_nav.dart';
import 'package:iyojana/dashboard/carousel_provider.dart';
import 'package:iyojana/dashboard/widgets/carousel.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

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

class Schemes {
  String id;
  String name;
  String imageLink;

  Schemes({
    required this.id,
    required this.name,
    required this.imageLink,
  });
}

class TempSchemes {
  String id;
  String name;
  String desc;

  TempSchemes({
    required this.id,
    required this.name,
    required this.desc,
  });
}

class _DashboardState extends State<Dashboard> {
  List<Tags> tags = [
    Tags(id: "1", name: "Agriculture and Cooperation", enabled: false),
    Tags(id: "2", name: "Education", enabled: false),
    Tags(id: "3", name: "Civil", enabled: false),
    Tags(id: "4", name: "Social Justice & Empowerment", enabled: false),
    Tags(id: "5", name: "Urban", enabled: false),
  ];

  List<Schemes> latestSchemes = [
    Schemes(id: "1", name: "Development", imageLink: "assets/homeScheme.png"),
    Schemes(id: "2", name: "Agriculture", imageLink: "assets/farmerScheme.png"),
    Schemes(
        id: "3", name: "Education", imageLink: "assets/educationScheme.png"),
    Schemes(id: "4", name: "Loan", imageLink: "assets/loanScheme.png"),
    Schemes(id: "5", name: "COVID-19", imageLink: "assets/covidScheme.png"),
    Schemes(
        id: "6", name: "Healthcare", imageLink: "assets/healthcareScheme.png"),
    Schemes(id: "7", name: "Science", imageLink: "assets/scienceScheme.png"),
    Schemes(id: "8", name: "Family", imageLink: "assets/familyScheme.png"),
  ];

  Future<List<TempSchemes>> fetchUpcomingEvents() async {
    List<TempSchemes> events = [];
    final url = Uri.parse(
        'https://iyojna-backend.herokuapp.com/schemes/retrieve-schemes/?tag=scholarship');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );

    print("WAITING...");
    print("printing request: ");
    print(response.statusCode);
    print(json.decode(response.body));
    final Map<String, dynamic> extractedData = json.decode(response.body);
    for (var x in extractedData.keys.toList()) {
      events.add(new TempSchemes(
          id: extractedData[x]["id"],
          name: extractedData[x]["id"],
          desc: extractedData[x]["desc"]));
    }
    return events;   
  }
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetchUpcoData();
  }
 

  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //bottomNavigationBar: BasicBottomNavBar(),
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Welcome back, Dhruv",
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black))),
          ),
          backgroundColor: Colors.transparent,
          // add suffix icon
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        // change background color

        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 6, left: 10, right: 10),
              child: AnimSearchBar(
                width: 400,
                textController: _searchController,
                onSuffixTap: () {
                  setState(() {
                    _searchController.clear();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recommended",
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 28,
                              color: Colors.black))),
                  SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.info, size: 32, color: Colors.grey.shade500),
                        Icon(Icons.sort, size: 32, color: Colors.grey.shade500),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        // render tags
                        child: ElevatedButton(
                            // add border radius
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              primary: tags[index].enabled
                                  ? Color.fromARGB(255, 227, 255, 217)
                                  : Color.fromARGB(255, 245, 244, 244),
                              side: BorderSide(
                                  width: 2,
                                  color: tags[index].enabled
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
                                tags[index].enabled = !tags[index].enabled;
                              });
                            },
                            child: Container(
                              child: Text(
                                tags[index].name,
                                style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        // rgba(0, 166, 36, 1)
                                        color: tags[index].enabled
                                            ? Color.fromARGB(255, 0, 166, 36)
                                            : Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)),
                              ),
                            )));
                  }),
            ),
            Expanded(child: JobsListView(tag:"scholarship",)),
            // FutureBuilder<List<TempSchemes>>(
            //   future: fetchUpcomingEvents(),
            //   builder: (ctx,snap){
            //     print(snap.hasData.toString());
            //     if(snap.hasData){
            //       List<TempSchemes> data = snap.data!; 
            //       return CarouselSlider.builder(
            //     itemCount: data.length,
            //     itemBuilder: (BuildContext context, i, pageViewIndex) {
            //       return Card(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(15.0),
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(left: 10.0),
            //               child: SizedBox(
            //                 width: 150,
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   children: [
            //                     Text(data[i].name,
            //                         textAlign: TextAlign.center,
            //                         style: GoogleFonts.inter(
            //                           textStyle: const TextStyle(
            //                               fontWeight: FontWeight.w500,
            //                               fontSize: 16,
            //                               color: Colors.black),
            //                         )),
            //                     Text(data[i].desc,
            //                         textAlign: TextAlign.center,
            //                         style: GoogleFonts.inter(
            //                           textStyle: const TextStyle(
            //                               fontWeight: FontWeight.w300,
            //                               fontSize: 12,
            //                               color: Colors.black),
            //                         )),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             Image.asset("assets/carousel_image.png"),
            //           ],
            //         ),
            //       );
            //     },
            //     options: CarouselOptions(
            //         height: MediaQuery.of(context).size.height * 0.19,
            //         autoPlayAnimationDuration: const Duration(seconds: 3),
            //         autoPlay: true,
            //         aspectRatio: 1,
            //         enlargeCenterPage: true,
            //         autoPlayInterval: const Duration(seconds: 3)));
            //     }
            //      return Text("LOL");
            //   }
            // ),
            
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Explore Latest Schemes',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 26,
                        color: Colors.black)),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 15,
                ),
                itemCount: latestSchemes.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 230, 230, 230),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(latestSchemes[index].imageLink),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        latestSchemes[index].name,
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                color: Colors.black)),
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        )));
  }
}
