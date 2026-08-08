import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../network/auth_interceptor.dart';
import '../network/dio_factory.dart';
import '../storage/secure_token_storage.dart';

class InjectionContainer {
  static final tokenStorage = SecureTokenStorage(
    const FlutterSecureStorage(),
  );

  static final authInterceptor = AuthInterceptor(
    tokenStorage,
  );

  static final dio = DioFactory(
    authInterceptor,
  ).create();
}