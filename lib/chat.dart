import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:fluter_practice/hintgenerate.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'arg.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:language_tool/language_tool.dart';
import 'main.dart';

import 'package:provider/provider.dart';
import 'arg.dart';
import 'main.dart';
import 'argument.dart';

StreamController streamController_hint = new StreamController();

class Notifer extends ChangeNotifier {
  update() {}
}

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestPageState();
}

ScrollController scrollController = new ScrollController();

class _TestPageState extends State<TestPage> {
  Future<String> feedbackError(List<WritingMistake> result) async {
    List<String> fullMistake = [];
    String fullMistake_string = "";
    for (final mistake in result) {
      fullMistake.add('''
        Issue: ${mistake.shortMessage}
        IssueType: ${mistake.issueDescription}
        replecement:${mistake.replacements}
      ''');
    }
    for (var item in fullMistake) {
      fullMistake_string = fullMistake_string + item.toString();
    }
    return fullMistake_string;
  }

  late final SocketConnect socketConnect;
  late final LanguageIdentifier languageIdentifier;
  @override
  void initState() {
    // TODO: implement initState
    socketConnect = new SocketConnect();
    languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    socketConnect.channel.sink.close();
    languageIdentifier.close();
    isChat = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (socketConnect.isSocketConnect == false) {
      //socketConnect.ReConnect();
    }
    //var state = context.watch<Notifer>();
    // TODO: implement build
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("提示"),
                      content: Text("退出后将丢失对话记录"),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            "取消",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () => Navigator.of(context).pop(), //关闭对话框
                        ),
                        TextButton(
                          child: Text(
                            "确定",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            MessageList = [];
                            socketConnect.channel.sink.close();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop(); //关闭对话框
                          },
                        ),
                      ],
                    );
                  });
              //Navigator.pop(context);
            },
          ),
          backgroundColor: Color.fromRGBO(252, 222, 95, 1),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 2),
              child: IconButton(
                icon: Icon(
                  Icons.book_outlined,
                  color: Colors.black,
                ),
                onPressed: (() {
                  if (CurrentVoc.isEmpty == false) {
                    MessageList.add(Messagee(
                        confidence: 0.0,
                        languageTag: "",
                        messagee:
                            "请使用这些单词" + CurrentVoc.toString() + "开始英语对话,谢谢",
                        isntGPT: true));
                    socketConnect.channel.sink
                        .add("请使用这些单词" + CurrentVoc.toString() + "开始英语对话,谢谢");
                    Arguments.iswaitingreply = true;
                    streamController.add("update");
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("提示"),
                            content: Text("您的单词本是空的"),
                          );
                        });
                    //Navigator.pop(context);
                  }
                }),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 16 * width_rato),
                child: IconButton(
                  icon: Icon(
                    Icons.lightbulb_outline,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => book()));
                  },
                ))
          ],
          title: Container(
            alignment: Alignment.topLeft,
            child: Text(""),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10 * heigh_ratio),
                  child: StreamBuilder(
                      stream: streamController.stream,
                      builder: (context, snapshot) {
                        if (Arguments.iswaitingreply == true) {
                          return ListView(
                            controller: scrollController,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 32 * width_rato),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 20),
                              ),
                              waitForSever(),
                              for (var messages in MessageList.reversed)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LineGenerator(
                                      confidence: messages.confidence,
                                      languageTag: messages.languageTag,
                                      isUser: messages.isntGPT,
                                      content: messages.messagee),
                                ),
                            ],
                            reverse: true,
                          );
                        } else {
                          return ListView(
                            controller: scrollController,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 32 * width_rato),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 20),
                              ),
                              for (var messages in MessageList.reversed)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LineGenerator(
                                      languageTag: messages.languageTag,
                                      confidence: messages.confidence,
                                      isUser: messages.isntGPT,
                                      content: messages.messagee),
                                ),
                            ],
                            reverse: true,
                          );
                        }
                      }),
                ),
                Container(
                    padding: EdgeInsets.only(top: 20 * heigh_ratio),
                    child: MessageBar(
                      sendButtonColor: Color.fromRGBO(225, 139, 0, 0.824),
                      onSend: (String a) async {
                        final String response =
                            await languageIdentifier.identifyLanguage(a);

                        final List<IdentifiedLanguage> possibleLanguages =
                            await languageIdentifier
                                .identifyPossibleLanguages(a);
                        MessageList.add(Messagee(
                            messagee: a,
                            isntGPT: true,
                            languageTag: possibleLanguages[0].languageTag,
                            confidence: possibleLanguages[0].confidence));

                        Arguments.iswaitingreply = true;
                        streamController.add("call");
                        scrollController.animateTo(0,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeIn);

                        socketConnect.channel.sink.add(a);
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LineGenerator extends StatelessWidget {
  bool isUser;
  String? content;
  double confidence;
  String languageTag;
  LineGenerator(
      {required this.isUser,
      required this.content,
      required this.confidence,
      required this.languageTag});
  @override
  Widget build(BuildContext context) {
    if (isUser == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                child: BubbleSpecialThree(
                  text: content.toString(),
                  color: Color.fromRGBO(174, 208, 237, 1),
                  tail: true,
                  isSender: isUser,
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                child: BubbleSpecialThree(
                  text: content.toString(),
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  color: Color.fromRGBO(174, 208, 237, 1 - 0),
                  tail: true,
                  isSender: isUser,
                ),
              ),
            ),
          )
        ],
      );
    }
  }
}

class waitForSever extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Container(
              child: SizedBox(
                width: 100,
                child: LoadingAnimationWidget.waveDots(
                    color: Colors.grey, size: 50),
              ),
            ),
          ),
        ),
      ],
    );
    throw UnimplementedError();
  }
}

StreamController streamController = new StreamController.broadcast();

class SocketConnect {
  bool isSocketConnect = true;
  WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse("ws://45.32.29.121:1234"));
  SocketConnect() {
    isSocketConnect = true;
    this.channel.stream.listen((dynamic message) {
      MessageList.add(Messagee(
          messagee: message, isntGPT: false, confidence: 0, languageTag: ""));
      Arguments.iswaitingreply = false;
      streamController.add("call");
      scrollController.animateTo(0,
          duration: Duration(seconds: 1), curve: Curves.easeIn);
    }, onDone: () {
      isSocketConnect = false;
      ReConnect();
    });
  }
  Send(String message) async {
    channel.sink.add(message);
  }

  Destory() async {
    channel.sink.close();
  }

  ReConnect() async {}
}

class Messagee {
  String messagee;
  bool isntGPT;
  double confidence;
  String languageTag;
  Messagee(
      {required this.messagee,
      required this.isntGPT,
      required this.confidence,
      required this.languageTag});
}

List<Messagee> MessageList = [];

class hintSocket {
  late final WebSocketChannel webSocketChannel;
  hintSocketinit() {
    webSocketChannel = WebSocketChannel.connect(Uri.parse(""));
    webSocketChannel.stream.listen((dynamic message) {
      streamController_hint.add(message);
    });
  }

  hintSocket() {
    hintSocketinit();
  }
  send(String message) async {
    webSocketChannel.sink.add(message);
  }
}
