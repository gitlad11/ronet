import 'package:flutter/foundation.dart';

class Status_provider extends ChangeNotifier{
  String _status = "";

  setStatus(String status){
    _status = status;
    notifyListeners();
  }

  String get status => _status;
}
