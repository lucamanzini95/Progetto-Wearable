import 'package:flutter/material.dart';
import 'package:progetto_wearable/screens/MyHomePage.dart';
import 'package:progetto_wearable/screens/loginPage.dart';
import 'package:progetto_wearable/screens/registrationPage.dart';
import 'package:progetto_wearable/screens/sleepPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progetto_wearable/database/database.dart';
import 'package:progetto_wearable/repositories/databaseRepository.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // open the database
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  // create repository from the AppDatabase just initialized
  final databaseRepository = DatabaseRepository(database: database);
  runApp(
    ChangeNotifierProvider<DatabaseRepository>(
      create: (context) => databaseRepository,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
      //Here, I'm demonstrating another way to manage Navigation. This approach can be handy when you need to
      //pass data to a route directly to its constructor and you want to continue to use pushNamed().
      onGenerateRoute: (settings) {
        if (settings.name == LoginPage.route) {
          return MaterialPageRoute(builder: (context) {
            return LoginPage();
          });
        } else if (settings.name == MyHomePage.route) {
          return MaterialPageRoute(builder: (context) {
            return MyHomePage();
          });
        } else if (settings.name == RegistrationPage.route) {
          final args = settings.arguments as Map;
          return MaterialPageRoute(builder: (context) {
            return RegistrationPage(user: args['user']);
          });
        } else {
          return null;
        } //if-else
      }, //routes
    );
  }
}
