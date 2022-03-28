import 'dart:io';

import 'package:ronet_engine/handlers/create_project.dart';

Future<List> get_scenes(path) async {
  var folder = Directory(path);
  var items = [];
  await for(var entity in folder.list(recursive: false, followLinks: false)){
    if(entity is File){
      if(entity.path.endsWith(".dart") || entity.path.endsWith('.cpp')){
        String name = entity.path.split(r'\').last;
        String n = name.split('.').first;
        var item = { "path" : entity.path, "name" : n };
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
      List comp = component.split(".");
      components.add(comp[0]);
    }
  }
  return components;
}
