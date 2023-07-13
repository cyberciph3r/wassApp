import 'package:flutter/material.dart';
import 'package:wassapp/screens/chat_screen.dart';
import '../components/roundedButton.dart';
import 'login.dart';
import 'register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  static String id = "home_screen";

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDFF48),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Hero(
              tag: "logo",
              child: Center(
                child: Text(
                  'WassApp',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w100,
                    letterSpacing: 4,
                    color: Color(0xFF181B20),
                  ),
                ),
              ),
            ),
            RoundedButton(
              color: const Color(0xFF181B20),
              buttonText: "LOG IN",
              onPress: () async {
                User? user = _auth.currentUser;
                if (user == null) {
                  Navigator.pushNamed(context, Login.id);
                } else {
                  Navigator.pushNamed(context, ChatScreen.id);
                }
              },
            ),
            RoundedButton(
              color: const Color(0xFF181B20),
              buttonText: "REGISTER",
              onPress: () {
                Navigator.pushNamed(context, Register.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
