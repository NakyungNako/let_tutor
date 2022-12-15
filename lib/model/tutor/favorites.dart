import 'package:flutter/material.dart';
import 'package:let_tutor/model/tutor/tutor.dart';

class Favorites extends ChangeNotifier {
  final List<String> itemIds = [];

  void add(Tutor tutor) {
    itemIds.add(tutor.id);
    notifyListeners();
  }

  void remove(Tutor tutor) {
    itemIds.remove(tutor.id);
    notifyListeners();
  }
}