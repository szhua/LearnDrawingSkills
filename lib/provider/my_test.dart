

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painter/provider/MyData.dart';
import 'package:painter/provider/change_notify_provider.dart';

void main(){

  runApp(MaterialApp(
     home: MyPage(),
  ));


}

class MyPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyPageState();
  }

}
class _MyPageState extends State<MyPage>{

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Center(
         child: ChangeNotifyProvider<MyData>(data:MyData(), child:Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Builder(builder: (context) {
               return Text("Counts:${ChangeNotifyProvider.of<MyData>(context).count}");
             },),
             Builder(builder: (context) {
               return  GestureDetector(
                 onTap: (){
                   ChangeNotifyProvider.of<MyData>(context).increment();
                 },
                 child: Text("Increment"),
               );
             },)
           ],
         ))
       )
     );
  }

}