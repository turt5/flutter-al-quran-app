import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActiveTextProvider extends ChangeNotifier {
  String _activeText = '';

  String get activeText => _activeText;
  
  void setActiveText(String text) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('activeText', text);

    _activeText = text;
    notifyListeners();
  }

  Future<void> getActiveText() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _activeText = pref.getString('activeText') ?? '';
    notifyListeners();
  }
}
