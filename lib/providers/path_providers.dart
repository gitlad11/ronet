import 'package:flutter/foundation.dart';

class Path_provider extends ChangeNotifier{
  String _path = '';

  set_path(path){
    _path = path;
    notifyListeners();
  }

  String get path => _path;
}