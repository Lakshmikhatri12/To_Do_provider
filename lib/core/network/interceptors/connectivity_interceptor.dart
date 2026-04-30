import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:to_do_app/core/error/failure.dart';

class ConnectivityInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: const NetworkFailure('No internet connection '),
          type: DioExceptionType.connectionError,
        ),
      );
      return;
    }
    handler.next(options);
  }
}
