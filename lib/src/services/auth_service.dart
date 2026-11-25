import 'package:dio/dio.dart';
import 'package:shop_app/src/config/app_config.dart';
import '../models/user_model.dart';

class AuthService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: '$baseUrl',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<UserModel> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'username': username, 'password': password, 'expiresInMins': 30},
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }
}
