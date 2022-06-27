import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progetto_wearable/database/entities/stepsData.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:progetto_wearable/database/entities/userData.dart';
import 'package:progetto_wearable/repositories/databaseRepository.dart';
import 'package:progetto_wearable/screens/loginPage.dart';
import 'package:progetto_wearable/screens/registrationPage.dart';
import 'package:progetto_wearable/utils/strings.dart';
import 'package:progetto_wearable/fetcData/fetchSteps.dart';
import 'package:progetto_wearable/fetcData/sleepData.dart';
import 'package:progetto_wearable/fetcData/activityData.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  static const route = '/home/';
  static const routename = 'Homepage';
  fetchSteps steppi = fetchSteps();
  sleepData sleppi = sleepData();
  activityData klcal = activityData();
  activityData dist = activityData();

  UserData? loggedUser;

  @override
  Widget build(BuildContext context) {
    DateTime d = new DateTime.now();
    StepsData step = StepsData(null, null, d, null);
    double? passi;
    print('${MyHomePage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(MyHomePage.routename),
      ),

      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              FutureBuilder(
                future: steppi.fetchDailySteps(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as double;
                    step = StepsData(null, null, d, data);
                    Provider.of<DatabaseRepository>(context, listen: false)
                        .insertStepsData(step);

                    return CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 10.0,
                      percent: _stepsToPercent(step.steps),
                      header: new Text('Passi'),
                      center: new Icon(
                        MdiIcons.footPrint,
                        size: 25,
                        color: Colors.blue,
                      ),
                      backgroundColor: Colors.grey,
                      progressColor: Colors.orange,
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Print passi giornalieri
                  FutureBuilder(
                    future: steppi.fetchDailySteps(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data as double;
                        step = StepsData(null, null, d, data);
                        Provider.of<DatabaseRepository>(context, listen: false)
                            .insertStepsData(step);
                        return Text('Daily steps: ${step.steps}');
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return CircularProgressIndicator();
                    },
                  ),

                  //print calorie bruciate
                  FutureBuilder(
                    future: klcal.fetchCaloriesOfTheDay(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text('calorie bruciate oggi: ${snapshot.data}');
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  FutureBuilder(
                    future: dist.fetchDistanceOfTheDay(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text('Today distance: ${snapshot.data} km');
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ],
          ),

          SizedBox(
            height: 50,
          ),
          Text('Dati del sonno:'),
          Row(
            children: [
              FutureBuilder(
                future: sleppi.sleepTime(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('Ore di sonno ultima notte:  ${snapshot.data}');
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),

          //sleep
          Consumer<DatabaseRepository>(
            builder: (context, dbr, child) {
              return FutureBuilder(
                initialData: null,
                future: dbr.findUserData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as List<UserData>;
                    if (data.isEmpty) {
                      return ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'registrationpage',
                              arguments: {'user': null});
                        },
                        child: const Text('Registration'),
                      );
                    } else {
                      loggedUser = data[0];
                      return Column(
                        children: [
                          Row(
                            children: [
                              Card(
                                child: InkWell(
                                  splashColor: Colors.blue.withAlpha(30),
                                  onTap: () {},
                                  child: const SizedBox(
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
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );
            },
          ),

          SizedBox(
            height: 50,
          ),

          //app authorization
          ElevatedButton(
            onPressed: () => _authorized(context),
            child: Text('Tap to authorize'),
          ),
        ],
      ),

      //MENU'
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
            Consumer<DatabaseRepository>(builder: (context, dbr, child) {
              return FutureBuilder(
                  initialData: null,
                  future: dbr.findUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as List<UserData>;
                      if (data.isEmpty) {
                        return ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text('Personal Information'),
                          onTap: () => Navigator.pushNamed(
                              context, RegistrationPage.route,
                              arguments: {'user': null}),
                        );
                      } else {
                        return ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text('Personal Information'),
                          onTap: () => Navigator.pushNamed(
                              context, RegistrationPage.route,
                              arguments: {'user': data[0]}),
                        );
                      }
                    } else {
                      return ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Personal Information'),
                        onTap: () => Navigator.pushNamed(
                            context, RegistrationPage.route,
                            arguments: {'user': null}),
                      );
                    }
                  });
            }),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => _toLoginPage(context),
            ),
          ],
        ),
      ),
    );
  } //build

  Future<void> _authorized(BuildContext context) async {
    // Authorize the app
    String? userId = await FitbitConnector.authorize(
        context: context,
        clientID: Strings.fitbitClientID,
        clientSecret: Strings.fitbitClientSecret,
        redirectUri: Strings.fitbitRedirectUri,
        callbackUrlScheme: Strings.fitbitCallbackScheme);
  }

  //Il widget di percent indcator accetta double compresi tra 0.00 e 1.0
  //con la seguente funzione converto il dato in percentuale+
  //double x: valore da voncertire
  //return: 1 se il dato è maggiore di 1, y altrimenti
  double _stepsToPercent(double? x) {
    double y = x! / 10000;
    if (y > 1) {
      return 1.0;
    } else {
      return y;
    }
  }

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
