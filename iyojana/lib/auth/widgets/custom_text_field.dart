import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customTextField(
    {required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required String labelText,
    required bool obscureText,
    required TextInputType keyboardType,
    required Function onChanged}) {
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
          TextFormField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              onChanged: (value) {
                onChanged(value);
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      top: 10.0, bottom: 5.0, left: 10.0, right: 5.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: hintText)),
        ],
      ),
    ),
  );
}
