import 'package:flutter/material.dart';

void main()=>runApp(new ContainerPageApp());

class ContainerPageApp extends StatelessWidget{
   @override
    Widget build(BuildContext context) {
       return new MaterialApp(
         title: 'container demo 1',
         theme: new ThemeData(primarySwatch:Colors.brown),
         home: new ContainerDemoPage(),
       );
    }
}

class ContainerDemoPage extends StatefulWidget{
   @override
   State<StatefulWidget> createState() {
       return new _ContainerDemoPageState();
   }
}

class _ContainerDemoPageState extends State<ContainerDemoPage>{
   @override
    Widget build(BuildContext context) {
       Expanded imageExpanded(String img){
         return new Expanded(child: new Container(
           decoration: new BoxDecoration(
             border: new Border.all(width: 10,color: Colors.black38),
             borderRadius: const BorderRadius.all(
               const Radius.circular(8)
             )
           ),
           margin: const EdgeInsets.all(4),
           child: new Image.asset(img),
         ));
       }

       var container = new Container(
         decoration: new BoxDecoration(color: Colors.black26),
         child: new Column(
           children: <Widget>[
             new Row(children: <Widget>[
               imageExpanded('images/c1.jpg'),
               imageExpanded('images/c2.jpg'),
             ],),
             new Row(children: <Widget>[
               imageExpanded('images/a.png'),
               imageExpanded('images/b.png'),
             ],),
             new Row(children: <Widget>[
               imageExpanded('images/c1.jpg'),
             ],)
           ],
         ),
       );
       return new Scaffold(
         appBar: new AppBar(title: new Text('Container page demo'),),
         body: new Center(
           child: container,
         ),
       );
    }
}
