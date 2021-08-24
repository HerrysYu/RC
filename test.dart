import 'package:flutter/material.dart';
class PageOne_State extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => PageOne();

}
class PageOne extends State<StatefulWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return(
    MaterialApp(
      home:Scaffold(
        appBar: AppBar(title: Text("PageOne"),),
        body: Hero(
          tag: 'test',
          child:RaisedButton(
            onPressed:(){
              Navigator.push(context,PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) => PageTwo()));
            },
          )
        )
      )
    )
    );
    throw UnimplementedError();
  }

}
class PasgeTwo_stf  extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    PageTwo();
    throw UnimplementedError();
  }

}
class PageTwo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home:Scaffold(
        appBar:AppBar(title: Text("PageTwo"),),
        body:Center(
          child: Hero(
            tag:'test',
            child:RaisedButton(
              onPressed: (){Navigator.pop(context,PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation)=>PageOne_State()));
              },
            )
          ),
        )
      )
    );
    throw UnimplementedError();
  }

}
void main(){
  runApp(
    MaterialApp(
      home:PageOne_State()
    )
  );
}