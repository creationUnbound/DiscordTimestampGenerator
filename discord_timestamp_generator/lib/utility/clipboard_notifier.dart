import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipboardNotifier with ChangeNotifier {
  String text = "";

  Future<void> updateTextFromClipboard() async {
    await Clipboard.getData(Clipboard.kTextPlain).then((value) {
      text = value?.text ?? "";
      notifyListeners();
    });
  }
}
