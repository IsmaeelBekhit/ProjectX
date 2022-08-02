import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/AppThemes.dart';
class MainProvider extends ChangeNotifier{

  ThemeMode _theme = ThemeMode.light;

  late SharedPreferences _sharedPreferences;

  ThemeMode get theme => _theme;

  set theme(ThemeMode value) {
    _theme = value;
    notifyListeners();
  }

  SharedPreferences get sharedPreferences => _sharedPreferences;

  set sharedPreferences(SharedPreferences value) {
    _sharedPreferences = value;
    notifyListeners();
  }
}