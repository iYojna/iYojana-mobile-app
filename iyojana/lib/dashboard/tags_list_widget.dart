import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class TagsListView extends StatefulWidget {
  TagsListView({Key? key}) : super(key: key);

  @override
  State<TagsListView> createState() => _TagsListViewState();
}

class _TagsListViewState extends State<TagsListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: _fetchTags(),
        builder: (ctx, snap) {
          if (snap.hasData) {
            List<dynamic> data = snap.data!;
            return _schemesListView(data);
          } else if (snap.hasError) {
            return Text("${snap.error}");
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _schemesListView(data) {
    return SizedBox(
        height: 60,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(10.0),
                  // render tags
                  child: ElevatedButton(
                      onPressed: () {},
                      // add border radius
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        // backgroundColor: MaterialStateProperty.all(
                        //     tag.enabled
                        //         ? Color.fromARGB(255, 227, 255, 217)
                        //         : Color.fromARGB(
                        //             255, 245, 244, 244))
                      ),
                      child: Container(
                        child: Text(
                          data[index].toString(),
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  // rgba(0, 166, 36, 1)
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16)),
                        ),
                      )));
            }));
  }
}

Future<List<dynamic>> _fetchTags() async {
  List<dynamic> _tags = [];
  final url = Uri.parse(
      "https://iyojna-backend.herokuapp.com/user/get-tags/"); //TODO: GIVE URL
  final response = await http.get(
    url,
    headers: <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
  );
  if (response.statusCode == 200) {
    // final Map<String, dynamic> extractedData = json.decode(response.body);
    // for (var x in extractedData.keys.toList()) {
    //   _tags.add();
    // }
    final List<dynamic> _tags = json.decode(response.body);
    return _tags;
  } else {
    throw Exception('Failed to load jobs from API');
  }
}
