import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../resources/consts.dart';
import 'models/country_summany.dart';
import 'time_series_cases.dart';
import 'chart.dart';

class CountryStatistics extends StatelessWidget {
  final List<CountrySummaryChartModel> summaryChartList;

  CountryStatistics({@required this.summaryChartList});

  @override
  Widget build(BuildContext context) {
    if (summaryChartList.length != 0) {
      return Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              'Biểu đồ tổng số ca mắc Covid-19',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kTitleTextColor,
              ),
            ),
          ),
          buildCardChart(summaryChartList),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "Cập nhật từ: " +
                  '${DateFormat("dd/MM/yyyy").format((summaryChartList[0].date))}' +
                  " đến ${DateFormat("dd/MM/yyyy").format((summaryChartList[summaryChartList.length - 1].date))}",
            ),
          ),
        ],
      );
    } else
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Không có dữ liệu về quốc gia hoặc vùng lãnh thổ này",
                  style: TextStyle(fontSize: 25, color: kPrimaryColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget buildCardChart(List<CountrySummaryChartModel> summaryChartList) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
        elevation: 5,
        shadowColor: kShadowColor,
        child: Container(
          height: 250,
          padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
          child: Chart(_createData(summaryChartList)),
        ),
      ),
    );
  }

  static List<charts.Series<TimeSeriesCases, DateTime>> _createData(
      List<CountrySummaryChartModel> summaryChartList) {
    List<TimeSeriesCases> confirmedData = [];
    List<TimeSeriesCases> activeData = [];
    List<TimeSeriesCases> recoveredData = [];
    List<TimeSeriesCases> deathData = [];

    for (var item in summaryChartList) {
      confirmedData.add(TimeSeriesCases(item.date, item.confirmed));
      activeData.add(TimeSeriesCases(item.date, item.active));
      recoveredData.add(TimeSeriesCases(item.date, item.recovered));
      deathData.add(TimeSeriesCases(item.date, item.death));
    }

    return [
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Confirmed',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kInfectedColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: confirmedData,
      ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Active',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kPrimaryColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: activeData,
      ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Recovered',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kRecoverColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: recoveredData,
      ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Death',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kDeathColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: deathData,
      ),
    ];
  }
}
