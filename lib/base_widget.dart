//import 'package:flutter/material.dart';
///*-------flex----------------*/
//class baseWidget extends StatelessWidget{
//   @override
//    Widget build(BuildContext context) {
//       return new Flex(
//           direction: Axis.horizontal,
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           new Flexible(
//             flex: 2,
//             fit: FlexFit.loose,
//             child: new Container(
//               color: Colors.blue,
//               height: 60,
//               alignment: Alignment.center,
//               child: const Text(
//                   'left!',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.black),
//                 textDirection: TextDirection.ltr,
//               ),
//             ),
//           ),
//           new Flexible(
//               flex: 1,
//               fit: FlexFit.loose,
//               child: new Container(
//                 color: Colors.red,
//                 height: 60,
//                 alignment: Alignment.center,
//                 child: const Text('right',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.black),
//                   textDirection: TextDirection.ltr,
//                 ),
//           ))
//         ],
//
//       );
//    }
//}
///**--------------stack----------------*/
//
//class stackWidget extends StatelessWidget{
//   @override
//    Widget build(BuildContext context) {
//       return new Container(
//          color: Colors.yellow,
//         height: 150,
//         width: 100,
//         child: new Stack(
//           children: <Widget>[
//             new Container(
//               color: Colors.blueAccent,
//               height: 50,
//               width: 100,
//               alignment: Alignment.center,
//               child: Text('unpositioned'),
//             ),
//             new Positioned(
//                 left: 40,
//                 top: 80,
//                 child: new Container(
//                  color: Colors.pink,
//                   height: 50,
//                   width: 94,
//                   alignment: Alignment.center,
//                   child: Text('positioned'),
//             ))
//           ],
//         ),
//       );
//    }
//}
//
//class VisibleWidget extends StatelessWidget{
//   @override
//    Widget build(BuildContext context) {
//       return isVisible?Widget:new Container();
//    }
//}
//
//class offstageWidget extends StatelessWidget{
//   @override
//    Widget build(BuildContext context) {
//       return new Offstage(
//         offstage: !isVisible,
//         child: child,
//       );
//    }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
