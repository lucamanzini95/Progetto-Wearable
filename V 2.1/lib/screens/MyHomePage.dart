import 'package:flutter/material.dart';
import 'package:progetto_wearable/database/entities/userData.dart';
import 'package:progetto_wearable/repositories/databaseRepository.dart';
import 'package:progetto_wearable/screens/loginPage.dart';
import 'package:progetto_wearable/screens/registrationPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  static const route = '/home/';
  static const routename = 'Homepage';

  UserData? loggedUser;

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
                if (data.isEmpty)
                {
                  return ElevatedButton
                  (
                    onPressed: () {Navigator.pushNamed(context, 'registrationpage', arguments: {'user': null});},
                    child: const Text('Registration'),
                  );
                } else
                {
                  loggedUser = data[0];
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
                              onTap: () {},
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
