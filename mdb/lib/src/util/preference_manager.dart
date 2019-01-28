import 'package:shared_preferences/shared_preferences.dart';

const String THEME_PREF = 'theme_pref';

class PreferenceManager {

  void saveThemePref(bool isDarkTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(THEME_PREF, isDarkTheme);
  }

  Future<bool> getThemePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_PREF);
  }

}
