import 'package:flutter/material.dart';

class OnBoardingProvider extends ChangeNotifier {
  int index = 0;

  skippages(int value) {
    index = value;
    notifyListeners();
  }
}
