import 'dart:async';

import 'package:mdb/src/bloc/bloc.dart';
import 'package:mdb/src/util/preference_manager.dart';

class SettingBloc implements BlocBase {
  final preferenceManager = PreferenceManager();
  
  StreamController<bool> _themeController = StreamController<bool>();
  Sink<bool> get themeController => _themeController.sink;
  Stream<bool> get outController => _themeController.stream;

  @override
  void dispose() {
    _themeController.close();
  }

  void saveTheme(bool isDarkTheme) {
    themeController.add(isDarkTheme);
  }

  getPrefTheme() async {
    var isDarkTheme = await preferenceManager.getThemePref();
    _themeController.add(isDarkTheme);
  }

}