import 'package:flutter/material.dart';
import 'dart:math' as math;
/**
 * Created by wangjiao on 2019/6/10.
 * description: 画一段圆弧
 * 2 加载动画，圆圈
 */

class PainterDemo extends CustomPainter{
  final double _arcStart;
  final double _arcSweep;
  PainterDemo(this._arcStart,this._arcSweep);
  @override
  void paint(Canvas canvas, Size size) {
    double size = 100;
    Paint paint = Paint()
    ..color=Colors.blue
    ..strokeCap=StrokeCap.round
    ..strokeWidth=4.0
    ..style=PaintingStyle.stroke;
    canvas.drawArc(Offset.zero & Size(size,size), _arcStart, _arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(PainterDemo other) {
    return _arcStart!=other._arcStart || _arcSweep !=other._arcSweep;
  }

}
class PaintWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: CustomPaint(painter: PainterDemo(0.0,3.14 )),
      height: 200.0,
      width: 200.0,
      color: Colors.deepOrange,
      padding: EdgeInsets.all(30.0),
    );
  }
}

void main(){
    runApp(
       new MaterialApp(
          title: 'Painter demo',
         home:Scaffold(
           appBar: AppBar(title: Text('painter demo'),),
           body:  DemoWidget(),
         ),
       )
    );

}


//动画，画一个圆圈
class DemoWidget extends StatefulWidget {
  @override
  _DemoWidgetState createState() => new _DemoWidgetState();
}

class _DemoWidgetState extends State<DemoWidget> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 1500))
    ..repeat()
    ..addListener((){
      setState(() {

      });
    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
//    return new Container(
//        child:CustomPaint(painter: PainterDemo(0.0, _controller.value*3.14*2)),
//      height: 200.0,
//      width: 200.0,
//      color: Colors.deepOrange,
//      padding: EdgeInsets.all(30.0),
//    );

    return new Container(
      child:AnimatedBuilder(
        animation: _controller,
        builder: (context,child){
          return CustomPaint(
            painter: PainterDemo(
              Tween(begin: math.pi*1.5,end: math.pi*3.5)
                  .chain(CurveTween(curve: Interval(0.5,1.0)))
                  .evaluate(_controller),
              math.sin(Tween(begin: 0.0,end: math.pi).evaluate(_controller))*math.pi,
            ),
          );
        },
      ),
      height: 200.0,
      width: 200.0,
      color: Colors.deepOrange,
      padding: EdgeInsets.all(30.0),
    );
//  return AnimatedBuilder(
//    animation: _controller,
//    builder: (context,child){
//      return CustomPaint(
//        painter: PainterDemo(
//          Tween(begin: math.pi*1.5,end: math.pi*3.5)
//        .chain(CurveTween(curve: Interval(0.5,1.0)))
//        .evaluate(_controller),
//          math.sin(Tween(begin: 0.0,end: math.pi).evaluate(_controller))*math.pi,
//        ),
//      );
//    },
//  );
  }
}
