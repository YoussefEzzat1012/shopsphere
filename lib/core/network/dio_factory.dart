import 'package:dio/dio.dart';
import 'api_constants.dart';
import 'auth_interceptor.dart';

class DioFactory {
  final AuthInterceptor authInterceptor;

  const DioFactory(this.authInterceptor);

  Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(authInterceptor);

    return dio;
  }
}