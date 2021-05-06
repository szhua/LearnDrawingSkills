
import 'package:painter/provider/notifier.dart';

class MyData extends Notifier{

   int count =0;

   void increment(){
     count++;
     notifyAll();
   }


}