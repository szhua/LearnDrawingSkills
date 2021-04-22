

import 'dart:math';
import 'dart:ui' as ui ;
import 'package:flutter/material.dart';
import 'package:painter/coordinate.dart';

void main(){
  runApp(MaterialApp(
      home: MyApp(),
  )) ;
}


class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}
class MyState extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: CustomPaint(
           painter: PagerPainter(),
           child: SizedBox(
             width: 900,
             height: 500,
             child: Container(
               decoration: BoxDecoration(
                 border:Border.all(color: Colors.blue,width: 0.1)
               ),
             ),
           ),
         ),
       ),
    );
  }
}
class PagerPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {

   // _drawPaint(canvas, size);
  //  canvas.drawColor(Colors.blue, BlendMode.lighten);


    Coordinate.drawCoordinateSystem(canvas, size);

    //_drawFill(canvas);

 //   drawShadow(canvas, size);

    //   _drawPath(canvas);

    //_clipCanvas(canvas);
   // _clipRRect(canvas);
    _clipPath(canvas);
  }

  var _paint =Paint()..style = PaintingStyle.fill..color=Colors.blueAccent;


  void drawShadow(Canvas canvas ,Size size){
    Path path = Path();
    path.lineTo(80, 80);
    path.lineTo(-80, 80);
    path.close();

    canvas.drawShadow(path, Colors.red, 3, true);
    canvas.save();
    canvas.translate(200, 0);
    canvas.drawShadow(path, Colors.red, 3, false);
    canvas.restore();
  }


  void _drawPaint(Canvas canvas,Size size){
    var colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    _paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, 0),
        colors, pos, TileMode.clamp);
    _paint.blendMode=BlendMode.overlay;
    canvas.drawPaint(_paint);
  }

  void _drawFill(Canvas canvas) {
    canvas.save();
    canvas.translate(-200, 0);
    canvas.drawCircle(Offset(0, 0), 60, _paint);
    canvas.restore();

    var rect = Rect.fromCenter(center: Offset(0, 0), height: 100, width: 120);
    canvas.drawOval(rect, _paint);

    canvas.save();
    canvas.translate(200, 0);
    //drawArc(矩形区域,起始弧度,扫描弧度,是否连中心,画笔)
    canvas.drawArc(rect, 0, pi / 2 * 3, true, _paint);
    canvas.restore();
  }

  void _drawPath(Canvas canvas){
     Path path = Path();
     path.lineTo(60, 60);
     path.lineTo(-60, 60);
     path.lineTo(60, -60);
     path.lineTo(-60, -60);
     path.close();
     canvas.save();
     canvas.drawPath(path, _paint);
     canvas.translate(140, 0);
     canvas.drawPath(
         path,
         _paint
           ..style = PaintingStyle.stroke
           ..strokeWidth = 2);
     canvas.restore();
  }


  void _clipCanvas(Canvas canvas){
    canvas.save();
    var rect = Rect.fromCenter(center: Offset.zero,width: 40,height: 100);
    canvas.clipRect(rect,doAntiAlias: true,clipOp: ui.ClipOp.intersect); //裁剪画布
    _drawPath(canvas);
    canvas.restore();
  }
  void _clipRRect(Canvas canvas){
    canvas.save();
    var rect = Rect.fromCenter(center: Offset.zero,width: 80,height: 100);
    //canvas.clipRRect(RRect.fromRectAndRadius(rect,Radius.circular(10)));
    canvas.clipRRect(RRect.fromRectAndCorners(rect,topLeft: Radius.circular(50)));
    _drawPath(canvas);
    canvas.restore();
  }

  void _clipPath(Canvas canvas){
    canvas.save();
    Path path = Path();
    path.lineTo(80, 80);
    path.lineTo(-180, 80);
    path.lineTo(100, -90);
    path.close();
    canvas.clipPath(path);
    canvas.drawColor(Colors.red, BlendMode.darken);
    canvas.restore();
  }



  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
     return true ;
  }


}


