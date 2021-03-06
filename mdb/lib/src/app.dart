import 'package:flutter/material.dart';
import 'package:mdb/src/resource/theme.dart';
import 'package:mdb/src/ui/home_screen/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkMdbTheme.theme,
      home: HomeScreen(),
    );
  }
}