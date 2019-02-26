import 'dart:async';

import 'package:mdb/src/bloc/base/block_provider.dart';

class SettingBloc implements DisposableBloc {

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

}
