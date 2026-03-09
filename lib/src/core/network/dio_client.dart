import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'rate_limit_interceptor.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        // 15-second cap on connecting + waiting for a response
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),

        // default headers sent with every request
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      RateLimitInterceptor(
        maxRequests: 10,
        perDuration: const Duration(seconds: 10),
      ),
    );

    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
      ),
    );
  }

  /// Expose the configured Dio instance for services to use.
  Dio get dio => _dio;
}
