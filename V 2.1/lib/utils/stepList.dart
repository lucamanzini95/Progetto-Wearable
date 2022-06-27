import 'package:charts_flutter/flutter.dart' as charts;

class StepList {
  final double? step;
  //uso string al posto di Datetime perchè il pacchetto non mi permette di usare un Datetime
  final String date;
  final charts.Color barColor;

  StepList({
    required this.date,
    required this.step,
    required this.barColor,
  });
}
