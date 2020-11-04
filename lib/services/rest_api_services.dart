import 'package:gala_sejahtera/models/covid_cases_records.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RestApiServices {
  Future<CovidCasesRecords> fetchCovidCasesRecordsData() async {
    final response =
        await http.get('https://knowyourzone.xyz/api/data/covid19/latest');
    if (response.statusCode == 200) {
      return CovidCasesRecords.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load covid data');
    }
  }
}
