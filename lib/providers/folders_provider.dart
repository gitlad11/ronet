import 'package:flutter/foundation.dart';

class Folders_provider extends ChangeNotifier{
  List _folders = [];

  setFolders(folders){
    _folders = folders;
    notifyListeners();
  }

  List get folders => _folders;
}