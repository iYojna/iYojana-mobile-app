import 'dart:math';
import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:iyojana/chat/widgets/messages.dart';
import 'package:iyojana/chat/widgets/new_message.dart';
import 'package:http/http.dart' as http;

const baseurl =
    'https://iyojna-backend.herokuapp.com/schemes/retrieve-query-schemes/?query=';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class _ChatScreenState extends State<ChatScreen> {
  List<Item> _data = [];
  List<Map<dynamic, dynamic>> messages = [];

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        var mssg =
            "${_data[index].headerValue}\n\n${_data[index].expandedValue}";
        _addMessage(mssg, false, 'Bot');
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.map((e) => e.isExpanded = !e.isExpanded).toList();
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

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
            _addMessage('No results found! Please try again', false, 'Bot');
            // var ankurUrl = 'https://long-kids-shave-112-79-141-26.loca.lt/get';
            // final ankurUri = Uri.parse(ankurUrl);
            // final ankurRes = await http.post(ankurUri, body: {
            //   'msg': query
            // }, headers: <String, String>{
            //   'Accept': 'application/json',
            //   'Bypass-Tunnel-Reminder': 'true'
            // });
            // print(ankurRes);
            // if (ankurRes.statusCode == 200) {
            //   print(ankurRes);
            // }
          } else {
            // print(data);
            _data.clear();
            for (var x in data.keys.toList()) {
              // var reply = "${data[x]["name"]}\n\n${data[x]["desc"]}";
              for (var elem in data[x]) {
                var reply = "${elem["name"]}\n\n${elem["desc"]}";
                _data.add(Item(
                  headerValue: elem["name"],
                  expandedValue: elem["desc"],
                ));
              }
            }
            _addMessage(_buildPanel(), false, 'Bot');
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
