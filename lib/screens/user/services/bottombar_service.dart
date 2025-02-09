import 'package:flutter/cupertino.dart';

class BottomBarServiceProvider extends ChangeNotifier{

  int selectedIndex=0;

  void changeIndex(int index){

    selectedIndex=index;
    notifyListeners();
  }

}