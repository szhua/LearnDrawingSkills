


import 'package:flutter/material.dart';
import 'package:painter/coordinate.dart';
import 'dart:ui' as ui ;




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
  void initState() {
    super.initState();
  }


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

  Paint _paint ;
  PagerPainter(){
     _paint =Paint()..style=PaintingStyle.fill..color=Colors.blue..strokeWidth=0.5;
  }


  @override
  void paint(Canvas canvas, Size size) {

    Coordinate.drawCoordinateSystem(canvas, size);
    //drawTextWithParagraph(canvas, TextAlign.start);
    // _drawTextWithTextPainter(canvas);
    //_drawTextWithTextPainterShowSize(canvas);
    _drawTextPaintWithPaint(canvas);
  }


  void drawTextWithParagraph(Canvas canvas ,TextAlign textAlign){

    var builder =ui.ParagraphBuilder(
      ui.ParagraphStyle(textAlign: textAlign,fontSize: 40,
          textDirection: TextDirection.ltr,maxLines: 1,ellipsis:"" )
    );
    builder.pushStyle(ui.TextStyle(
      color: Colors.black87,textBaseline: ui.TextBaseline.alphabetic
    ));
    builder.addText("Paragraph text drawing");
    var paragraph = builder.build();
    paragraph.layout(ui.ParagraphConstraints(width: 300));
    canvas.drawParagraph(paragraph, Offset(0, 0));
    canvas.drawRect(Rect.fromLTRB(0, 0, 300, 40), _paint..color=Colors.blue.withAlpha(33));

  }


  void _drawTextWithTextPainter(Canvas canvas){
    var textPainter = TextPainter(
      text: TextSpan(
        text: "this is TextPainter Drawing",
        style: TextStyle(color: Colors.black),
      ),
      //  textAlign: TextAlign.start,
        textDirection: TextDirection.ltr
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset.zero) ;
  }

  void _drawTextPaintWithPaint(Canvas canvas) {
    Paint textPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: 'Flutter Unit by 张风捷特烈',
            style: TextStyle(
                foreground: textPaint, fontSize: 40)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: 280); // 进行布局
    Size size = textPainter.size; // 尺寸必须在布局后获取
    textPainter.paint(canvas, Offset(-size.width / 2, -size.height / 2));

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, size.height)
            .translate(-size.width / 2, -size.height / 2),
        _paint..color = Colors.blue.withAlpha(33));
  }

  void _drawTextWithTextPainterShowSize(Canvas canvas){
    Paint textPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color=Colors.pink
      ..strokeWidth = 1;
    var textPainter = TextPainter(
        text: TextSpan(
          text: "this is TextPainter Drawing",
          style: TextStyle(foreground: textPaint,fontSize: 40),
        ),
        textAlign: TextAlign.center,
        //  textAlign: TextAlign.start,
        textDirection: TextDirection.ltr
    );
    textPainter.layout(maxWidth: 300);
    var size =textPainter.size;
    textPainter.paint(canvas,Offset( -size.width/2,-size.height/2)) ;
    canvas.drawRect(Rect.fromLTRB(-size.width/2, -size.height/2, size.width/2, size.height/2),
        _paint..color=Colors.blue.withAlpha(33));
  }







  @override
  bool shouldRepaint(covariant PagerPainter oldDelegate) {
       return true ;
  }


}


