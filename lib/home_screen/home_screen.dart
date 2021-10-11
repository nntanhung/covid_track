import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../loading_screen/country_loading.dart';
import '../services/covid_services.dart';
import '../resources/consts.dart';
import '../widgets/my_header.dart';
import 'models/country_model.dart';
import 'country_statistics_chart.dart';
import 'country_statistics.dart';
import 'models/country_summany.dart';
import 'tracker.dart';

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
                  textFieldCustom(context, snapshot),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
                                child: CountryLoading(inputTextLoading: false)),
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
                                  child: Text("Không có dữ liệu"),
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
      },
    );
  }

  Widget textFieldCustom(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: 'Nhập quốc gia cần tìm',
            hintStyle: TextStyle(fontSize: 15),
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
                      setState(() {
                        textEditingController.clear();
                      });
                    },
                    child: FocusScope.of(context).hasFocus
                        ? Icon(Icons.clear)
                        : Icon(
                            Icons.clear,
                            color: Colors.transparent,
                          )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.search),
                ),
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
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: (suggestion) {
          this.textEditingController.text = suggestion;
          setState(() {
            summaryChartList = covidService.getCountrySummary(snapshot.data
                .firstWhere((element) => element.country == suggestion)
                .slug);
            summaryNewList = covidService.getCountrySummaryNew(snapshot.data
                .firstWhere((element) => element.country == suggestion)
                .slug);
            FocusScope.of(context).unfocus();
          });
        },
        errorBuilder: (BuildContext context, Object error) => Container(
          padding: const EdgeInsets.only(left: 15),
          height: 40,
          alignment: Alignment.centerLeft,
          child: Text(
            'Không có dữ liệu',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
        ),
      ),
    );
  }
}
