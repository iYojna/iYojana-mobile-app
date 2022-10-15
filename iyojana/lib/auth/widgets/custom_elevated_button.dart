import 'package:flutter/material.dart';

Widget customElevatedButton(
    {required BuildContext context,
    required Function onPressed,
    required String content,
    required ButtonStyle style}) {
  return Padding(
    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
    child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            onPressed();
          },
          style: style,
          child: Text(content),
        )),
  );
}
