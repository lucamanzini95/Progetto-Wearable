import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progetto_wearable/database/entities/userData.dart';
import 'package:progetto_wearable/database/entities/sleepData.dart';
import 'package:progetto_wearable/repositories/databaseRepository.dart';
import 'package:provider/provider.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:fl_chart/fl_chart.dart';

class SleepPage extends StatefulWidget {
  SleepPage({Key? key, required this.user}) : super(key: key);

  final UserData? user;

  static const route = 'sleeppage';
  static const routeDisplayName = 'Sleep page';

  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  List<FlSpot> mySpots = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
        return FutureBuilder(
          initialData: null,
          future: dbr.findUserSleep(widget.user!.id!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<SleepData> mySleepData = snapshot.data as List<SleepData>;
              mySpots = [];
              for (int i = 0; i < mySleepData.length; i++) {
                switch (mySleepData[i].level) {
                  case 'deep':
                    {
                      mySpots.add(FlSpot(
                          timeToDouble(mySleepData[i].entryDateTime), 0));
                    }
                    break;
                  case 'light':
                    {
                      mySpots.add(FlSpot(
                          timeToDouble(mySleepData[i].entryDateTime), 1));
                    }
                    break;
                  case 'rem':
                    {
                      mySpots.add(FlSpot(
                          timeToDouble(mySleepData[i].entryDateTime), 2));
                    }
                    break;
                  case 'wake':
                    {
                      mySpots.add(FlSpot(
                          timeToDouble(mySleepData[i].entryDateTime), 3));
                    }
                    break;
                  default:
                    {
                      //;
                    }
                    break;
                }
              }
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Sleep page'),
                ),
                body: Center(
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 25, 5, 10),
                      alignment: Alignment.center,
                      width: 350,
                      height: 350,
                      child: LineChart(
                        LineChartData(
                          minY: 0,
                          maxY: 3,
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: bottomTitleWidgets,
                            )),
                            leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 50,
                              getTitlesWidget: leftTitleWidgets,
                              interval: 1,
                            )),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: mySpots,
                              isCurved: false,
                              dotData: FlDotData(show: false),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        );
      }),
    );
  }
}

double timeToDouble(DateTime dateTime) {
  double year = dateTime.year * 525600;
  double month = dateTime.month * 43800;
  double day = dateTime.day * 1440;
  double hour = dateTime.hour * 60;
  double minute = dateTime.minute.toDouble();
  return year + month + day + hour + minute;
}

DateTime doubleToTime(double value) {
  int year = value ~/ 525600;
  value = value - year * 525600;
  int month = value ~/ 43800;
  value = value - month * 43800;
  int day = value ~/ 1440;
  value = value - month * 1440;
  int hour = value ~/ 60;
  value = value - hour * 60;
  return DateTime(year, month, day, hour);
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  String text;
  switch (doubleToTime(value).hour) {
    case 0:
      text = '00:00';
      break;

    case 4:
      text = '04:00';
      break;

    case 8:
      text = '08:00';
      break;

    case 12:
      text = '12:00';
      break;

    case 16:
      text = '16:00';
      break;

    case 20:
      text = '20:00';
      break;

    default:
      text = '';
      break;
  }

  return Text(text, style: style, textAlign: TextAlign.center);
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff68737d),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = 'Deep';
      break;
    case 1:
      text = 'Light';
      break;
    case 2:
      text = 'REM';
      break;
    case 3:
      text = 'Awake';
      break;
    default:
      text = '';
      break;
  }
  return Text(text, style: style, textAlign: TextAlign.left);
}
