import 'dart:convert';
import 'dart:async';
import 'package:gala_sejahtera/models/covid_cases_records.dart';
import 'package:gala_sejahtera/models/news_records.dart';
import 'package:gala_sejahtera/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'ApiEngine.dart';

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

  Future<NewsRecords> fetchNewsRecords() async {
    String url = '$API_BASE_URL$GET_COVID_NEWS';

    ApiEngine apiEngine = new ApiEngine();
    var result = await apiEngine.get(url);

    return NewsRecords.fromJson(result);
  }

  Future<Map> createUserAccount(
      String username, String email, String password) async {
    String url = '$API_BASE_URL$CREATE_USER_ACCOUNT';
    Map input = {
      "data": {
        "email": email,
        "role": "user",
        "name": username,
        "password": password
      }
    };

    ApiEngine apiEngine = new ApiEngine();
    var result = await apiEngine.post(url, input);

    return result;
  }

  Future<Map> userLogin({String email, String password}) async {
    String url = '$API_BASE_URL$USER_LOGIN';
    ApiEngine apiEngine = new ApiEngine();
    Map input = {'email': "$email", 'password': "$password"};
    var result = await apiEngine.post(url, input);
    
    return result;
  }

  Future<Map> getCaseByDistrict(String district) async {
    String url = '$API_BASE_URL$GET_CASE_BY_DISTRICT$district';
    print(url);
    ApiEngine apiEngine = new ApiEngine();
    var result = await apiEngine.get(url);
    
    return result['data'];
  }
}
