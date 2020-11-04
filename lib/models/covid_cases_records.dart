class CovidCasesRecords {
  final List<StateModel> states;
  final int last_updated;

  CovidCasesRecords({this.states, this.last_updated});

  factory CovidCasesRecords.fromJson(Map<String, dynamic> json) {
    var list = json['states'] as List;
    List<StateModel> stateList = list.map((i) => StateModel.fromJson(i)).toList();

    return CovidCasesRecords(
      states: stateList,
      last_updated: json['last_updated'],
    );
  }
}

class StateModel {
  final String name;
  final int total;
  final List<DistrictModel> districts;

  StateModel({this.name, this.total, this.districts});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    var list = json['districts'] as List;
    List<DistrictModel> districtList =
    list.map((i) => DistrictModel.fromJson(i)).toList();

    return StateModel(
      name: json['name'],
      total: json['total'],
      districts: districtList,
    );
  }
}

class DistrictModel {
  final String name;
  final int total;

  DistrictModel({this.name, this.total});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      name: json['name'],
      total: json['total'],
    );
  }
}

