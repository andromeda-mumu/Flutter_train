import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/animation.dart';
/**
 * Created by wangjiao on 2019/6/10.
 * description: 自定义动画，让一个圆点进行曲线运动
 */

class AnimationDemo extends StatefulWidget {
  @override
  _AnimationDemoState createState() => new _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo> with SingleTickerProviderStateMixin{
  static const Padding=16.0;
  AnimationController controller;
  Animation<double> left;

  Animation<Color> color;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //future是在dart事件队列里插入一个事件，以达到延后执行的目的
    Future(_initState);
  }
  void _initState(){
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000),
        //vsync提供时针滴答，触发动画的更新
        vsync: this);
    //获得屏幕宽度
    final MediaQueryData = MediaQuery.of(context);
    final displayWidth = MediaQueryData.size.width;
    debugPrint('width = $displayWidth');
    //
    left=Tween(begin: Padding,end:displayWidth-Padding).animate(controller)
    //每一帧都会触发listener回调
    ..addListener((){
      //这个值是随着动画的进行不断变化的，就是利用这个值实现动画效果的
      print('mmc=  value=${left.value}');
      // 调用 setState 触发他重新 build 一个 Widget。在 build 方法里，我们根据
      // Animatable<T> 的当前值来创建 Widget，达到动画的效果（类似 Android 的属性动画）。
      //不太理解这里 todo
      setState(() {

      });
    })
    ..addStatusListener((status){
      if(status==AnimationStatus.completed){
        controller.reverse();
      }else if(status == AnimationStatus.dismissed){
         controller.forward();
      }
    });
    color = ColorTween(begin: Colors.red,end: Colors.blue).animate(controller);
    controller.forward();

  }

  @override
  Widget build(BuildContext context) {
    //假定一个单位是24
    final unit = 24.0;
    final marginLeft = left==null?Padding:left.value;

    //把marginLeft单位化
    final unitizedLeft = (marginLeft-Padding)/unit;
    final unitizedTop = math.sin(unitizedLeft);
    // unitizedTop + 1 是了把 [-1, 1] 之间的值映射到 [0, 2]
    // (unitizedTop+1) * unit 后把单位化的值转回来
    final marginTop = (unitizedTop+1)*unit+Padding;

    final color = this.color==null?Colors.red:this.color.value;
    return new Container(
      //根据动画的进度设置动画的位置
      margin: EdgeInsets.only(left: marginLeft,top: marginTop),
      child: Container(
        decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(7.5)),
        width: 15.0,
        height: 15.0,
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter animation demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Animation demo'),),
        body:AnimationDemo() ,
      ),
    );
  }
}
void main(){
    runApp(
       new MyApp()
    );

}

