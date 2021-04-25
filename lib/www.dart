
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:painter/store/counter/counter.dart';


void main(){
  runApp(MaterialApp(
     home: Texts(),
  ));
}

class Texts extends StatefulWidget {
  @override
  _TextsState createState() => _TextsState();
}


Stream<dynamic> test() async*{
  for(var i=0 ;i<10;i++){
      yield "fsdfsd$i";
  }
}



class _TextsState extends State<Texts> {

  var counter = Counter();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(test().toSet().then((value) => print(value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mox Sample"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Observer(builder: (context) => Text("${counter.value}"), ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RepaintBoundary(),
                TextButton.icon(onPressed: counter.increment, icon: Icon(Icons.add), label: Text("Add")),
                TextButton.icon(onPressed: counter.decrement, icon: Icon(Icons.remove), label: Text("Minus"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
