import 'package:flutter/material.dart';

class ActiveTextProvider extends ChangeNotifier {
  String _activeText = '';

  String get activeText => _activeText;

  void setActiveText(String text) {
    _activeText = text;
    notifyListeners();
  }
}
