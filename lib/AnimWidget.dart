import 'package:flutter/material.dart';

/**
 * 放大动画
 */
class AnimWidget extends StatefulWidget {
  @override
  _AnimWidgetState createState() => new _AnimWidgetState();
}

class _AnimWidgetState extends State<AnimWidget> with SingleTickerProviderStateMixin {
  var controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=AnimationController(
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );
    // 调用 forward 方法开始动画
    controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      child: FlutterLogo(size: 200),
      scale: controller,
    );
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'animation',
      home: Scaffold(
        appBar: AppBar(title: Text('animation'),),
        body: AnimWidget(),
      ),
    );
  }
}
void main(){
  runApp(MyApp());
}
