import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:iyojana/dashboard/widgets/carousel.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // remove the initial space in appbar
          titleSpacing: 0,
          elevation: 0,
          title: Text("Welcome back, Dhruv",
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black))),
          backgroundColor: Colors.white,
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
            SizedBox(
              height: 80.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
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
            Carousel(),
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
