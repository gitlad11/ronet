import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Scenes_provider extends ChangeNotifier{
  List _scenes = [];
  List _opened_scenes = [];
  Map _current_scene = {"name" : "", "path" : r""};

  set_scenes(scenes){
    _scenes = scenes;
    notifyListeners();
  }

  set_current_scene(scene){
    _current_scene = scene;

    bool in_array = false;
    for(var s in _opened_scenes){
      if(s['name'] == scene['name']){
        in_array = true;
      }
    }
    if(!in_array){
      _opened_scenes.add(scene);
    }
    notifyListeners();
  }
  close_scene(index){
    _opened_scenes.removeAt(index);
    notifyListeners();
  }

  List get scenes => _scenes;
  List get opened_scenes => _opened_scenes;
  Map get current_scene => _current_scene;
}