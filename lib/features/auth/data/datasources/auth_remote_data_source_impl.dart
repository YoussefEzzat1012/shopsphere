import 'package:dio/dio.dart';

import '../../../../core/network/api_constants.dart';
import '../models/login_response_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  const AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      ApiConstants.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    return LoginResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}