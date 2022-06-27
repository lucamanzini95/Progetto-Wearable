import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:progetto_wearable/database/entities/sleepData.dart';
import 'package:progetto_wearable/database/entities/userData.dart';
import 'package:progetto_wearable/repositories/databaseRepository.dart';
import 'package:progetto_wearable/screens/loginPage.dart';
import 'package:progetto_wearable/screens/registrationPage.dart';
import 'package:progetto_wearable/screens/sleepPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  static const route = '/home/';
  static const routename = 'Homepage';

  String? userIdentification;

  @override
  Widget build(BuildContext context) {
    print('${MyHomePage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(MyHomePage.routename),
      ),
      body: Consumer<DatabaseRepository>
      (
        builder: (context, dbr, child)
        {
          return FutureBuilder
          (
            initialData: null,
            future: dbr.findUserData(),
            builder: (context, snapshot)
            {
              if(snapshot.hasData)
              {
                final data = snapshot.data as List<UserData>;
                if (data.isEmpty || userIdentification == null)
                {
                  return ElevatedButton
                  (
                    onPressed: () {Navigator.pushNamed(context, 'registrationpage', arguments: {'user': null});},
                    child: const Text('Registration'),
                  );
                } else
                {
                  return Column
                  (
                    children: 
                    [
                      Row
                      (
                        children: 
                        [
                          Card
                          (
                            child: InkWell
                            (
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () async
                              {
                                FitbitSleepDataManager fitbitSleepDataManager = FitbitSleepDataManager(
                                  clientID: '238LL2',
                                  clientSecret: '2d897732730cb4a5aee10cbada65206d',
                                );
                                FitbitSleepAPIURL fitbitSleepAPIURL = FitbitSleepAPIURL.withUserIDAndDay(
                                    date: DateTime.now(),
                                    userID: userIdentification,
                                );
                                List<FitbitSleepData> fitbitSleepData = await fitbitSleepDataManager.fetch(fitbitSleepAPIURL) as List<FitbitSleepData>;
                                List<SleepData> mySleepData = List.filled(fitbitSleepData.length, SleepData(null, data[0].id, DateTime.now(), DateTime.now(), ''));
                                for(int i = 0; i < fitbitSleepData.length; i++)
                                {
                                  try
                                  {
                                    mySleepData[i] = SleepData(null, data[0].id!, fitbitSleepData[i].dateOfSleep!, fitbitSleepData[i].entryDateTime!, fitbitSleepData[i].level);
                                  }on Exception catch(_)
                                  {
                                    //
                                  }
                                }
                                List<SleepData> userSleepData = await dbr.findUserSleep(data[0].id!);
                                await dbr.deleteSleep(userSleepData);
                                await dbr.insertSleepData(mySleepData);
                                Navigator.pushNamed(context, SleepPage.route, arguments: {'user': data[0]});
                              },
                              child: const SizedBox
                              (
                                width: 150,
                                height: 100,
                                child: Text('Go to sleep data'),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }
              } else
              {
                return CircularProgressIndicator();
              }
            },
          );
        },
        
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text('nome@mail.com'),
              accountName: Text('Pippo'),
              decoration: BoxDecoration(color: Colors.blue),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/dog.jpg'),
                radius: 100,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => _toLoginPage(context),
            ),
            Consumer<DatabaseRepository>
            (
              builder: (context, dbr, child)
              {
                return FutureBuilder
                (
                  initialData: null,
                  future: dbr.findUserData(),
                  builder: (context, snapshot)
                  {
                    if(snapshot.hasData)
                    {
                      final data = snapshot.data as List<UserData>;
                      if (data.isEmpty)
                      {
                        return ListTile
                        (
                          leading: const Icon(Icons.settings),
                          title: const Text('Personal Information'),
                          onTap: () => Navigator.pushNamed(context, RegistrationPage.route, arguments: {'user' : null}),
                        );
                      } else
                      {
                        return ListTile
                        (
                          leading: const Icon(Icons.settings),
                          title: const Text('Personal Information'),
                          onTap: () => Navigator.pushNamed(context, RegistrationPage.route, arguments: {'user' : data[0]}),
                        );
                      }
                    } else
                    {
                      return ListTile
                        (
                          leading: const Icon(Icons.settings),
                          title: const Text('Personal Information'),
                          onTap: () => Navigator.pushNamed(context, RegistrationPage.route, arguments: {'user' : null}),
                        );
                    }
                  }
                );
              }
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => _toLoginPage(context),
            ),
            ListTile
            (
              title: const Text('Connect your device'),
              onTap: () async
              {
                String? userId = await FitbitConnector.authorize(
                context: context,
                clientID: '238LL2',
                clientSecret: '2d897732730cb4a5aee10cbada65206d',
                redirectUri: 'example://fitbit/auth',
                callbackUrlScheme: 'example');
                userIdentification = userId;
              },
            )
          ],
        ),
      ),
    );
  } //build

  void _toLoginPage(BuildContext context) async {
    //Unset the 'username' filed in SharedPreference
    final sp = await SharedPreferences.getInstance();
    sp.remove('username');

    //Pop the drawer first
    Navigator.pop(context);
    //Then pop the HomePage
    Navigator.of(context).pushReplacementNamed(LoginPage.route);
  } //_toCalendarPage
}
