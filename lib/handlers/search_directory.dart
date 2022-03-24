import 'dart:io';

Future search_directory(String path, String reqExp) async {
  var folder = Directory(path);

  if(await folder.exists()){
    var folders = [];
    await for (var entity in folder.list(recursive: false, followLinks: false, )){
      if(entity is Directory){
        var path = entity.path;
        var name = path.split(r'\').last;
        if(name.contains(reqExp)){
          folders.add(entity.path);
        }
      }
    }
    return folders;
  }
}