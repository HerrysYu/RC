import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'argument.dart';
import 'connect.dart';
import 'package:rxdart/rxdart.dart';

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
    // TODO: implement build
    print("hello");
    return StreamBuilder(
      stream: streamController.stream,
      builder: (context, snapshot) {
        return Text(
          snapshot.hasData ? '${snapshot.data}' : '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        );
      },
    );
  }
}
