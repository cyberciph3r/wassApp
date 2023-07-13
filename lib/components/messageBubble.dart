import 'package:flutter/material.dart';
import '../screens/chat_screen.dart';
import 'package:bubble/bubble.dart';

class MessageBubble extends StatelessWidget {
  var msgText;
  var msgSenderEmail;
  var msgSenderUsername;
  var sentDate;
  var sentTime;

  MessageBubble(
      {this.msgText,
      this.msgSenderEmail,
      this.msgSenderUsername,
      this.sentDate,
      this.sentTime});

  @override
  Widget build(BuildContext context) {
    bool isMe = currentUser?.email == msgSenderEmail;
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Text(
            msgSenderUsername,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        Bubble(
          color: isMe ? const Color(0xFFCDFF48) : Colors.blueAccent.shade100,
          nip: isMe ? BubbleNip.rightTop : BubbleNip.leftTop,
          child: Text(
            "$msgText",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 5, bottom: 20, left: 8, right: 8),
          child: Text(
            sentTime,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
