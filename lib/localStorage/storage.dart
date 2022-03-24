
import 'dart:io' show Directory, File, FileMode, Platform;
import 'dart:convert';
import 'package:excel/excel.dart';


var current_directory = Directory.current.path;
var sub_directories = '/lib/localStorage/';

Future create_database (name) async {
  File new_file = await File(current_directory + sub_directories + name).create(recursive: false);

  if(new_file.path.isNotEmpty){
    return true;
  } else {
    return false;
  }

}

Future read_data(name) async {
  List<String> lines = await File(current_directory + sub_directories + name).readAsLines();
  var rows = [];
  for(var line in lines){
    rows.add(line);
  }
  return rows;
}

Future write_data(String file,  data) async {
  var f = File(current_directory + sub_directories + file);
  var exists = await f.exists();
  if(!exists){
    create_database(file);
  }
  if(f.path.endsWith("json")){
    String json_string = await f.readAsString();
    Map json_map = await json.decode(json_string);

  } else if (data is String){
    List lines = await f.readAsLines();

    if(lines.length > 2){
      if(lines.last != data){
        lines.add(data.trim());
      }
    } else if(lines.length == 1){
      if(lines[0] != data){
        lines.add(data.trim());
      }
    } else {
      lines.add(data.trim());
    }
    f.openWrite().write('');
    for(var line in lines){
      f.writeAsStringSync('$line\n', mode: FileMode.append);
    }
  }
}



