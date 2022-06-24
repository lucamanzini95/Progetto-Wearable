import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progetto_wearable/database/entities/userData.dart';
import 'package:progetto_wearable/database/entities/sleepData.dart';
import 'package:progetto_wearable/repositories/databaseRepository.dart';
import 'package:provider/provider.dart';

class SleepPage extends StatefulWidget
{
  SleepPage({Key? key, required this.user}) : super(key:key);

  final UserData? user;

  static const route = 'sleeppage';
  static const routeDisplayName = 'Sleep page';


  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage>
{
  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap:() => FocusManager.instance.primaryFocus?.unfocus(),
      child: Consumer<DatabaseRepository>
      (
        builder: (context, dbr, child)
        {
          return FutureBuilder
          (
            initialData: null,
            future: dbr.findSleepData(),
            builder: (context, snapshot)
            {
              if(snapshot.hasData)
              {
                return Scaffold
                (
                  appBar: AppBar
                  (
                    title: const Text('Sleep page'),
                    actions: 
                    [
                      IconButton
                      (
                        onPressed: ()
                        {

                        },
                        icon: const Icon(Icons.check)
                      )
                    ],
                  ),
                  body: Center
                  (
                    child: Text('Hello'),
                  ),
                );
              } else
              {
                return CircularProgressIndicator();
              } 
            },
          );
        }
      ),
    );
  }
}
