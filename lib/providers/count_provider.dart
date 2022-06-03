import 'package:flutter/material.dart';

class CountProvider extends ChangeNotifier {
  int count = 0;

  CountProvider() {
    // only first time
  }

  updateCount() {
    count += 1;
    notifyListeners();
  }
}
