// ignore_for_file: unnecessary_null_comparison

import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as htpp;
import 'package:progetto_wearable/utils/stepchart.dart';
import '../utils/strings.dart';
import 'package:progetto_wearable/utils/stepchart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:progetto_wearable/utils/stepList.dart';

class fetchSteps {
  Future fetchDailySteps() async {
    FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager =
        FitbitActivityTimeseriesDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
      type: 'steps',
    );

    final stepD = await fitbitActivityTimeseriesDataManager
        .fetch(FitbitActivityTimeseriesAPIURL.dayWithResource(
      date: DateTime.now(),
      userID: '7ML2XV',
      resource: fitbitActivityTimeseriesDataManager.type,
    )) as List<FitbitActivityTimeseriesData>;
    var steps = stepD[0].value;
    var d = stepD[0].dateOfMonitoring;
    //inserire nel DBpè'òpèò'0
    if (steps != null) {
      return steps;
    } else {
      throw Exception('Faild to load data');
    }
  } //fetchDailySteps

  Future countWeeklySteps() async {
    FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager =
        FitbitActivityTimeseriesDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
      type: 'steps',
    );

    final stepW = await fitbitActivityTimeseriesDataManager
        .fetch(FitbitActivityTimeseriesAPIURL.weekWithResource(
      baseDate: DateTime.now(),
      userID: '7ML2XV',
      resource: fitbitActivityTimeseriesDataManager.type,
    )) as List<FitbitActivityTimeseriesData>;
    int lunghezzaLista = stepW.length;
    double steps = 0;
    for (var i = 0; i < lunghezzaLista; i++) {
      steps = steps + (stepW[i].value as double);
    } //for
    if (steps != null) {
      return steps;
    } else {
      throw Exception('Faild to load data');
    }
  } //_coutnWeeklySteps

  Future countMonthlySteps() async {
    FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager =
        FitbitActivityTimeseriesDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
      type: 'steps',
    );

    final stepM = await fitbitActivityTimeseriesDataManager
        .fetch(FitbitActivityTimeseriesAPIURL.monthWithResource(
      baseDate: DateTime.now(),
      userID: '7ML2XV',
      resource: fitbitActivityTimeseriesDataManager.type,
    )) as List<FitbitActivityTimeseriesData>;
    int lunghezzaLista = stepM.length;
    double steps = 0;
    for (var i = 0; i < lunghezzaLista; i++) {
      steps = steps + (stepM[i].value as double);
    } //for

    if (steps != null) {
      return steps;
    } else {
      throw Exception('Faild to load data');
    }
  } //_coutnMonthySteps

  /* Future saveMonthlySteps() async {
    List<StepList> k;
    FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager =
        FitbitActivityTimeseriesDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
      type: 'steps',
    );

    final stepM = await fitbitActivityTimeseriesDataManager
        .fetch(FitbitActivityTimeseriesAPIURL.monthWithResource(
      baseDate: DateTime.now(),
      userID: '7ML2XV',
      resource: fitbitActivityTimeseriesDataManager.type,
    )) as List<FitbitActivityTimeseriesData>;
    int lunghezzaLista = stepM.length;
    double? x;
    String c;
    for (var i = 0; i < lunghezzaLista; i++) {
      x = stepM[i].value;
      c = stepM[i].dateOfMonitoring as String;
      k = [
        StepList(
            date: c,
            step: x,
            barColor: charts.ColorUtil.fromDartColor(Colors.black))
      ];
    }
      return StepChart(s: k);
  } //
  */

  //metodo per calcolare le ore di sonno di un determinato giorno
} //fetchSteps
