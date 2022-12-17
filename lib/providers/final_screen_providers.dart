import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckStateProvider extends ChangeNotifier {
  bool checkState = false;

  bool checkStateFun() {
    checkState = !checkState;
    notifyListeners();
    return checkState;
  }



}
