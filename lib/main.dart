import 'package:flume/Pages/HomePage.dart';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blue),
      //home: new LoginPage(),
      home: new HomePage(),
    );
  }
}
