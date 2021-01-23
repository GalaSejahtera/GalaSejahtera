class GeneralCases {
  final int totalConfirmed;
  final int activeCases;

  GeneralCases({this.totalConfirmed, this.activeCases});

  factory GeneralCases.fromJson(Map<String, dynamic> json) {
    return GeneralCases(
      totalConfirmed: int.parse(json['data']['totalConfirmed']),
      activeCases: int.parse(json['data']['activeCases']),
    );
  }
}
