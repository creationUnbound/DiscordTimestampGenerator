import 'package:flutter/material.dart';

class BooleanTextNotifier with ChangeNotifier {
  String text = "";
  String trueString;
  String falseString;

  BooleanTextNotifier(this.trueString, this.falseString, bool defaultState) {
    text = defaultState ? trueString : falseString;
  }

  void setText(bool boolean) {
    text = boolean ? trueString : falseString;
    notifyListeners();
  }
}
