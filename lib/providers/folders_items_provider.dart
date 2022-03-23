import 'package:flutter/foundation.dart';

class Folders_items_provider extends ChangeNotifier{
  List _items = [];

  setItems(items){
    _items = items;
    notifyListeners();
  }

  List get items => _items;
}