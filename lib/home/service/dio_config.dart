import 'package:dio/dio.dart';

class DioConfig {
  static Dio createDio() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com/',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );
  }
}
