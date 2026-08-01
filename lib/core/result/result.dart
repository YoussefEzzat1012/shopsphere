import '../errors/failure.dart';

class Result<T> {
  final T? data;
  final Failure? failure;

  const Result.success(this.data)
      : failure = null;

  const Result.failure(this.failure)
      : data = null;

  bool get isSuccess => failure == null;

  bool get isFailure => !isSuccess;
}