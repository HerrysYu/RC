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

final sqlHelper = SqlHelper(db_path: Arguments.database_path.toString());
SeverConnect severConnect = new SeverConnect();

class WordInfo extends StatelessWidget {
  var radius = 10;
  final Color color_background = Color.fromRGBO(231, 244, 254, 1);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    height = height / 926;
    var width = MediaQuery.of(context).size.width;
    width = width / 428;
    print(MediaQuery.of(context).size.width);
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          margin: EdgeInsets.only(top: 0, left: 0),
          width: 1080 * width,
          height: 1920 * height,
          color: color_background,
          child: Column(
            children: [
              Container(
                  width: 350 * width,
                  height: 120 * height,
                  child: Container(
                      margin: EdgeInsets.only(top: 30 * height, left: 0),
                      child: MyTextField()),
                  margin: EdgeInsets.only(top: 65 * height),
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(5.0, 5.0),
                            blurRadius: 10,
                            spreadRadius: 2.0)
                      ])), //word,
              Container(
                child: ListView(children: [Center(child: Message())]),
                margin: EdgeInsets.only(top: 45 * height),
                width: 350 * width,
                height: 460 * height,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5.0, 5.0),
                          blurRadius: 10,
                          spreadRadius: 2.0)
                    ]),
              ),
              //
              Container(
                  margin: EdgeInsets.only(top: 40 * height),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Red Button 红色按钮 ########################################################
                      Container(
                        height: 90 * height,
                        decoration: new BoxDecoration(),
                        child: ElevatedButton(
                          onPressed: () async {
                            sqlHelper.SaveWord(tec.text);
                            //sqlHelper
                            //.ClearDataBase(); //######################### delete the table for debug purpose
                          },
                          onLongPress: () async {
                            Arguments.VocabularyList =
                                await sqlHelper.ReadOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => vocabulary()));
                          },
                          style: TextButton.styleFrom(
                              shape: CircleBorder(),
                              backgroundColor:
                                  Color.fromRGBO(240, 206, 235, 1)),
                          child: null,
                        ),
                      ),

                      //第一阶段
                      //第二阶段
                      Container(
                        margin: EdgeInsets.only(
                            right: 40 * width, left: 40 * width),
                        height: 90 * height,
                        child: ElevatedButton(
                          onPressed: () {
                            print("pressed");
                            //SeverConnect().ConnetWs();
                            Arguments.message = tec.text.toString();
                            severConnect.channel.sink
                                .add(Arguments.message); //SEND MESSAGE
                            //Arguments.CurrentWord = tec.text.toString();
                          },
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Color.fromRGBO(249, 255, 214, 1.00),
                              shape: CircleBorder()),
                          child: null,
                        ),
                      ),
                      //第二阶段
                      //第三阶段
                      Container(
                        height: 90 * height,
                        child: ElevatedButton(
                          onPressed: () async {
                            tec.clear();
                          },
                          onLongPress: (() async {
                            sqlHelper.ClearDataBase();
                          }),
                          style: TextButton.styleFrom(
                              backgroundColor: Color.fromRGBO(
                                  178, 255, 169, 1), //CLEAR THE TEXTBOX
                              shape: CircleBorder()),
                          child: null,
                        ),
                      ),
                      //第三阶段
                    ],
                  ),
                  width: 350 * width,
                  height: 100 * height,
                  decoration: new BoxDecoration(
                    color: color_background,
                  ))
            ],
          )),
    ));
    throw UnimplementedError();
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: WordInfo(),
    );
    throw UnimplementedError();
  }
}

void main() {
  runApp(App());
}
