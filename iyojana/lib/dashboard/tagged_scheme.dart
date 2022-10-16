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

class SpecificSchemeListView extends StatefulWidget {
  final String tag;
  SpecificSchemeListView({Key? key, required this.tag}) : super(key: key);

  @override
  State<SpecificSchemeListView> createState() => _SpecificSchemeListViewState();
}

class _SpecificSchemeListViewState extends State<SpecificSchemeListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
          Align(
              alignment: Alignment.topLeft,
              child: Image.asset("assets/appBG.png")),
          Padding(
            padding: const EdgeInsets.only(top: 100.0, left: 20.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Available Schemes",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ]),
          FutureBuilder<List<TempScheme>>(
              future: _fetchSchemes(widget.tag),
              builder: (ctx, snap) {
                if (snap.hasData) {
                  List<TempScheme> data = snap.data!;
                  return _schemesListView(data);
                } else if (snap.hasError) {
                  return Text("${snap.error}");
                }
                return CircularProgressIndicator();
              }),
        ],
      ),
    );
  }

  Widget _schemesListView(data) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (ctx,index){
          return Card(
            child: ListTile(
              title: Text(data[index].name),
              subtitle: Text(data[index].desc),
            ),
          );
        }
        ),
    );
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