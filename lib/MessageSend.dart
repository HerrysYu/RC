import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'argument.dart';
import 'connect.dart';
import 'package:rxdart/rxdart.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
//channel = WebSocketChannel.connect(Uri.parse(Arguments.SeverAddress),);
//final channel = SeverConnect().channel;

class Message extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  static String Meassage = "Message";
  @override
  Widget build(BuildContext context) {
    final Color color_background = Color.fromRGBO(84, 174, 244, 1);
    // TODO: implement build
    print("hello");
    return StreamBuilder(
      stream: streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.data.toString() == "LdDd") {
          return Padding(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: color_background, size: 60),
            ),
          );
        } else {
          return ListView(children: [
            Center(
              child: Text(
                snapshot.hasData ? '${snapshot.data}' : '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ]);
        }
      },
    );
  }
}
