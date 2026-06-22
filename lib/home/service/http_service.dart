import 'package:http/http.dart' as http;
import 'package:dio_train/home/service/network_service.dart';
import 'dart:convert';

class HttpService implements NetworkService {
  static const String _baseUrl = 'https://dummyjson.com';

  final http.Client client;

  HttpService({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<http.Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse(
        '$_baseUrl$endpoint',
      ).replace(queryParameters: queryParameters?.cast<String, String>());

      final response = await client.get(uri);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');

      final response = await client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');

      final response = await client.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> delete(String endpoint) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');

      final response = await client.delete(uri);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
