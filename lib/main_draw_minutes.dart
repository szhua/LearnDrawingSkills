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
      home: MyHomePage(title: 'PaintersDrawMinutes'),
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
              height: 200,
              width: 200,
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
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    child.paint(context, offset);
  }
}

class MyPainter extends CustomPainter {

  var minutes =0  ;

  MyPainter({this.minutes});



  @override
  void paint(Canvas canvas, Size size) {
    // drawIsAntiAliasColor(canvas);
    // drawLineStrokeCap(canvas);
    // drawStokeJoin(canvas);
    //drawStrokeMiterLimit(canvas);
    drawDot(canvas, size);
    drawCenterCircle(canvas, size);
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return oldDelegate.minutes==minutes;
  }


  void drawDot(Canvas canvas ,Size size ){



     var radius = min(size.width, size.height)/2;

     canvas.save();
     canvas.translate(radius, radius);


     var paint  =Paint()..color=Colors.blueGrey..style=PaintingStyle.stroke..strokeWidth=10;
     canvas.save();
     for(var i =0 ;i <12 ;i++){
       var angle = pi*2/12 ;
       canvas.drawLine(Offset(radius/10*8,0),Offset(radius/10*9,0) , paint);
       canvas.rotate(angle);
     }
     canvas.restore();
     canvas.restore();
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
