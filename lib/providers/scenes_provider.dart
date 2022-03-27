import 'package:flutter/foundation.dart';

class Scenes_provider extends ChangeNotifier{
  List _scenes = [];

  set_scenes(scenes){
    _scenes = scenes;
    print(_scenes);
    notifyListeners();
  }

  List get scenes => _scenes;
}