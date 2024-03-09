import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkFirstLaunch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('first_launch') ?? true;
  if (isFirstLaunch) {
    await prefs.setBool('first_launch', false);
  }
  return isFirstLaunch;
}
