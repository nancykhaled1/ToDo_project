import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;
  Locale appLang = Locale('en');

  void changeTheme(ThemeMode newMode) {
    if (appTheme == newMode) {
      return;
    }
    appTheme = newMode;
    notifyListeners();
  }

  void changeTLang(Locale newLang) {
    if (appLang == newLang) {
      return;
    }
    appLang = newLang;
    notifyListeners();
  }
}