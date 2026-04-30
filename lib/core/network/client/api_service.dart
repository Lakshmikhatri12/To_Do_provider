import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/core/network/interceptors/auth_interceptors.dart';
import 'package:to_do_app/core/network/interceptors/connectivity_interceptor.dart';
import 'package:to_do_app/core/network/interceptors/logger_interceptor.dart';
import 'package:to_do_app/core/error/failure.dart';

@LazySingleton()
class ApiService {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  ApiService(this._dio, this._secureStorage) {
    _dio.options = BaseOptions(
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    );

    _dio.interceptors.addAll([
      AuthInterceptors(_secureStorage),
      ConnectivityInterceptor(),
    ]);
    if (kDebugMode) {
      _dio.interceptors.add(LoggerInterceptor());
    }
  }

  Future<dynamic> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Failure _handleError(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return BadRequestFailure(e.response?.data?['message'] ?? 'Bad request');
      case 401:
        return UnAuthorizedFailure(
          e.response?.data?['message'] ?? 'Invalid credentials',
        );
      case 403:
        return ForbiddenFailure(
          e.response?.data?['message'] ?? 'Access denied',
        );
      case 404:
        return NotFoundFailure(
          e.response?.data?['message'] ?? 'Resource not found',
        );
      case 422:
        return ValidationFailure(
          e.response?.data?['message'] ?? 'Unprocessable entity',
        );
      case 500:
        return ServerFailure(e.response?.data?['message'] ?? 'Server error');
      case 503:
        return ServerFailure(
          e.response?.data?['message'] ?? 'Server unavailable',
        );
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          return const NetworkFailure('No internet connection');
        }
        return const ServerFailure('Something went wrong');
    }
  }
}
