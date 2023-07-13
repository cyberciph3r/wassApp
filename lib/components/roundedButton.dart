import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  Color? color;
  String buttonText;
  void Function()? onPress;

  RoundedButton(
      {this.color = Colors.blue, this.buttonText = "", @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(10),
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          )),
        ),
        onPressed: onPress,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              fontFamily: "Nexa",
              letterSpacing: 4,
              color: Color(0xFFCDFF48),
            ),
          ),
        ),
      ),
    );
  }
}
