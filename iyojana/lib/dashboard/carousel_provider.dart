import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class TempScheme {
  final String id;
  final String name;
  final String desc;

  TempScheme({required this.id, required this.name, required this.desc});

  factory TempScheme.fromJson(Map<String, dynamic> json) {
    return TempScheme(
      id: json["id"].toString(),
      name: json["name"].toString(),
      desc: json["desc"].toString(),
    );
  }
}

class JobsListView extends StatefulWidget {
  final String tag;
  JobsListView({Key? key, required this.tag}) : super(key: key);

  @override
  State<JobsListView> createState() => _JobsListViewState();
}

class _JobsListViewState extends State<JobsListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TempScheme>>(
        future: _fetchSchemes(widget.tag),
        builder: (ctx, snap) {
          if (snap.hasData) {
            List<TempScheme> data = snap.data!;
            return _schemesListView(data);
          } else if (snap.hasError) {
            return Text("${snap.error}");
          }
          return CircularProgressIndicator();
        });
  }

  Widget _schemesListView(data) {
    return CarouselSlider.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, i, pageViewIndex) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(data[i].name,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black),
                            )),
                        Text(data[i].desc,
                        overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                  color: Colors.black),
                            )),
                      ],
                    ),
                  ),
                ),
                Image.asset("assets/carousel_image.png"),
              ],
            ),
          );
        },
        options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.19,
            autoPlayAnimationDuration: const Duration(seconds: 3),
            autoPlay: true,
            aspectRatio: 1,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 3)));
  }
}

Future<List<TempScheme>> _fetchSchemes(String tags) async {
  List<TempScheme> _schemes = [];
  final url = Uri.parse(
      'https://iyojna-backend.herokuapp.com/schemes/retrieve-schemes/?tag='+tags);
  final response = await http.get(
    url,
    headers: <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
  );
  if (response.statusCode == 200) {
    final Map<String, dynamic> extractedData = json.decode(response.body);
    for (var x in extractedData.keys.toList()) {
      _schemes.add(new TempScheme(
          id: extractedData[x]["id"].toString(),
          name: extractedData[x]["name"],
          desc: extractedData[x]["desc"]));
    }
    return _schemes;
  } else {
    throw Exception('Failed to load jobs from API');
  }
}
