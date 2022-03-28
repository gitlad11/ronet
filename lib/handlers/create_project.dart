import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:ronet_engine/providers/status_provider.dart';

Future<String> removeLastCharacter(String str) async {
  var result = null;
  if (str.isNotEmpty) {
    result = str.substring(0, str.length - 1);
  }

  return result;
}


create_project(String path, String name, int type, context) async {
  await Provider.of<Status_provider>(context, listen: false).setStatus("Создание проекта");
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
      created = await create_dart_project(project, context);
      break;
    case 1:
      break;
    case 2:
      break;
  }
  return created;
}

create_dart_project(Directory directory, context) async {
  Provider.of<Status_provider>(context, listen: false).setStatus("Инициализация Dart проекта");
  if(Platform.isWindows){
    var project = await Process.run("where flutter", [], runInShell: true);
    var result = project.stdout.toString().split(r'\');
    if(result.length > 1){
      var disk = result[0];
      var path = project.stdout.toString().split(disk);
      var enabled = await Process.run("flutter", [], runInShell: true);
      if(enabled.exitCode == 0){
        await Provider.of<Status_provider>(context, listen: false).setStatus(r"Создание Flutter проекта в \flutter_project");
        var name = directory.path + r'\flutter_project';
        var project = await Process.run("flutter create $name", [], runInShell: true);
        if(project.exitCode == 0){
          await Provider.of<Status_provider>(context, listen: false).setStatus(r"Установка зависимостей окружения");
            var created = await init_project(name, context);
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

init_project(String name, context) async {

  var assets_folder = await Directory(name + r"\assets").create(recursive: false);
  var components_folder = await Directory(name + r'\lib\components').create(recursive: false);
  var scenes_folder = await Directory(name + r'\lib\scenes').create(recursive: false);
  var provider_folder = await Directory(name + r'\lib\providers').create(recursive: false);

  await Provider.of<Status_provider>(context, listen: false).setStatus("Копирование игровой структуры в $name");
  var init_engine = await init_game_engine(scenes_folder, provider_folder, name);

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
        index++;
      } else {
        index++;
      }
    }
    await Provider.of<Status_provider>(context, listen: false).setStatus("Настройка /assets директории");
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

Future read_data(String name) async {
  List<String> lines = await File(name).readAsLines();
  var rows = [];
  for(var line in lines){
    rows.add(line + '\n');
  }
  return rows;
}

init_game_engine(Directory scenes_folder, Directory provider_folder, String name) async {
  var game_engine = Directory(Directory.current.path + r'\lib\game_engine');
try {
  List game_state_data = await read_data(game_engine.path + r'\game_state.dart');
  List provider_data = await read_data(game_engine.path + r'\providers\game_state_provider.dart');
  List splash_data = await read_data(game_engine.path + r'\scenes\splash.dart');
  List scene_data = await read_data(game_engine.path + r'\scenes\scene.dart');

  File game_state_file = File(name + r'\lib\game_state.dart');
  File provider_file = File(name + r'\lib\providers\game_state_provider.dart');
  File splash_file = File(name + r'\lib\scenes\splash.dart');
  File scene_file = File(name + r'\lib\scenes\scene.dart');

  await game_state_file.create(recursive: false);
  await provider_file.create(recursive: false);
  await splash_file.create(recursive: false);
  await scene_file.create(recursive: false);

  print(game_state_file.path);

  await write_file(game_state_file, game_state_data);
  await write_file(provider_file, provider_data);
  await write_file(splash_file, splash_data);
  await write_file(scene_file, scene_data);
  } catch(error){
  print(error);

}
}

void main() async {
  await init_game_engine(Directory(r"D:\dsada\lib\scenes"), Directory(r"D:\dsada\lib\provider"), r"D:\dsada");
}