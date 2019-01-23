import 'package:flutter/material.dart';
import 'package:mdb/src/navigation/navigator.dart';
import 'package:mdb/src/ui/home_screen/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      initialRoute: '/',
      routes: smbRoutes
    );
  }
}