

import 'package:flutter/material.dart';

class Notifier extends Listenable{


  List<VoidCallback> listeners = [] ;


  @override
  void addListener(listener) {
      listeners.add(listener);
  }
  @override
  void removeListener(listener) {
      listeners.remove(listener);
  }

  void notifyAll(){
      listeners.forEach((element) {
           element();
      });
  }

}
