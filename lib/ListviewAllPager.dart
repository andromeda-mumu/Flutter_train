import 'package:flutter/material.dart';
/**--------------
 * 1.静态添加数据
 * 2.动态添加数据,用户滚动到底部，加载新数据
 * 3.进度条提示
 * 4.处理空数据，给予动画
 *
 * ----------------*/
void main(){
  runApp(new MaterialApp(
      title: 'list',
      home: new MyHomePage(),
  ));
}
class MyHomePage extends StatefulWidget{
   @override
   State<StatefulWidget> createState() {
       return _MyHomePageState();
   }
}


class _MyHomePageState extends State<MyHomePage>{
  //from 包括 to不包括
  //通过这个模拟http请求
  Future<List<int>> fakeRequest(int from,int to) async{
    return Future.delayed(Duration(seconds: 2),(){
      return List.generate(to-from, (i)=>i+from);

    });
  }

  List<int> items = List.generate(20, (i)=>i);//产生数据
  ScrollController _scrollController = new ScrollController();
  bool isPerfoormingRequest = false;//是否正在请求

  Widget _buildProgressIndicator(){
    return new Padding(
      padding: const EdgeInsets.all(8),
      child: new Center(
        child: new Opacity(
            opacity: isPerfoormingRequest?1.0:0.0,
            child:new CircularProgressIndicator()
      ),),
    );
  }
  @override
  void initState() {
    super.initState();
    _scrollController.addListener((){
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
        _getMoreData();
      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  _getMoreData() async{
    if(!isPerfoormingRequest){
      setState(()=>isPerfoormingRequest=true);
//      List<int> newEntiries = await fakeRequest(items.length, items.length+10);
      List<int> newEntiries = await fakeRequest(items.length, items.length);
      if(newEntiries.isEmpty){
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent-_scrollController.position.pixels;
        if(offsetFromBottom<edge){
          _scrollController.animateTo(
              _scrollController.offset-(edge-offsetFromBottom),
              duration: new Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }
      setState(() {
        items.addAll(newEntiries);
        isPerfoormingRequest = false;//下一次请求可以开始
      });
    }
  }

   @override
    Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(title: new Text('infinite listview'),),
         body: ListView.builder(
             itemBuilder: (context,index){
               if(index==items.length-1){
                 return _buildProgressIndicator();
               }else{
                 return ListTile(title: new Text('number $index'));
               }
             },
             itemCount: items.length,
             controller: _scrollController
         ),
       );
    }
}