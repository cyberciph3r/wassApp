import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  String? alertText;

  Alert({this.alertText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF181B20),
      title: Text(
        alertText!,
        style: const TextStyle(
          fontFamily: "nexa",
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(10),
            backgroundColor: MaterialStateProperty.all(const Color(0xFFCDFF48)),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              "Go Back",
              style: TextStyle(
                fontSize: 25,
                fontFamily: "Nexa",
                letterSpacing: 2,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
