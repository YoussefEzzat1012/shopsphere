import '../../../../core/network/network_error_handler.dart';
import '../../../../core/result/result.dart';
import '../../../../core/storage/token_storage.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../../../core/errors/unknown_failure.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final TokenStorage tokenStorage;
  final NetworkErrorHandler errorHandler;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.tokenStorage,
    required this.errorHandler,
  });

  @override
  Future<Result<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
      );

      await tokenStorage.saveToken(response.token);

      return Result.success(response.user);
    } catch (e) {
      if (e is DioException) {
        final failure = errorHandler.handle(e);
        return Result.failure(failure);
      }

      return Result.failure(
        const UnknownFailure('Something went wrong'),
      );
    }
  }
}