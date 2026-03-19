import 'package:dio/dio.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://content.guardianapis.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.addAll([
      _ApiKeyInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }
}

class _ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.queryParameters['api-key'] =
        '4e6f8206-e897-4380-9bea-21943a277039';
    options.queryParameters['show-fields'] =
        'thumbnail,headline,trailText';
    handler.next(options);
  }
}
