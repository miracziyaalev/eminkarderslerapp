import 'package:flutter/material.dart';

class CheckStateProvider extends ChangeNotifier {
  bool checkState = false;

  bool checkStateFun() {
    checkState = !checkState;
    notifyListeners();
    return checkState;
  }
}
