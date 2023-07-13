import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wassapp/screens/chat_screen.dart';
import '../components/alert.dart';
import '../components/roundedButton.dart';
import '../components/inputText.dart';

class Login extends StatefulWidget {
  static String id = "loing_screen";

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFCDFF48),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Hero(
                tag: "logo",
                child: Image(
                  height: 200,
                  image: AssetImage(
                    'assets/chat.gif',
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'nexa',
                  ),
                ),
              ),
              InputText(
                hint: "Email",
                onChange: (value) {
                  email = value;
                },
              ),
              InputText(
                hint: "Password",
                isPassword: true,
                onChange: (value) {
                  password = value;
                },
              ),
              RoundedButton(
                color: const Color(0xFF181B20),
                buttonText: "LOG IN",
                onPress: () async {
                  try {
                    var user = await _auth.signInWithEmailAndPassword(
                      email: email!,
                      password: password!,
                    );

                    Navigator.pushNamed(context, ChatScreen.id);
                  } on FirebaseAuthException catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) => Alert(
                        alertText: "Invalid credentials!!",
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
