class DailyCases {
  final List<DailyCase> dailyCases;

  DailyCases({this.dailyCases});

  factory DailyCases.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<DailyCase> dailyList = list.map((i) => DailyCase.fromJson(i)).toList();

    return DailyCases(dailyCases: dailyList);
  }
}

class DailyCase {
  final String lastUpdated;
  final int newDeaths, newInfections, newRecovered;

  DailyCase(
      {this.lastUpdated,
      this.newDeaths,
      this.newInfections,
      this.newRecovered});

  factory DailyCase.fromJson(Map<String, dynamic> json) {
    return DailyCase(
      lastUpdated: json['last_updated'],
      newDeaths: int.parse(json['new_deaths']),
      newInfections: int.parse(json['new_infections']),
      newRecovered: int.parse(json['new_recovered']),
    );
  }
}
