import 'package:dio/dio.dart';
import '../models/user_profile_model.dart';

class UserService {
  final Dio dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));

  Future<UserProfileModel> getUserProfile(String accessToken) async {
    try {
      final response = await dio.get(
        '/auth/me',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      return UserProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to load user profile',
      );
    }
  }
}
