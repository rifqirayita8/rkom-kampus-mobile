import 'package:dio/dio.dart';
import 'package:rkom_kampus/utils/api.dart';


class MyDioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.baseUrl= ApiEnv.apiUrl;

    options.headers= {
      'Content-Type': 'application/json',
    };

    return super.onRequest(options, handler);
  }
}