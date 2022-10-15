import 'package:flutter/material.dart';
import 'package:iyojana/chat/widgets/message_bubble.dart';

class Messages extends StatelessWidget {
  final List<Map<String, dynamic>> messages;
  Messages(this.messages);
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(8),
      color: Colors.black12,
      child:
      ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (ctx, index) => MessageBubble(messages[index]['message'],
              messages[index]['isUserMessage'], messages[index]['username'])),
    );
  }
}