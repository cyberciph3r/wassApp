import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  String hint;
  bool inChatScreen;
  Function(String)? onChange;
  bool? isPassword;
  var textController;

  InputText(
      {this.hint = "",
      this.inChatScreen = false,
      this.onChange,
      this.isPassword = false,
      this.textController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: TextField(
        controller: textController,
        onChanged: onChange,
        obscureText: isPassword!,
        style: TextStyle(
            color: inChatScreen ? Colors.white : Colors.black, fontSize: 20),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: true,
          enabled: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 5,
              color: inChatScreen ? const Color(0xFFCDFF48) : Colors.black,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 7,
              color: inChatScreen ? const Color(0xFFCDFF48) : Colors.black,
            ),
          ),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 17,
            letterSpacing: 2,
            color: inChatScreen ? Colors.white.withOpacity(0.7) : Colors.black,
          ),
        ),
      ),
    );
  }
}
