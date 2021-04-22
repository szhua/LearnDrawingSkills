import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Painters'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var mins = 0 ;

  @override
  void initState() {
    super.initState();
         Timer.periodic(Duration(seconds: 1),(timer){
                  mins++;
                  if(mins>60){
                    mins=mins%60;
                  }
                  setState(() {
                    
                  });
         });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        floatingActionButton: ElevatedButton(onPressed: (){
                setState(() {
                  mins++;
                });
              }, child: Text("$mins")),
        body: Center(
          child: CustomPaint(
            painter: MyPainter(minutes: mins),
            child: Container(
              height: 100,
              width: 100,
              child: Center(
                
              ),
            ),
          ),
        ));
  }
}

class MyPaintLayout extends SingleChildRenderObjectWidget {
  MyPaintLayout({Widget child}) : super(child: child);
  @override
  RenderObject createRenderObject(BuildContext context) {
    return MyPainterRenderObject();
  }
}

class MyPainterRenderObject extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  @override
  void performLayout() {
  
    child.layout(BoxConstraints.tight(size), parentUsesSize: true);
    size = child.size;
    print(size);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    child.paint(context, offset);
  }
}

class MyPainter extends CustomPainter {

  var minutes =0  ;

  MyPainter({this.minutes});



  void drawStokeJoin(Canvas canvas) {
    var paint = Paint();
    paint
      ..color = Colors.blue
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel;
    var path = Path();
    path.moveTo(50, 50);
    path.lineTo(50, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint);

    paint
      ..color = Colors.blueGrey
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.miter
      ..strokeMiterLimit = 1.2;
    path.reset();
    path.moveTo(200, 50);
    path.relativeLineTo(0, 100);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint);

    paint
      ..color = Colors.blue
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    path.reset();
    path.moveTo(350, 50);
    path.relativeLineTo(0, 100);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint);
  }

  void drawLineStrokeCap(Canvas canvas) {
    var paint = Paint();
    canvas.drawLine(
        Offset(540, 360),
        Offset(540, 540),
        paint
          ..color = Colors.blueGrey
          ..strokeWidth = 20);
    canvas.drawLine(
        Offset(570, 360),
        Offset(570, 540),
        paint
          ..color = Colors.red
          ..strokeWidth = 20
          ..strokeCap = StrokeCap.round);
    canvas.drawLine(
        Offset(600, 360),
        Offset(600, 540),
        paint
          ..color = Colors.red
          ..strokeWidth = 20
          ..strokeCap = StrokeCap.square);
  }

  void drawIsAntiAliasColor(Canvas canvas) {
    var paint = Paint();
    canvas.drawCircle(
        Offset(180, 180),
        170,
        paint
          ..color = Colors.greenAccent
          ..strokeWidth = 10);

    canvas.drawCircle(
        Offset(180 + 360.0, 180),
        170,
        paint
          ..color = Colors.redAccent
          ..isAntiAlias = false
          ..strokeWidth = 10);

    canvas.drawCircle(
        Offset(180, 180 + 360.0),
        170,
        paint
          ..color = Colors.orangeAccent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10);
  }

  void drawStrokeMiterLimit(Canvas canvas) {
    Paint paint = Paint();
    Path path = Path();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeJoin = StrokeJoin.miter
      ..strokeWidth = 20;
    for (int i = 0; i < 4; i++) {
      path.reset();
      path.moveTo(50 + 150.0 * i, 50);
      path.lineTo(50 + 150.0 * i, 150);
      path.relativeLineTo(100, -(40.0 * i + 20));
      canvas.drawPath(path, paint..strokeMiterLimit = 2);
    }
    for (int i = 0; i < 4; i++) {
      path.reset();
      path.moveTo(50 + 150.0 * i, 50 + 150.0);
      path.lineTo(50 + 150.0 * i, 150 + 150.0);
      path.relativeLineTo(100, -(40.0 * i + 20));
      canvas.drawPath(path, paint..strokeMiterLimit = 0);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // drawIsAntiAliasColor(canvas);
    // drawLineStrokeCap(canvas);
    // drawStokeJoin(canvas);
    //drawStrokeMiterLimit(canvas);
    drawCenterCircle(canvas, size);
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return oldDelegate.minutes==minutes;
  }

  void drawCenterCircle(Canvas canvas, Size size) {
       var radius = min(size.width, size.height)/2;
       var paint  =Paint()..color=Colors.blue..style=PaintingStyle.stroke..strokeWidth=radius/10;
      // canvas.drawCircle(Offset(radius,radius), radius-radius/10, paint); 
       canvas.translate(radius,radius);
       canvas.drawCircle(Offset.zero, radius-radius/10, paint); 

        canvas.drawLine(
      Offset(0,0),
      Offset(0, radius-radius/10-30),
      paint
        ..color = Colors.red
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke);


  var angle = pi*minutes/30-pi/2;
  print(cos(angle));
  print(sin(angle));
  var le =radius-radius/10-20;
  var offsetEnd = Offset(cos(angle)*le, sin(angle)*le);
  

   canvas.drawLine(
      Offset(0,0),
      offsetEnd,
      paint
        ..color = Colors.green
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke);
  }
}
