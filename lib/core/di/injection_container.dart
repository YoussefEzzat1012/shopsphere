import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../network/auth_interceptor.dart';
import '../network/dio_factory.dart';
import '../network/network_error_handler.dart';
import '../storage/secure_token_storage.dart';
import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart';

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

  static final authRemoteDataSource = AuthRemoteDataSourceImpl(
    dio,
  );

  static final NetworkErrorHandler networkErrorHandler =
  const NetworkErrorHandler();

  static final AuthRepository authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemoteDataSource,
    tokenStorage: tokenStorage,
    errorHandler: networkErrorHandler,
  );

  static final login = Login(
    authRepository,
  );
}