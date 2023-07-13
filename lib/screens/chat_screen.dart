import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/inputText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:move_to_background/move_to_background.dart';

import '../components/messageBubble.dart';
import 'home.dart';

class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
var currentUser;

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var textController = TextEditingController();
  String msg = "";

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: TextButton(
            onPressed: () {
              MoveToBackground.moveTaskToBack();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFCDFF48),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsetsDirectional.all(10),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsetsDirectional.all(0)),
                  elevation: MaterialStateProperty.all(10),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFCDFF48)),
                ),
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushReplacementNamed(context, Home.id);
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF181B20),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder(
                stream: _firestore.collection('wassapp-messages').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var documents = snapshot.data?.docs.reversed;
                    List<Widget> msgsWidget = [];
                    for (var document in documents!) {
                      var msg = document.data();
                      var msgText = msg['text'];
                      var msgSenderEmail = msg['sender-email'];
                      var msgSenderUsername = msg['sender-username'];
                      var msgSentDate = msg['sent-date'];
                      var msgSentTime = msg['sent-time'];
                      var msgWidget = MessageBubble(
                        msgText: msgText,
                        msgSenderEmail: msgSenderEmail,
                        msgSenderUsername: msgSenderUsername,
                        sentDate: msgSentDate,
                        sentTime: msgSentTime,
                      );
                      msgsWidget.add(msgWidget);
                    }
                    return Expanded(
                      child: ListView(
                        reverse: true,
                        children: msgsWidget,
                      ),
                    );
                  }
                  return Container();
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: InputText(
                      textController: textController,
                      hint: "New message!!",
                      inChatScreen: true,
                      onChange: (value) {
                        msg = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsetsDirectional.all(0),
                      ),
                      elevation: MaterialStateProperty.all(10),
                    ),
                    onPressed: () {
                      var datetime = DateTime.now();
                      String date = DateFormat.yMMMMd('en_US').format(datetime);
                      String time = DateFormat.jm().format(datetime);

                      _firestore
                          .collection("wassapp-messages")
                          .doc(
                            DateTime.now().millisecondsSinceEpoch.toString(),
                          )
                          .set({
                        "text": msg,
                        "sender-email": currentUser!.email,
                        "sender-username": currentUser!.displayName,
                        "sent-date": date,
                        "sent-time": time,
                      });
                      textController.clear();
                      msg = "";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFCDFF48),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(17),
                        child: Icon(
                          Icons.send,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
