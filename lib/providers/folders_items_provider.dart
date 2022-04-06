import 'package:flutter/foundation.dart';

class Folders_items_provider extends ChangeNotifier{
  List _items = [];
  List _nest = [];

  setItems(items){
    _items = items;
    notifyListeners();
  }

  setItem(item, nest){
    _items.add(item);
    while(_nest.length < item){
      _nest.add(0);
    }
    _nest.add(nest);
    print(_nest);
    notifyListeners();
  }

  setRemove(item){
    _items.remove(item);
    notifyListeners();
  }

  List get items => _items;
  List get nest => _nest;
}