import 'package:get/get.dart';

import '../models/user_profile_model.dart';
import '../services/user_service.dart';
import 'auth_controller.dart';

class UserController extends GetxController {
  final UserService userService = UserService();

  // Loading
  var isLoading = false.obs;

  // User Data
  var user = Rxn<UserProfileModel>();

  // Error Message
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
  }

  // Get User Profile
  Future<void> getUserProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Get Login Token
      final authController = Get.find<AuthController>();

      final token = authController.user!.accessToken;

      // API Call
      final result = await userService.getUserProfile(token);

      // Store User Data
      user.value = result;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }
}
