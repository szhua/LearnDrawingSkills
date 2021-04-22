
import 'dart:ui';

import 'package:flutter/material.dart';

class Coordinate{

  static void drawCoordinateSystem(Canvas canvas ,Size size ){
    canvas.translate(size.width/2, size.height/2);
    _drawGrids(canvas, size) ;
    _drawAxis(canvas, size) ;
  }

 static  void _drawGrids(Canvas canvas, Size size) {
    var  _paint =Paint();
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


  static void _drawAxis(Canvas canvas, Size size) {
    var _paint = Paint();
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
}