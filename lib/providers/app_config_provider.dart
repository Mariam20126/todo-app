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
  DateTime selectedDate=DateTime.now();
  List<Task> taskList = [];
  void getAllTasksFromFirestore() async {
    QuerySnapshot<Task> querySnapshot = await FireBaseUtils.getTasksCollection().get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    taskList=taskList.where((task) {
      if(task.dateTime?.day==selectedDate.day&&
          task.dateTime?.month==selectedDate.month&&
          task.dateTime?.year==selectedDate.year
      ){
        return true;
      }
      return false;
    }).toList( );
    taskList.sort(
            (Task task1,Task task2){
              return task1.dateTime!.compareTo(task2.dateTime!);
    }
    );
    notifyListeners();

  }
  void setNewSelectedDate(DateTime newDate){
    selectedDate=newDate;
    getAllTasksFromFirestore();
  }



}
