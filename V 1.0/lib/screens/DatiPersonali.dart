import 'package:flutter/material.dart';

class DatiPersonalini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("dati personali"),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(253, 105, 15, 239),
                Color.fromARGB(255, 174, 39, 247),
              ]),
        ),
      ),
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Notifiche",
            style: TextStyle(color: Colors.black),
          )),
    );
  }
}
