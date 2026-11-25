import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: const Color(0xff5146E5),
        foregroundColor: Colors.white,
      ),

      body: Obx(() {
        // Loading
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 50, color: Colors.red),

                const SizedBox(height: 10),

                Text(controller.errorMessage.value),

                const SizedBox(height: 15),

                ElevatedButton(
                  onPressed: controller.getUserProfile,
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        // User Data
        final user = controller.user.value;

        if (user == null) {
          return const Center(child: Text('No User Data Found'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              // Profile Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  children: [
                    // User Image
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(user.image),
                    ),

                    const SizedBox(height: 15),

                    // Name
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      '@${user.username}',
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 15),

                    const Chip(
                      label: Text('Verified User'),
                      avatar: Icon(Icons.verified, color: Colors.green),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // User Information
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    profileItem(
                      Icons.person_outline,
                      'User ID',
                      user.id.toString(),
                    ),

                    profileItem(Icons.person, 'First Name', user.firstName),

                    profileItem(Icons.person, 'Last Name', user.lastName),

                    profileItem(Icons.email_outlined, 'Email', user.email),

                    profileItem(Icons.transgender, 'Gender', user.gender),

                    profileItem(
                      Icons.alternate_email,
                      'Username',
                      user.username,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Refresh Button
              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton.icon(
                  onPressed: controller.getUserProfile,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh Profile'),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5146E5),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Reusable Widget
  Widget profileItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),

      child: Row(
        children: [
          Icon(icon, color: const Color(0xff5146E5)),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
