

import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';

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


    canvas.translate(size.width/2, size.height/2);


    _drawAxis(canvas, size);
    _drawGrids(canvas,size);

    // _drawPointsWithPoints(canvas);
    //    _drawPointsWithLines(canvas);
    //    _drawPointLineWithPolygon(canvas);
   // _drawRawPoints(canvas);
  //  _drawRect(canvas);
   // _drawRRect(canvas);

    _drawDRRect(canvas);





  }
  var   _paint = Paint() ;
  final List<Offset> points = [
    Offset(-120, -20),
    Offset(-80, -80),
    Offset(-40, -40),
    Offset(0, -100),
    Offset(40, -140),
    Offset(80, -160),
    Offset(120, -100),
  ];

  void _drawRawPoints(Canvas canvas) {
    Float32List pos = Float32List.fromList([
      -120, 20,-80, 80,-40,
      -40,0, -100,40, -140,
      80, -160,120, -100]);
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawRawPoints(PointMode.polygon, pos, _paint);
  }


  void _drawAxis(Canvas canvas, Size size) {
    _paint..color=Colors.blue..strokeWidth=2;
    // canvas.save();
    // canvas.translate(0, 150);
    canvas.drawLine(Offset(-size.width/2, 0) , Offset(size.width/2, 0),_paint);
    canvas.drawLine(Offset(size.width/2, 0) , Offset(size.width/2-10, 7),_paint);
    canvas.drawLine(Offset(size.width/2, 0) , Offset(size.width/2-10, -7),_paint);
    //canvas.restore();
    canvas.drawLine(Offset( 0,-size.height/2) , Offset( 0,size.height/2),_paint);
    canvas.drawLine(Offset( 0,size.height/2) , Offset( 0-7.0,size.height/2-10),_paint);
    canvas.drawLine(Offset( 0,size.height/2) , Offset( 0+7.0,size.height/2-10),_paint);

  }
  void _drawPointLineWithPolygon(Canvas canvas) {
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.polygon, points, _paint);
  }


  void _drawPointsWithLines(Canvas canvas) {
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.lines, points, _paint);
  }


  void _drawPointsWithPoints(Canvas canvas) {
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke..strokeWidth=10
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.points, points, _paint);
  }


  void _drawRect(Canvas canvas){
    _paint..color=Colors.blue..strokeWidth=1.5..style=PaintingStyle.fill;
    //【1】.矩形中心构造
    Rect rectFromCenter = Rect.fromCenter(center: Offset(0, 0),width: 160,height: 160);
    canvas.drawRect(rectFromCenter, _paint);
    //【2】.矩形左上右下构造
    Rect rectFromLTRB = Rect.fromLTRB(-120, -120, -80, -80);
    canvas.drawRect(rectFromLTRB, _paint..color=Colors.red);
    //【3】. 矩形左上宽高构造
    Rect rectFromLTWH = Rect.fromLTWH(80, -120, 40, 40);
    canvas.drawRect(rectFromLTWH, _paint..color=Colors.orange);
    //【4】. 矩形内切圆构造
    Rect rectFromCircle = Rect.fromCircle(center: Offset(100, 100),radius: 20);
    canvas.drawRect(rectFromCircle, _paint..color=Colors.green);
    //【5】. 矩形两点构造
    Rect rectFromPoints= Rect.fromPoints(Offset(-120 , 80),Offset(-80 , 120));
    canvas.drawRect(rectFromPoints, _paint..color=Colors.purple);
  }


  void _drawRRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..style=PaintingStyle.fill
      ..strokeWidth = 1.5;
    //【1】.圆角矩形fromRectXY构造
    Rect rectFromCenter =
    Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRRect(RRect.fromRectXY(rectFromCenter, 40, 20), _paint);

    //【2】.圆角矩形fromLTRBXY构造
    canvas.drawRRect(RRect.fromLTRBXY(-120, -120, -80, -80, 10, 10),
        _paint..color = Colors.red);

    //【3】. 圆角矩形fromLTRBR构造
    canvas.drawRRect(RRect.fromLTRBR(80, -120, 120, -80, Radius.circular(10)),
        _paint..color = Colors.orange);

    //【4】. 圆角矩形fromLTRBAndCorners构造
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(80, 80, 120, 120,
            bottomRight: Radius.elliptical(10, 10)),
        _paint..color = Colors.green);

    //【5】. 矩形两点构造
    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 80), Offset(-80, 120));
    canvas.drawRRect(
        RRect.fromRectAndCorners(rectFromPoints,
            bottomLeft: Radius.elliptical(10, 10)),
        _paint..color = Colors.purple);
  }


  void _drawDRRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..style=PaintingStyle.fill
      ..strokeWidth = 1.5;
    Rect outRect =
    Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    Rect inRect =
    Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100);

    canvas.drawDRRect(RRect.fromRectXY(outRect, 20, 20),
        RRect.fromRectXY(inRect, 20, 20), _paint);


    Rect outRect2 =
    Rect.fromCenter(center: Offset(0, 0), width: 60, height: 60);
    Rect inRect2 =
    Rect.fromCenter(center: Offset(0, 0), width: 40, height: 40);
    canvas.drawDRRect(RRect.fromRectXY(outRect2, 15, 15),
        RRect.fromRectXY(inRect2, 10, 10), _paint..color=Colors.green);
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
     return true ;
  }

  void _drawGrids(Canvas canvas, Size size) {
    _paint
      ..color = Colors.grey.shade500
      ..style = PaintingStyle.stroke..strokeWidth=1
      ..strokeCap = StrokeCap.square;
    for(var i =0 ;i<10;i++){
      var gap = size.height/20 ;
      canvas.drawLine(Offset(-size.width/2, i*gap), Offset(size.width/2, i*gap), _paint);
      canvas.drawLine(Offset(-size.width/2, -i*gap), Offset(size.width/2, -i*gap), _paint);
    }

    var count = size.width/(size.height/20)/2+1;


    for(var i =0 ;i<count;i++){
      var gap = size.height/20 ;
      canvas.drawLine(Offset(i*gap, -size.height/2), Offset(i*gap, size.height/2), _paint);
      canvas.drawLine(Offset(-i*gap, -size.height/2), Offset(-i*gap, size.height/2), _paint);
    }

  }

}


