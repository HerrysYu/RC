import 'dart:io';

import 'package:fluter_practice/arg.dart';
import 'package:fluter_practice/data.dart';
import 'package:fluter_practice/structure.dart';
import 'package:flutter/material.dart';
import 'MessageSend.dart';
import 'argument.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Voabulary.dart';
import 'package:provider/provider.dart';
import 'connect.dart';
import 'chat.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ttp extends StatefulWidget {
  String speekContent;
  ttp({required this.speekContent});
  @override
  State<StatefulWidget> createState() => ttp_state();
}

class ttp_state extends State<ttp> {
  late FlutterTts flutterTts;
  @override
  void initState() {
    // TODO: implement initState
    initTTS();
    super.initState();
  }

  initTTS() {
    flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.voice_chat),
      onPressed: () async {
        await flutterTts.setVolume(1);
        await flutterTts.setSpeechRate(0.2);
        await flutterTts.setVoice({"name": "Karen", "locale": "en-UK"});
        await flutterTts.speak(widget.speekContent);
        print("done");
      },
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
