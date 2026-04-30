import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/core/network/config/app_url.dart';
import 'package:to_do_app/core/network/interceptors/auth_interceptors.dart';
import 'package:to_do_app/core/network/interceptors/connectivity_interceptor.dart';
import 'package:to_do_app/core/network/interceptors/logger_interceptor.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  FlutterSecureStorage get secureStorage => FlutterSecureStorage();
  @lazySingleton
  Dio dio(FlutterSecureStorage secureStorage) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppUrl.baseUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.addAll([
      ConnectivityInterceptor(),
      AuthInterceptors(secureStorage),
      LoggerInterceptor(),
    ]);
    return dio;
  }
}
