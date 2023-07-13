import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wassapp/screens/login.dart';
import '../components/alert.dart';
import '../components/roundedButton.dart';
import '../components/inputText.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  static String id = "register_screen";

  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? userName;
  String? email;
  String? password;
  String? cPassword;

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
              const Center(
                child: Text(
                  'Create your Account',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'nexa',
                  ),
                ),
              ),
              InputText(
                hint: "Username",
                onChange: (value) {
                  userName = value;
                },
              ),
              InputText(
                hint: "Email",
                onChange: (value) {
                  email = value;
                },
              ),
              InputText(
                hint: "New password",
                isPassword: true,
                onChange: (value) {
                  password = value;
                },
              ),
              InputText(
                hint: "Confirm password",
                isPassword: true,
                onChange: (value) {
                  cPassword = value;
                },
              ),
              Hero(
                tag: "logo",
                child: RoundedButton(
                  color: const Color(0xFF181B20),
                  buttonText: "REGISTER",
                  onPress: () async {
                    userName = userName?.toLowerCase();
                    // print(userName);
                    bool isnewUsername = true;
                    var userNamesRef = await _firestore
                        .collection('wassapp-userNames')
                        .where('username', isEqualTo: userName)
                        .get();
                    if (userNamesRef.docs.isNotEmpty) {
                      isnewUsername = false;
                    }

                    if (!isnewUsername) {
                      showDialog(
                        context: context,
                        builder: (context) => Alert(
                          alertText: "Username already taken. Try another!!",
                        ),
                      );
                    } else if (password == cPassword) {
                      try {
                        var newUser =
                            await _auth.createUserWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );
                        await newUser.user?.updateDisplayName(userName);
                        _firestore.collection("wassapp-userNames").add({
                          "username": userName,
                        });
                        Navigator.pushNamed(context, Login.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showDialog(
                            context: context,
                            builder: (context) => Alert(
                              alertText: "The password provided is too weak.",
                            ),
                          );
                        } else if (e.code == 'email-already-in-use') {
                          showDialog(
                            context: context,
                            builder: (context) => Alert(
                              alertText:
                                  "The account already exists for that email.",
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => Alert(
                              alertText: "Something went wrong!!",
                            ),
                          );
                        }
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) => Alert(
                            alertText: "Something went wrong.Try again!",
                          ),
                        );
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => Alert(
                          alertText: "Passwords do not match. Try again!!",
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
