import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:fluter_practice/structure.dart';
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
import 'chat.dart';

import 'package:provider/provider.dart';
import 'arg.dart';
import 'main.dart';
import 'argument.dart';
import 'grammerCheck.dart';

class Slist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SListState();
}

class SListState extends State<Slist> {
  GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      key: _key,
      children: [
        for (var key in MessageList)
          if (key.languageTag == "en")
            Container(
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                alignment: Alignment.topLeft,
                //margin: EdgeInsets.only(left: 30, bottom: 5, top: 20),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.only(left: 30, bottom: 20, top: 20),
                      primary: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.white,
                      side: BorderSide(color: Colors.white)),
                  child: Text(
                    key.messagee,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                    textAlign: TextAlign.left,
                  ),
                  onPressed: (() {
                    textEditingControllera.text = key.messagee;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => spage()));
                  }),
                  onLongPress: () {},
                ),
              ),
            )
      ],
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

class book extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey _key = GlobalKey();
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CustomScrollView(slivers: [
          Bar(),
          SliverToBoxAdapter(
            child: Container(
              child: Slist(),
            ),
          )
        ]),
      ),
    );
  }
}

class ScroolView extends StatelessWidget {
  const ScroolView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [Bar(), Slist()],
    );
  }
}

class Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey _key = GlobalKey();
    return SliverAppBar(
      expandedHeight: 150,
      key: _key,
      //centerTitle: true,
      backgroundColor: Color.fromRGBO(252, 222, 95, 1),
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: EdgeInsets.only(bottom: 50 * width_rato),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Text(
                  "语句合集",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          )),
      stretch: true,
      //onStretchTrigger: State.ListRefresh(),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
