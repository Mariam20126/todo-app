import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage ='ar';
 late String appTheme ;

  void changeLanguage(String newLanguage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (appLanguage == newLanguage) {
      prefs.setString('appLanguage', appLanguage);
    }
    appLanguage = newLanguage;
    prefs.setString('appLanguage', newLanguage);
    notifyListeners();
  }

  void changeTheme(String newMood) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (appTheme == newMood) {
      prefs.setString('appTheme', appTheme);
    }
    appTheme = newMood;
    prefs.setString('appTheme', newMood);
    notifyListeners();
  }

  bool isDarkMood() {
    return appTheme == ThemeMode.dark;
  }



}
