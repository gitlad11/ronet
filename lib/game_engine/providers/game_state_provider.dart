import 'package:flutter/foundation.dart';


class Game_state_provider extends ChangeNotifier{
  int _state = 0;
  bool _splash_full_screen = false;
  bool _full_screen = false;
  int _splash_show_time = 4;

  set_state(int state) async{
    _state = state;
    notifyListeners();
  }

  init_game(sfs, fs, sst){
    _splash_full_screen = sfs;
    _full_screen = fs;
    _splash_show_time = sst;
    notifyListeners();
  }

  int get state => _state;
  bool get splash_full_screen => _splash_full_screen;
  bool get full_screen => _full_screen;
  int get splash_show_time => _splash_show_time;
}