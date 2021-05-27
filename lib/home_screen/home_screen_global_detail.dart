import 'dart:convert';

import 'package:covid_track/resources/consts.dart';
import 'package:covid_track/widgets/home_screen_counter_detail.dart';
import 'package:covid_track/home_screen/models/global_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Global extends StatefulWidget {
  @override
  _GlobalState createState() => _GlobalState();
}

Future<GlobalModel> globalData;
var isLoading = false;

class _GlobalState extends State<Global> {
  Future<GlobalModel> _fetchGlobalData() async {
    http.Response response =
        await http.get('https://disease.sh/v3/covid-19/all');
    if (response.statusCode == 200) {
      return GlobalModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    globalData = _fetchGlobalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder(
              future: globalData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, bottom: 10),
                            child: Container(
                              child: Text('Thế giới', style: kTitleTextStyle),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CounterDetail(
                                color: kInfectedColor,
                                number: snapshot.data.cases,
                                title: "Nhiễm bệnh",
                                subtitle: snapshot.data.todayCases,
                              ),
                              CounterDetail(
                                color: kRecoverColor,
                                number: snapshot.data.recovered,
                                title: "Hồi phục",
                                subtitle: snapshot.data.todayRecovered,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CounterDetail(
                                color: kPrimaryColor,
                                number: snapshot.data.active,
                                title: "Đang điều trị",
                                subtitle: snapshot.data.critical,
                              ),
                              CounterDetail(
                                color: kDeathColor,
                                number: snapshot.data.deaths,
                                title: "Tử vong",
                                subtitle: snapshot.data.todayDeaths,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
    );
  }
}
