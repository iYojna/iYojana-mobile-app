import 'dart:math';
import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:iyojana/chat/widgets/messages.dart';
import 'package:iyojana/chat/widgets/new_message.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<dynamic, dynamic>> messages = [];
  void _addMessage(dynamic message, bool isUser, String userName) {
    // print('inside _add msg: $message is user: $isUser');
    setState(() {
      messages.insert(0, {
        'message': message,
        'isUserMessage': isUser,
        'username': userName,
      });
    });
    if (isUser) {
      final userMsg = messages.elementAt(0);
      const baseurl =
          'https://iyojna-backend.herokuapp.com/schemes/retrieve-query-schemes/?query=';
      // for every space in the message, replace it with &
      final query = userMsg['message'].toString().replaceAll(' ', ',');
      final combinedurl = baseurl + query;
      // print(query);
      final uri = Uri.parse(combinedurl);

      Widget botIcon = const SizedBox(
        child: CircularProgressIndicator(),
      );

      _addMessage(botIcon, false, 'Bot');

      // make async function
      Future<void> getResponse() async {
        final response = await http.get(uri, headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        });

        if (response.statusCode == 200) {
          setState(() {
            messages.removeAt(0);
          });
          print(json.decode(response.body));
      final Map<dynamic, dynamic> data = json.decode(response.body);

          if (data.isEmpty) {
            _addMessage('No schemes found', false, 'Bot');
          } else {
            // print(data);
            for (var x in data.keys.toList()) {
              // var reply = "${data[x]["name"]}\n\n${data[x]["desc"]}";
              for(var elem in data[x]){
                var reply = "${elem["name"]}\n\n${elem["desc"]}";
                _addMessage(reply, false, 'Bot');
              }
              //print("replyyyy"+reply.toString());
              // _addMessage(reply, false, 'Bot');
            }
          }
        } else {
          setState(() {
            messages.removeAt(0);
          });
          _addMessage('An error occurred while processing, please try again',
              false, 'Bot');
        }
      }

      getResponse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Messages(messages),
          ),
          NewMessage(_addMessage)
        ],
      ),
    );
  }
}
