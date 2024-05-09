import 'dart:async';
import 'dart:io';

import 'package:fluter_practice/Config.dart';
import 'package:fluter_practice/arg.dart';
import 'package:fluter_practice/structure.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'argument.dart';
import 'package:rxdart/rxdart.dart';
import 'structure.dart';

StreamController streamControllera = new StreamController();

class SeverConnect {
  bool isDisconnected_bool = false;
  bool isError_bool = false;
  WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse("ws:" + "//" + SeverAddress + ":" + QueryPort),
  );
  SeverConnect() {
    ConnetWs();
  }
  ConnetWs() {
    this.channel = WebSocketChannel.connect(
      Uri.parse("ws:" + "//" + SeverAddress + ":" + QueryPort),
    );
    this.channel.stream.listen((dynamic message) {
      isqreplied = true;
      streamControllera.add(message);
      Arguments.socketDisconnected = false;
    }, onDone: () {
      print("socket closed");
      Arguments.socketDisconnected = true;
    });
  }
}
