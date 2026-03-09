import 'package:dio/dio.dart';

class RateLimitInterceptor extends Interceptor {
  final int maxRequests;
  final Duration perDuration;

  final List<DateTime> _requestTimestamps = [];

  RateLimitInterceptor({
    this.maxRequests = 5, // Default: allow maximum 5 requests
    this.perDuration = const Duration(seconds: 10), // per 10 seconds
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final now = DateTime.now();

    // Clean up timestamps older than the configured duration
    _requestTimestamps.removeWhere(
      (timestamp) => now.difference(timestamp) > perDuration,
    );

    // If we have hit our maximum requests for this time window, reject the outgoing request
    if (_requestTimestamps.length >= maxRequests) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'Rate limit exceeded. Please try again later.',
          type: DioExceptionType.cancel,
        ),
      );
    } else {
      // Record the timestamp and proceed
      _requestTimestamps.add(now);
      super.onRequest(options, handler);
    }
  }
}
