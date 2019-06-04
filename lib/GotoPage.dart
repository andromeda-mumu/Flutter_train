import 'package:flutter/material.dart';

/**
 * 页面跳转
 * 并且通过页面跳转传递数据
 */

void main(){
  runApp(new MaterialApp(
      title: '页面跳转' ,
      home: FirstScreen(),
  )
  );
  }
class FirstScreen extends StatefulWidget{
    @override
    State<StatefulWidget> createState() {
        return _FirstScreenState();
    }
}
class _FirstScreenState extends State<FirstScreen>{
   @override
    Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(title: new Text('Navigation demo'),),
         body: Center(
           child: RaisedButton(
               child: Text('First Screen'),
               onPressed: ()async{
                 var msg = await Navigator.push(context, MaterialPageRoute(builder: (_)=>SecondScreen()));
                 debugPrint('mmc=  msg=$msg');
//                   Navigator.push(context, MaterialPageRoute(builder: (_)=>SecondScreen()));
                }),
         ),
       );
    }
}

class SecondScreen extends StatefulWidget{
   @override
   State<StatefulWidget> createState() {
       return _SecondScreenState();
   }
}
class _SecondScreenState extends State<SecondScreen>{
   @override
    Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(title: Text('Navigation demo'),),
         body: Center(
            child: RaisedButton(
                child: Text('Second screen'),
                onPressed: (){
                    Navigator.pop(context,'message from second screen');
                  }),
         ),
       );
    }
}