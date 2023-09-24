import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'argument.dart';

class SeverConnect {
  bool isDisconnected_bool = false;
  WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse(Arguments.SeverAddress),
  );

  ConnetWs() {
    this.channel = WebSocketChannel.connect(
      Uri.parse(Arguments.SeverAddress),
    );
  }
}
