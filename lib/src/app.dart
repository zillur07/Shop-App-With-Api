import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shop_app/src/pages/home_page.dart';
import 'package:shop_app/src/pages/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: LoginPage());
  }
}
