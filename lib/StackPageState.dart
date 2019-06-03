import 'package:flutter/material.dart';
void main(){
  runApp(new StackApp());
}
class StackApp extends StatelessWidget{
   @override
    Widget build(BuildContext context) {
       return MaterialApp(title: 'stack demo',home: new StatePage(),);
    }
}

class StatePage extends StatefulWidget{
   @override
   State<StatefulWidget> createState() {
       return _StatePageState();
   }
}

class _StatePageState extends State<StatePage>{
   @override
    Widget build(BuildContext context) {
     var stack = new Stack(
       alignment: const Alignment(0.6, 0.6),
       children: <Widget>[
         new CircleAvatar(
           backgroundImage: new AssetImage('images/a.png'),
           radius: 100.0,
         ),
         new Container(
              decoration: new BoxDecoration(color: Colors.black45),
              child: new Text('android avatar',style: new TextStyle(color: Colors.white70),),
         ),
         new Container(
             decoration: new BoxDecoration(color: Colors.transparent),
             padding: const EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
             child: new CircleAvatar(
                 backgroundImage: new AssetImage('images/b.png'),
                 backgroundColor: Colors.transparent,
                 radius: 10.0,
           ),
         ),
       ],
     );
       return new Scaffold(
         appBar: new AppBar(title: new Text('stack demo 1'),),
         body: new Center(child: stack,),
       );


    }
}