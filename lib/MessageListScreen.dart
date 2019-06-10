import 'package:flutter/material.dart';
//https://juejin.im/post/5bdf10156fb9a049f66b8c2f#heading-4
import 'Message.dart';
import 'MessageForm.dart';
//消息展示页
class MessageListScreen extends StatelessWidget{
  /**
   * 引入一个 GlobalKey 的原因在于，MessageListScreen 需要把从 AddMessageScreen
   * 返回的数据放到 _MessageListState 中，而我们无法从 MessageList 拿到这个 state
   */
  final messageListKey = GlobalKey<_MessageListState>(debugLabel: 'messageListKey');
   @override
    Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(
           title: Text('echo client'),
         ),
         body: MessageList(key: messageListKey),
         floatingActionButton: FloatingActionButton(
             onPressed: ()async{
               //push 一个新的route到navigator管理的栈中
              final result = await Navigator.push(
                 context,
                 MaterialPageRoute(builder: (_)=>AddMessageScreen())
               );
              debugPrint('result =$result');
              if(result is Message){
                messageListKey.currentState.addMessage(result);
              }
             },

           tooltip: 'Add message',
           child: Icon(Icons.add),
         ),
       );
    }
}
class MessageList extends StatefulWidget {
  MessageList({Key key}):super(key:key);
  @override
  _MessageListState createState() => new _MessageListState();
}


class _MessageListState extends State<MessageList> {
  final List<Message> messages =[];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
        itemBuilder: (context,index){
         final msg = messages[index];
         final subtitle = DateTime.fromMicrosecondsSinceEpoch(msg.timestamp).toLocal().toIso8601String();
         return ListTile(
           title: Text(msg.msg),
           subtitle: Text(subtitle),
         );
        }
    );
  }
  void addMessage(Message msg){
    setState(() {
      messages.add(msg);
    });
  }
}


void main(){
  runApp(new MyListApp());
}
class MyListApp extends StatelessWidget{
   @override
    Widget build(BuildContext context) {
       return MaterialApp(
         title: 'Flutter Ux Demo',
         home: MessageListScreen(),
       );
    }
}