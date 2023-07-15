import 'package:flutter/services.dart';

class ClipboardComparator {
  // Checks if the clipboard contents is equal to a given string.
  static bool isEqual(String string) {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      if (value == null) return false;
      if (string == value.text) return true;
    });
    return false;
  }
}
