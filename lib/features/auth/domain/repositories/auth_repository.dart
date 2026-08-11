import '../../../../core/errors/failure.dart';
import '../../../../core/result/result.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Result<User>> login({
    required String email,
    required String password,
  });
}