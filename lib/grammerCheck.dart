import 'package:fluter_practice/arg.dart';
import 'package:fluter_practice/argument.dart';
import 'package:fluter_practice/data.dart';
import 'package:fluter_practice/sentencesVc.dart';
import 'package:fluter_practice/structure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class spage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => spageState();
}

final SqlHelpera sqlHelpera =
    new SqlHelpera(db_path: Arguments.sentences_database_path);

class spageState extends State<spage> {
  late queryGrammer querygrammer;
  late SqlHelpera sqlHelpera;
  @override
  void initState() {
    sqlHelpera = new SqlHelpera(db_path: Arguments.sentences_database_path);

    // TODO: implement initState
    querygrammer = new queryGrammer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    querygrammer.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var height = MediaQuery.of(context).size.height;
    height = height / 926;
    var heigh_ratio = height;
    var width = MediaQuery.of(context).size.width;
    width = width / 428;
    var width_rato = width;
    print(MediaQuery.of(context).size.width);
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          margin: EdgeInsets.only(top: 0, left: 0),
          width: 1080 * width,
          height: 1920 * height,
          color: Color.fromRGBO(231, 244, 254, 1),
          child: Column(
            children: [
              Container(
                  width: 350 * width,
                  height: 120 * height,
                  child: Container(
                      margin: EdgeInsets.only(top: 30 * height, left: 0),
                      child: MyTextFielda()),
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
                clipBehavior: Clip.hardEdge,
                child: Messagea(),
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
                            sqlHelpera.SaveWord(textEditingControllera.text);

                            //sqlHelper
                            //.ClearDataBase(); //######################### delete the table for debug purpose
                          },
                          onLongPress: () async {
                            SentenceList = await sqlHelpera.ReadOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VoSc()));
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
                            isreplieda = false;
                            if (grammerqdis == true) {
                              querygrammer.Connect(querygrammer.address);
                            }
                            querygrammer.channel.sink.add(
                                "请帮我检查下面这句话有没有语法问题,如果有的话请给我修改意见,如果没有的话,请帮我替换成更好的表达方式,谢谢" +
                                    textEditingControllera.text);
                          },
                          onLongPress: () async {},
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
                            textEditingControllera.clear();
                          },
                          onLongPress: (() async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("提示"),
                                    content: Text("您确定要清空整个句子本吗?"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          "取消",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
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
                                        onPressed: () {
                                          sqlHelpera.ClearDataBase();
                                          Navigator.of(context).pop(); //关闭对话框
                                        },
                                      ),
                                    ],
                                  );
                                });
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
                    color: Color.fromRGBO(231, 244, 254, 1),
                  ))
            ],
          )),
    ));
    throw UnimplementedError();
  }
}
