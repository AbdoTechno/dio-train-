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

      print('GET Request: $uri');

      final response = await client.get(uri);

      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');

      return response;
    } catch (e) {
      print('GET Error: $e');
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

      print('POST Request: $uri');
      print('Data: ${jsonEncode(data)}');

      final response = await client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');

      return response;
    } catch (e) {
      print('POST Error: $e');
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

      print('PUT Request: $uri');
      print('Data: ${jsonEncode(data)}');

      final response = await client.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');

      return response;
    } catch (e) {
      print('PUT Error: $e');
      rethrow;
    }
  }

  @override
  Future<http.Response> delete(String endpoint) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');

      print('DELETE Request: $uri');

      final response = await client.delete(uri);

      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');

      return response;
    } catch (e) {
      print('DELETE Error: $e');
      rethrow;
    }
  }
}
