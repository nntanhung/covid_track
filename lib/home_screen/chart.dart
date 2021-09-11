import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../home_screen/time_series_cases.dart';

class Chart extends StatelessWidget {
  final List<charts.Series<TimeSeriesCases, DateTime>> seriesList;

  Chart(this.seriesList);

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: true,
      domainAxis: charts.EndPointsTimeAxisSpec(),
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}
