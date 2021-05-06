import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:painter/coordinate.dart';
///
///
/// @defined ValueNotifier (extends from listenable)  当我们valueNotifier的value进行改变的情况下，会回调 markNeedPaint 方法
/// 这个方法会在 flush paint 中进行 paint 操作， 而 设置了 repaintBoundary = true 确保了 保证 仅仅是 当前层级被重新绘制；'
///
/// //嵌套避免进行重新绘制==》内部 repaintBoundary = ture
/// RepaintBoundary(
///
///   child: CustomPaint(
///
///     painter:MyCustomPainter(valueNotifier)
///
///   )
///
/// )
///
///
///
///
///




void main() {
  runApp(MaterialApp(home: DrawPathWidget()));
}

class DrawPathWidget extends StatefulWidget {
  @override
  _DrawPathWidgetState createState() => _DrawPathWidgetState();
}

class _DrawPathWidgetState extends State<DrawPathWidget> {


  ValueNotifier<BezierPoints> valueNotifier =
      ValueNotifier(BezierPoints(Offset.zero, Offset.zero));

  bool jude(BuildContext context ,DragStartDetails detail , Offset offset  ,{bool offset1 =true}){
    Offset currentLocation = detail.localPosition -
        Offset(context.size.width / 2, context.size.height / 2);
    var resultX = currentLocation.dx.clamp(
        offset.dx - 10,
        offset.dx + 10);
    var resultY = currentLocation.dy.clamp(
        offset.dy - 10,
        offset.dy + 10);
    if (resultX == currentLocation.dx && currentLocation.dy == resultY && offset1 ) {
       valueNotifier.value = valueNotifier.value.copy()..offset1=currentLocation..drag1=true..drag2=false;
       return true ;
    }
    if (resultX == currentLocation.dx && currentLocation.dy == resultY && !offset1 ) {
      valueNotifier.value = valueNotifier.value.copy()..offset2=currentLocation..drag1=false..drag2=true;
      return true ;
    }
    return false ;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    valueNotifier.value =BezierPoints.clear;
                  },
                  child: Text(
                    "REMOVE",
                    style: TextStyle(color: Colors.black),
                  )),
              SizedBox(
                width: 100,
              )
            ],
          )
        ],
      ),
      body: Center(child: Builder(builder: (context) {
        return Container(
          width: 800,
          height: 600,
          transform: Matrix4.diagonal3Values(300, 300, 1.0),
          child: GestureDetector(
            onLongPressStart: (detail) {
              Offset currentLocation = detail.localPosition -
                  Offset(context.size.width / 2, context.size.height / 2);
              valueNotifier.value =valueNotifier.value.copy()..point =currentLocation;

            },
            onPanEnd: (detal) {
              if (valueNotifier.value.drag1) {
                  valueNotifier.value.drag1 = false;
              }
              if(valueNotifier.value.drag2){
                 valueNotifier.value.drag2 = false;
              }
            },
            onPanStart: (detail) {
              var  result =jude(context,detail, valueNotifier.value.offset1,offset1: true);
              if(!result) {
                jude(context,detail, valueNotifier.value.offset2, offset1: false);
              }
            },
            onPanUpdate: (detail) {
              Offset currentLocation = detail.localPosition - Offset(context.size.width / 2, context.size.height / 2);
              if (valueNotifier.value.drag1) {
                valueNotifier.value = valueNotifier.value.copy()..offset1=currentLocation;
              }else if(valueNotifier.value.drag2){
                valueNotifier.value = valueNotifier.value.copy()..offset2=currentLocation;
              }
            },
            child: RepaintBoundary(
              child: CustomPaint(
                painter: MyPainter(valueNotifier: valueNotifier),
                size: Size(800, 600),
                child: SingleChildScrollView(),
              ),
            ),
          ),
        );
      })),
    );
  }
}

class BezierPoints {
  Offset point ;
  Offset offset1;
  Offset offset2;
  BezierPoints(this.offset1, this.offset2, {this.drag1=false,this.drag2=false,this.point= const Offset(100,80)});
  bool drag1 = false;
  bool drag2 = false;
  static  BezierPoints clear = BezierPoints(Offset.zero,Offset.zero);

  BezierPoints copy(){
    return BezierPoints(offset1,offset2,drag1: drag1,drag2:drag2,point: point);
  }



}

class MyPainter extends CustomPainter {
  final ValueNotifier<BezierPoints> valueNotifier;

  MyPainter({this.valueNotifier}) : super(repaint: valueNotifier);

  @override
  void paint(Canvas canvas, Size size) {
    Coordinate.drawCoordinateSystem(canvas, size);
    //_drawSamplePath(canvas);
    // _drawRelativePath(canvas);
    //_acrTo(canvas);
    //_arcToPoint(canvas);
    //_conicTo(canvas);
    _bezierTo(canvas);
   //   _cubicTo(canvas);

  }

  void _cubicTo(Canvas canvas) {
    Offset offset = valueNotifier.value.offset1;
    final Offset p1 = offset;
    final Offset p2 = valueNotifier.value.offset2;
    final Offset point=valueNotifier.value.point;
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    Path path = Path();
    path.cubicTo(p1.dx, p1.dy, p2.dx,p2.dy, point.dx, point.dy);
    canvas.drawPath(path, paint) ;

    canvas.drawPoints(
        PointMode.points,
        [p1,p2],
        paint
          ..color = Colors.green
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 20);


    canvas.drawLine(
        p1,
        Offset.zero,
        paint
          ..color = Colors.blueGrey
          ..strokeWidth = 2);

    canvas.drawLine(
        p2,
        point,
        paint
          ..color = Colors.blueGrey
          ..strokeWidth = 2);

  }

  void _bezierTo(Canvas canvas) {
    Offset offset = valueNotifier.value.offset1;
    final Offset p1 = offset;
    final Offset p2 = valueNotifier.value.point;
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
//path.relativeQuadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);

    canvas.drawPath(path, paint);

    canvas.drawPoints(
        PointMode.points,
        [p1],
        paint
          ..color = Colors.green
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 20);
    canvas.drawLine(
        p1,
        Offset.zero,
        paint
          ..color = Colors.blueGrey
          ..strokeWidth = 2);
    canvas.drawLine(
        p1,
        p2,
        paint
          ..color = Colors.blueGrey
          ..strokeWidth = 2);
  }

  void _conicTo(Canvas canvas) {
    final Offset p1 = Offset(80, -100);
    final Offset p2 = Offset(160, 0);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

//抛物线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1);
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(-180, 0);
//椭圆线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 0.5);
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(180 + 180.0, 0);
//双曲线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1.5);
    canvas.drawPath(path, paint);
  }

  void _arcToPoint(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path.lineTo(80, -40);

//绘制中间
    path
      ..arcToPoint(
        Offset(40, 40),
        radius: Radius.circular(60),
        largeArc: false,
      )
      ..close();
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(-150, 0);
//绘制左侧
    path.lineTo(80, -40);
    path
      ..arcToPoint(Offset(40, 40),
          radius: Radius.circular(60), largeArc: true, clockwise: false)
      ..close();
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(150 + 150.0, 0);
//绘制右侧
    path.lineTo(80, -40);
    path
      ..arcToPoint(
        Offset(40, 40),
        radius: Radius.circular(60),
        largeArc: true,
      )
      ..close();
    canvas.drawPath(path, paint);
  }

  void _drawRelativePath(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;
    path
      ..lineTo(0, 0)
      ..relativeLineTo(100, 120)
      ..relativeLineTo(-10, -60)
      ..relativeLineTo(60, -10)
      ..close();

    canvas.drawPath(path, paint);

    paint
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    path
      ..reset()
      ..moveTo(-200, 0)
      ..relativeLineTo(100, 120)
      ..relativeLineTo(-10, -60)
      ..relativeLineTo(60, -10)
      ..close();

    canvas.drawPath(path, paint);
  }

  void _acrTo(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;
    path.moveTo(30, 30);
    var rect = Rect.fromCenter(center: Offset(0, 0), width: 160, height: 100);
    path.arcTo(rect, 0, pi * 1.5, true);
    canvas.drawPath(path, paint);
  }

  void _drawSamplePath(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;
    path.moveTo(0, 0);
    path.lineTo(-100, 100);
    path.lineTo(-100, 0);
    path.lineTo(0, -100);
    path.close();
    canvas.drawPath(path, paint);

    canvas.save();
    canvas.scale(-1, 1);

    paint..style = PaintingStyle.fill;
    path.moveTo(0, 0);
    path.lineTo(-100, 100);
    path.lineTo(-100, 0);
    path.lineTo(0, -100);
    path.close();
    canvas.drawPath(path, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) =>
      valueNotifier != oldDelegate.valueNotifier;

  @override
  bool shouldRebuildSemantics(MyPainter oldDelegate) => false;
}
