import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:progetto_wearable/screens/MyHomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const route = 'settingspage';
  static const routename = 'SettingPage';

  @override
  _settingsPageState createState() => _settingsPageState();
}

class _settingsPageState extends State<SettingsPage> {
  bool valNotify1 = false;
  @override
  void initState() {
    super.initState();
  } //initState

  onChangeFunction1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('account')
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOption(context, 'Change Password'),
            buildAccountOption(context, 'Content Settings'),
            buildAccountOption(context, 'Social'),
            buildAccountOption(context, 'Languege'),
            buildAccountOption(context, 'Privacy and Security'),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Notifcation',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOption(
                'Theme Dark', valNotify1, onChangeFunction1),
            SizedBox(
              height: 50,
            ),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back home page'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Padding buildNotificationOption(
    String title, bool value, Function onChangeMethod) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            activeColor: Colors.blue,
            trackColor: Colors.grey,
            value: value,
            onChanged: (bool newValue) {
              onChangeMethod(newValue);
            },
          ),
        )
      ],
    ),
  );
}

void _toHomePage(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(MyHomePage.route);
} //_toHomePage

GestureDetector buildAccountOption(BuildContext context, String title) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('to be implemented'),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop;
                    },
                    child: Text('Close'))
              ],
            );
          });
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[500],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ],
      ),
    ),
  );
}
