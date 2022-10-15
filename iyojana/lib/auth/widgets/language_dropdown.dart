import 'package:flutter/material.dart';

import '../../language.dart';
import '../../language_constants.dart';
import '../../main.dart';

Widget languageDropdown(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: DropdownButton<Language>(
      underline: const SizedBox(),
      icon: const Icon(
        Icons.language,
        color: Colors.black,
      ),
      onChanged: (Language? language) async {
        if (language != null) {
          Locale _locale = await setLocale(language.languageCode);
          MyApp.setLocale(context, _locale);
          print(_locale);
        }
      },
      items: Language.languageList()
          .map<DropdownMenuItem<Language>>(
            (e) => DropdownMenuItem<Language>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    e.flag,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(e.name)
                ],
              ),
            ),
          )
          .toList(),
    ),
  );
}
