
import 'dart:io' show Directory, File, Platform;
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
    print(line);
    rows.add(line);
  }
  return rows;
}

void write_data(object) async {

}



void main() async {
  var exists = await File(current_directory + sub_directories + "path.json").exists();
  if(!exists){
    create_database("path.json");
  }
}
