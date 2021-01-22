import 'package:gala_sejahtera/exceptions/AppException.dart';
import 'package:gala_sejahtera/models/covid_cases_records.dart';
import 'package:gala_sejahtera/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class RestApiServices {

  dynamic _returnResponse(http.StreamedResponse response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException();
      case 401:
      case 409:
        throw BadRequestException('${response.statusCode}');
      case 403:
        throw UnauthorisedException();
      case 500:
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<CovidCasesRecords> fetchCovidCasesRecordsData() async {
    final response =
        await http.get('https://knowyourzone.xyz/api/data/covid19/latest');
    if (response.statusCode == 200) {
      return CovidCasesRecords.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load covid data');
    }
  }

  createUserAccount() async {
    var url = API_BASE_URL + ApiEndpoints.CREATE_USER_ACCOUNT;
    Map input = {
      "data": {
        "email": "lewis@xxx.com",
        "role": "user",
        "name": "Lewis",
        "password": "123456"
      }
    };
    var postData = json.encode(input);

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = postData;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    try
    {
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      }
      else {
        print(response.reasonPhrase);
      }
    }
    catch(e)
    {
      throw e;
    }
  }
}
