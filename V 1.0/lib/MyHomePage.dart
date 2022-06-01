import 'package:flutter/material.dart';
import 'package:multilevel_drawer/screens/DatiPersonali.dart';
import 'package:multilevel_drawer/screens/SecondScreen.dart';
import 'package:multilevel_drawer/layout/MultiLevelDrawer.dart';
import 'package:multilevel_drawer/screens/DatiPersonali.dart';
import 'package:multilevel_drawer/screens/Options.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: MultiLevelDrawer(
          backgroundColor: Colors.white,
          rippleColor: Colors.white,
          subMenuBackgroundColor: Colors.grey.shade100,
          divisionColor: Colors.grey,
          header: Container(
            height: size.height * 0.20,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/io.jpeg",
                  width: 100,
                  height: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Luca Manzini")
              ],
            )),
          ),
          children: [
            MLMenuItem(
                leading: Icon(Icons.person),
                trailing: Icon(Icons.arrow_right),
                content: Text(
                  "My Profile",
                ),
                subMenuItems: [
                  MLSubmenu(
                      onClick: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DatiPersonalini()));
                      },
                      submenuContent: Text("Dati Personali")),
                  MLSubmenu(
                      onClick: () {},
                      submenuContent: Text("Resoconto settimanle")),
                ],
                onClick: () {}),
            MLMenuItem(
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.arrow_right),
              content: Text("Settings"),
              onClick: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Options(),
                ));
              },
            ),
            MLMenuItem(
              leading: Icon(Icons.notifications),
              content: Text("Notifications"),
              onClick: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SecondScreen()));
              },
            ),
            MLMenuItem(
              leading: Icon(Icons.logout),
              content: Text('Logout'),
              onClick: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SecondScreen()));
              },
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Prova layout app",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(253, 105, 15, 239),
                    Color.fromARGB(255, 174, 39, 247),
                  ]),
            ),
            child: Center()),
      ),
    );
  }
}
