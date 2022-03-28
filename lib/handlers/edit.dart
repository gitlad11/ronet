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


