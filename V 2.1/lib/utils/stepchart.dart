import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:progetto_wearable/utils/stepList.dart';

class StepChart extends StatelessWidget {
  List<StepList> s;
  StepChart({required this.s});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<StepList, String>> series = [
      charts.Series(
        id: "steps",
        data: s,
        domainFn: (StepList series, _) => series.date,
        measureFn: (StepList series, _) => series.step,
        colorFn: (StepList series, _) => series.barColor,
      ),
    ];

    return Container(
        height: 400,
        padding: EdgeInsets.all(20),
        child: Card(
          child: Column(
            children: <Widget>[
              Text('Summary of the last 30 days'),
              charts.BarChart(
                series,
                animate: true,
              )
            ],
          ),
        ));
  } //widget constructor
}//classs
