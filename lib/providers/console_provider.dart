import "package:flutter/foundation.dart";

class Console_provider extends ChangeNotifier{
  List _items = ["Для управления проектом доступны команды :", "  run - запуск в режиме разработки", "  build - сборка проекта для desktop"];

  setItem(item) async {
    _items.add(item);
    notifyListeners();
  }

  clearItems() async{
    _items.clear();
    notifyListeners();
  }

  List get items => _items;
}

