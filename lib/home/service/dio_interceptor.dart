import 'dart:developer';

import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    log('Request Method: $options.method');
    log('------------------------------------');
    log('Request Path: ${options.path}');
    log('------------------------------------');
    log('Request Headers: ${options.headers}');
    log('------------------------------------');
    log('Base URL: ${options.baseUrl}');
    log('------------------------------------');
    if (options.queryParameters.isNotEmpty) {
      log('Query Parameters: ${options.queryParameters}');
      log('------------------------------------');
    }
    if (options.data != null) {
      log('Request Body: ${options.data}');
      log('------------------------------------');
    }
    // handle the request and continue to the next interceptor or send the request
    handler.next(options);
    // If you want to stop the request and return a custom response, you can use:
    // handler.resolve(Response(
    //   requestOptions: options,
    //   data: {'custom': 'response'},
    //   statusCode: 200,
    // ));
    // super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    log('Response Status Code: ${response.statusCode}');
    log('------------------------------------');
    log(
      'Response  Data: ${response.data}: ${response.requestOptions.method} ${response.requestOptions.path}',
    );
    log('------------------------------------');
    // handle the response and continue to the next interceptor or return the response
    handler.next(response);
    // If you want to stop the response and return a custom response, you can use:
    // handler.resolve(Response(
    //   requestOptions: response.requestOptions,
    //   data: {'custom': 'response'},
    //   statusCode: 200,
    // ));
    // super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('Error Message: ${err.message}');
    log('------------------------------------');
    log('Error Type: ${err.type}');
    log('------------------------------------');
    if (err.response != null) {
      log('Error Response Data: ${err.response?.data}');
      log('------------------------------------');
      log('Error Response Status Code: ${err.response?.statusCode}');
      log('------------------------------------');
    }
    // handle the error and continue to the next interceptor or return the error
    handler.next(err);
    // If you want to stop the error and return a custom response, you can use:
    // handler.resolve(Response(
    //   requestOptions: err.requestOptions,
    //   data: {'custom': 'response'},
    //   statusCode: 200,
    // ));
    // super.onError(err, handler);
  }
  
}
