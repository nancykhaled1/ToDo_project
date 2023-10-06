import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils/firebase_utils.dart';
import '../model/task_data.dart';

class AppConfigProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;
  Locale appLang = Locale('en');
  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();


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

  void getAllTasksFromFirestore(String uId) async {
    QuerySnapshot<Task> querySnapshot =
    await FirebaseUtils.getTasksCollection(uId).get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    /// filtering list
    tasksList = tasksList.where((task) {
      if (task.dateTime?.day == selectedDate.day &&
          task.dateTime?.month == selectedDate.month &&
          task.dateTime?.year == selectedDate.year) {
        return true;
      }
      return false;
    }
    ).toList();


    /// sorting
    tasksList.sort(
            (Task task1, Task task2) {
          return task1.dateTime!.compareTo(task2.dateTime!);
        }
    );

    notifyListeners();
  }

  void changeSelectDate(DateTime newDate, String uId) {
    selectedDate = newDate;
    getAllTasksFromFirestore(uId);
  }
}