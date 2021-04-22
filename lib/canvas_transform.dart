



import 'dart:math';

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
             width: 300,
             height: 300,
             child: Container(
               decoration: BoxDecoration(
                 border:Border.all(color: Colors.blue,width: 4)
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
        translateDraw(canvas, size);
        drawDot(canvas, size) ;

  }

  void drawDot(Canvas canvas, Size size){
   var  paint = Paint()
      ..strokeWidth=4
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.stroke;
   canvas.save();

   for(int i =0 ;i<12;i++){
     var step = 2*pi /12 ;
     canvas.drawLine(Offset(80,0), Offset(100,0), paint);
     canvas.rotate(step);
   }

   canvas.restore();

  }



  void translateDraw(Canvas canvas ,Size size){
    var paint = Paint()..style = PaintingStyle.fill..color = Colors.blue;
    canvas.translate(size.width/2, size.height/2);
    canvas.drawCircle(Offset(0, 0), 50, paint) ;
    canvas.drawLine(
        Offset(20, 20),
        Offset(50, 50),
        paint
          ..color = Colors.red
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);
    // canvas.drawCircle(Offset(0, 0), 50, paint..color=Colors.greenAccent) ;
    // canvas.drawLine(
    //     Offset(20, 20),
    //     Offset(50, 50),
    //     paint
    //       ..color = Colors.red
    //       ..strokeWidth = 5
    //       ..strokeCap = StrokeCap.round
    //       ..style = PaintingStyle.stroke);
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
     return true ;
  }

}


