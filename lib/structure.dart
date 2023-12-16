import 'dart:async';
import 'dart:ui';
import 'arg.dart';

import 'package:flutter/material.dart';
import 'argument.dart';
import 'MessageSend.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final CurrentInfo = "";
final tec = TextEditingController();
void ChangeMessage() {
  Arguments.message = "a";
}

final InfoBlockController = TextEditingController();

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

TextEditingController textEditingControllera = TextEditingController();

class MyTextFielda extends StatefulWidget {
  // This class is the configuration for the state.
  // It holds the values (in this case nothing) provided
  // by the parent and used by the build  method of the
  // State. Fields in a Widget subclass are always marked
  // "final".
  @override
  State<MyTextFielda> createState() => _MyTextFieldStatea();
}

class _MyTextFieldStatea extends State<MyTextFielda> {
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
        controller: textEditingControllera);
  }
}

class queryGrammer {
  String address = "ws://45.32.29.121:2020";
  var channel = WebSocketChannel.connect(Uri.parse("ws://45.32.29.121:2020"));
  queryGrammer() {
    channel.sink.close();
    Connect(address);
  }
  Connect(String address) {
    channel = WebSocketChannel.connect(Uri.parse(address));
    Stream sta = channel.stream;
    sta.listen((dynamic message) {
      QueryStream.add(message);
      isreplieda = true;
      grammerqdis = false;
    }, onDone: () {
      grammerqdis = true;
      print("socket closed");
    });
  }
}

StreamController QueryStream = StreamController.broadcast();

class Messagea extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessageStatea();
}

class _MessageStatea extends State<Messagea> {
  double isEmpty = 0;
  static String Meassage = "Message";
  @override
  Widget build(BuildContext context) {
    final Color color_background = Color.fromRGBO(84, 174, 244, 1);
    // TODO: implement build
    print("hello");
    return StreamBuilder(
      stream: QueryStream.stream,
      builder: (context, snapshot) {
        if (isreplieda == false) {
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
                      children: []),
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
