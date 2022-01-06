import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  var _isDark = false;

  void switchMode(){
    _isDark = !_isDark;
    notifyListeners();
  }

  bool get isDarkMode{
    return _isDark;
  }

  set darkMode(bool value){
    _isDark = value;
    notifyListeners();
  }
}