import 'package:flutter/material.dart';

/**
 * 放大动画 非线性
 */
class AnimWidget extends StatefulWidget {
  @override
  _AnimWidgetState createState() => new _AnimWidgetState();
}

class _AnimWidgetState extends State<AnimWidget> with SingleTickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=AnimationController(
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );
    curve=CurvedAnimation(parent: controller, curve: Curves.easeInOut,);
    // 调用 forward 方法开始动画
    controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    var scaled =  ScaleTransition(
      child: FlutterLogo(size: 200),
      scale: curve,
    );
    return FadeTransition(
      child: scaled,
      opacity: curve,
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
