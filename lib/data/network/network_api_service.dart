import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:to_do_app/data/app_exception.dart';
import 'package:to_do_app/data/network/base_api_services.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future<dynamic> getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url), headers: {"Content-Type": "application/json"})
          .timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw fetchDataExceptions("No internet connection");
    }
    return responseJson;
  }

  @override
  Future<dynamic> getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw fetchDataExceptions("No internet connection");
    }
    return responseJson;
  }

  @override
  Future<dynamic> getPutApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw fetchDataExceptions("No internet connection");
    }
    return responseJson;
  }

  @override
  Future<dynamic> getDeleteApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await delete(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw fetchDataExceptions("No internet connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 404:
        throw UnAuthorizedException(response.body.toString());
      default:
        throw fetchDataExceptions(
          "Error occurred while communicating with server with status code " +
              response.statusCode.toString(),
        );
    }
  }
}
