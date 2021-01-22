import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gala_sejahtera/exceptions/AppException.dart';
import 'package:gala_sejahtera/models/auth_credentials.dart';
import 'package:gala_sejahtera/models/covid_cases_records.dart';
import 'package:gala_sejahtera/services/dioInstance.dart';
import 'package:gala_sejahtera/utils/constants.dart';
import 'package:http/http.dart' as http;

class RestApiServices {
  final Dio dioInstance = getDioWithoutAuth();

  Future<CovidCasesRecords> fetchCovidCasesRecordsData() async {
    final response =
        await http.get('https://knowyourzone.xyz/api/data/covid19/latest');
    if (response.statusCode == 200) {
      return CovidCasesRecords.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load covid data');
    }
  }

  Future<AuthCredentials> userLogin({String email, String password}) async {
    try {
      final Response response = await dioInstance.post(USER_LOGIN, data: {
        'email': email,
        'password': password,
      });
      print("print success");
      print(response);
      
      return AuthCredentials.fromJson(jsonDecode(response.toString()));
    } on DioError catch (e) {
      return null;
    }
  }

  Future<Response> registerUser(
      {String username, String email, String password}) async {
    try {
      final response = await dioInstance.post(CREATE_USER_ACCOUNT, data: {
        "data": {
          "role": "user",
          "name": username,
          "email": email,
          "password": password
        }
      });
      return response;
    } on DioError catch (e) {
      return null;
    }
  }

  createUserAccount() async {
    var url = API_BASE_URL + CREATE_USER_ACCOUNT;
    Map input = {
      "data": {
        "email": "lewis@xxx.com",
        "role": "user",
        "name": "Lewis",
        "password": "123456"
      }
    };
    var postData = json.encode(input);

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body = postData;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    try {
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      throw e;
    }
  }

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
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
