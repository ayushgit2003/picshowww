import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../core/exceptions/app_exceptions.dart';
import 'base_api_services.dart';
import 'package:http/http.dart' as http;


class NetworkApiService implements BaseApiServices {
  @override
  Future<List<T>> getApi<T>(String url, T Function(Map<String, dynamic>) fromJson) async {
    if (kDebugMode) {
      print(url);
    }
    List<T> responseList = [];
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 20));
      responseList = returnResponse<T>(response, fromJson);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
    if (kDebugMode) {
      print(responseList);
    }
    return responseList;
  }

  List<T> returnResponse<T>(http.Response response, T Function(Map<String, dynamic>) fromJson) {
    if (kDebugMode) {
      print(response.statusCode);
    }

    switch (response.statusCode) {
      case 200:
        return (jsonDecode(response.body) as List)
            .map((item) => fromJson(item as Map<String, dynamic>))
            .toList();
      case 400:
        throw BadRequestException('Bad Request');
      case 401:
        throw UnauthorisedException('Unauthorized');
      case 404:
        throw FetchDataException('Not Found');
      default:
        throw FetchDataException('Error occurred while communicating with server');
    }
  }
}
