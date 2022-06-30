import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as htpp;
import '../utils/strings.dart';
import 'package:intl/intl.dart';

class sleepData {
  Future sleepTime() async {
    FitbitSleepDataManager fitbitSleepDataManager = FitbitSleepDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
    );
    final sleepData = await fitbitSleepDataManager.fetch(
        FitbitSleepAPIURL.withUserIDAndDay(
            date: DateTime.now().subtract(Duration(days: 0)),
            userID: '7ML2XV')) as List<FitbitSleepData>;

    //last & first entryDateTime extraction
    var lastElement = sleepData.elementAt(sleepData.length - 1).entryDateTime;
    var firstElement = sleepData.elementAt(0).entryDateTime;

    //suddivisione di ore minuti e secondi per entrmabi gli elementi
    var hhL = lastElement?.day;
    var mmL = lastElement?.minute;
    var ssL = lastElement?.second;
    String endTime = '$hhL:$mmL:$ssL';

    var hhF = firstElement?.hour;
    var mmF = firstElement?.minute;
    var ssF = firstElement?.second;
    String startTime = '$hhF:$mmF:$ssF';

    //calcolo della differenza
    Duration? diff = lastElement?.difference(firstElement!);
    int? days = diff?.inDays;
    int hours = diff!.inHours % 24;
    int minutes = diff.inMinutes % 60;
    int seconds = diff.inSeconds % 60;

    String tS = "$hours:$minutes:$seconds.";
    return tS;
  } //sleeTime

}
