

import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui ;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:painter/coordinate.dart';


///加载本地图片资源
Future<ui.Image> loadImageFromAssets(String path ) async{
  ByteData data  = await rootBundle.load(path);
  List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
  return decodeImageFromList(bytes);
}



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

  ui.Image _image;

  void loadImage() async {
    _image = await loadImageFromAssets("assets/test.jpeg");
     setState(() {

     });
  }


  @override
  void initState() {
    super.initState();
    loadImage();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: CustomPaint(
           painter: PagerPainter(_image),
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


  final ui.Image image ;

  Paint _paint ;
  PagerPainter(this.image){
     _paint =Paint()..style=PaintingStyle.fill..color=Colors.blue..strokeWidth=0.5;
  }



  @override
  void paint(Canvas canvas, Size size) {

    Coordinate.drawCoordinateSystem(canvas, size);

  //  _drawImage(canvas);

    //_drawRectImage(canvas);

    _drawImageNine(canvas);

  }


  void _drawRectImage(Canvas canvas){
     if (image!=null) {
       canvas.drawImageRect(
           image,
           Rect.fromCenter(
               center: Offset(image.width/2, image.height/2),
               width: 100, height: 100),
           Rect.fromLTRB(-50, -50, 50, 50),
           _paint);

       // canvas.drawImageRect(
       //     image,
       //     Rect.fromCenter(
       //         center: Offset(image.width/2, image.height/2-60), width: 60, height: 60),
       //     Rect.fromLTRB(0, 0, 100, 100).translate(-280, -100),
       //     _paint);
       //
       // canvas.drawImageRect(
       //     image,
       //     Rect.fromCenter(
       //         center: Offset(image.width/2+60, image.height/2), width: 60, height: 60),
       //     Rect.fromLTRB(0, 0, 100, 100).translate(-280, 50),
       //     _paint);
     }
  }


  void _drawImage(Canvas canvas){
    if(image!=null) {
      //canvas.save();
      //canvas.scale(0.5,0.5);
      canvas.drawImage(image, Offset(-image.width.toDouble()/2, -image.height.toDouble()/2), _paint);
     // canvas.restore();
    }

  }


  void _drawImageNine(Canvas canvas) {
    if (image != null) {
      canvas.drawImageNine(
          image,
          Rect.fromCenter(center: Offset(image.width/2, image.height-6.0),
              width: image.width-20.0, height: 2.0),
          Rect.fromCenter(center: Offset(0, 0,), width:300, height: 120),
          _paint);

      canvas.drawImageNine(
          image,
          Rect.fromCenter(center: Offset(image.width/2, image.height-6.0),
              width: image.width-20.0, height: 2.0),
          Rect.fromCenter(center: Offset(0, 0,), width:100, height: 50).translate(250, 0),
          _paint);

      canvas.drawImageNine(
          image,
          Rect.fromCenter(center: Offset(image.width/2, image.height-6.0),
              width: image.width-20.0, height: 2.0),
          Rect.fromCenter(center: Offset(0, 0,), width:80, height: 250).translate(-250, 0),
          _paint);
    }
  }


  @override
  bool shouldRepaint(covariant PagerPainter oldDelegate) {
     return image!=oldDelegate.image ;
  }


}


