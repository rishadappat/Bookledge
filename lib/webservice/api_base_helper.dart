import 'dart:io';
import 'package:bookledge/webservice/app_exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ApiBaseHelper {
  final String _baseUrl =
      "https://samagra.kite.kerala.gov.in/v2/api/public/getSubjectTextbooks/";
  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      var webUrl = Uri.parse(_baseUrl + url);
      print('Api Get, url $webUrl');
      final response = await http.get(webUrl);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
