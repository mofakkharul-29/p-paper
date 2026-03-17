import 'package:dio/dio.dart';

String handleDioError(DioException e) {
  if (e.type == DioExceptionType.connectionTimeout) {
    return 'Connection timeout';
  } else if (e.type == DioExceptionType.badResponse) {
    return e.response?.data['message'] ?? 'Server error';
  } else if (e.type == DioExceptionType.unknown) {
    return 'No internet connection';
  } else {
    return 'Something went wrong';
  }
}
