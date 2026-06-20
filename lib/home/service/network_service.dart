import 'package:http/http.dart' as http;

abstract class NetworkService {
  Future<http.Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? data,
  });

  Future<http.Response> put(String endpoint, {Map<String, dynamic>? data});

  Future<http.Response> delete(String endpoint);
}
