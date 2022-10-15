import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customDropDown(
    {required BuildContext context,
    required String hintText,
    required String labelText,
    required Function onChanged,
    required List<String> items}) {
  String _category = items[0];
  return SizedBox(
    width: 300,
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText,
              textAlign: TextAlign.left,
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color.fromARGB(255, 0, 166, 36)))),
          SizedBox(
            height: 10,
          ),
          DropdownButtonFormField(
              items: items.map((String category) {
                return new DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: <Widget>[
                        Text(
                          category,
                        ),
                      ],
                    ));
              }).toList(),
              onChanged: (newValue) {
                // do other stuff with _category
                onChanged(newValue);
              },
              value: _category,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      top: 10.0, bottom: 5.0, left: 10.0, right: 5.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: hintText))
        ],
      ),
    ),
  );
}
