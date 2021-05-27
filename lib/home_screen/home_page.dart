import 'package:covid_track/loading_screen/country_loading.dart';
import 'package:covid_track/home_screen/models/country_model.dart';
import 'package:covid_track/home_screen/country_statistics_chart.dart';
import 'package:covid_track/home_screen/country_statistics.dart';
import 'package:covid_track/home_screen/models/country_summany.dart';
import 'package:covid_track/home_screen/tracker.dart';
import 'package:covid_track/services/covid_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../resources/consts.dart';
import '../widgets/my_header.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

CovidService covidService = CovidService();

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  final TextEditingController textEditingController = TextEditingController();
  Future<List<CountryModel>> countryList;

  Future<List<CountrySummaryChartModel>> summaryChartList;
  Future<CountrySummaryNewModel> summaryNewList;

  _HomePageState({this.summaryChartList, this.summaryNewList});
  GlobalKey<RefreshIndicatorState> _refreshKey;

  double offset = 1;
  // final focus = FocusNode();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  List<String> _getSuggestions(List<CountryModel> list, String query) {
    List<String> matches = [];

    for (var item in list) {
      matches.add(item.country);
    }

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  void initState() {
    super.initState();
    onRefresh();
  }

  onRefresh() async {
    setState(() {
      controller.addListener(onScroll);
      countryList = covidService.getCountryList();

      this.textEditingController.text = "Việt Nam";
      summaryChartList = covidService.getCountrySummary("vietnam");
      summaryNewList = covidService.getCountrySummaryNew("vietnam");
      _refreshKey = GlobalKey<RefreshIndicatorState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: countryList,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: RefreshIndicator(
              key: _refreshKey,
              onRefresh: () => onRefresh(),
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  children: [
                    MyHeader(
                      image: "assets/icons/Drcorona.svg",
                      textTop: "Ở nhà là\nYÊU NƯỚC",
                      offset: offset,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, bottom: 20),
                      child: TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 16),
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                            ),
                            suffixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) =>
                                              textEditingController.clear());
                                    },
                                    child: FocusScope.of(context).hasFocus
                                        ? Icon(Icons.clear)
                                        : Icon(
                                            Icons.clear,
                                            color: Colors.transparent,
                                          )),
                                const SizedBox(width: 10),
                                Icon(Icons.search),
                                const SizedBox(width: 10)
                              ],
                            ),
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        suggestionsCallback: (pattern) {
                          return _getSuggestions(snapshot.data, pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        transitionBuilder:
                            (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (suggestion) {
                          this.textEditingController.text = suggestion;
                          setState(() {
                            summaryChartList = covidService.getCountrySummary(
                                snapshot.data
                                    .firstWhere((element) =>
                                        element.country == suggestion)
                                    .slug);
                            summaryNewList = covidService.getCountrySummaryNew(
                                snapshot.data
                                    .firstWhere((element) =>
                                        element.country == suggestion)
                                    .slug);
                            FocusScope.of(context).unfocus();
                          });
                        },
                        errorBuilder: (BuildContext context, Object error) =>
                            Container(
                          padding: EdgeInsets.only(left: 15),
                          height: 40,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Không có dữ liệu',
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Thông tin dịch bệnh",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: kTitleTextColor,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => Tracker(),
                              ));
                            },
                            child: Text(
                              "Xem chi tiết",
                              style: TextStyle(
                                fontSize: 14,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: summaryNewList,
                      builder: (context, snapshot) {
                        if (snapshot.hasError)
                          return Center(
                            child: Text("Vui lòng kiểm tra lại kết nối mạng"),
                          );
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  child:
                                      CountryLoading(inputTextLoading: false)),
                            );
                          default:
                            return !snapshot.hasData
                                ? Center(
                                    child: Text(""),
                                  )
                                : CountryStatisticsNew(
                                    summaryNewList: snapshot.data,
                                  );
                        }
                      },
                    ),
                    FutureBuilder(
                      future: summaryChartList,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) return null;
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: CountryChartLoading(
                                      inputTextLoading: false)),
                            );
                          default:
                            return !snapshot.hasData
                                ? Center(
                                    child: Text("Empty"),
                                  )
                                : CountryStatistics(
                                    summaryChartList: snapshot.data,
                                  );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
