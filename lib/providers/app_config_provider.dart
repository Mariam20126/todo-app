import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';
class AppConfigProvider extends ChangeNotifier {
  String appLanguage ='en';
  ThemeMode appTheme =ThemeMode.light ;

  void changeLanguage(String newLanguage)  {
    if (appLanguage == newLanguage) {
      return ;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void changeTheme(ThemeMode newMood)  {
    if (appTheme == newMood) {
      return ;
    }
    appTheme = newMood;
    notifyListeners();
  }

  bool isDarkMood() {
    return appTheme == ThemeMode.dark;
  }

  List<Task> taskList = [];
  void getAllTasksFromFirestore() async {
    QuerySnapshot<Task> querySnapshot =
    await FireBaseUtils.getTasksCollection().get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();

  }



}
