import 'package:flutter/material.dart';
import 'package:multilevel_drawer/screens/SecondScreen.dart';
import 'package:multilevel_drawer/layout/MultiLevelDrawer.dart';
import 'package:multilevel_drawer/MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Progetto Biomedical',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
