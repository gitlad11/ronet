import 'package:flutter/foundation.dart';


class Game_state_provider extends ChangeNotifier{
  int _state = 0;

  set_state(int state) async{
    _state = state;
    notifyListeners();
  }

  int get state => _state;
}