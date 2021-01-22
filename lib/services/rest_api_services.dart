import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gala_sejahtera/models/auth_credentials.dart';
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
    if(!result.containsKey(ApiResponseKey.error)) {
      return NewsRecords.fromJson(result);
    }
    // TODO handle the error messages
  }

  Future<dynamic> createUserAccount() async {
    String url = '$API_BASE_URL$CREATE_USER_ACCOUNT';
    Map input = {
        "data": {
          "email": "lewis@hotmails.com",
          "role": "user",
          "name": "Lewis",
          "password": "123456"
        }
    };

    ApiEngine apiEngine = new ApiEngine();
    var result = await apiEngine.post(url, input);
    if(!result.containsKey(ApiResponseKey.error)) {
      // TODO success create account
      return null;
    }
    print(result);
    // TODO handle the error messages
  }

  Future<AuthCredentials> userLogin({String email, String password}) async {
    String url = '$API_BASE_URL$USER_LOGIN';
    ApiEngine apiEngine = new ApiEngine();
    Map input = { 'email': "$email", 'password': "$password"};
    var result = await apiEngine.post(url, input);
    if(!result.containsKey(ApiResponseKey.error)) {
      return AuthCredentials.fromJson(result);
    }
    // TODO handle the error messages
  }
}
