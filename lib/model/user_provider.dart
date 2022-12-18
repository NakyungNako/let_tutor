import 'package:flutter/material.dart';
import 'package:let_tutor/model/user/user.dart';

class UserProvider extends ChangeNotifier {
  late User userInfo;

  void setUser(User user) {
    userInfo = user;
    notifyListeners();
  }
}