import 'package:flutter/material.dart';

void main(){
  runApp(new GridViewApp());
}

class GridViewApp extends StatelessWidget{
   @override
    Widget build(BuildContext context) {
       return new MaterialApp(
         title: 'grid page1 demo',
         theme: new ThemeData(primarySwatch:Colors.brown),
         home: new GlideDemo1Page(),
       );
    }
}

class GlideDemo1Page extends StatefulWidget{
   @override
   State<StatefulWidget> createState() {
       return _GlidDemo1Page();
   }
}

class _GlidDemo1Page extends State<GlideDemo1Page>{
   @override
    Widget build(BuildContext context) {
       return new Scaffold(
         appBar: new AppBar(title: new Text('Grid page 1 demo'),),
         body: new Center(child: buildGrid(),),
       );
    }

    List<Container> _buildGridTitleList(int count){
     return new List<Container>.generate(count, (int index)=>
     new Container(child: new Image.asset('images/pic${index+1}.png'),));
    }

    Widget buildGrid(){
      var countGrid = GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0 ,
        padding: const EdgeInsets.all(4),
        childAspectRatio: 1.5 ,
        children: _buildGridTitleList(10),
      );
          return countGrid;
    }

    /**--------------使用extent指定最大宽度----------------*/
   /* Widget buildGrid(){
      return new GridView.extent(
          maxCrossAxisExtent: 200,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children:_buildGridTitleList(10),
      );
    }*/

}