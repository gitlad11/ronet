import 'dart:io';

import 'package:ronet_engine/handlers/create_project.dart';

Future<List> get_scenes(path) async {
  var folder = Directory(path);
  var items = [];
  await for(var entity in folder.list(recursive: false, followLinks: false)){
    if(entity is File){
      if(entity.path.endsWith(".dart") || entity.path.endsWith('.cpp')){
        String name = entity.path.split(r'\').last;
        var item = { "path" : entity.path, "name" : name };
        items.add(item);
      }
    }
  }
  return items;
}

Future<List> get_components(entity) async {
  var components = [];
  var rows = await read_data(entity["path"]);
  for (String row in rows){
    if(row.contains("/components/")){
      String component = row.split(r'/').last;
      components.add(component);
    }
  }
  print(components);
  return components;
}

void main() async {
  var scenes = await get_scenes(r"D:\ronet\lib\game_engine\scenes");
  print(scenes);
}