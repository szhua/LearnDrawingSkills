import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:huawei_scan/HmsScanLibrary.dart';
import 'package:painter/WidgetToImage.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyImagePage(),
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
  var minutes = 0;

  @override
  void initState() {
    super.initState();
  }

  permissionRequest() async {
    bool permissionResult =
        await HmsScanPermissions.hasCameraAndStoragePermission();
    print(permissionResult);
    if (permissionResult == false) {
      return await HmsScanPermissions.requestCameraAndStoragePermissions();
    } else {
      return true;
    }
  }

  ///使用华为的二维码扫；
  void huaweiGetScan() async {
    //showToast("requestPermission");
    bool hasPermissions = await permissionRequest();
    if (hasPermissions) {
      CustomizedViewRequest request = new CustomizedViewRequest(
          scanType: HmsScanTypes.AllScanType,
          continuouslyScan: false,
          isGalleryAvailable: false,
          customizedCameraListener: (ScanResponse response) {
            EasyLoading.showSuccess("OK  ${response.originalValue}");
          });
      await HmsCustomizedView.startCustomizedView(request);
    } else {
      EasyLoading.showError("Permission Denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        floatingActionButton: ElevatedButton(
            onPressed: () {
              huaweiGetScan();
            },
            child: Text("$minutes")),
        body: Center(
            child: WidgetToImage(
          imagePath: "assets/test.jpeg",
          child: Text("this is text"),
        )));
  }
}

class MyImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyImagePageState();
  }
}

class MyImagePageState extends State<MyImagePage> {
  final key = GlobalKey();

  Uint8List fileBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RepaintBoundary(
          key: key,
          child: TextButton(
            onPressed: () async {
              fileBytes = await getUint8List();
              setState(() {});
            },
            child: Column(
              children: [
                Text("sss"),
                if (fileBytes == null)
                  Container()
                else
                  Container(
                    width: 500,
                    height: 500,
                    child: Image(image: MemoryImage(fileBytes)),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 获取unit8
  Future<Uint8List> getUint8List() async {
    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
    var image = await boundary.toImage(
      pixelRatio: window.devicePixelRatio,
    );
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  // 获取路径
  Future<File> _getPath() async {
    String _filePath = (await getExternalStorageDirectory()).path + "sss";
    // 路径不存在则创建
    if (!await Directory(_filePath).exists()) {
      Directory(_filePath).create();
    }
    return File(_filePath + "ssssss.png").writeAsBytes(await getUint8List());
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
  var minutes = 0;

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
    return oldDelegate.minutes == minutes;
  }

  void drawCenterCircle(Canvas canvas, Size size) {
    var radius = min(size.width, size.height) / 2;
    var paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius / 10;
    // canvas.drawCircle(Offset(radius,radius), radius-radius/10, paint);
    canvas.translate(radius, radius);
    canvas.drawCircle(Offset.zero, radius - radius / 10, paint);

    canvas.drawLine(
        Offset(0, 0),
        Offset(0, radius - radius / 10 - 30),
        paint
          ..color = Colors.red
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);

    var angle = pi * minutes / 30 - pi / 2;
    print(cos(angle));
    print(sin(angle));
    var le = radius - radius / 10 - 20;
    var offsetEnd = Offset(cos(angle) * le, sin(angle) * le);

    canvas.drawLine(
        Offset(0, 0),
        offsetEnd,
        paint
          ..color = Colors.green
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);
  }
}
