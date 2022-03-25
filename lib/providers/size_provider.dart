import 'package:flutter/foundation.dart';

class Size_provider extends ChangeNotifier{
  double _side_height = 230.0;
  double _side_width = 244.0;

  setSideHeight(size){
    _side_height = size;
    notifyListeners();
  }
  setSideWidth(size){
    _side_width = size;
    notifyListeners();
  }


  double get side_height => _side_height;

  double get side_width => _side_width;
}