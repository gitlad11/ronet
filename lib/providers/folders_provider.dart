import 'package:flutter/foundation.dart';

class Folders_provider extends ChangeNotifier{
  List _folders = [];
  List _opened_folders = [];
  List _nested_folders = [];

  setFolders(folders){
    _folders = folders;
    notifyListeners();
  }

  setFoldersIndex(int index){
    if(_opened_folders.contains(index)){
      _opened_folders.remove(index);
    } else {
      _opened_folders.add(index);
    }
    notifyListeners();
  }

  setNestedFolders(List folders, int index) async {
    while(_nested_folders.length < index){
      _nested_folders.add([]);
    }
    if(_nested_folders.length >= index){
      _nested_folders.insert(index, folders);
    }
    notifyListeners();
  }

  List get folders => _folders;
  List get opened_folders => _opened_folders;
  List get nested_folders => _nested_folders;
}