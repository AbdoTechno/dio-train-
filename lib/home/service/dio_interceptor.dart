import 'dart:developer';
import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    log('''
🚀 ╔════════════════ REQUEST ════════════════╗
📌 Method      : ${options.method}
🌐 Base URL    : ${options.baseUrl}
🔗 Path        : ${options.path}
📋 Headers     : ${options.headers}
🔍 Query Params: ${options.queryParameters}
📦 Body        : ${options.data}
🚀 ╚═════════════════════════════════════════╝
''');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('''
✅ ╔════════════════ RESPONSE ═══════════════╗
📌 Status Code : ${response.statusCode}
🔗 Endpoint    : ${response.requestOptions.method} ${response.requestOptions.path}
📊 Data Type   : ${response.runtimeType}
📦 Response    :${response.data.toString().length > 500 ? '${response.data.toString().substring(0, 500)}... [truncated]' : response.data.toString()}

✅ ╚═════════════════════════════════════════╝
''');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('''
❌ ╔════════════════ ERROR ══════════════════╗
⚠️ Type        : ${err.type}
📝 Message     : ${err.message}
📌 Status Code : ${err.response?.statusCode}
📦 Response    : ${err.response?.data}
🔗 Endpoint    : ${err.requestOptions.method} ${err.requestOptions.path}
❌ ╚═════════════════════════════════════════╝
''');

    handler.next(err);
  }
}
