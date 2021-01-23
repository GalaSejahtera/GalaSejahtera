import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:gala_sejahtera/exceptions/AppException.dart';

class ApiEngine {
  static HttpClient client = new HttpClient()
    ..badCertificateCallback = (_certificateCheck);

  static bool _certificateCheck(X509Certificate cert, String host, int port) =>
      true;

  dynamic _returnResponse(HttpClientResponse response) {
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
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> get(String url, [Map<String, String> queryParams, Map header]) async {
    Map<String, String> defaultHeader = {'Content-Type': 'application/json'};
    header = header ?? defaultHeader;

    if(queryParams != null) {
      String queryString = Uri(queryParameters: queryParams).query;
      url += '?$queryString';
    }

    try {
      HttpClientRequest request = await client.getUrl(Uri.parse(url));
      header.forEach((k, v) => request.headers.add(k, v));
      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        return jsonDecode(await response.transform(utf8.decoder).join());
      } else {
        return _returnResponse(response);
      }
    } catch (ex) {
      throw Exception(ex.toString());
    }
  }

  Future<Map<String, dynamic>> post(String url, Map inputData, [Map header]) async {
    Map<String, String> defaultHeader = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    header = header ?? defaultHeader;

    final completer = Completer<String>();
    final contents = StringBuffer();

    try {
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      header.forEach((k, v) => request.headers.add(k, v));
      // POST DATA
      request.add(utf8.encode(json.encode(inputData)));
      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        return jsonDecode(await response.transform(utf8.decoder).join());
      } else {
        response.transform(utf8.decoder).listen((data) {
          contents.write(data);
        }, onDone: () => completer.complete(contents.toString()));
        Map<String, dynamic> output = jsonDecode(await completer.future);
        return output;
      }
    } catch (ex) {
      throw Exception(ex.toString());
    }
  }
}
