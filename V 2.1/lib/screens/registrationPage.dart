import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progetto_wearable/database/entities/userData.dart';
import 'package:progetto_wearable/repositories/databaseRepository.dart';
import 'package:provider/provider.dart';
import 'package:fitbitter/fitbitter.dart';

class RegistrationPage extends StatefulWidget
{
  RegistrationPage({Key? key, required this.user}) : super(key:key);

  final UserData? user;

  static const route = 'registrationpage';
  static const routeDisplayName = 'Registration page';


  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
{
  final List<TextEditingController> myController = [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()];

  @override
  void initState()
  {
    myController[0].text = widget.user == null ? '' : widget.user!.name;
    myController[1].text = widget.user == null ? '' : widget.user!.surname;
    myController[2].text = widget.user == null ? '' : widget.user!.age.toString();
    myController[3].text = widget.user == null ? '' : widget.user!.height.toString();
    myController[4].text = widget.user == null ? '' : widget.user!.weight.toString();
    
    super.initState();
  }

  @override
  void dispose()
  {
    myController[0].dispose();
    myController[1].dispose();
    myController[2].dispose();
    myController[3].dispose();
    myController[4].dispose();
    super.dispose();
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
            future: dbr.findUserData(),
            builder: (context, snapshot)
            {
              if(snapshot.hasData)
              {
                return Scaffold
                (
                  appBar: AppBar
                  (
                    title: const Text('Registration page'),
                    actions: 
                    [
                      IconButton
                      (
                        onPressed: ()
                        {
                          if(widget.user == null && myController[0].text != '' && myController[1].text != '' && myController[2].text != '' && myController[3].text != '' && myController[4].text != '')
                          {
                            UserData newUser = UserData(null, myController[0].text, myController[1].text, int.parse(myController[2].text), int.parse(myController[3].text), int.parse(myController[4].text));
                            Provider.of<DatabaseRepository>(context, listen:false).insertUser(newUser);
                            Navigator.pop(context);
                          } else if(widget.user != null && myController[0].text != '' && myController[1].text != ''&& myController[2].text != '' && myController[3].text != '' && myController[4].text != '')
                          {
                            UserData updatedUser = UserData(widget.user!.id, myController[0].text, myController[1].text, int.parse(myController[2].text), int.parse(myController[3].text), int.parse(myController[4].text));
                            Provider.of<DatabaseRepository>(context, listen:false).updateUser(updatedUser);
                            Navigator.pop(context);
                          } else
                          {
                            ScaffoldMessenger.of(context).showSnackBar
                            (
                              const SnackBar
                              (
                                content: Center(child: Text('Invalid Data')),
                                duration: Duration(seconds: 2),
                              )
                            );
                          }
                        },
                        icon: const Icon(Icons.check)
                      )
                    ],
                  ),
                  body: Center
                  (
                  child: Column
                    (
                      children: 
                      [
                        Container
                        (
                          margin: const EdgeInsetsDirectional.fromSTEB(10,10,10,0),
                          width: 380,
                          height: 30,
                          //color: Colors.red,
                          child: const Text('Please enter your personal info', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                        ),
                        Container
                        (
                          margin: const EdgeInsetsDirectional.fromSTEB(10,10,10,0),
                          width: 300,
                          height: 50,
                          //color: Colors.red,
                          child: TextFormField
                          (
                            controller: myController[0],
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration
                            (
                              labelText: 'Name',
                              border: UnderlineInputBorder(),
                            )
                          ),
                        ),
                        Container
                        (
                          margin: const EdgeInsetsDirectional.fromSTEB(10,25,10,0),
                          width: 300,
                          height: 50,
                          //color: Colors.yellow,
                          child: TextFormField
                          (
                            controller: myController[1],
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration
                            (
                              labelText: 'Surname',
                              border: UnderlineInputBorder(),
                            )
                          ),
                        ),
                        Container
                        (
                          margin: const EdgeInsetsDirectional.fromSTEB(10,25,10,0),
                          width: 300,
                          height: 50,
                          //color: Colors.red,
                          child: TextFormField
                          (
                            controller: myController[2],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration
                            (
                              labelText: 'Age',
                              border: UnderlineInputBorder(),
                            )
                          ),
                        ),
                        Row
                        (
                          children: 
                          [
                            Container
                            (
                              margin: const EdgeInsetsDirectional.fromSTEB(50,10,10,0),
                              width: 140,
                              height: 50,
                              //color: Colors.red,
                              child: TextFormField
                              (
                                controller: myController[3],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration
                                (
                                  labelText: 'Height [cm]',
                                  border: UnderlineInputBorder(),
                                )
                              ),
                            ),
                            Container
                            (
                              margin: const EdgeInsetsDirectional.fromSTEB(10,10,10,0),
                              width: 140,
                              height: 50,
                              //color: Colors.red,
                              child: TextFormField
                              (
                                controller: myController[4],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration
                                (
                                  labelText: 'Weight [kg]',
                                  border: UnderlineInputBorder(),
                                )
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton
                        (
                          onPressed: () async
                          {
                            String? userId = await FitbitConnector.authorize(
                            context: context,
                            clientID: '238LL2',
                            clientSecret: '2d897732730cb4a5aee10cbada65206d',
                            redirectUri: 'example://fitbit/auth',
                            callbackUrlScheme: 'example://fitbit/auth');
                          },
                          child: const Text('Connect your device'),
                        )
                      ],

                    ),
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
