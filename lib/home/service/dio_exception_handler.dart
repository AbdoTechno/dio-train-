import 'package:dio/dio.dart';

class DioExceptionHandler {
  static String handle(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';

      case DioExceptionType.sendTimeout:
        return 'Send timeout';

      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';

      case DioExceptionType.badCertificate:
        return 'Bad certificate';

      case DioExceptionType.badResponse:
        return _handleStatusCode(
          error.response?.statusCode,
        );

      case DioExceptionType.cancel:
        return 'Request was cancelled';

      case DioExceptionType.connectionError:
        return 'No internet connection';

      case DioExceptionType.unknown:
        return 'Unexpected error occurred';
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';

      case 401:
        return 'Unauthorized';

      case 403:
        return 'Forbidden';

      case 404:
        return 'Resource not found';

      case 500:
        return 'Internal server error';

      case 502:
        return 'Bad gateway';

      default:
        return 'Something went wrong';
    }
  }
}