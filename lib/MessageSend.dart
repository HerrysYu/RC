import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'argument.dart';

final channel = WebSocketChannel.connect(
  Uri.parse(Arguments.SeverAddress),
);

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
      stream: channel.stream,
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
