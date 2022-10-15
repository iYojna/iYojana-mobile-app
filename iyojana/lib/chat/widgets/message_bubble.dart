import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  bool isMe;
  MessageBubble(this.message, this.isMe, this.username);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8),
        child: Stack(
          clipBehavior: Clip.none,
          //Stack is only for user image on every message
          children: [
            Row(
              //to make width of container work
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: isMe ? Colors.red[400] : Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft:
                              !isMe ? Radius.circular(0) : Radius.circular(12),
                          bottomRight:
                              isMe ? Radius.circular(0) : Radius.circular(12)),
                    ),
                    width:
                        200, //width will not work if we have only container as parent widget
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isMe ? Colors.grey[300] : Colors.black,
                          ),
                        ),
                        Text(
                          message,
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                          ),
                          textAlign: isMe ? TextAlign.end : TextAlign.start,
                        ),
                      ],
                    )),
              ],
            ),
            Positioned(
              //positioned widget helps us to position a
              //widget in a stack
              top: -7,
              left: isMe ? null : 172,
              right: isMe ? 172 : null,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: isMe
                    ? NetworkImage(
                        'https://unloc.online/wp-content/uploads/2020/04/283-2833820_user-icon-orange-png.png')
                    : NetworkImage(
                        'https://img.freepik.com/free-vector/robot-vector-chat-bot-concept-illustration-virtual-assistant-banner-talk-bubble-speech-digital_111651-653.jpg?size=338&ext=jpg'),
              ),
            ),
          ],
        ));
  }
}
