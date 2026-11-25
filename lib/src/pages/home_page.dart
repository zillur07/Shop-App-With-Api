import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/src/models/user_model.dart';
import 'package:shop_app/src/pages/user_page.dart';

class HomePage extends StatelessWidget {
  final UserModel? user;
  HomePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          const Center(child: Text('Welcome to the Home Page')),

          if (user != null) ...[
            const SizedBox(height: 20),
            Text('Hello, ${user!.firstName} ${user!.lastName}'),
            Text('Email: ${user!.email}'),
          ],

          ElevatedButton(
            onPressed: () {
              Get.to(() => ProfilePage());
            },
            child: const Text('Go to Profile'),
          ),
        ],
      ),
    );
  }
}
