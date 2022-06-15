import 'package:flutter/material.dart';
import 'package:progetto_wearable/screens/MyHomePage.dart';
import 'package:progetto_wearable/screens/loginPage.dart';

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
      initialRoute: LoginPage.route,
      routes: {
        LoginPage.route: (context) => LoginPage(),
        MyHomePage.route: (context) => MyHomePage(),
      }, //routes
    );
  }
}
