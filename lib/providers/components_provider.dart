import 'package:flutter/material.dart';

class Components_provider extends ChangeNotifier{
  List _components = [];
  int _component_index = 9999;
  String _component_path = '';

  set_components(components){
    _components = components;
    notifyListeners();
  }

  set_component(int index, String path){
    _component_index = index;
    _component_path = path;
    notifyListeners();
  }

  List get components => _components;

  int get component_index => _component_index;
  String get component_path => _component_path;
}