
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Scaffold(
      body: RefreshIndicator(
         onRefresh: () async{
           await new Future.delayed(const Duration(seconds: 5));
           print("sss");
         },
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    width: 1,
                  )
              ),
              child: Container(
                width: 200,
                height: 200,
                transform: Matrix4.diagonal3Values(1, 1, 20),
                child: FlutterLogo(),
              ),
            ),
          ],
        )
      )
    ),
  ));
}