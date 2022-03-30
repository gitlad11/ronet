import 'dart:io';
import 'dart:async';
import 'package:ronet_engine/handlers/create_project.dart';
import 'package:ronet_engine/handlers/get_scenes.dart';

String sub_dir_scene = r'\lib\game_engine\scenes\scene.dart';

rename_scene(scene, String new_name) async {
  File scene_file = File(scene["path"]);
  if(await scene_file.exists()){
    var path = scene_file.path;
    var last_separator = path.lastIndexOf(Platform.pathSeparator);
    var new_path = path.substring(0, last_separator + 1) + new_name;
    await scene_file.rename(new_path);
    return true;
  } else {
    return false;
  }
}

create_scene(String path) async {
  List scenes = await get_scenes(path + r"\flutter_project\lib\scenes");
  String name = "scene ${scenes.length}.dart";
  File new_scene = File(path + r'\flutter_project\lib\scenes\' + name);
  await new_scene.create(recursive: false);
  var current_dir = Directory.current.path;
  List scene_data = await read_data(current_dir + sub_dir_scene);
  var index = 0;
  for(String line in scene_data){
    if(line.contains('class Scene extends')){
      scene_data[index] = "class Scene${scenes.length} extends StatefulWidget{\n";
      break;
    } else {
      index++;
    }
  }
  await write_file(new_scene, scene_data);
  return true;
}

add_component(scene, String path, String name, int type) async {
  File scene_file = File(scene['path']);
  File new_component = File(path + r'\flutter_project\lib\components\'+ name);
  await new_component.create(recursive: false);

  late List component_data;
  List scene_data = await read_data(scene_file.path);

  scene_data[0] = scene_data[0] + '\n import "package:flutter-project' + r"/flutter_project/lib/components/" + name + '";\n' ;

  if(await scene_file.exists()){
    switch(type){
      case 0:
        component_data = await read_data(Directory.current.path + r'\lib\game_engine\components\empty_component.dart');
        break;
      case 1:
        component_data = await read_data(Directory.current.path + r'\lib\game_engine\components\box_collider.dart');
        break;
      case 2:
        component_data = await read_data(Directory.current.path + r'\lib\game_engine\components\camera.dart');
        break;
      case 3:
        component_data = await read_data(Directory.current.path + r'\lib\game_engine\components\animation.dart');
        break;
      case 4:
        component_data = await read_data(Directory.current.path + r'\lib\game_engine\components\sound.dart');
        break;
      case 5:
        component_data = await read_data(Directory.current.path + r'\lib\game_engine\components\gif_background.dart');
        break;
      case 6:
        component_data = await read_data(Directory.current.path + r'\lib\game_engine\components\gif_effect.dart');
        break;
      case 7:
        component_data = await read_data(Directory.current.path + r'\lib\game_engine\components\text.dart');
        break;
      default:
        break;
    }
        await write_file(new_component, component_data);
        await write_file(scene_file, scene_data);
  }
}

