
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Coordinate{

  static void drawCoordinateSystem(Canvas canvas ,Size size ){
    canvas.translate(size.width/2, size.height/2);
    _drawGrids(canvas, size) ;
    _drawAxis(canvas, size) ;

  }

  static void drawTextZero(Canvas canvas ,Size size){
    TextPainter textPainter =TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text: "0",
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
        )
    );
    textPainter.layout();
    var textSize = textPainter.size;
    textPainter.paint(canvas, Offset(-textSize.width-2, 2));
  }

  static void drawText(Canvas canvas ,String str ,Offset offset ,{double dx =5 ,double dy =5}){
     TextPainter textPainter =TextPainter(
       textDirection: TextDirection.ltr,
       text: TextSpan(
         text: str,
         style: TextStyle(color: Colors.green)
       )
     );
     textPainter.layout();
     var textSize = textPainter.size;
     if(offset.dx==dx){
       offset=Offset(dx,offset.dy-textSize.height/2);
     }
     if(offset.dy==dy){
       offset=Offset(offset.dx-textSize.width/2,dy);
     }
     textPainter.paint(canvas, offset);
  }

 static  void _drawGrids(Canvas canvas, Size size) {
    var  _paint =Paint();
    _paint
      ..color = Colors.grey.shade500
      ..style = PaintingStyle.stroke..strokeWidth=1
      ..strokeCap = StrokeCap.square;


    var gapSize= 20.0;
    var horizontalCount = size.height/gapSize/2;


    for(var i =0 ;i<horizontalCount;i++){
      if(i*gapSize>size.height){
         break;
      }
      canvas.drawLine(Offset(-size.width/2, i*gapSize), Offset(size.width/2, i*gapSize), _paint);
      canvas.drawLine(Offset(-size.width/2, -i*gapSize), Offset(size.width/2, -i*gapSize), _paint);
      if(i!=0 && i%2==0){
        var number = (i*5);
        drawText(canvas, number.toString(), Offset(8, i*gapSize)  ,dx: 8);
        drawText(canvas, (-number).toString(), Offset(8, -i*gapSize),dx: 8);
      }


    }

    var verticalCount = size.width/gapSize/2;

    for(var i =0 ;i<verticalCount;i++){
      if(i*gapSize>size.width){
        break;
      }
      canvas.drawLine(Offset(i*gapSize, -size.height/2), Offset(i*gapSize, size.height/2), _paint);
      canvas.drawLine(Offset(-i*gapSize, -size.height/2), Offset(-i*gapSize, size.height/2), _paint);

      if(i!=0 && i%2==0){
        var number = (i*5);
        drawText(canvas, number.toString(), Offset(i*gapSize,4)  ,dy: 4);
        drawText(canvas, (-number).toString(), Offset( -i*gapSize,4),dy: 4);
      }
    }

    drawTextZero(canvas, size);
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