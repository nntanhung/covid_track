import 'dart:convert';
import 'package:http/http.dart' as http;

import '../home_screen/models/country_model.dart';
import '../home_screen/models/country_summany.dart';

class CovidService {
  Future<CountryModel> getGlobalSummary() async {
    final data =
        await http.Client().get("https://disease.sh/v3/covid-19/countries");

    if (data.statusCode != 200) throw Exception();

    CountryModel summary = new CountryModel.fromJson(json.decode(data.body));

    return summary;
  }

  Future<List<CountrySummaryChartModel>> getCountrySummary(String slug) async {
    final data = await http.Client()
        .get("https://api.covid19api.com/total/dayone/country/" + slug);

    if (data.statusCode != 200) throw Exception();

    List<CountrySummaryChartModel> summaryList =
        (json.decode(data.body) as List)
            .map((item) => new CountrySummaryChartModel.fromJson(item))
            .toList();

    return summaryList;
  }

  Future<CountrySummaryNewModel> getCountrySummaryNew(String slug) async {
    final response =
        await http.get('https://disease.sh/v3/covid-19/countries/' + slug);

    if (response.statusCode == 200) {
      return CountrySummaryNewModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<List<CountryModel>> getCountryList() async {
    final data =
        await http.Client().get('https://nntanhung.github.io/countries.json');

    if (data.statusCode != 200) throw Exception();

    List<CountryModel> countries = (json.decode(data.body) as List)
        .map((item) => new CountryModel.fromJson(item))
        .toList();

    return countries;
  }
}
