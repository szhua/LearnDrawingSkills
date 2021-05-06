import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:painter/my_theme_container.dart';
import 'package:painter/store/counter/counter.dart';

///Container is tighted ；
/// Container 中含有一个ConstrainedBox这个box对期进行约束传递；
///
///
///
///
///
void main() {
  runApp(MyThemeWidget(MyThemeContainer.getTheme(),MaterialApp(
    theme: MyThemeContainer.getTheme(),
    home:  Texts(),
  )));
}

class Texts extends StatefulWidget {
  @override
  _TextsState createState() => _TextsState();
}

Stream<dynamic> test() async* {
  for (var i = 0; i < 10; i++) {
    yield "fsdfsd$i";
  }
}

class _TextsState extends State<Texts> {
  var counter = Counter();

  @override
  void initState() {
    super.initState();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){

          }, child: Text("ChangeTheme",style: TextStyle(color: Colors.pink),))
        ],
        title: Text("Mox Sample"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Observer(
              builder: (context) => Text("${counter.value}"),
            ),
            Container(
                height: 100,
                width: 100,
                child: UnconstrainedBox(
                    constrainedAxis: Axis.horizontal,
                    child: Builder(
                      builder: (context) {
                        return TextButton(
                            onPressed: () {
                              print(context.size.width);
                              print(context.size.height);
                            },
                            child: Text("this is buttonthis is "
                                "buttonthis is buttonthis is buttonthis is buttonthis "
                                "is buttonthis is button ",style: TextStyle(),overflow: TextOverflow.ellipsis,));
                      },
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text("this is buttonthis is "
                    "buttonthis is buttonthis is buttonthis is buttonthis "
                    "is buttonthis is button buttonthis is buttonthis is"
                    " buttonthis is buttonthisbuttonthis is buttonthis is"
                    " buttonthis is buttonthis",style: TextStyle(),overflow: TextOverflow.ellipsis,),),
               Container(
                 width: 100,
                 child:  Text("this is buttonthis is "
                     "buttonthis is buttonthis is buttonthis is buttonthis "
                     "is buttonthis is button buttonthis is buttonthis is"
                     " buttonthis is buttonthisbuttonthis is buttonthis is"
                     " buttonthis is buttonthis",style: TextStyle(),overflow: TextOverflow.ellipsis,),
               ) ,
                RepaintBoundary(),
                TextButton.icon(
                    onPressed: counter.increment,
                    icon: Icon(Icons.add),
                    label: Text("Add")),
                TextButton.icon(
                    onPressed: counter.decrement,
                    icon: Icon(Icons.remove),
                    label: Text("Minus"))
              ],
            ),
            TextButton(onPressed: (){

            }, child: Text("Change"))
          ],
        ),
      ),
    );
  }
}
