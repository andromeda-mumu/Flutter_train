import 'package:flutter/material.dart';
void main(){
  runApp(new CardApp());
}
class CardApp extends StatelessWidget{
   @override
    Widget build(BuildContext context) {
       return MaterialApp(
         title:'listview demo',
         home: new CardPage(),
       );
    }
}
class CardPage extends StatefulWidget{
   @override
   State<StatefulWidget> createState() {
       return _ListViewPageState();
   }
}

class _ListViewPageState extends State<CardPage>{
   @override
    Widget build(BuildContext context) {
     List<Widget> list = <Widget>[];
     for(int i=0;i<10;i++){
       list.add(new Card(
         child:new Column(
           children: <Widget>[
             new Image.asset('images/pic${i+1}.png',),
             new ListTile(
               title: new Text('title$i',style: _itemTextStyle,),
               subtitle: new Text('A'),
               leading: i%3==0?new Icon(Icons.theaters,color: Colors.blue,):new Icon(Icons.restaurant,color: Colors.blue,),
             )
           ],
         )
       ));
     }

       return new Scaffold(
         appBar: new AppBar(title: new Text('listview demo'),),
         body: new Center(child: new ListView(children: list,),),
       );
    }
}
TextStyle _itemTextStyle = new TextStyle(
  fontWeight: FontWeight.w500,fontSize: 14.0);