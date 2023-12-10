import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:fluter_practice/structure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'argument.dart';
import 'connect.dart';
import 'package:rxdart/rxdart.dart';
import 'arg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'speech.dart';
//channel = WebSocketChannel.connect(Uri.parse(Arguments.SeverAddress),);
//final channel = SeverConnect().channel;

class Message extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  double isEmpty = 0;
  static String Meassage = "Message";
  @override
  Widget build(BuildContext context) {
    final Color color_background = Color.fromRGBO(84, 174, 244, 1);
    // TODO: implement build
    print("hello");
    return StreamBuilder(
      stream: streamControllera.stream,
      builder: (context, snapshot) {
        if (isqreplied == false) {
          return Padding(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: LoadingAnimationWidget.inkDrop(
                  color: color_background, size: 60),
            ),
          );
        } else {
          if (snapshot.data.toString() == "received") {
            return Padding(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: LoadingAnimationWidget.discreteCircle(
                    color: color_background, size: 60),
              ),
            );
          } else {
            if (tec.text == "") {
              print("empty");
            } else {
              isEmpty = 1;
            }
            return ListView(children: [
              Opacity(
                opacity: isEmpty,
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "发音:",
                          style: TextStyle(fontSize: 20),
                        ),
                        ttp(speekContent: tec.text)
                      ]),
                ),
              ),
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
        }
      },
    );
  }
}
