import 'dart:convert';
import 'dart:io';


Future get_disks() async {
  if(Platform.isWindows){
    var process = await Process.run('fsutil fsinfo drives', [], runInShell: true, stdoutEncoding: utf8);
    List disks = process.stdout.toString().split(' ');
    disks.removeAt(0);
    return disks;
  }
}
