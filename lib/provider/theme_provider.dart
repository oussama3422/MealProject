import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var primaryColor = Colors.pink;
  var accentColor = Colors.amber;

  var tm = ThemeMode.system;
  String themeText='s' ;
  onChanged(color, n) async {
    n == 1
        ? primaryColor = setMaterialColor(color.hashCode)
        : accentColor = setMaterialColor(color.hashCode);
    notifyListeners();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("primaryColor", primaryColor.value);
    preferences.setInt("accentColor", accentColor.value);
  }

  getThemeColors() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    primaryColor =
        setMaterialColor(preferences.getInt("primaryColor") ?? 0xFFE91E63);
    accentColor =
        setMaterialColor(preferences.getInt("accentColor") ?? 0xFFFFC107);
    notifyListeners();
  }

  MaterialColor setMaterialColor(colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: const Color(0xFFFFEBEE),
        100: const Color(0xFFFFCDD2),
        200: const Color(0xFFEF9A9A),
        300: const Color(0xFFE57373),
        400: const Color(0xFFEF5350),
        500: Color(colorVal),
        600: const Color(0xFFE53935),
        700: const Color(0xFFD32F2F),
        800: const Color(0xFFC62828),
        900: const Color(0xFFB71C1C),
      },
    );
  }

  void themeModeChange(newThemeVal) async {
    tm = newThemeVal;
    getThemeText(tm);
    notifyListeners();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("ThemeText", themeText);
    // print(preferences.getString("ThemeText"));
  }

  getThemeText(ThemeMode theme) async {
    if (theme == ThemeMode.dark) {
      themeText = "d";
    } else if (theme == ThemeMode.light) {
      themeText = "l";
    } else if (theme == ThemeMode.system) {
      themeText = "s";
    }
    notifyListeners();
  }

  getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeText = prefs.getString("ThemeText") ?? "s";
    if (themeText == "d") {
      themeText = ThemeMode.dark as String;
    } else if (themeText == "l") {
      themeText = ThemeMode.light as String ;
    } else if (themeText == "s") {
      themeText = ThemeMode.system as String;
    }
    notifyListeners();
  }
}
