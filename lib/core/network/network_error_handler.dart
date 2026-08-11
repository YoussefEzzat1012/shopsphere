import 'package:dio/dio.dart';

import '../errors/failure.dart';
import '../errors/network_failure.dart';
import '../errors/server_failure.dart';
import '../errors/unknown_failure.dart';

class NetworkErrorHandler {
  const NetworkErrorHandler();

  Failure handle(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Network timeout');

      case DioExceptionType.connectionError:
        return const NetworkFailure(
          'Network connection error',
        );

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;

        switch (statusCode) {
          case 400:
            return const ServerFailure('Bad request');

          case 401:
            return const ServerFailure('Unauthorized');

          case 403:
            return const ServerFailure('Forbidden');

          case 404:
            return const ServerFailure('Not found');

          case 500:
            return const ServerFailure(
              'Internal server error',
            );

          default:
            return const ServerFailure('Server error');
        }

      case DioExceptionType.cancel:
        return const UnknownFailure('Request cancelled');

      default:
        return const UnknownFailure(
          'Something went wrong',
        );
    }
  }
}