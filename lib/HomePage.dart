import 'package:flutter/material.dart';
import 'package:flutter_sample2/container_page.dart';

import 'GlidDemoPage.dart';
import 'ListViewPage.dart';
import 'StackPageState.dart';

void main(){
  runApp(new MaterialApp(home: new HomePage(),
    routes:{
      CONTAINER_DEMO_PAGE:(BuildContext context)=>new ContainerPageApp(),
      '/b':(BuildContext context)=>new GridViewApp(),
      '/c':(BuildContext context)=>new ListviewApp(),
      '/d':(BuildContext context)=>new StackApp(),
    },
  ));
}

class HomePage extends StatefulWidget{
   @override
   State<StatefulWidget> createState() {
       return _HomePageState();

   }
}
const String CONTAINER_DEMO_PAGE ='/a';

class _HomePageState extends State<HomePage>{
   @override
    Widget build(BuildContext context) {
     getGestureDetector(String routeName,String content){
        return new GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(routeName);
          },
          child: new Container(
            padding: EdgeInsets.all(20.0),
            child: new Center(child: new Text(content),),
          ),
        );
     }
       return new Scaffold(
           appBar: new AppBar(title: new Text('home'),),
        body: new Column(children: <Widget>[
          getGestureDetector(CONTAINER_DEMO_PAGE , 'container demo'),
          getGestureDetector('/b', 'Grid demo 1'),
          getGestureDetector('/c', 'listview Demo'),
          getGestureDetector('/d', 'stack demo'),
          getGestureDetector('/e',  'Button page'),
        ],),
       );
    }
}