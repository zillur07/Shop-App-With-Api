
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/pages/home_page.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';


class AuthController extends GetxController {
  final AuthService authService = AuthService();

  // TextField Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Reactive Variables
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  UserModel? user;

  // Login Function
  Future<void> login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    // Empty Check
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Warning',
        'Please enter username and password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Call API
      user = await authService.login(username, password);

      // Success
      Get.off(
        () => HomePage(user: user!),
      );

    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Password Visibility
  void togglePassword() {
    isPasswordVisible.value =
        !isPasswordVisible.value;
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
