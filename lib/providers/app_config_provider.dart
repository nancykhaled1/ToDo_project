import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils/firebase_utils.dart';
import '../firebase_utils/model.dart';

class AppConfigProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;
  Locale appLang = Locale('en');
  List<Task> tasksList = [];

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

  void getAllTasksFromFirestore() async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollection().get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }
}