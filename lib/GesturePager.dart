import 'package:flutter/material.dart';
void main(){
  runApp(new MaterialApp(title: 'gesture',home: new TestWidget(),));
}
class TestWidget extends StatelessWidget{
  @override
   Widget build(BuildContext context) {
//    return GestureDetector(
//      child: Text('text'),
//      onTap: ()=> debugPrint('clicked'),
//    );
    return Listener(
      child: Text('text'),
      onPointerDown: (event)=>print('mmc= onPointDown'),
      onPointerUp: (event)=>print('mmc= onPointUp'),
      onPointerMove: (event)=>print('mmc= onPointMove'),
      onPointerCancel: (event)=>print('mmc= onPointCancel'),
    );
   }
}