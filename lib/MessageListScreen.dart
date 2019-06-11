import 'package:flutter/material.dart';
//https://juejin.im/post/5bdf10156fb9a049f66b8c2f#heading-4
import 'Message.dart';
import 'MessageForm.dart';
import 'echo/HttpEchoClient.dart';
import 'echo/HttpEchoServer.dart';
import 'echo/HttpEchoServer2.dart';
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
              //echo客户端
              if(_client==null)return;
              //不是直接构造一个message，而是通过_client把消息发送给服务端
              var msg=await _client.send(result);
              if(msg!=null){
                messageListKey.currentState.addMessage(msg);
              }else{
                debugPrint('fail to send $result');
              }
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

HttpEchoServer _server;
HttpEchoClient _client;
class _MessageListState extends State<MessageList> with WidgetsBindingObserver{
  final List<Message> messages =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const port = 6060;
    _server = HttpEchoServer(port);
    // initState 不是一个 async 函数，这里我们不能直接 await _server.start(),
    // future.then(...) 跟 await 是等价的
    _server.start().then((_){
      // 等服务器启动后才创建客户端
    _client=HttpEchoClient(port);
    //创建客户端后马上拉取历史记录
      _client.getHistory().then((list){
        setState(() {
          messages.addAll(list);
        });
      });
    });

    //注册生命周期回调
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state==AppLifecycleState.paused){
      var server = _server;
      _server =null;
      server?.close();
    }
  }
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