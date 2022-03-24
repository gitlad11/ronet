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

  switch(type){
    case 0:
      create_dart_project(project);
      break;
    case 1:
      break;
    case 2:
      break;
  }

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

            init_project(name);

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
  var new_directory = await Directory(name + r"\assets").create(recursive: false);
  var pubsec = File(name + '/pubspec.yaml');
  List<String> lines = await pubsec.readAsLines();
  var rows = [];
  for(var line in lines){
    rows.add(line);
  }
  print(rows.contains("assets:"));
  return rows;
}