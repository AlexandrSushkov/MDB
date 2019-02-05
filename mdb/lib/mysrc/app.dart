import 'package:flutter/material.dart';
import 'package:mdb/mysrc/ui/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: Scaffold(body: HomeScreen()),
    );
  }
}