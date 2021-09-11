class CountrySummaryChartModel {
  final String country;
  final int confirmed;
  final int death;
  final int recovered;
  final int active;
  final DateTime date;

  CountrySummaryChartModel(this.country, this.confirmed, this.death,
      this.recovered, this.active, this.date);

  factory CountrySummaryChartModel.fromJson(Map<String, dynamic> json) {
    return CountrySummaryChartModel(
      json['Country'],
      json['Confirmed'],
      json['Deaths'],
      json['Recovered'],
      json['Active'],
      DateTime.parse(json['Date']),
    );
  }
}

class CountrySummaryNewModel {
  final int updated;
  final String country;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int todayRecovered;
  final int active;

  CountrySummaryNewModel(
      this.updated,
      this.country,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.todayRecovered,
      this.active);

  factory CountrySummaryNewModel.fromJson(Map<String, dynamic> json) {
    return CountrySummaryNewModel(
      json['updated'],
      json['country'],
      json['cases'],
      json['todayCases'],
      json['deaths'],
      json['todayDeaths'],
      json['recovered'],
      json['todayRecovered'],
      json['active'],
    );
  }
}
