import 'package:fluter_practice/data.dart';
import 'package:fluter_practice/structure.dart';
import 'package:flutter/material.dart';
import 'MessageSend.dart';
import 'argument.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final sqlHelper = SqlHelper(db_path: Arguments.database_path.toString());

class WordInfo extends StatelessWidget {
  var radius = 10;
  final Color color_background = Color.fromRGBO(231, 244, 254, 1);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              margin: EdgeInsets.only(top: 0, left: 0),
              width: 1080,
              height: 1920,
              color: color_background,
              child: Column(
                children: [
                  Container(
                      width: 350,
                      height: 120,
                      child: Container(
                          margin: EdgeInsets.only(top: 30, left: 0),
                          child: MyTextField()),
                      margin: EdgeInsets.only(top: 65),
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
                    margin: EdgeInsets.only(top: 45),
                    width: 350,
                    height: 460,
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
                      margin: EdgeInsets.only(top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //第一阶段
                          Container(
                            height: 90,
                            decoration: new BoxDecoration(),
                            child: ElevatedButton(
                              onPressed: () {
                                sqlHelper.Opericate(tec.text);
                                //sqlHelper.ReadOut();
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
                            margin: EdgeInsets.only(right: 40, left: 40),
                            height: 90,
                            child: ElevatedButton(
                              onPressed: () {
                                print("pressed");
                                channel.sink
                                    .add(Arguments.message); //SEND MESSAGE
                                Arguments.CurrentWord = tec.text.toString();
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
                            height: 90,
                            child: ElevatedButton(
                              onPressed: () {
                                //tec.clear();
                                sqlHelper.ReadOut();
                              },
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
                      width: 350,
                      height: 100,
                      decoration: new BoxDecoration(
                        color: color_background,
                      ))
                ],
              )),
        ));
    throw UnimplementedError();
  }
}

void main() {
  runApp(MaterialApp(home: WordInfo()));
}
