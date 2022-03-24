import 'dart:convert';
import 'dart:io';


Future get_directories(String path) async {
  var folder = Directory(path);

  if(await folder.exists()){
    List folders = [];
    await for (var entity in folder.list(recursive: false, followLinks: false, )){
      if(entity is Directory){
        var len = 0;
        try {
          await for(var dir in entity.list(recursive: false, followLinks: false)){
            len = len + 1;
          }
        } on Exception {
          print("system volume information!");
        }
        var name = entity.path.split(r'\').last;

        if(len == 0){
          var item = { "name" : name, "path" : entity.path,  "empty" : true, "type" : 'directory' };
          folders.add(item);

        } else {
          var item = { "name" : name, "path" : entity.path, "empty" : false, "type" : 'directory' };
          folders.add(item);
        }
      } else if(entity.path.endsWith("png") || entity.path.endsWith("svg") || entity.path.endsWith("jpg") || entity.path.endsWith("jpeg")){

        var name = entity.path.split(r'\').last;
        var item = { "name" : name, "path" : entity.path, "empty" : false, "type" : 'image' };
        folders.add(item);

      } else if(entity is File){
        var name = entity.path.split(r'\').last;
        var item = { "name" : name, "path" : entity.path, "empty" : false, "type" : 'file' };
        folders.add(item);
      }
    }

    return folders;
  }
}


