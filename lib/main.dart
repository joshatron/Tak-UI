import 'package:flutter/material.dart';
import 'login_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tak',
      theme: ThemeData(
        primaryColor: Colors.brown,
      ),
      home: LoginPage(),
    );
  }
}
