import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AllScheme {
  final String id;
  final String name;
  final String desc;

  AllScheme({required this.id, required this.name, required this.desc});
}

class AllSchemesListView extends StatefulWidget {
  AllSchemesListView({Key? key}) : super(key: key);

  @override
  State<AllSchemesListView> createState() => _AllSchemesListViewState();
}

class _AllSchemesListViewState extends State<AllSchemesListView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: [
        Align(
            alignment: Alignment.topLeft,
            child: Image.asset("assets/appBG.png")),
        Padding(
          padding: const EdgeInsets.only(top: 100.0, left: 20.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              "All Schemes",
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
      FutureBuilder<List<AllScheme>>(
          future: _fetchSchemes(),
          builder: (ctx, snap) {
            if (snap.hasData) {
              List<AllScheme> data = snap.data!;
              return _allSchemesListView(data);
            } else if (snap.hasError) {
              return Text("${snap.error}");
            }
            return const CircularProgressIndicator();
          })
    ]);
  }

  Widget _allSchemesListView(data) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (ctx, int index) {
            return Card(
              child: ListTile(
                title: Text(data[index].name),
                subtitle: Text(data[index].desc),
              ),
            );
          }),
    );
  }

  Future<List<AllScheme>> _fetchSchemes() async {
    List<AllScheme> _schemes = [];
    final url =
        Uri.parse('https://iyojna-backend.herokuapp.com/schemes/get-schemes/');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    print(response.body.toString());
    if (response.statusCode == 200) {
      final List<dynamic> extractedData = json.decode(response.body);
      for (var x in extractedData) {
        _schemes.add(new AllScheme(
            id: x["id"].toString(), name: x["name"], desc: x["desc"]));
      }
      return _schemes;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
