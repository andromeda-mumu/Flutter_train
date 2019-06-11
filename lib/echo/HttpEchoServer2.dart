import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import '../Message.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sqflite/sqflite.dart';
/**
 * Created by wangjiao on 2019/6/11.
 * description: 服务端架构
 */
class HttpEchoServer2{
  String historyFilepath;
  static const GET ='get';
  static const POST='post';
  static const List<Message> messages=[];
  final int port;
  HttpServer httpServer;
//  Map<String,void Function(HttpServer)> routes;
  Map<String, void Function(HttpRequest)> routes;

  static const tableName ='history';
  static const columnId ='id';
  static const columnMsg='msg';
  static const columnTimestamp ='timestamp';
  Database database;


  HttpEchoServer2(this.port){
    _initRoutes();
  }

  void _initRoutes() {
    routes = {
      // 我们只支持 path 为 '/history' 和 '/echo' 的请求。
      // history 用于获取历史记录；
      // echo 则提供 echo 服务。
      '/history': _history,
      '/echo': _echo,
    };
  }

  Future start() async{
    await _initDatabase();
    historyFilepath = await _historyPath();
    //在启动服务器前先加载历史记录
    await _loadMessages();
    httpServer = await HttpServer.bind(InternetAddress.loopbackIPv4,port);
    //开始监听客户请求
    return httpServer.listen((request){
      final path = request.uri.path;
      final handler =routes[path];
      if(handler!=null){
        handler(request);
      }else{
        //给客户端一个返回404
        request.response.statusCode = HttpStatus.notFound;
        request.response.close();
      }
    });
  }
  Future _initDatabase() async{
    var path = await getDatabasesPath()+"/history.db";
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db,version)async{
          var sql='''
         CREATE TABLE $tableName (            
         $columnId INTEGER PRIMARY KEY,            
         $columnMsg TEXT,            
         $columnTimestamp INTEGER            
         )
          ''';
          await db.execute(sql);
     }
    );
  }
  Future _loadMessages()async{
//    try {
//      var file = File(historyFilepath);
//      var exits = await file.exists();
//      if(!exits) return;
//
//      var content = await file.readAsString();
//      var list = json.decode(content);
//      for(var msg in list){
//        var message = Message.fromJson(msg);
//        messages.add(message);
//      }
//    }catch(e){
//      print("mmc= _loadMessages:$e");
//    }

  //使用数据库的方式获取
    var list = await database.query(
      tableName,
      columns: [columnMsg,columnTimestamp],
      orderBy: columnId,
    );
    for(var item in list){
      var message = Message.fromJson(item);
      messages.add(message);
    }
  }
  Future<String> _historyPath() async{
    //获取应用的私有的文件目录
    final directory = await path_provider.getApplicationDocumentsDirectory();
    return directory.path+'/messages.json';
  }
  //把messages全部返回给客户端
  void _history(HttpRequest request){
    if(request.method!=GET){
      _unsupportedMethod(request);
      return;
    }
    String historyData = json.encode(messages);
    request.response.write(historyData);
    request.response.close();
  }
  _unsupportedMethod(HttpRequest request){
    request.response.statusCode= HttpStatus.methodNotAllowed;
    request.response.close();
  }
  void _echo(HttpRequest request) async{
    if(request.method!=POST){
      _unsupportedMethod(request);
      return;
    }
    //获取从客户端POST请求的body,
    String body = await request.transform(utf8.decoder).join();
    if(body!=null){
      var message = Message.create(body);
      messages.add(message);
      request.response.statusCode = HttpStatus.ok;
      // json 是 convert 包里的对象，encode 方法还有第二个参数 toEncodable。当遇到对象不是
      //  Dart 的内置对象时，如果提供这个参数，就会调用它对对象进行序列化；这里我们没有提供，      
      //  所以 encode 方法会调用对象的 toJson 方法，这个方法在前面我们已经定义了
      var data = json.encode(messages);
      request.response.write(data);
      _storeMessages(message);
    }else{
      request.response.statusCode = HttpStatus.badRequest;
    }
    request.response.close();


  }
  Future<bool> _storeMessages(Message msg) async{
//    try{
//      //json.decode支持list map
//      final data =json.encode(messages);
//      final file = File(historyFilepath);
//      final exits = await file.exists();
//      if(!exits){
//        await file.create();
//      }
//      file.writeAsString(data);
//      return true;
//      // 虽然文件操作方法都是异步的，我们仍然可以通过这种方式 catch 到
//      // 他们抛出的异常
//    }catch(e){
//      print("mmc= _storeMessages:$e");
//      return false;
//    }

  database.insert(tableName, msg.toJson());
  }

  void close()async{
    var server = httpServer;
    httpServer = null;
    await server?.close();

    var db = database;
    database=null;
    db?.close();
  }

}