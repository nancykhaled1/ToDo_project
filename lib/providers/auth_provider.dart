import 'package:flutter/cupertino.dart';
import 'package:project_todo/model/user_data.dart';

class AuthProvider extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
