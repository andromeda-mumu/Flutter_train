import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
/**
 * Created by wangjiao on 2019/6/10.
 * description:数据库
 */
class Todo{
  static const columnId ='id';
  static const columnTitle ='title';
  static const columnContent ='content';

  int id;
  String title;
  String content;

  Todo(this.title,this.content,[this.id]);
  Todo.fromMap(Map<String,dynamic> map):id=map[columnId],title=map[columnTitle],content=map[columnContent];
  Map<String,dynamic> toMap()=>{
    columnTitle:title,
    columnContent:content,
  };
  @override
  String toString() {
    // TODO: implement toString
    return 'tODO{id=$id,title=$title,content$content}';
  }
}
void foo()async{
  const table ='Todo';
  var path = await getDatabasesPath()+'/demo.db';
  var database = await openDatabase(
    path,
    version: 1,
    onCreate: (db,version) async{
      var sql='''
      CREATE TABLE $table ('
      ${Todo.columnId} INTEFER PRIMART KEY,'
      ${Todo.columnTitle} TEXT,'
      ${Todo.columnContent} TEXT'
      )
      ''';
      await db.execute(sql);
    }
  );
  //先清掉数据
  await database.delete(table);

  var todo1 = Todo('Flutter','Learn Flutter widgets');
  var todo2 = Todo('Flutter','Learn how to IO in flutter');

  //插入数据
  await database.insert(table, todo1.toMap());
  await database.insert(table, todo2.toMap());

  List<Map> list = await database.query(table);
  todo1 = Todo.fromMap(list[0]);
  todo2 = Todo.fromMap(list[1]);
  print('mmc= query:todo1=$todo1');
  print('mmc= query:todo2=$todo2');

  todo1.content =' come on!';
  todo2.content +='I\'m tired';
  //使用事务
  await database.transaction((txn) async{
    //这里只能用txn，直接使用database会导致锁死
    await txn.update(table, todo1.toMap(),
      where: '${Todo.columnId}=?',whereArgs: [todo1.id]);
    await txn.update(table, todo2.toMap(),
      where: '${Todo.columnId}=?',whereArgs: [todo2.id]);
  });

  list = await database.query(table);
  for(var map in list){
    var todo = Todo.fromMap(map);
    print('mmc= update:todo=$todo');
  }

  await database.close();
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Listener(
      child: Text('测试数据库'),
      onPointerDown: (event)=>foo(),
    );
  }
}

void main(){
    runApp(
       new MaterialApp(
          title: 'sqlite demo',
          home: new Scaffold(
            appBar: AppBar(title: Text('aqilte demo'),),
            body: MyApp(),
          ),
       )
    );

}