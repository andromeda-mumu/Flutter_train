import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart'as http;
/**
 * Created by wangjiao on 2019/6/10.
 * description: 文件 json http sqlite
 */
//异步
void foo() async{
  const filepath = "path";
  var file = File(filepath);
  try{
    bool exists = await file.exists();
    if(!exists){
      await file.create();
    }
  }catch(e){
    print(e);
  }
}
//同步
void foo2() {
  const filepath = "path";
  var file = File(filepath);
  try{
    bool exists =  file.existsSync();
    if(!exists){
       file.createSync();
    }
  }catch(e){
    print(e);
  }
}
/**--------------写文件----------------*/
void foo3() async{
  const filepath ='path';
  var file = File(filepath);
  await file.writeAsString('hello,dart IO');
  List<int> toBeWritten = [1,2,3];
  await file.writeAsBytes(toBeWritten);
}

void foo4()async{
  const filepath ='path';
  var file = File(filepath);
  IOSink sink;
  try{
    //默认的写操作会覆盖原有内容，如果要拼接后面的内容，用append模式
//    sink=file.openWrite(mode: FileMode.append);
    sink = file.openWrite();
    sink.write('hello dart');
    await sink.flush();
  }catch(e){
    print(e);
  }finally{
    sink?.close();
  }
}

/**--------------读文件----------------*/
void foo5()async{
  const filepath = 'path';
  var file = File(filepath);
  try{
    Stream<List<int>> stream = file.openRead();
    //utf8编码，且每次返回一行
    var lines = stream.transform(utf8.decoder).transform(LineSplitter());
    await for(var line in lines){
      print(line);
    }
  }catch(e){
    print(e);
  }
}


/**--------------对象转json----------------*/
class Point{
  int x;
  int y;
  String description;
  Point(this.x,this.y,this.description);
  Point.fromJson(Map<String,dynamic> map):x=map['x'],y=map['y'],description=map['desc'];
  Map<String,dynamic> toJson()=>{
    'x':x,
    'y':y,
    'desc':description
  };
  @override
  String toString() {
    // TODO: implement toString
    return "point{x=$x,y=$y,desc=$description}";
  }
}

void ObjToJson(){
  var point = Point(2,12,'some point');
  var pointJson = json.encode(point);
  print('pointJson = $pointJson');

  //list map等都是支持的
  var points =[point,point];
  var pointsJson = json.encode(points);
  print('pointsJson=$pointsJson');

  //json转对象
  var decoded = json.decode(pointJson);
  print('decode.runtimeType=${decoded.runtimeType}');
  var point2 = Point.fromJson(decoded);
  print('point2=$point2');

  decoded = json.decode(pointsJson);
  print('decoded.runtimeType=${decoded.runtimeType}');
  var points2=<Point>[];
  for(var map in decoded){
    points2.add(Point.fromJson(map));
  }
  print('points2=$points2');
}
// 执行后打印出：
//  pointJson = {"x":2,"y":12,"desc":"Some point"}
//  pointsJson = [{"x":2,"y":12,"desc":"Some point"},{"x":2,"y":12,"desc":"Some point"}]

//decoded.runtimeType = _InternalLinkedHashMap<String, dynamic>
// point2 = Point{x=2, y=12, desc=Some point}
// decoded.runtimeType = List<dynamic>
// points2 = [Point{x=2, y=12, desc=Some point}, Point{x=2, y=12, desc=Some point}]


/**--------------http请求----------------*/
Future<String> getMessage()async{
  try{
    final response = await http.get('http://www.xxx.com/yyy/xxx');
    if(response.statusCode==200){
      return response.body;
    }
  }catch(e){
    print('getMessage:$e');
  }
  return null;
}















