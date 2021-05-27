import 'dart:convert';

import 'package:covid_track/resources/consts.dart';
import 'package:covid_track/widgets/home_screen_counter_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Country extends StatefulWidget {
  @override
  _CountryCovidPageState createState() => _CountryCovidPageState();
}

class _CountryCovidPageState extends State<Country> {
  // Future<GlobalModel> globalData;
  List countryData;
  var isLoading = false;
  ScrollController _scrollController = ScrollController();
  int _currentMax = 20;

  Future _fetchCountryData() async {
    setState(() {
      isLoading = true;
    });
    var url = 'https://disease.sh/v3/covid-19/countries?sort=cases';

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      _currentMax = _currentMax + 20;
      setState(() {
        countryData = json.decode(response.body);
        setState(() {
          isLoading = false;
        });
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void initState() {
    super.initState();
    countryData = List.generate(20, (index) => _fetchCountryData());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _countryListView();
      }
    });
  }

  // @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _countryListView(),
    );
  }

  Widget _countryListView() {
    return Container(
      child: ListView.builder(
        itemCount: countryData == null ? 0 : countryData.length,
        controller: _scrollController,
        // physics: NeverScrollableScrollPhysics(),
        // shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 3,
            color: kBackgroundColor,
            child: ExpansionTile(
              title: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${index + 1}'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      elevation: 5,
                      child: Image.network(
                        countryData[index]['countryInfo']['flag'],
                        width: 50,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      child: Text(
                        countryData[index]["country"].toString(),
                        overflow: TextOverflow.fade,
                        style: kTitleTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CounterDetail(
                            color: kInfectedColor,
                            number: countryData[index]['cases'],
                            title: "Nhiễm bệnh",
                            subtitle: countryData[index]['todayCases'],
                          ),
                          CounterDetail(
                            color: kRecoverColor,
                            number: countryData[index]['recovered'],
                            title: "Hồi phục",
                            subtitle: countryData[index]['todayRecovered'],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CounterDetail(
                            color: kPrimaryColor,
                            number: countryData[index]['active'],
                            title: "Đang điều trị",
                            subtitle: countryData[index]['critical'],
                          ),
                          CounterDetail(
                            color: kDeathColor,
                            number: countryData[index]['deaths'],
                            title: "Tử vong",
                            subtitle: countryData[index]['todayDeaths'],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
