import "package:flutter/material.dart";

import 'Message.dart';

/**
 * 输入框 按钮
 * inkWell 可以坚挺手势事件，并且有水波纹效果
 */
class MessageForm extends StatefulWidget{
   @override
   State<StatefulWidget> createState() {
       return new _MessageFormState();
   }
}

class _MessageFormState extends State<MessageForm>{
  final editController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    editController.dispose();
  }
   @override
    Widget build(BuildContext context) {
       return Padding(
         padding: EdgeInsets.all(16),
         child: Row(
           children: <Widget>[
             Expanded(
               child: Container(
                   margin: EdgeInsets.only(right: 8),
                   child: TextField(
                     decoration: InputDecoration(
                       hintText: 'Input message',
                       contentPadding: EdgeInsets.all(0),
                     ),
                     style: TextStyle(
                       fontSize: 22,
                       color: Colors.black54
                     ),
                     controller: editController,
                     autofocus: true,
                   ),
                 ),
             ),
             InkWell(
//               onTap: ()=>debugPrint('send: ${editController.text}'),
             onTap: (){
               debugPrint('send: ${editController.text}');
               final msg = Message(
                 editController.text,
                 DateTime.now().millisecondsSinceEpoch
               );
               Navigator.pop(context,msg);//页面跳转传参
             },
               onDoubleTap: ()=>debugPrint('mmc= double tapped'),
               onLongPress: ()=>debugPrint('mmc= long pressed'),
               child: Container(
                 padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                 decoration: BoxDecoration(
                   color: Colors.black12,
                   borderRadius: BorderRadius.circular(5)
                 ),
                 child: Text('send'),
               ),
             )
           ],
         ),
       );
    }
}
class MyApp extends StatelessWidget{
   @override
    Widget build(BuildContext context) {
       return MaterialApp(
         title: 'Flutter UX demo',
         home: AddMessageScreen(),
       );
    }
}
class AddMessageScreen extends StatelessWidget{
   @override
    Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(
           title: Text('add message'),
         ),
         body: MessageForm(),
       );
    }
}
