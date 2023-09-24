import 'dart:ui';

import 'package:flutter/material.dart';
import 'argument.dart';
import 'MessageSend.dart';

final tec = TextEditingController();
void ChangeMessage() {
  Arguments.message = "a";
}

class MyTextField extends StatefulWidget {
  // This class is the configuration for the state.
  // It holds the values (in this case nothing) provided
  // by the parent and used by the build  method of the
  // State. Fields in a Widget subclass are always marked
  // "final".
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
        onChanged: (String input) {
          Arguments.message = input;
        },
        onTap: () {
          print('tapped');
          setState(() {});
        },
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w800, fontSize: 25),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: "",
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            top: 0,
            bottom: 0,
          ),
        ),
        controller: tec);
  }
}

class MyButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialButton(
        onPressed: () {
          print("pressed");
          channel.sink.add(Arguments.message);
        },
        color: Colors.blue);

    throw UnimplementedError();
  }
}
