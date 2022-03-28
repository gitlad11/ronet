import 'package:flutter/foundation.dart';

class Scenes_provider extends ChangeNotifier{
  List _scenes = [];
  Map _current_scene = {"name" : "", "path" : r""};

  set_scenes(scenes){
    _scenes = scenes;
    notifyListeners();
  }

  set_current_scene(scene){
    _current_scene = scene;
    notifyListeners();
  }

  List get scenes => _scenes;
  Map get current_scene => _current_scene;
}