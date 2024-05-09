import 'package:fluter_practice/arg.dart';
import 'package:fluter_practice/data.dart';
import 'package:fluter_practice/main.dart';
import 'package:fluter_practice/structure.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/utils/utils.dart';
import 'MessageSend.dart';
import 'argument.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';
import 'data.dart';
import 'grammerCheck.dart';

class sl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => sl_state();
}

class sl_state extends State<sl> {
  GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    List list = SentenceList;
    return Column(
      key: _key,
      children: [
        for (var key in list)
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
                    //primary: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.white,
                    side: BorderSide(color: Colors.white)),
                child: Text(
                  key.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 25),
                  textAlign: TextAlign.left,
                ),
                onPressed: (() {
                  //Search(key);
                  print("$key tapped");
                  Navigator.pop(context);
                  textEditingControllera.text = key.toString();
                }),
                onLongPress: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("提示"),
                          content: Text("您要删除这个句子吗?"),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                "取消",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () =>
                                  Navigator.of(context).pop(), //关闭对话框
                            ),
                            TextButton(
                              child: Text(
                                "确定",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                print("$key LongPressed");
                                sqlHelpera.RemoveWord(key.toString());
                                SentenceList = await sqlHelpera.ReadOut();
                                setState(() {
                                  list = SentenceList;
                                });
                                SentenceList = await sqlHelpera.ReadOut();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            ),
          )
      ],
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

class VoSc extends StatelessWidget {
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
              child: sl(),
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
      slivers: [Bar(), sl()],
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
      backgroundColor: Color.fromARGB(255, 245, 214, 225),
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: EdgeInsets.only(bottom: 50 * width_rato),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Text(
                  "句子本",
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
