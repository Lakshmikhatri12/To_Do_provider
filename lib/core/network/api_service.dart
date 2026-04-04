import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:to_do_app/features/auth/failures/failure.dart';

class ApiService {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  ApiService(this._dio, this._secureStorage) {
    _dio.options = BaseOptions(
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _secureStorage.read(key: 'access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          if (kDebugMode) {
            debugPrint('REQUEST: ${options.method} ${options.uri}');
            debugPrint('Data: ${options.data}');
          }
          handler.next(options);
        },

        onResponse: (response, handler) {
          if (kDebugMode) {
            debugPrint(
              'RESPONSE: ${response.statusCode} ${response.requestOptions.uri}',
            );
          }
          handler.next(response);
        },

        onError: (error, handler) async {
          if (kDebugMode) {
            debugPrint(
              'ERROR: ${error.response?.statusCode} ${error.requestOptions.uri}',
            );
          }

          if (error.response?.statusCode == 401) {
            await _secureStorage.delete(key: 'access_token');
          }
          handler.next(error);
        },
      ),
    );
  }

  Future<dynamic> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> post(String path, {dynamic, data}) async {
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
        return BadRequestFailure(
          e.response?.data?['message'] ??
              'Invalid username or password. Please check your credentials.',
        );
      case 401:
        return UnAuthorizedFailure(
          e.response?.data?['message'] ?? 'Invalid credentials',
        );
      case 500:
        return ServerFailure(e.response?.data?['message'] ?? 'Server error');
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          return const NetworkFailure('No internet connection');
        }
        return const ServerFailure('Something went wrong');
    }
  }
}
