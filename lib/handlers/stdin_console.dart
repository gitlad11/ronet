import 'dart:convert';
import 'dart:io';

stdin_console(command) async {
  var result = await Process.run(command, [], runInShell: true);
  if(result.exitCode == 0){
    return result.stdout;
  } else {
    return result.stderr;
  }
}