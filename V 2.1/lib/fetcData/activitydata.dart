import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as htpp;
import '../utils/strings.dart';

class activityData {
  Future fetchActivityData() async {
    FitbitActivityDataManager fitbitActivityDataManager =
        FitbitActivityDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
    );

    final act = await fitbitActivityDataManager.fetch(FitbitActivityAPIURL.day(
      date: DateTime.now(),
      userID: '7ML2XV',
    )) as List<FitbitActivityData>;
  } //fetch

  Future fetchCaloriesOfTheDay() async {
    FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager =
        FitbitActivityTimeseriesDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
      type: 'calories',
    );

    final calories = await fitbitActivityTimeseriesDataManager
        .fetch(FitbitActivityTimeseriesAPIURL.dayWithResource(
      date: DateTime.now(),
      userID: '7ML2XV',
      resource: fitbitActivityTimeseriesDataManager.type,
    )) as List<FitbitActivityTimeseriesData>;
    var cal = calories.elementAt(0).value;
    if (cal != null) {
      return cal;
    } else {
      throw Exception('Faild to load data');
    }
  }

  //distanza percrosa  oggi
  Future fetchDistanceOfTheDay() async {
    FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager =
        FitbitActivityTimeseriesDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
      type: 'distance',
    );

    final distance = await fitbitActivityTimeseriesDataManager
        .fetch(FitbitActivityTimeseriesAPIURL.dayWithResource(
      date: DateTime.now(),
      userID: '7ML2XV',
      resource: fitbitActivityTimeseriesDataManager.type,
    )) as List<FitbitActivityTimeseriesData>;
    var dist = distance.elementAt(0).value;
    if (dist != null) {
      return dist;
    } else {
      throw Exception('Faild to load data');
    }
  }
} //class
