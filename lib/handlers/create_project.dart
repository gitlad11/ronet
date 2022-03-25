import 'dart:convert';
import 'dart:io';
import 'dart:async';

Future<String> removeLastCharacter(String str) async {
  var result = null;
  if (str.isNotEmpty) {
    result = str.substring(0, str.length - 1);
  }

  return result;
}


create_project(String path, String name, int type) async {
  late String p;
  if(path.trim().endsWith(r'\')){
    p = path.trim() + name.trim();
  } else if(path.endsWith('/')){
    String result = await removeLastCharacter(path);
    path = result + r'\';
    p = path.trim() + name.trim();
  } else {
    p = path + r'\' + name;
  }

  var project = Directory(p);
  if(await project.exists()){
    project = Directory(p + '(1)');
  }
  await project.create(recursive: false);

  Map created = { "success" : false, };

  switch(type){
    case 0:
      created = await create_dart_project(project);
      break;
    case 1:
      break;
    case 2:
      break;
  }
  return created;
}

create_dart_project(Directory directory) async {
  if(Platform.isWindows){
    var project = await Process.run("where flutter", [], runInShell: true);
    var result = project.stdout.toString().split(r'\');
    if(result.length > 1){
      var disk = result[0];
      var path = project.stdout.toString().split(disk);
      var enabled = await Process.run("flutter", [], runInShell: true);
      if(enabled.exitCode == 0){
        var name = directory.path + r'\flutter_project';
        var project = await Process.run("flutter create $name", [], runInShell: true);
        if(project.exitCode == 0){

            var created = await init_project(name);
            if(!created){
              return { "success" : false, "message" : "Ошибка установки зависимостей в файл pubsec.yaml" };
            } else {
              return { "success" : true, "message" : "", "name" : name };
            }
        } else {
          return { "success" : false, "message" : "Ошибка создания flutter проекта, для полной информации наберите команду flutter doctor -v" };
        }
      } else {
        String result = path[1].trim();
        var res = result.split(r'\');
        res.removeLast();
        var p = disk + res.join(r'\');
        var r = await Process.run('setx path "%path%;$p"', [], runInShell: true);
        var t = await Process.run("set PATH=%PATH%;$p", [], runInShell: true);
      }
    } else {
        var s = await Process.run("start https://docs.flutter.dev/get-started/install", [], runInShell: true);
    }
  } else if(Platform.isLinux){

  }
}

init_project(name) async {
  var assets_folder = await Directory(name + r"\assets").create(recursive: false);
  var components_folder = await Directory(name + r'\lib\components').create(recursive: false);
  var pubsec = File(name + '/pubspec.yaml');
  try {
    List<String> lines = await pubsec.readAsLines();
    var rows = [];
    for(var line in lines){
      rows.add(line+ '\n');
    }

    int index = 0;
    for(String string in rows){
      if(string.contains("assets:")){
        rows[index] = "  assets:\n";
        rows[index + 1] = "      - assets/\n";
      } else {
        index++;
      }
    }
    await write_file(pubsec, rows);
    return true;
  } catch(error) {
    return false;
  }
}

write_file(File file, List data) async {
  file.openWrite().write('');
  for(var line in data){
    file.writeAsStringSync('$line', mode: FileMode.append);
  }
}