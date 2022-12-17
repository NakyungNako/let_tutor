import 'package:flutter/material.dart';

class Favorites extends ChangeNotifier {
  final List<String> itemIds = [];

  void add(String tutorId) {
    itemIds.add(tutorId);
    notifyListeners();
  }

  void remove(String tutorId) {
    itemIds.remove(tutorId);
    notifyListeners();
  }
}