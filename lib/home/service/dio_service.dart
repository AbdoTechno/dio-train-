import 'package:dio/dio.dart';
import 'package:dio_train/home/service/dio_exception_handler.dart';
import 'package:dio_train/home/service/dio_interceptor.dart';
import 'package:dio_train/home/service/network_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DioService implements NetworkService {
  final Dio _dio;

  DioService({Dio? dio})
    : _dio =
          dio ??
                Dio(
                  BaseOptions(
                    baseUrl: 'https://dummyjson.com/',
                    connectTimeout: const Duration(seconds: 5),
                    receiveTimeout: const Duration(seconds: 5),
                    sendTimeout: const Duration(seconds: 5),
                    headers: {'Content-Type': 'application/json'},
                  ),
                )
            ..interceptors.add(DioInterceptor());

  @override
  Future<http.Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );

      return http.Response(
        jsonEncode(response.data),
        response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      throw Exception(DioExceptionHandler.handle(e));
    }
  }

  @override
  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(endpoint, data: data);

      return http.Response(
        jsonEncode(response.data),
        response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      throw Exception(DioExceptionHandler.handle(e));
    }
  }

  @override
  Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.put(endpoint, data: data);

      return http.Response(
        jsonEncode(response.data),
        response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      throw Exception(DioExceptionHandler.handle(e));
    }
  }

  @override
  Future<http.Response> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);

      return http.Response(
        jsonEncode(response.data),
        response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      throw Exception(DioExceptionHandler.handle(e));
    }
  }
}


/*

I/flutter (21954): -------------------------------------------------------------------------
I/flutter (21954): Response status: 200
I/flutter (21954): {posts: [{id: 7, title: This is important to remember., body: This is important to remember. Love isn't like pie. You don't need to divide it among all your friends and loved ones. No matter how much love you give, you can always give more. It doesn't run out, so don't try to hold back giving it as if it may one day run out. Give it freely and as much as you want., tags: [magical, crime], reactions: {likes: 127, dislikes: 26}, views: 168, userId: 70}, {id: 39, title: It was so great to hear from you today, body: "It was so great to hear from you today and it was such weird timing," he said. "This is going to sound funny and a little strange, but you were in a dream I had just a couple of days ago. I'd love to get together and tell you about it if you're up for a cup of coffee," he continued, laying the trap he'd been planning for years., tags: [french, magical, american], reactions: {likes: 772, dislikes: 39}, views: 1129, userId: 115}, {id: 55, title: She tried to explain that love wasn't like pie., body: S
I/flutter (21954): -------------------------------------------------------------------------
 */