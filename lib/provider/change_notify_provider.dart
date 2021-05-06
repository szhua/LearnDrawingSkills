
import 'package:flutter/material.dart';
import 'package:painter/provider/inherited_provider.dart';
import 'package:painter/provider/notifier.dart';

class ChangeNotifyProvider<T extends Notifier> extends StatefulWidget{

  final T data ;
  final Widget child ;

  ChangeNotifyProvider({this.data, this.child});




  //定义一个便捷方法，方便子树中的widget获取共享数据
  static T of<T>(BuildContext context) {
    final provider =  context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    return provider.data;
  }

  @override
  State<StatefulWidget> createState() {
     return _ChangeNotifyProviderState<T>();
  }

}
class _ChangeNotifyProviderState<T extends Notifier> extends State<ChangeNotifyProvider<T>>{

  void update(){
      setState(() {

      });
  }

  @override
  void initState() {
    super.initState();
    widget.data.addListener(update);
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChangeNotifyProvider<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(oldWidget.child==widget.child);
    if(widget.data!=oldWidget.data){
       oldWidget.data.removeListener(update);
       widget.data.addListener(update);
    }
  }


  @override
  Widget build(BuildContext context) {
      return InheritedProvider<T>(data: widget.data,child: widget.child);
  }
}