import 'dart:async';
import 'dart:convert';

import 'package:gala_sejahtera/models/daily_cases.dart';
import 'package:gala_sejahtera/models/general_cases.dart';
import 'package:gala_sejahtera/models/news_records.dart';
import 'package:gala_sejahtera/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'ApiEngine.dart';

class RestApiServices {
  ApiEngine apiEngine = new ApiEngine();

  Future<Map> reverseGeocoding(double latitude, double longitude) async {
    final response = await http.get(
        'https://us1.locationiq.com/v1/reverse.php?key=$LOCATION_IQ_TOKEN&lat=$latitude&lon=$longitude&format=json&zoom=18');
    return jsonDecode(response.body);
  }

  Future<NewsRecords> fetchNewsRecords(
      [String start, String end, String searchValue]) async {
    String url = '$API_BASE_URL$GET_COVID_NEWS';
    Map<String, String> queryParams = {
      'from': start = start ?? '0',
      'to': end = end ?? '10',
      'filterItem': 'q',
      'filterValue': searchValue = searchValue ?? '',
    };
    var result = await apiEngine.get(url, queryParams);

    return NewsRecords.fromJson(result);
  }

  Future<GeneralCases> fetchGeneralCases() async {
    String url = '$API_BASE_URL$GET_GENERAL_CASES';

    var result = await apiEngine.get(url);

    return GeneralCases.fromJson(result);
  }

  Future<DailyCases> fetchDailyCases() async {
    String url = '$API_BASE_URL$GET_DAILY_CASES';

    var result = await apiEngine.get(url);

    return DailyCases.fromJson(result);
  }

  Future<Map> createUserAccount(String username, String email, String password) async {
    String url = '$API_BASE_URL$CREATE_USER_ACCOUNT';
    Map input = {
      "data": {
        "email": email,
        "role": "user",
        "name": username,
        "password": password
      }
    };

    var result = await apiEngine.post(url, input);

    return result;
  }

  Future<Map> userLogin({String email, String password}) async {
    String url = '$API_BASE_URL$USER_LOGIN';
    Map input = {'email': "$email", 'password': "$password"};
    var result = await apiEngine.post(url, input);

    return result;
  }

  Future<Map> getCaseByDistrict(String accessToken, String district) async {
    String url = '$API_BASE_URL$GET_CASE_BY_DISTRICT$district';
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    };
    var result = await apiEngine.get(url, null, requestHeaders);

    return result['data'];
  }

  Future<Map> userLogout({String accessToken}) async {
    String url = '$API_BASE_URL$USER_LOGOUT';
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    };
    var result = await apiEngine.post(url, null, requestHeaders);
    return result;
  }

  Future<Map> getNearbyUsers(String accessToken, String userId, double latitude,
      double longitude) async {
    String url = '$API_BASE_URL$GET_NEARBY_USERS';
    Map input = {
      'user': {'id': "$userId", 'lat': "$latitude", 'long': "$longitude"}
    };
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    };
    var result = await apiEngine.post(url, input, requestHeaders);
    return result;
  }

  Future<Map> createReport(String id, bool hasSymptom, List<bool> results) async {
    String url = '$API_BASE_URL' + 'v1/reports/0';
    // print(url);
    Map input = {
      "data": {"userId": id, "hasSymptom": hasSymptom, "results": results}
    };
    var result = await apiEngine.post(url, input);
    return result;
  }

  Future<List> getReports(String id) async {
    String url =
        '$API_BASE_URL' + 'v1/reports?filterItem=userId&filterValue=$id';
    // print(url);
    var result = await apiEngine.get(url);
    return result['data'];
  }

  Future<List> getReport(String id) async {
    String url = '$API_BASE_URL' + 'v1/reports/$id';
    // print(url);
    var result = await apiEngine.get(url);
    return result['data'];
  }

  Future<dynamic> passwordReset({String email}) async {
    var result;
    try {
      String url = '$API_BASE_URL$PASSWORD_RESET?email=$email';
      result = await apiEngine.get(url);
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<dynamic> passwordUpdate({String id, String password}) async {
    String url = '$API_BASE_URL$PASSWORD_RESET/$id';
    final input = jsonEncode({'password': "$password"});
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var result = await http.put(url, body: input, headers: requestHeaders);
    return (result);
  }
}
