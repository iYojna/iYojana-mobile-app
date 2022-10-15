import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:iyojana/chat/widgets/messages.dart';
import 'package:iyojana/chat/widgets/new_message.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> messages = [];
  void _addMessage(String message, bool isUser, String userName) {
    print('inside _add msg: $message is user: $isUser');
    setState(() {
      messages.insert(0, {
        'message': message,
        'isUserMessage': isUser,
        'username': userName,
      });
    });
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