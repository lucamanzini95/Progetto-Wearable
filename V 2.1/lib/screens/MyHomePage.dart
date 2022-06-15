import 'package:flutter/material.dart';
import 'package:progetto_wearable/screens/loginPage.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const route = '/home/';
  static const routename = 'Homepage';

  @override
  Widget build(BuildContext context) {
    print('${MyHomePage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(MyHomePage.routename),
      ),
      body: Center(
        child: Text('login_flow'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('login_flow'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => _toLoginPage(context),
            ),
          ],
        ),
      ),
    );
  } //build

  void _toLoginPage(BuildContext context) {
    //Pop the drawer first
    Navigator.pop(context);
    //Then pop the HomePage
    Navigator.of(context).pushReplacementNamed(LoginPage.route);
  } //_toCalendarPage
}
