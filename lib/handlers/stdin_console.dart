import 'dart:convert';
import 'dart:io';

stdin_console(command) async {
  var result = await Process.run(command, [], runInShell: true, stdoutEncoding: utf8);
  if(result.exitCode == 0){
    return result.stdout;
  } else {
    return result.stderr;
  }
}