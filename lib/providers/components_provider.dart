import 'package:flutter/material.dart';

class Components_provider extends ChangeNotifier{
  List _components = [];

  set_components(components){
    _components = components;
    notifyListeners();
  }

  List get components => _components;
}