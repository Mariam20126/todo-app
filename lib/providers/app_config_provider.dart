import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.dark;

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void changeTheme(ThemeMode newMood) {
    if (appTheme == newMood) {
      return;
    }
    appTheme = newMood;
    notifyListeners();
  }

  bool isDarkMood() {
    return appTheme == ThemeMode.dark;
  }
}
